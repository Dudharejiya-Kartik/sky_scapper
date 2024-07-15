class CurrentModal {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final dynamic isDay;
  final double tempC;
  final double tempF;
  final double windKph;
  final double windMph;
  final int windDegree;
  final String windDir;
  final dynamic pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelsLikeC;
  final double feelsLikeF;
  final double windchillC;
  final double windchillF;
  final double heatindexC;
  final double heatindexF;
  final double dewPointC;
  final double dewPointF;
  final double visKm;
  final double visMiles;
  final dynamic uv;
  final double gustMph;
  final double gustKph;
  final ConditionModel conditionModel;

  CurrentModal({
    required this.isDay,
    required this.conditionModel,
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.windKph,
    required this.windMph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewPointC,
    required this.dewPointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory CurrentModal.fromJson(Map<String, dynamic> json) {
    return CurrentModal(
      conditionModel: ConditionModel.getData(json['condition']),
      isDay: json['is_day'],
      lastUpdatedEpoch: json['last_updated_epoch'],
      lastUpdated: json['last_updated'],
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      windKph: json['wind_kph'],
      windMph: json['wind_mph'],
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'],
      pressureIn: json['pressure_in'],
      precipMm: json['precip_mm'],
      precipIn: json['precip_in'] ?? 0.0,
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelsLikeC: json['feelslike_c'],
      feelsLikeF: json['feelslike_f'],
      windchillC: json['windchill_c'],
      windchillF: json['windchill_f'],
      heatindexC: json['heatindex_c'],
      heatindexF: json['heatindex_f'],
      dewPointC: json['dewpoint_c'],
      dewPointF: json['dewpoint_f'],
      visKm: json['vis_km'],
      visMiles: json['vis_miles'],
      uv: json['uv'],
      gustMph: json['gust_mph']?.toDouble() ?? 0.0,
      gustKph: json['gust_kph'],
    );
  }
}

class ConditionModel {
  final String text;
  final String icon;
  final int code;

  ConditionModel({required this.text, required this.icon, required this.code});

  factory ConditionModel.getData(Map json) {
    return ConditionModel(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}
