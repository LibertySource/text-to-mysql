FROM denoland/deno:latest

WORKDIR /app

COPY . .

RUN deno cache main.ts

CMD ["run", "--env", "--allow-env", "--allow-net", "--allow-read", "--allow-sys", "main.ts"]