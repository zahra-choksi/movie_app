import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie_app/core/errors/server_exception.dart';
import 'package:movie_app/features/data/datasource/remote/movie_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/features/data/datasource/remote/movie_remote_data_source_impl.dart';
import 'movie_remote_data_source_test.mocks.dart';

 @GenerateMocks([http.Client])


void main(){
  late MovieRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tQuery = 'Avengers';
  const pUrl = "https://api.themoviedb.org/3/movie/popular?api_key=8e90bc2f1c03b0c193cd33820c055c37";
  const tUrl = "https://api.themoviedb.org/3/trending/movie/day?api_key=8e90bc2f1c03b0c193cd33820c055c37";
  const sUrl = "https://api.themoviedb.org/3/search/movie?query=$tQuery&api_key=8e90bc2f1c03b0c193cd33820c055c37";

  const String sampleApiResponse = '''
  {
    "page": 1,
    "results": [
        {
            "adult": false,
            "backdrop_path": "/tElnmtQ6yz1PjN1kePNl8yMSb59.jpg",
            "genre_ids": [
                16,
                12,
                10751,
                35
            ],
            "id": 1241982,
            "original_language": "en",
            "original_title": "Moana 2",
            "overview": "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced.",
            "popularity": 5883.763,
            "poster_path": "/yh64qw9mgXBvlaWDi7Q9tpUBAvH.jpg",
            "release_date": "2024-11-27",
            "title": "Moana 2",
            "video": false,
            "vote_average": 6.958,
            "vote_count": 307
         }
         ],
         "total_pages": 1,
         "total_results": 1
         }

        ''';


  test('should perform a GET request on a url to get popular movies ', () async {
    // arrange
    when(mockHttpClient.get(Uri.parse(pUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse,200));

    // act
    await dataSource.getPopularMovies();

    // assert
    verify(mockHttpClient.get(Uri.parse(pUrl)));

  });
  
  test('should perform a GET request on a url to get trending movies', () async {
    // arrange
    when(mockHttpClient.get(Uri.parse(tUrl)))
    .thenAnswer((_) async => http.Response(sampleApiResponse,200));

    // act
    await dataSource.getTrendingMovies();

    // assert
    verify(mockHttpClient.get(Uri.parse(tUrl)));
  });
  
  test('should perform a GET request on a url to get search movies', () async{
    // arrange
    when(mockHttpClient.get(Uri.parse(sUrl)))
    .thenAnswer((_) async=>http.Response(sampleApiResponse,200));

    // act
    await dataSource.searchMovies(tQuery);

    // assert
    verify(mockHttpClient.get(Uri.parse(sUrl)));
  });

  test('should throw a ServerException when the response code is 404', () async {
    // arrange
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response("Something went wrong" , 404));

    // act
    final call = dataSource.getTrendingMovies();

    // assert
    expect(() => call, throwsA(isA<ServerException>()));
  });


}