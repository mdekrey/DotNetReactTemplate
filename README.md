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

- Full README
- dotnet template definition
- CI/CD
    - Publish template to NuGet as a package

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

## Local testing of templates

`dotnet new` templates can be installed either via packages or folders. To
install or uninstall a single template, use the folder path:

```sh
# Install
dotnet new install <folder>
# example
dotnet new install template/content/vitereact

# Uninstall
dotnet new uninstall <folder>
# example
dotnet new uninstall template/content/vitereact
```

This repository packages templates as a nuget package automatically when built.
NuGet packages are cached locally per version, so each time you build, you need
to specify a unique version to be able to install it. For instance:

```sh
dotnet build -p:Version=0.0.1-local.1
# OR
dotnet build -p:VersionSuffix=local.1

# The full file path is output as the last line of the build
dotnet new install artifacts/packages/Debug/DeKreyConsulting.Templates.CompleteDotnetReactSpa.0.0.1-local.1.nupkg
```

To uninstall a package this way, only the package name is needed:
```sh
# Uninstall
dotnet new uninstall DeKreyConsulting.Templates.CompleteDotnetReactSpa
```
