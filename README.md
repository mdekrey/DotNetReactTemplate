# Modern .NET + React with Vite

A modern full React SPA application with .NET Backend for Frontend.

## Features

- Full README
- MSBuild Tooling
    - Integrate Frontend build
    - Integrate Frontend tests
    - Handle Visual Studio experiencce
    - Integrate Backend code cleanliness
    - Integrate Frontend code cleanliness
- .NET Server
    - OpenAPI generation
    - SPA service
    - Telemetry
    - Tests
    - .env file support
- UI
    - PNPM
    - nvmrc
    - Vite
    - Tests
    - Initial shared library
    - OpenAPI generation
- Docker
- Code cleanliness
    - Editorconfig
    - dotnet format
    - eslint
    - prettier

## Template Features

- [X] Full README
- [X] dotnet template definition
- [ ] CI/CD
    - [ ] Publish template to NuGet as a package

## Infrastructure improvements

These future improvements require other packages/projects to provide more
features:

- Support MSW 2.x to mock API requests more easily.
- Improved UI test harness in msbuild. While UI tests can fail `dotnet test`,
  full capabilities like listing tests, code coverage, and even reporting as a
  test assembly do not work.

## Intentionally excluded features:

- `dotnet user-secrets` is not set up by default because the command line to use
  a secret will add a custom Guid; if it is set up in this template, all
  projects built from the template would by default share secrets, which would
  be a security concern on development machines.