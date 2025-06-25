FROM oven/bun:canary-alpine AS base

WORKDIR /usr/src/app

# install dependencies into temp directory
# this will cache them and speed up future builds

FROM base AS install
RUN mkdir -p /temp/prod
COPY package*.json bun.lockb /temp/prod/
RUN cd /temp/prod && bun install --frozen-lockfile


# copy node_modules from temp directory
# then copy all (non-ignored) project files into the image
FROM base AS builder
COPY --from=install /temp/prod/node_modules node_modules
COPY . .


RUN bun run build

FROM base AS runner
WORKDIR /usr/src/app
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder --chown=bun:bun /usr/src/app/.next/standalone ./

# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing

COPY --from=builder --chown=bun:bun /usr/src/app/.next/static ./.next/static
COPY --from=builder --chown=bun:bun /usr/src/app/public ./public

USER bun
EXPOSE 3000
# server.js is created by next build from the standalone output
# https://nextjs.org/docs/pages/api-reference/config/next-config-js/output
ENV HOSTNAME="0.0.0.0"
CMD ["bun", "server.js" ]