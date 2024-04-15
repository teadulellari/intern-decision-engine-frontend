import 'dart:convert';

import 'package:http/http.dart' as http;

// ApiService is a class that provides methods for making API calls
// to the decision engine.
class ApiService {
  final String _baseUrl = 'http://localhost:8080';
  String responseAmount = '';
  String responsePeriod = '';
  String responseError = '';
  http.Client httpClient;

  ApiService({http.Client? client}) : httpClient = client ?? http.Client();

  // requestLoanDecision sends a request to the API to get a loan decision
  // based on the provided personalCode, loanAmount, and loanPeriod.
  Future<Map<String, String>> requestLoanDecision(
      String personalCode, int loanAmount, int loanPeriod) async {
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/loan/decision'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'personalCode': personalCode,
        'loanAmount': loanAmount,
        'loanPeriod': loanPeriod,
      }),
    );

    try {
      // Decode the API response and update response data variables
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      // Return the response data as a map, handling null values if necessary
      return {
        'loanAmount': responseData['loanAmount'] != null ? responseData['loanAmount'].toString() : '0',
        'loanPeriod': responseData['loanPeriod'] != null ? responseData['loanPeriod'].toString() : '0',
        'errorMessage': responseData['errorMessage'] != null ? responseData['errorMessage'].toString() : '',
      };
    } catch (e) {
      // An unexpected error occurred when querying the server,
      // so an error is displayed.
      return {
        'loanAmount': '0',
        'loanPeriod': '0',
        'errorMessage': 'An unexpected error occurred.',
      };
    }
  }
}
