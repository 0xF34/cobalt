FROM node:22-alpine

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
ENV NODE_ENV=production

WORKDIR /app

RUN corepack enable \
    && apk add --no-cache python3 make g++ git

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY api/package.json ./api/package.json
COPY web/package.json ./web/package.json
COPY packages/version-info/package.json ./packages/version-info/package.json

RUN pnpm install --prod --frozen-lockfile

COPY api ./api
COPY packages/version-info ./packages/version-info

WORKDIR /app/api
EXPOSE 9000
CMD ["node", "src/cobalt"]
