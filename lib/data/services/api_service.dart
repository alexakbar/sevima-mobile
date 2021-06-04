import 'package:http/http.dart' as http;

class ApiService {
  static final client = http.Client();
  static String baseUrl = "http://6b3e6fbea4fd.ngrok.io/api/v1/";
  static String imageUrl = "http://6b3e6fbea4fd.ngrok.io/";
}
