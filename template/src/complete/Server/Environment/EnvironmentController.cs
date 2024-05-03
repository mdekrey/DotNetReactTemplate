using CompleteDotnetReactSpa.Api;

using Microsoft.Extensions.Options;

namespace CompleteDotnetReactSpa.Environment
{
	public class EnvironmentController : ApiEnvControllerBase
	{
		private readonly BuildOptions buildOptions;

		public EnvironmentController(IOptions<BuildOptions> options)
		{
			buildOptions = options.Value;
		}

		protected override Task<GetEnvironmentInfoActionResult> GetEnvironmentInfo()
		{
			return Task.FromResult(
				GetEnvironmentInfoActionResult.Ok(new(buildOptions.GitHash, buildOptions.Tag))
			);
		}
	}
}
