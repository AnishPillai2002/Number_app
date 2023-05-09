import 'package:http/http.dart' as http;

Future<String?> getNumberFact({required int num}) async {
  try {
    final response =
        await http.get(Uri.parse("http://numbersapi.com/$num?json."));

    return (response.body);
  } catch (error) {
    return "No Data on this Number";
  }
}
