import 'dart:convert';

import 'package:family/src/core/api/api_service.dart';
import 'package:family/src/core/models/family.dart';
import 'package:http/http.dart' as http;

class FamilyRepository {
  Future<List<Family>> getList() async {
    final response = await http.get(ApiService.baseUrl);
    final FamilyResponse data =
        FamilyResponse.fromJson(jsonDecode(response.body));
    return data.data;
  }

  Future<String> create(String nama, String kelamin, int parentId) async {
    final response = await http.post(
      ApiService.baseUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nama': nama,
        'kelamin': kelamin,
        'parentId': "$parentId",
      }),
    );
    final json = jsonDecode(response.body);
    return json['message'];
  }

  Future<String> update(
      int id, String nama, String kelamin, int parentId) async {
    final response = await http.patch(
      ApiService.baseUrl + '/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nama': nama,
        'kelamin': kelamin,
        'parentId': "$parentId",
      }),
    );
    final json = jsonDecode(response.body);
    return json['message'];
  }

  Future<String> delete(int id) async {
    final response = await http.delete(ApiService.baseUrl + '/$id');
    final json = jsonDecode(response.body);
    return json['message'];
  }
}
