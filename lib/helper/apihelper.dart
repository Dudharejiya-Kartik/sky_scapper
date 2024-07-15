import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiHelper {
  Logger logger = Logger();

  Future<String?> getData(String cityName) async {
    String apidata =
        'https://api.weatherapi.com/v1/forecast.json?key=9885c92eb56e4e0596d103301241906&q=$cityName}';
    Uri uri = Uri.parse(apidata);

    Response response = await http.get(uri);
    if (response.statusCode == 200) {
      logger.i("API Called");
      return response.body;
    } else {
      logger.e("Error");
      return null;
    }
  }

  getsearchdata(String cityName) async {
    String apidata =
        'https://api.weatherapi.com/v1/search.json?key=9885c92eb56e4e0596d103301241906&q=$cityName';
    Uri uri = Uri.parse(apidata);
    Response response = await http.get(uri);
    if (response.statusCode == 200) {
      logger.i("success");
      return response.body;
    } else {
      logger.e("error");
      return null;
    }
  }
}
