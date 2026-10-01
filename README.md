# Velo Chat

A full-stack chat application monorepo with a Flutter mobile client and a NestJS backend API.

## Repository structure

```
velo-chat/
├── backend/     # NestJS REST API (TypeScript)
├── velo_chat/   # Flutter mobile app (Android & iOS)
├── docs/        # Project documentation
└── README.md
```

## Tech stack

| Layer   | Technology                                                                                     |
| ------- | ---------------------------------------------------------------------------------------------- |
| Mobile  | Flutter, Dart `^3.13.4`, Riverpod 3, go_router 18, Dio 5, flutter_secure_storage, fluttertoast |
| Backend | NestJS 12, TypeScript 6 (ESM), Vitest 4, oxlint, Prettier, pnpm                                |

## Features

- Authentication flow with route guards: **Splash → Login → Home**
- Automatic redirects driven by auth state (`unknown`, `loggedOut`, `loggedIn`)
- Tokens persisted securely on-device (`flutter_secure_storage`)
- State management with Riverpod providers
- Dio HTTP client with interceptor scaffolding ready for API integration

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- [Node.js](https://nodejs.org/) 24+ and [pnpm](https://pnpm.io/)
- Android Studio / Xcode for running the mobile app

## Getting started

### Backend

```bash
cd backend
pnpm install
pnpm run start:dev
```

The API starts on `http://localhost:3000` (override with the `PORT` environment variable).

### Flutter app

```bash
cd velo_chat
flutter pub get
flutter run
```

## Available scripts

### Backend (`backend/`)

| Command               | Description               |
| --------------------- | ------------------------- |
| `pnpm run start`      | Start in development mode |
| `pnpm run start:dev`  | Start in watch mode       |
| `pnpm run start:prod` | Run the production build  |
| `pnpm run build`      | Compile with `nest build` |
| `pnpm run lint`       | Lint with oxlint          |
| `pnpm run format`     | Format with Prettier      |
| `pnpm test`           | Run unit tests (Vitest)   |
| `pnpm run test:e2e`   | Run end-to-end tests      |
| `pnpm run test:cov`   | Run tests with coverage   |

### Flutter app (`velo_chat/`)

| Command           | Description           |
| ----------------- | --------------------- |
| `flutter run`     | Run the app           |
| `flutter analyze` | Static analysis       |
| `flutter test`    | Run widget/unit tests |

## App architecture

```
velo_chat/lib/
├── main.dart                    # Entry point, wraps the app in ProviderScope
├── app.dart                     # MaterialApp.router + theme
├── providers/
│   ├── auth_provider.dart       # Auth state machine (unknown / loggedOut / loggedIn)
│   ├── router_provider.dart     # go_router configuration with auth-based redirects
│   └── token_storage_provider.dart
├── screens/
│   ├── splash.dart              # Startup screen while auth state is restored
│   ├── login.dart               # Email/password sign-in form
│   └── home.dart                # Post-login placeholder with logout
├── services/
│   └── connection_instance.dart # Dio HTTP client (baseUrl, interceptors)
└── shared/common/
    └── token_storage.dart       # Access/refresh token persistence
```

### Routes

| Route     | Screen   | Description                                       |
| --------- | -------- | ------------------------------------------------- |
| `/splash` | `Splash` | Initial route while the session is being restored |
| `/login`  | `Login`  | Shown when the user is logged out                 |
| `/home`   | `Home`   | Shown when the user is logged in                  |

## Documentation

Detailed technical documentation lives in [`docs/`](docs/):

- [Architecture](docs/architecture.md) — system design, repository layout, technology choices
- [Mobile app](docs/mobile.md) — Flutter structure, state management, routing, networking
- [Backend](docs/backend.md) — NestJS toolchain, conventions, testing
- [Authentication](docs/authentication.md) — session model, auth flows, planned API contract
- [Development guide](docs/development.md) — setup, workflow, code style, troubleshooting

## Current status

The project is in early development:

- Login is currently **mocked** (2-second delay, fake token) and will be replaced by a real API call through Dio.
- The Dio `baseUrl` is empty and needs to be pointed at the backend.
- The backend is a NestJS starter scaffold; feature modules (auth, chat, etc.) are yet to be implemented.
