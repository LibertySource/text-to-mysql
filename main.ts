/*
  ___ __  __ ___  ___  ___ _____ ___
 |_ _|  \/  | _ \/ _ \| _ \_   _/ __|
  | || |\/| |  _/ (_) |   / | | \__ \
 |___|_|  |_|_|  \___/|_|_\ |_| |___/

*/

import { Application } from "https://deno.land/x/oak/mod.ts";
import { Client } from "https://deno.land/x/mysql/mod.ts";
import { Router } from "https://deno.land/x/oak/mod.ts";
import {
  BedrockAgentRuntimeClient,
  InvokeFlowCommand,
} from "npm:@aws-sdk/client-bedrock-agent-runtime";
import { bold, gray, white } from "https://deno.land/std@0.224.0/fmt/colors.ts";

/*
  ___ _  ___   __ __   ___   ___  ___
 | __| \| \ \ / / \ \ / /_\ | _ \/ __|
 | _|| .` |\ V /   \ V / _ \|   /\__ \
 |___|_|\_| \_/     \_/_/ \_\_|_\|___/

*/

// read this first for logging
const debug: boolean = Deno.env.get("DEBUG")?.toLowerCase() === "true";
log(`Debug mode set to '${debug}'`, true); // aways log this line

const awsAccessKey: string | undefined = Deno.env.get("AWS_ACCESS_KEY_ID");
log(`AWS_ACCESS_KEY_ID set to  '${awsAccessKey?.substring(0, 6)}.....'`, false);

const awsRegion: string | undefined = Deno.env.get("AWS_REGION");
log(`AWS_REGION set to  '${awsRegion}'`, false);

const awsSecretAccessKey: string | undefined = Deno.env.get(
  "AWS_SECRET_ACCESS_KEY",
);
log(
  `AWS_SECRET_ACCESS_KEY set to  '${awsSecretAccessKey?.substring(0, 6)}.....'`,
  false,
);

const flowAliasIdentifier: string | undefined = Deno.env.get(
  "AWS_BEDROCK_FLOW_ALIAS_IDENTIFIER",
);
log(
  `AWS_BEDROCK_FLOW_ALIAS_IDENTIFIER set to '${
    flowAliasIdentifier?.substring(0, 6)
  }.....'`,
  false,
);

const flowIdentifier: string | undefined = Deno.env.get(
  "AWS_BEDROCK_FLOW_IDENTIFIER",
);
log(
  `AWS_BEDROCK_FLOW_IDENTIFIER set to '${
    flowIdentifier?.substring(0, 6)
  }.....'`,
  false,
);

// Add after env var declarations
if (!awsAccessKey || !awsSecretAccessKey || !awsRegion || !flowIdentifier || !flowAliasIdentifier) {
  console.error("Missing required environment variables");
  Deno.exit(1);
}

/*
   ___ ___  _  _ ___ _____ _   _  _ _____ ___
  / __/ _ \| \| / __|_   _/_\ | \| |_   _/ __|
 | (_| (_) | .` \__ \ | |/ _ \| .` | | | \__ \
  \___\___/|_|\_|___/ |_/_/ \_\_|\_| |_| |___/

*/

const app = new Application();

const bedrock_client = new BedrockAgentRuntimeClient({
  region: awsRegion,
  credentials: {
    accessKeyId: awsAccessKey,
    secretAccessKey: awsSecretAccessKey,
  },
});

// Database connection
const db_client = await new Client().connect({
  hostname: "db",
  username: "root",
  password: "rootpassword",
  db: "myapp",
});

const router = new Router();

/*
  _    ___   ___   _   _
 | |  / _ \ / __| /_\ | |
 | |_| (_) | (__ / _ \| |__
 |____\___/ \___/_/_\_\____|___ ___  _  _ ___
 | __| | | | \| |/ __|_   _|_ _/ _ \| \| / __|
 | _|| |_| | .` | (__  | |  | | (_) | .` \__ \
 |_|  \___/|_|\_|\___| |_| |___\___/|_|\_|___/

*/

