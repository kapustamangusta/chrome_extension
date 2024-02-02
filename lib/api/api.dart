import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:retrofit/retrofit.dart';

import 'models/models.dart';

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


  @POST("/chad-gpt/create-chat")
  Future<void> createChat(@Query("uidClient") String uidClient,@Query("chatNumber") String chatNumber, @Body() Map<String, dynamic> data);

  @POST('/chad-gpt/send-message-in-chat')
  Future<String> sendMessage(@Query("uidClient") String uidClient,@Query("chatNumber") String chatNumber, @Body() Map<String, dynamic> data);

   @GET('/chad-gpt/get-messages-from-chat')
  Future<List<Messages>> getMessagesFromChat(@Query("uidClient") String uidClient,@Query("chatNumber") String chatNumber);

  @GET('/chad-gpt/get-all-messages-from-chat')
  Future<List<ChatInfo>> getAllMessagesFromChats(@Query("uidClient") String uidClient);

  @DELETE('/chad-gpt/delete-chat')
  Future<void> deleteChat(@Query("uidClient") String uidClient, @Query("chatNumber") String chatNumber);
}


  // @override
  // Future<List<ChatInfo>> getAllMessagesFromChats(String uidClient) async {
  //   const _extra = <String, dynamic>{};
  //   final queryParameters = <String, dynamic>{r'uidClient': uidClient};
  //   final _headers = <String, dynamic>{};
  //   final Map<String, dynamic>? _data = null;
  //   final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
  //     method: 'GET',
  //     headers: _headers,
  //     extra: _extra,
  //   )
  //       .compose(
  //         _dio.options,
  //         '/chad-gpt/get-all-messages-from-chat',
  //         queryParameters: queryParameters,
  //         data: _data,
  //       )
  //       .copyWith(
  //           baseUrl: _combineBaseUrls(
  //         _dio.options.baseUrl,
  //         baseUrl,
  //       ))));
  //   List<ChatInfo> value = (jsonDecode(_result.data!) as List).map((dynamic i) {
  //     return ChatInfo.fromJson(i as Map<String, dynamic>);
  //   }).toList();
  //   return value;
  // }