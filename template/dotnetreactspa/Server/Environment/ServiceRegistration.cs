using Microsoft.AspNetCore.DataProtection;

using OpenTelemetry.Resources;
using OpenTelemetry.Trace;

namespace CompleteDotnetReactSpa.Environment;

public static class ServiceRegistration
{
	internal static void RegisterEnvironment(this IServiceCollection services,
		bool isProduction,
		string environmentName,
		IConfigurationSection buildConfig,
		IConfigurationSection dataProtectionConfig)
	{
		services.AddHealthChecks();
		services.AddControllers(config =>
		{
			config.Filters.Add(new MvcActionTracing());
		});

		services.Configure<BuildOptions>(buildConfig);

		services.AddSpaStaticFiles(configuration =>
		{
			configuration.RootPath = "wwwroot";
		});

		services.RegisterDataProtection(isProduction, dataProtectionConfig);
		services.RegisterOpenTelemetry(environmentName, buildConfig);
	}

	private static void RegisterDataProtection(this IServiceCollection services, bool isProduction, IConfigurationSection dataProtectionConfig)
	{
		if (isProduction)
		{
			var dataProtectionBuilder = services.AddDataProtection();
			// TODO: add specific DataProtection provider for production
		}
	}

	private static void RegisterOpenTelemetry(this IServiceCollection services, string environmentName, IConfigurationSection buildConfig)
	{
		services
			.AddOpenTelemetry()
			.WithTracing(tracerProviderBuilder =>
			{
				tracerProviderBuilder.AddOtlpExporter();
				tracerProviderBuilder
					.AddSource(TracingHelper.ActivitySource.Name)
					.ConfigureResource(resource =>
						resource.AddService(TracingHelper.ActivitySource.Name, serviceVersion: buildConfig["GitHash"] ?? "local")
						.AddAttributes(new Dictionary<string, object>
						{
							{ "deployment.environment", environmentName }
						}))
					.AddAspNetCoreInstrumentation(cfg =>
					{
						cfg.RecordException = true;
					});
			});
	}
}
