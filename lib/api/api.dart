import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  factory ApiClient.create({required String? apiUrl}) {

    final dio = Dio();
    if (apiUrl != null) {
      return ApiClient(dio, baseUrl: apiUrl);
    }
    return ApiClient(dio);
  }

  @GET('/birthdays')
  Future<String> getBirhdays();

  @POST('/send-message')
  Future<String> getAnswer(@Query("question") String question);
}


// @JsonSerializable()
// class Task {
//   const Task({this.id, this.name, this.avatar, this.createdAt});

//   factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

//   final String? id;
//   final String? name;
//   final String? avatar;
//   final String? createdAt;

//   Map<String, dynamic> toJson() => _$TaskToJson(this);
// }