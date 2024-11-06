/*
  ___ __  __ ___  ___  ___ _____ ___
 |_ _|  \/  | _ \/ _ \| _ \_   _/ __|
  | || |\/| |  _/ (_) |   / | | \__ \
 |___|_|  |_|_|  \___/|_|_\ |_| |___/

*/

import { Application } from 'https://deno.land/x/oak/mod.ts';
import { Client } from 'https://deno.land/x/mysql/mod.ts';
import { Router } from 'https://deno.land/x/oak/mod.ts';
import { BedrockAgentRuntimeClient, InvokeFlowCommand } from 'npm:@aws-sdk/client-bedrock-agent-runtime';
import { bold, gray, white } from 'https://deno.land/std@0.224.0/fmt/colors.ts';

/*
  ___ _  ___   __ __   ___   ___  ___
 | __| \| \ \ / / \ \ / /_\ | _ \/ __|
 | _|| .` |\ V /   \ V / _ \|   /\__ \
 |___|_|\_| \_/     \_/_/ \_\_|_\|___/

*/

// read this first for logging
const debug: boolean = Deno.env.get('DEBUG')?.toLowerCase() === 'true';
log(`Debug mode set to '${debug}'`, true); // aways log this line

const awsAccessKey: string | undefined = Deno.env.get('AWS_ACCESS_KEY_ID');
log(`AWS_ACCESS_KEY_ID set to '${awsAccessKey}'`, false);

const awsRegion: string | undefined = Deno.env.get('AWS_REGION');
log(`AWS_REGION set to '${awsRegion}'`, false);

const awsSecretAccessKey: string | undefined = Deno.env.get(
  'AWS_SECRET_ACCESS_KEY',
);
log(
  `AWS_SECRET_ACCESS_KEY set to  '${awsSecretAccessKey?.substring(0, 6)}.....'`,
  false,
);

const dbHostname: string | undefined = Deno.env.get(
  'DB_HOSTNAME',
);
log(
  `DB_HOSTNAME set to  '${dbHostname}'`,
  false,
);

const flowAliasIdentifier: string | undefined = Deno.env.get(
  'AWS_BEDROCK_FLOW_ALIAS_IDENTIFIER',
);
log(
  `AWS_BEDROCK_FLOW_ALIAS_IDENTIFIER set to '${
    flowAliasIdentifier?.substring(
      0,
      6,
    )
  }.....'`,
  false,
);

const flowIdentifier: string | undefined = Deno.env.get(
  'AWS_BEDROCK_FLOW_IDENTIFIER',
);
log(
  `AWS_BEDROCK_FLOW_IDENTIFIER set to '${
    flowIdentifier?.substring(
      0,
      6,
    )
  }.....'`,
  false,
);

