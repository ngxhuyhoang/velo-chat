# Development guide

## Prerequisites

| Tool | Version | Notes |
| --- | --- | --- |
| Flutter SDK | Stable channel (Dart `^3.13.4`) | `flutter doctor` should be clean for Android/iOS |
| Node.js | 24+ | ESM support required |
| pnpm | Latest | `corepack enable` or install globally |
| Android Studio / Xcode | — | Required for emulators/simulators |

## First-time setup

### Flutter app

```bash
cd velo_chat
flutter pub get
flutter run          # pick a connected device/emulator
```

### Backend

```bash
cd backend
pnpm install
pnpm run start:dev
```

The API listens on `http://localhost:3000` by default; override with `PORT`:

```bash
PORT=4000 pnpm run start:dev
```

### Connecting the app to the API

`velo_chat/lib/services/connection_instance.dart` currently has an empty `baseUrl`:

| Target | URL to use |
| --- | --- |
| iOS simulator | `http://localhost:3000` |
| Android emulator | `http://10.0.2.2:3000` |
| Physical device | `http://<your-machine-LAN-IP>:3000` |

## Daily commands

| Task | Command | Directory |
| --- | --- | --- |
| Run app | `flutter run` | `velo_chat/` |
| Analyze | `flutter analyze` | `velo_chat/` |
| Format (Dart) | `dart format .` | `velo_chat/` |
| Widget tests | `flutter test` | `velo_chat/` |
| Backend dev server | `pnpm run start:dev` | `backend/` |
| Backend lint | `pnpm run lint` | `backend/` |
| Backend format | `pnpm run format` | `backend/` |
| Backend unit tests | `pnpm test` | `backend/` |
| Backend e2e tests | `pnpm run test:e2e` | `backend/` |

## Code style

### Dart / Flutter

- Lints: `flutter_lints` (see `velo_chat/analysis_options.yaml`); VS Code formats on save (`.vscode/settings.json`).
- File names: `snake_case.dart`.
- Providers: `xxxProvider`; notifier classes: `XxxController`.
- Screens are plain widgets; put state and side effects in providers.
- UI strings are currently Vietnamese; keep new copy consistent with the existing screens.

### TypeScript / NestJS

- Prettier: single quotes, trailing commas (`backend/.prettierrc`).
- oxlint: `typescript/no-floating-promises` is an **error** — always `await` or `void` promises.
- Relative imports must end in `.js` (ESM, `nodenext`).
- `strict` TypeScript is on; `strictPropertyInitialization` is disabled for Nest decorators.

## Git conventions

- Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/): `type(scope): summary`, e.g. `feat(auth): add token refresh interceptor`. Observed in history: `feat: init project`.
- Suggested branch naming: `feature/<topic>`, `fix/<topic>`, `docs/<topic>`.
- Keep commits focused; update these docs when architecture or flows change.

## Testing expectations

- New Riverpod logic (controllers, redirects) should get unit/widget tests.
- Backend units: `*.spec.ts` next to sources; e2e: `test/*.e2e-spec.ts`.
- `flutter test` currently fails because `widget_test.dart` still targets the default counter demo — replace it before relying on CI.

## Troubleshooting

| Symptom | Cause / fix |
| --- | --- |
| `nest start` fails with missing `app.controller` / `app.service` | The scaffold controller/service were removed; clean up the imports in `backend/src/app.module.ts` or recreate the files |
| API calls fail immediately | `dioProvider.baseUrl` is empty; configure it (see table above) |
| `Address already in use` on port 3000 | Run with `PORT=4000 pnpm run start:dev` or stop the other process |
| Login appears to hang for ~2 seconds | Expected: login is mocked with a 2-second delay |
| Flutter can't reach `localhost` from an emulator | Use `10.0.2.2` (Android emulator) or the machine's LAN IP (physical device) |

## Related documentation

- [Architecture](./architecture.md)
- [Mobile app](./mobile.md)
- [Backend](./backend.md)
- [Authentication](./authentication.md)
