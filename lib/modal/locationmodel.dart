class LocationModal {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String localtime;
  final String tzId;
  final int localtimeEpoch;

  LocationModal({
    required this.tzId,
    required this.localtimeEpoch,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.localtime,
  });

  factory LocationModal.getData(Map json) {
    return LocationModal(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
      localtimeEpoch: json['localtime_epoch'],
      tzId: json['tz_id'],
      localtime: json['localtime'],
    );
  }
}
