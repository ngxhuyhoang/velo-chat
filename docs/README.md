# Velo Chat — Technical Documentation

Technical documentation for the Velo Chat monorepo. Start with the root [`README.md`](../README.md) for a quick overview and setup instructions.

## Index

| Document | Description |
| --- | --- |
| [Architecture](./architecture.md) | High-level system design, repository layout, technology choices and design decisions |
| [Mobile app](./mobile.md) | Flutter client: project structure, Riverpod state, routing and networking |
| [Backend](./backend.md) | NestJS API: toolchain, configuration, testing and current state |
| [Authentication](./authentication.md) | Session model, auth flows, token storage and the planned API contract |
| [Development](./development.md) | Local setup, daily workflow, code style, Git conventions and troubleshooting |

## Conventions used in these documents

- **Implemented** sections describe code that exists in the repository today.
- **Planned / TODO** sections describe agreed direction that is not implemented yet. Do not treat them as available behaviour.
- `bash` code blocks are commands to run from the directory stated in the text.

> ⚠️ The project is in early development. Several parts of the app are mocked (see [Authentication](./authentication.md)) and the backend is still a fresh NestJS scaffold.