// Add after env var declarations
if (
  !awsAccessKey ||
  !awsSecretAccessKey ||
  !awsRegion ||
  !flowIdentifier ||
  !flowAliasIdentifier
) {
  console.error('Missing required environment variables');
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
  hostname: dbHostname,
  username: 'root',
  password: 'rootpassword',
  db: 'myapp',
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

function getAIStatus(sql: string) {
  return sql.toUpperCase().startsWith('ERROR') ? false : true;
}

async function getAuditLogRows() {
  const results = await db_client.query(
    `SELECT 
        question,
        mysql,
        aiStatus,
        mysqlStatus,
        ROUND(execAIElapsed / 1000.0, 3) AS execSeconds
        FROM ?? 
        ORDER BY execAIStart DESC
      `,
    ['AuditLog'],
  );

  return results;
}

async function getQuestionRows() {
  const results = await db_client.query(
    `SELECT
        id, 
        '' AS status,
        question, 
        mysql, 
        response
      FROM ??
      WHERE mysql IS NOT NULL 
      ORDER BY sortOrder; 
      `,
    ['Question'],
  );

  return results;
}

async function insertAuditLogRow(
  question: string,
  mysql: string,
  aiStatus: boolean,
  mysqlStatus: boolean,
  execAIStart: number,
  execAIEnd: number,
) {
  try {
    const t1 = new Date(execAIStart);
    const t2 = new Date(execAIEnd);
    await db_client.execute(
      `INSERT INTO AuditLog (awsAccessKey, awsRegion, flowIdentifier, 
        flowAliasIdentifier, question, mysql, aiStatus, mysqlStatus, 
        execAIStart, execAIEnd, execAIElapsed) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        awsAccessKey,
        awsRegion,
        flowIdentifier,
        flowAliasIdentifier,
        question,
        mysql,
        aiStatus,
        mysqlStatus,
        t1,
        t2,
        execAIEnd - execAIStart,
      ],
    );
  } catch (error) {
    console.error(error);
  }
}

async function invokeFlow(
  question: string,
  flowIdentifier: string | undefined,
  flowAliasIdentifier: string | undefined,
) {
  const inputs = [
      {
        content: { document: question },
        nodeName: 'FlowInputNode',
        nodeOutputName: 'document',
      },
  ];

  const command = new InvokeFlowCommand({
    flowIdentifier,
    flowAliasIdentifier,
    inputs,
  });

  let mysql: string = '';

  try {
    // deno-lint-ignore no-explicit-any
    let flowResponse: any = {};
    const response = await bedrock_client.send(command);

    if (response && response.responseStream) {
      for await (const chunkEvent of response.responseStream) {
        const { flowOutputEvent, flowCompletionEvent } = chunkEvent;

        if (flowOutputEvent) {
          flowResponse = { ...flowResponse, ...flowOutputEvent };
          mysql = flowResponse?.content?.document;
          log(`Question = '${question}'`, false);
          log(`Generated SQL = '${mysql}'`, false);
        } else if (flowCompletionEvent) {
          if (flowCompletionEvent.completionReason == 'SUCCESS') {
            log(`flowCompletionEvent: Success`, false);
          } else {
            //log(`flowCompletionEvent: ${flowCompletionEvent}`, true);
          }
        }
      }
    }
  } catch (error) {
    console.error(error);
  }

  return mysql;
}

function log(msg: string | object, critical: boolean) {
  // when critical is 'true' msg will always be displayed
  // otherwise msg is only displayed if debug is true

  try {
    if (typeof msg === 'object') {
      console.log(msg);
    } else {
      if (critical) {
        console.log(`${bold(white('LOG:'))} ${bold(msg)}`);
      } else if (debug) {
        console.log(`${bold(white('LOG:'))} ${gray(msg)}`);
      }
    }
  } catch (error) {
    console.error(error);
  }
}

async function runSQL(mysql: string) {
  let success = true;
  log(`Running: '${mysql}'`, false);

  try {
    const result = await db_client.query(mysql);
    log(JSON.stringify(result), false);
    return [result, success];
  } catch (error) {
    success = false;
    console.error(error);
    return [`${error}`, success];
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
      index: 'index.html',
    });
  } catch (error) {
    console.error(error);
    await next();
  }
});

router.get('/audit-api', async (ctx) => {
  try {
    const data = await getAuditLogRows();

    ctx.response.status = 200;
    ctx.response.headers.set('Content-Type', 'application/json');
    ctx.response.body = JSON.stringify(data);
    return;
  } catch (error) {
    console.error(error);
  }
});

router.get('/test-api', async (ctx) => {
  try {
    const data = await getQuestionRows();

    ctx.response.status = 200;
    ctx.response.headers.set('Content-Type', 'application/json');
    ctx.response.body = JSON.stringify(data);
    return;
  } catch (error) {
    console.error(error);
  }
});

// route to convert question to SQL
router.post('/txt2sql', async (ctx) => {
  try {
    // deno-lint-ignore no-explicit-any
    let dbResult: Promise<any> | string | null = null;
    let mysqlStatus: boolean = true;
    const json = await ctx.request.body.json();

    if (!json.question) {
      ctx.response.status = 400;
      ctx.response.body = { error: 'Question is required' };
      return;
    }

    const execAIStart = Date.now();
    const mysql = await invokeFlow(
      json.question,
      flowIdentifier,
      flowAliasIdentifier,
    );
    const execAIEnd = Date.now();

    const aiStatus = getAIStatus(mysql);

    if (!aiStatus) {
      log(`SQL not generated`, false);
    } else if (json.autoRun) {
       [dbResult, mysqlStatus] = await runSQL(mysql.toString());
    }

    insertAuditLogRow(json.question, mysql, aiStatus, mysqlStatus, execAIStart, execAIEnd);

    ctx.response.body = { mysql, dbResult, success: aiStatus && mysqlStatus };
  } catch (error) {
    console.error(error);
    ctx.response.status = 500;
    ctx.response.body = { error: 'Internal server error' };
  }
});

// route to run SQL
router.post('/sql', async (ctx) => {
  const json = await ctx.request.body.json();

  const [result, success] = await runSQL(json.sql);
  ctx.response.body = { dbResult: result, success };
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

log('Server running on http://localhost:8000\n', true);
await app.listen({ port: 8000 });
