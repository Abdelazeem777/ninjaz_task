import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_task/api_end_point.dart';
import 'package:ninjaz_task/core/exceptions/request_exception.dart';
import 'package:ninjaz_task/core/service/network_service.dart';
import 'package:ninjaz_task/features/home/data/datasources/home_remote_data_source.dart';
import 'package:ninjaz_task/features/home/data/models/post_model.dart';

class NetworkServiceMock extends Mock implements NetworkService {}

void main() {
  late NetworkServiceMock networkServiceMock;
  late HomeRemoteDataSource homeRemoteDataSource;

  setUp(() {
    networkServiceMock = NetworkServiceMock();
    homeRemoteDataSource = HomeRemoteDataSourceImpl(networkServiceMock);
  });

  group("getPosts", () {
    final posts = List.generate(
        5,
        (i) => PostModel(
            id: '$i',
            likes: i,
            tags: ['tag $i'],
            text: 'text $i',
            publishDate: DateTime(2021, 9, 1),
            owner: null));
    test('should return list of PostModel when the response code is 200',
        () async {
      // arrange
      when(() => networkServiceMock.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(baseUrl: ApiEndPoint.BASE_URL),
          statusCode: 200,
          data: {
            'data': posts.map((e) => e.toMap()).toList(),
          },
        ),
      );
      // act
      final result = await homeRemoteDataSource.getPosts();
      // assert
      expect(result, posts);
    });

    test('should throw RequestException when the response code is not 200',
        () async {
      // arrange
      when(() => networkServiceMock.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(baseUrl: ApiEndPoint.BASE_URL),
          statusCode: 400,
          data: 'error',
        ),
      );
      // act
      Future call() async => await homeRemoteDataSource.getPosts();
      // assert
      expect(() => call(), throwsA(isA<RequestException>()));
    });
  });
}
