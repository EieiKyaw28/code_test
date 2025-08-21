# Sky Cast Weather

Sky Cast Weather is a cross-platform Flutter application that displays current weather and forecasts for cities worldwide. It is designed as a code test and demonstrates clean architecture, state management with Riverpod, and integration with a real-world weather API. This project is developed in Riverpod Layer-First Architecture.

## Weather API

This project uses [WeatherAPI.com](https://www.weatherapi.com/) to fetch weather data.  
**WeatherAPI.com** provides a RESTful API for accessing current weather, forecasts, and location search.  
You need a free API key from [WeatherAPI.com](https://www.weatherapi.com/signup.aspx) to use the app.

- **API Base URL:** `https://api.weatherapi.com/v1`
- **Endpoints used:**
  - `/search.json` — Search for cities by name
  - `/current.json` — Get current weather by latitude/longitude
  - `/forecast.json` — Get 5-day weather forecast by latitude/longitude

Your API key and base URL are stored in the `.env` file:

```
API_KEY=your_api_key_here
BASE_URL=https://api.weatherapi.com/v1
```

## Main Use Cases

- **Search for a City:**  
  Enter a city name to search and select from matching locations.

- **View Current Weather:**  
  See the current temperature, weather condition, wind, humidity, and visibility for the selected city.

- **View 5-Day Forecast:**  
  Browse a summary of the upcoming week’s weather, including daily temperatures and conditions.

- **Hourly Forecast Details:**  
  Tap on a day to view hourly temperature and condition breakdowns.

- **Unit Toggle:**  
  Switch between Celsius and Fahrenheit.

- **Location Permission:**  
  On supported platforms, allow location access to get weather for your current position.

## Project Structure

```
lib/
  domain/         # Data models
  presentation/   # UI screens and widgets
  provider/       # Riverpod providers
  repository/     # Data repositories
  service/        # API and session services
  env.dart        # Environment variable access
assets/
  images/         # Weather images
  jsons/          # Lottie animations
```

## Getting Started

1. **Install Flutter:**  
   [Flutter installation guide](https://docs.flutter.dev/get-started/install)

2. **Get dependencies:**  
   ```
   flutter pub get
   ```

3. **Set up your API key:**  
   - Copy `.env.example` to `.env` (or edit `.env` directly)
   - Add your WeatherAPI.com API key or you can use the exisiting one

4. **Run the app:**  
   ```
   flutter run
   ```

## Notes

- This project is for demonstration and code review purposes.
- The API key in `.env` is required for the app to function.
- The app supports Android, iOS, Web, Windows, macOS, and Linux.

---

*For any questions, see [WeatherAPI.com documentation](https://www.weatherapi.com/docs/) or you can contact me via eieikyaw.dev@gmail.com.*