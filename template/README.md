# Modern .NET Server + React with Vite

A web application starter with a Backend for Frontend built with .NET, with an
OpenAPI file to define the API layer, along with a UI built with React and Vite.

Includes:
- MSBuild Tooling
	- Single command `dotnet build` to build server and UI
	- Single command `dotnet test` to run both backend and frontend tests
	- `sln` file for Visual Studio support
- .NET Server
	- OpenAPI generation
	- OpenTelemetry setup
	- xUnit Tests
	- .env file support
- UI
	- React via Vite
	- OpenAPI generation
	- Vitest setup
- Docker
- Code cleanliness
	- Editorconfig with `dotnet format`
	- eslint
	- prettier

See the generated README.md for more details.

## How to Use

Install the templates:

```sh
dotnet new install DeKreyConsulting.Templates.CompleteDotnetReactSpa
```

Use them:

```sh
# Create a full site including OpenAPI, Server, React front-end, and front-end
# OpenAPI client. Includes unit tests, pnpm, and dotnet build framework.
dotnet new dekreycompletereactapispa -n <new-solution-name>

# Creates a blank solution with .NET and pnpm build tooling.
dotnet new dekreymsbuildviteframework -n <new-solution-name>

# Create a new React UI project
dotnet new dekreymsbuildvitereact -n <ui-project-name> -N <npm-scope>

# Create a new TS project for use with the MSBuild Vite Framework
dotnet new dekreymsbuildmtslibrary -n <ui-project-name> -N <npm-scope>
```
