# Modern .NET + React with Vite

A modern full React SPA application with .NET backend-for-frontend.

## Features (WIP):
- [ ] Full README
- [ ] MSBuild Tooling
    - [X] Integrate Frontend build
    - [X] Integrate Frontend tests
    - [X] Handle Visual Studio experiencce
    - [X] Integrate Backend code cleanliness
    - [X] Integrate Frontend code cleanliness
- [ ] .NET Server
    - [X] OpenAPI generation
    - [X] SPA service
    - [X] Telemetry
    - [X] Tests
    - [X] .env file support
- [ ] UI
    - [X] PNPM
    - [X] nvmrc
    - [X] Vite
    - [X] Tests
    - [ ] Initial shared library
    - [X] OpenAPI generation
- [ ] Docker
- [X] Code cleanliness
    - [X] Editorconfig
    - [X] dotnet format
    - [X] eslint
    - [X] prettier

## Template Features:

- [ ] Full README
- [ ] dotnet template definition
- [ ] CI/CD
    - [ ] Publish template to NuGet as a package
    - [ ] Publish to a (orphaned) Branch to use as a 0.0 service line

## Intentionally excluded features:

- `dotnet user-secrets` is not set up by default because the command line to use
  a secret will add a custom Guid; if it is set up in this template, all
  projects built from the template would by default share secrets, which would
  be a security concern on development machines.