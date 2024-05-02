#!/usr/bin/env pwsh

dotnet new uninstall DeKreyConsulting.Templates.CompleteDotnetReactSpa
dotnet new install "$PSScriptRoot/content/msbuildviteframework" --force
dotnet new install "$PSScriptRoot/content/msbuildmtslibrary" --force
dotnet new install "$PSScriptRoot/content/vitereact" --force

function Add-XmlChildrenInto {
	[OutputType([System.Xml.XmlNode])] param ([xml] $sample, [System.Xml.XmlNode] $target)
	foreach ($child in $sample.FirstChild.ChildNodes) {
		$actualNode = $target.OwnerDocument.ImportNode($child, $true)
		$target.AppendChild($actualNode)
	}
}

$templateName = 'CompleteDotnetReactSpa'
$templatePath = "$PSScriptRoot/content/complete"
New-Item "$templatePath" -Force -ItemType:Directory
Push-Location "$templatePath"
try {
	Remove-Item -r "$templatePath/*"

	dotnet new dekreymsbuildviteframework -n $templateName

	function Initialize-Server() {
		dotnet new web -o Server
		dotnet sln add ./Server/Server.csproj
		dotnet add ./Server/Server.csproj package Azure.Extensions.AspNetCore.DataProtection.Blobs
		dotnet add ./Server/Server.csproj package Azure.Extensions.AspNetCore.DataProtection.Keys
		dotnet add ./Server/Server.csproj package dotenv.net
		dotnet add ./Server/Server.csproj package Microsoft.AspNetCore.SpaServices.Extensions
		dotnet add ./Server/Server.csproj package OpenTelemetry
		dotnet add ./Server/Server.csproj package OpenTelemetry.Exporter.OpenTelemetryProtocol
		dotnet add ./Server/Server.csproj package OpenTelemetry.Extensions.Hosting
		dotnet add ./Server/Server.csproj package OpenTelemetry.Instrumentation.AspNetCore
		dotnet add ./Server/Server.csproj package OpenTelemetry.Instrumentation.Runtime
		dotnet add ./Server/Server.csproj package PrincipleStudios.OpenApiCodegen.Json.Extensions
		dotnet add ./Server/Server.csproj package PrincipleStudios.OpenApiCodegen.Server.Mvc
		dotnet add ./Server/Server.csproj package PrincipleStudios.ViteDevelopmentServer
		dotnet add ./Server/Server.csproj reference ./Ui/Ui.esproj

		[xml]$serverProj = Get-Content './Server/Server.csproj'
		$serverProj.Project.RemoveChild($serverProj.Project.PropertyGroup)
		$serverProj.SelectSingleNode('/Project/ItemGroup/PackageReference[@Include="PrincipleStudios.OpenApiCodegen.Server.Mvc"]').SetAttribute('PrivateAssets', 'All')
		$viteDevServerPackage = $serverProj.SelectSingleNode('/Project/ItemGroup/PackageReference[@Include="PrincipleStudios.ViteDevelopmentServer"]')
		$viteDevServerPackage.ParentNode.RemoveChild($viteDevServerPackage)
		Add-XmlChildrenInto @'
<Project>
	<!-- Debug Dependencies -->
	<ItemGroup Condition=" '$(Configuration)' == 'Debug' ">
		<VitePkg />
	</ItemGroup>

	<ItemGroup>
		<OpenApiSchemaMvcServer Include="..\schemas\api.yaml" Link="Api\api.yaml" />
		<Watch Include=".env" />
		<Watch Include="../.env" />
	</ItemGroup>

	<Import Project="$(RepositoryEngineeringDir)jaeger/Jaeger.targets"  />
</Project>
'@ $serverProj.Project
		$target = $serverProj.SelectSingleNode('//VitePkg')
		$target.ParentNode.InsertAfter($viteDevServerPackage, $target)
		$target.ParentNode.RemoveChild($target)
		$serverProj.Save("$templatePath/Server/Server.csproj")
	}
	function Initialize-ServerTests() {
		dotnet new xunit -o Server.Tests
		dotnet sln add ./Server.Tests/Server.Tests.csproj
		dotnet add ./Server.Tests/Server.Tests.csproj package Microsoft.AspNetCore.Mvc.Testing
		dotnet add ./Server.Tests/Server.Tests.csproj package PrincipleStudios.OpenApiCodegen.Client
		dotnet add ./Server.Tests/Server.Tests.csproj reference ./Server/Server.csproj

		[xml]$serverTestProj = Get-Content './Server.Tests/Server.Tests.csproj'
		$serverTestProj.SelectSingleNode('/Project/ItemGroup/PackageReference[@Include="PrincipleStudios.OpenApiCodegen.Client"]').SetAttribute('PrivateAssets', 'All')
		Add-XmlChildrenInto @'
<Project>
	<ItemGroup>
		<OpenApiSchemaClient Include="..\schemas\api.yaml" Link="Api\api.yaml" />
	</ItemGroup>
</Project>
'@ $serverTestProj.Project
		$serverTestProj.Save("$templatePath/Server.Tests/Server.Tests.csproj")
	}

	function Initialize-Ui() {
		dotnet new dekreymsbuildvitereact -o Ui -N ui -V '../Server/wwwroot'
		dotnet add ./Ui/Ui.esproj reference ./Ui.Api/Ui.Api.esproj
		Push-Location Ui
		pnpm install '@ui/ui.api' -D
		Pop-Location

		$packageJson = Get-Content 'Ui/package.json' | ConvertFrom-Json
		$packageJson.scripts.start = 'cd ../Server && dotnet watch'
		$packageJson | ConvertTo-Json -Depth 100 | Set-Content -Path 'Ui/package.json'

		$tsconfig = Get-Content 'Ui/tsconfig.json' | ConvertFrom-Json
		$tsconfig.references = $tsconfig.references + @(@{ path = '../Ui.Api' })
		$tsconfig | ConvertTo-Json -Depth 100 | Set-Content -Path 'Ui/tsconfig.json'

		$html = Get-Content './Ui/index.html'
		$html = $html.Replace('<title>Ui</title>', "<title>$templateName</title>")
		$html | Set-Content './Ui/index.html'
	}

	function Initialize-UiApi() {
		dotnet new dekreymsbuildmtslibrary -o Ui.Api -N ui
		[xml]$uiApiProj = Get-Content './Ui.Api/Ui.Api.esproj'
		Add-XmlChildrenInto @'
	<ItemGroup>
		<Clean Include="src/generated/api/**/*" />
	</ItemGroup>
'@ $uiApiProj.SelectSingleNode('/Project/ItemGroup[CompileOutputs]')
Add-XmlChildrenInto @'
<Project>
	<Target Name="GenerateApi" BeforeTargets="Generation" DependsOnTargets="PnpmInstall" Inputs="$(SolutionRoot)schemas\api.yaml" Outputs="src/generated/api/.gitignore">
		<Exec WorkingDirectory="$(ProjectDir)" Command="pnpm openapi-codegen-typescript ../schemas/api.yaml src/generated/api/ -c -o codegen.config.yaml"/>
	</Target>
</Project>
'@ $uiApiProj.Project
		$uiApiProj.Save("$templatePath/Ui.Api/Ui.Api.esproj")

		Push-Location Ui.Api
		pnpm install '@tanstack/react-query'
		pnpm install '@principlestudios/openapi-codegen-typescript' '@principlestudios/openapi-codegen-typescript-fetch' '@types/node' 'tsc-alias' -D
		Pop-Location
	}

	Initialize-UiApi
	Initialize-Ui
	Initialize-Server
	Copy-Item -Path "$PSScriptRoot/src/complete" -Destination "../" -Recurse
	Initialize-ServerTests

	$removedFiles = @(
		'pnpm-lock.yaml'
		'Server.Tests/UnitTest1.cs'
		'Ui/src/pages/info/index.test.tsx'
		'Ui.Api/src/hello.mts'
		'Ui.Api/src/hello.test.mts'
	)
	foreach ($file in $removedFiles) {
		Remove-Item -Path $file
	}

	$tsconfig = Get-Content 'tsconfig.json' | ConvertFrom-Json
	$tsconfig.references = @(@{ path = './Ui' }, @{ path = './Ui.Api' })
	$tsconfig | ConvertTo-Json -Depth 100 | Set-Content -Path 'tsconfig.json'

	pnpm lint:fix

} finally {
	Pop-Location

	dotnet new uninstall "$PSScriptRoot/content/msbuildviteframework"
	dotnet new uninstall "$PSScriptRoot/content/msbuildmtslibrary"
	dotnet new uninstall "$PSScriptRoot/content/vitereact"
}
