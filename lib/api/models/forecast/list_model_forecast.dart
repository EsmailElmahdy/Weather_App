class ForecastModel {
  final List<ForecastList> forecastList;

  ForecastModel({required this.forecastList});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      forecastList: List<ForecastList>.from(
        json['list'].map((data) => ForecastList.fromJson(data)),
      ),
    );
  }
}

class ForecastList {
  final String date;
  final double tempMin;
  final double tempMax;

  ForecastList({
    required this.date,
    required this.tempMin,
    required this.tempMax,
  });

  factory ForecastList.fromJson(Map<String, dynamic> json) {
    return ForecastList(
      date: json['dt_txt'],
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
    );
  }
}
