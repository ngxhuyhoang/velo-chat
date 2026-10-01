# Backend (NestJS)

REST API for Velo Chat, built with NestJS 12 and TypeScript (ESM) in [`backend/`](../backend).

## Toolchain

| Concern | Tool | Configuration |
| --- | --- | --- |
| Runtime | Node.js 24+ | — |
| Package manager | pnpm | `pnpm-lock.yaml` |
| Language | TypeScript 6, ESM | `"type": "module"`; `module`/`moduleResolution: nodenext`; `target: ES2023`; `strict: true` |
| Lint | oxlint | `.oxlintrc.json` — `typescript/no-floating-promises: error`, `typescript/no-explicit-any: off` |
| Format | Prettier | `.prettierrc` — `singleQuote: true`, `trailingComma: all` |
| Tests | Vitest 4 | `vitest.config.ts`, `vitest.config.e2e.ts` |

## Source layout (current)

```
backend/
├── src/
│   ├── main.ts          # Bootstrap: NestFactory.create(AppModule), listen(PORT ?? 3000)
│   └── app.module.ts    # Root module
├── test/
│   └── app.e2e-spec.ts  # E2E test (supertest)
├── nest-cli.json        # sourceRoot: src, deleteOutDir: true
└── tsconfig.json
```

## Bootstrap

`src/main.ts` creates the application and listens on `process.env.PORT ?? 3000`. It uses a top-level `await` (ESM).

## ESM conventions

Because the package is ESM (`"type": "module"`), **relative imports must include the `.js` extension**, even from `.ts` files:

```ts
import { AppModule } from './app.module.js';
```

This is required by `moduleResolution: nodenext` and applies to tests too.

## Scripts

| Command | Description |
| --- | --- |
| `pnpm install` | Install dependencies |
| `pnpm run start` | Start in development mode |
| `pnpm run start:dev` | Start with file watching |
| `pnpm run start:debug` | Start with `--watch` and debugger |
| `pnpm run start:prod` | Run the compiled build (`node dist/main`) |
| `pnpm run build` | Compile with `nest build` (outputs to `dist/`) |
| `pnpm run lint` | Type-aware oxlint over `src/` and `test/` |
| `pnpm run format` | Prettier over `src/` and `test/` |
| `pnpm test` | Unit tests (`**/*.spec.ts`) |
| `pnpm run test:watch` | Vitest watch mode |
| `pnpm run test:cov` | Coverage via `@vitest/coverage-v8` |
| `pnpm run test:e2e` | E2E tests (`**/*.e2e-spec.ts`) |

## Testing

- Unit tests are colocated with sources as `*.spec.ts`; globals are enabled (`describe`/`it`/`expect` without imports).
- E2E tests live in `test/*.e2e-spec.ts`, bootstrap `AppModule` with `@nestjs/testing` and call it with `supertest`.
- Both configurations load `vite-tsconfig-paths`, so path aliases (e.g. from `nest g library`) resolve in tests.

## Proposed feature module layout

When domain code is added, prefer one folder per feature module:

```
src/
├── main.ts
├── app.module.ts
└── modules/
    └── auth/
        ├── auth.module.ts
        ├── auth.controller.ts
        ├── auth.service.ts
        └── dto/
```

## Current status and known gaps

- The scaffold's `AppController`, `AppService` and their unit test were removed, but `app.module.ts` still imports them — **the backend will not compile until those imports are cleaned up or the modules are recreated**.
- No database, no auth module and no business endpoints exist yet.
- The default e2e test expects `GET /` to return `Hello World!`; it will need updating alongside the first real endpoint.
