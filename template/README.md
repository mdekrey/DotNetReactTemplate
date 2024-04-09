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

Install the template:

	dotnet new install DeKrey.Templates.CompleteDotnetReactSpa

Use it:

	dotnet new reactapispa -n <new-solution-name>
