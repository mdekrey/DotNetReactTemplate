#!/usr/bin/env pwsh

dotnet new uninstall DeKreyConsulting.Templates.CompleteDotnetReactSpa
dotnet new install "$PSScriptRoot/content/msbuildviteframework" --force
dotnet new install "$PSScriptRoot/content/msbuildmtslibrary" --force
dotnet new install "$PSScriptRoot/content/vitereact" --force

New-Item "$PSScriptRoot/content/complete-2" -Force -ItemType:Directory
Push-Location "$PSScriptRoot/content/complete-2"
try {
	Remove-Item -r "$PSScriptRoot/content/complete-2/*"

	dotnet new dekreymsbuildviteframework -n CompleteDotnetReactSpa
	dotnet new dekreymsbuildvitereact -o Ui -N ui
	dotnet new dekreymsbuildmtslibrary -o Ui.Api -N ui
	dotnet new web -o Server
	dotnet sln add ./Server/Server.csproj
	dotnet new xunit -o Server.Tests
	dotnet sln add ./Server.Tests/Server.Tests.csproj

	dotnet add ./Server/Server.csproj reference ./Ui/Ui.esproj
	dotnet add ./Server.Tests/Server.Tests.csproj reference ./Server/Server.csproj
	dotnet add ./Ui/Ui.esproj reference ./Ui.Api/Ui.Api.esproj
	Push-Location Ui
	pnpm install '@ui/ui.api' -D
	Pop-Location

} finally {
	Pop-Location

	dotnet new uninstall "$PSScriptRoot/content/msbuildviteframework"
	dotnet new uninstall "$PSScriptRoot/content/msbuildmtslibrary"
	dotnet new uninstall "$PSScriptRoot/content/vitereact"
}
