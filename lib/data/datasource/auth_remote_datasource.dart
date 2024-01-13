import 'package:dartz/dartz.dart';
import 'package:flutter_siakad_app/common/constants/variables.dart';
import 'package:flutter_siakad_app/data/datasource/auth_local_datasource.dart';
import 'package:flutter_siakad_app/data/models/request/auth_request_model.dart';
import 'package:flutter_siakad_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> login(
      AuthRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: requestModel.toJson(),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      return left("The provided credentials are incorrect.");
    }
  }

  Future<Either<String, String>> Logout() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await AuthLocalDatasource().getToken()}'
    };

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right("Logout succesfully");
    } else {
      return left("Unauthenticated");
    }
  }
}
