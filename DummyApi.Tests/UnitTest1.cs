using DummyApi.Controllers;
using Microsoft.Extensions.Logging;
using NUnit.Framework.Internal;

namespace DummyApi.Tests
{
    public class Tests
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void TestController()
        {
            WeatherForecastController controller = new WeatherForecastController();
            IEnumerable<WeatherForecast> result = controller.Get();
            Assert.AreEqual(result.ToList().Count, 5);
        }

    }
}