using CompleteDotnetReactSpa.Api;
using CompleteDotnetReactSpa.TestUtils;

namespace CompleteDotnetReactSpa.Environment;

public class EnvironmentControllerShould
{
	private readonly BaseWebApplicationFactory webApplicationFactory;

	public EnvironmentControllerShould()
	{
		webApplicationFactory = new BaseWebApplicationFactory();

	}

	[Fact]
	public async Task Test1()
	{

		// Arrange
		var client = webApplicationFactory
			.CreateClient();

		// Act
		var response = await client.GetEnvironmentInfo();

		// Assert
		response.Response.EnsureSuccessStatusCode(); // Status Code 200-299
		var okResult = Assert.IsType<Operations.GetEnvironmentInfoReturnType.Ok>(response);
		Assert.Equal("HEAD", okResult.Body.GitHash);
		Assert.Equal("unknown", okResult.Body.Tag);
	}
}
