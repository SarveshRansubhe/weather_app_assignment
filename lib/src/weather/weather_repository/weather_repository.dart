import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_assignment_assignment/src/shared/http/api_provider.dart';
import 'package:weather_app_assignment_assignment/src/weather/model/current_weather.dart';
import 'package:weather_app_assignment_assignment/src/weather/model/forecast_weather.dart';

class WeatherRepository {
  getCurrentWeather(
      {required String latitude, required String longitude}) async {
    debugPrint('$latitude-$longitude');
    Response response = await APiProvider().get('/v1/current.json', query: {
      'key': dotenv.env['API_KEY'],
      'q': '$latitude,$longitude',
      'aqi': 'no'
    });
    debugPrint(response.toString());
    return CurrentWeatherModel.fromJson(response.data);
  }

  getForecastWeather(
      {required String latitude, required String longitude}) async {
    debugPrint('$latitude-$longitude');
    Response response = await APiProvider().get(
      '/v1/forecast.json',
      query: {
        'key': dotenv.env['API_KEY'],
        'q': '$latitude,$longitude',
        'aqi': 'no',
        'days': '5',
        'alerts': 'no'
      },
    );
    debugPrint(response.toString());
    return ForecastWeatherModel.fromJson(response.data);
  }
}
