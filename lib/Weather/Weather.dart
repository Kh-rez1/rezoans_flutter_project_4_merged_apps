import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late final WeatherFactory _wf;
  Weather? _weather;
  List<Weather>? _forecast;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _wf = WeatherFactory('0006cfc2b3e0a12c46a2c815a76d3fb0');
    _fetchWeatherData("Dhaka");
  }

  Future<void> _fetchWeatherData(String cityName) async {
    try {
      _weather = await _wf.currentWeatherByCityName(cityName);
      _forecast = await _wf.fiveDayForecastByCityName(cityName);
      setState(() {});
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  Future<void> _onSearch() async {
    String cityName = _searchController.text;
    if (cityName.isNotEmpty) {
      await _fetchWeatherData(cityName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchBar(),
            _buildUI(),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter city name',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearch,
          ),
        ],
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null || _forecast == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        _locationHeader(),
        _weatherIcon(),
        _currentTemp(),
        _extraInfo(),
        _forecastSection(),
      ],
    );
  }

  Widget _locationHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        _weather?.areaName ?? "",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _weatherIcon() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.tealAccent,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 70,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forecastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '7-Day Forecast',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 150, // Adjust the height according to your need
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _forecast!.length,
            itemBuilder: (context, index) {
              Weather forecast = _forecast![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
  _getWeekday(forecast.date ?? DateTime.now()),
  style: const TextStyle(
    color: Colors.white,
    fontSize: 16,
  ),
),

                    Image.network(
                      "http://openweathermap.org/img/wn/${forecast.weatherIcon}@4x.png",
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      '${forecast.temperature?.celsius?.toStringAsFixed(0)}° C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Define a method to get the weekday
  String _getWeekday(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: WeatherWidget(),
  ));
}
