import 'package:clean_architecture/0_data/data_sources/advice_remote_datasource.dart';
import 'package:clean_architecture/0_data/exceptions/exception.dart';
import 'package:clean_architecture/0_data/models/advice_model.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart';

import 'advice_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('should return AdviceModel', () {
    test('when Client response was 200 and has valid data', () async {
      final mockClient = MockClient();
      final adviceRemoteDatasourceUnderTest =
          AdviceRemoteDatasourceImpl(client: mockClient);
      const responseBody = '{"advice": "test advice", "advice_id": 1}';

      when(mockClient.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice'),
        headers: {
          'content-type': 'application/json ',
        },
      )).thenAnswer(
          (realInvocation) => Future.value(Response(responseBody, 200)));

      final result =
          await adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();

      expect(result, const AdviceModel(advice: 'test advice', id: 1));
    });
  });

  group('should throw', () {
    test('when Client response was not 200', () {
      final mockClient = MockClient();
      final adviceRemoteDatasourceUnderTest =
          AdviceRemoteDatasourceImpl(client: mockClient);
      // const responseBody = '{"advice": "test advice", "advice_id": 1}';

      when(mockClient.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice'),
        headers: {
          'content-type': 'application/json ',
        },
      )).thenAnswer((realInvocation) => Future.value(Response('', 201)));

      final result = adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();

      expect(
        () => result,
        throwsA(isA<ServerException>()),
      );
    });

    test('when Client get type error and response was 200', () {
      final mockClient = MockClient();
      final adviceRemoteDatasourceUnderTest =
          AdviceRemoteDatasourceImpl(client: mockClient);
      const responseBody = '{"advice": "test advice"}';

      when(mockClient.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice'),
        headers: {
          'content-type': 'application/json ',
        },
      )).thenAnswer(
          (realInvocation) => Future.value(Response(responseBody, 200)));

      final result = adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();

      expect(
        () => result,
        throwsA(isA<TypeError>()),
      );
    });
  });
}
