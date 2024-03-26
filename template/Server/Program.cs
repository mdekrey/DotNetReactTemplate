#pragma warning disable CA1861 // Avoid constant arrays as arguments - the envfile list belongs here, and static arrays cannot be created in Program.cs
using dotenv.net;

DotEnv.Load(new DotEnvOptions(envFilePaths: [
	"../.env",
	".env",
]));

var builder = WebApplication.CreateBuilder(args);
var services = builder.Services;

// services.RegisterEnvironment(
// 	isProduction: builder.Environment.IsProduction(),
// 	environmentName: builder.Environment.EnvironmentName,
// 	buildConfig: builder.Configuration.GetSection("build"),
// 	dataProtectionConfig: builder.Configuration.GetSection("DataProtection")
// );

var app = builder.Build();

app.UseHealthChecks("/health");

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

#pragma warning disable ASP0014 // Suggest using top level route registrations - this seems to be necessary to prevent the SPA middleware from overwriting controller requests
app.UseEndpoints(endpoints =>
	{
		endpoints.MapControllers();
	});
#pragma warning restore ASP0014 // Suggest using top level route registrations


// Keep stray POSTs from hitting the SPA middleware
// Based on a comment in https://github.com/dotnet/aspnetcore/issues/5192
app.MapWhen(context => context.Request.Method == "GET" || context.Request.Method == "CONNECT", (when) =>
{
	// Force lookup so bundle.js doesn't get cached and changes get ignored
	// app.UseCacheControlForSpaPages();
	app.UseSpaStaticFiles();
	app.UseSpa(spa =>
	{
#if DEBUG
		if (app.Environment.IsDevelopment())
		{
			spa.Options.SourcePath = "../ui";

			spa.UseViteDevelopmentServer("node_modules/.bin/vite", "--port {port}");
		}
#endif
	});
});

app.Run();