function checkAiSqlForError(sql: string) {
  return sql.toUpperCase().startsWith("ERROR") ? 1 : 0;
}

async function invokeFlow(
  flowIdentifier: string | undefined,
  flowAliasIdentifier: string | undefined,
  inputs: any[],
) {
  const command = new InvokeFlowCommand({
    flowIdentifier,
    flowAliasIdentifier,
    inputs,
  });

  let rval = "";

  try {
    let flowResponse: any = {};
    const response = await bedrock_client.send(command);

    if (response && response.responseStream) {
      for await (const chunkEvent of response.responseStream) {
        const { flowOutputEvent, flowCompletionEvent } = chunkEvent;

        if (flowOutputEvent) {
          flowResponse = { ...flowResponse, ...flowOutputEvent };
          rval = flowResponse?.content?.document;
          log(`Generated SQL = '${rval}'`, false);
        } else if (flowCompletionEvent) {
          if (flowCompletionEvent.completionReason == "SUCCESS") {
            log(`flowCompletionEvent: Success`, false);
          } else {
            log(`flowCompletionEvent: ${flowCompletionEvent}`, true);
          }
        }
      }
    }
    return rval;
  } catch (error) {
    log(`Error invoking flow: '${error}'`, true);
    throw error;
  }
}

function log(msg: string, critical: boolean) {
  // when critical is 'true' msg will always be displayed
  // otherwise msg is only displayed if debug is true

  try {
    if (critical) {
      console.log(`${bold(white("LOG:"))} ${bold(msg)}`);
    } else if (debug) {
      console.log(`${bold(white("LOG:"))} ${gray(msg)}`);
    }
  } catch (error) {
    console.error("Error in logging: ", error);
  }
}

async function runSQL(sql: string) {
  log(`Running: '${sql}'`, false);

  try {
    const result = await db_client.query(sql);
    log(result, false);
    return result;
  } catch (error) {
    log(error, true);
    return error;
  }
}

/*
  ___  ___  _   _ _____ ___ ___
 | _ \/ _ \| | | |_   _| __/ __|
 |   / (_) | |_| | | | | _|\__ \
 |_|_\\___/ \___/  |_| |___|___/

*/

// Default route, serves static HTML page index.html
app.use(async (ctx, next) => {
  try {
    await ctx.send({
      root: `${Deno.cwd()}/public`,
      index: "index.html",
    });
  } catch (error) {
    log(error, true);
    await next();
  }
});

// route to convert question to SQL
router.post("/txt2sql", async (ctx) => {
  try {
    const json = await ctx.request.body.json();
    
    if (!json.question) {
      ctx.response.status = 400;
      ctx.response.body = { error: "Question is required" };
      return;
    }

    const inputs = [
      {
        content: { document: json.question },
        nodeName: "FlowInputNode",
        nodeOutputName: "document",
      },
    ];

    const sql = await invokeFlow(flowIdentifier, flowAliasIdentifier, inputs);
    const hasError = checkAiSqlForError(sql);

    if (hasError) {
      log(`SQL not generated`, false);
      ctx.response.body = { sql, dbResult: null };
    } else if (json.autoRun) {
      const dbResult = await runSQL(sql);
      ctx.response.body = { sql, dbResult };
    } else {
      ctx.response.body = { sql, dbResult: null };
    }
  } catch (error) {
    log(`Error in /txt2sql: ${error}`, true);
    ctx.response.status = 500;
    ctx.response.body = { error: "Internal server error" };
  }
});

// route to run SQL
router.post("/sql", async (ctx) => {
  const json = await ctx.request.body.json();

  const result = await runSQL(json.sql);
  ctx.response.body = { dbResult: result };
});

/*
  ___ _            _
 / __| |_ __ _ _ _| |_
 \__ \  _/ _` | '_|  _|
 |___/\__\__,_|_|  \__|

*/

// Add router middleware
app.use(router.routes());
app.use(router.allowedMethods());

log("Server running on http://localhost:8000\n", true);
await app.listen({ port: 8000 });
