using System.Diagnostics;

namespace CompleteDotnetReactSpa.Environment;

public static class TracingHelper
{
	public static readonly ActivitySource ActivitySource = new("CompleteDotnetReactSpa");

	public static Activity? StartActivity(string name, ActivityKind kind = ActivityKind.Internal)
	{
		return ActivitySource.StartActivity(name, kind);
	}
}
