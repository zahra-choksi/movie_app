import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/features/domain/entity/movie.dart';
import 'package:movie_app/features/domain/repository/movie_repository.dart';
import 'package:movie_app/features/domain/usecase/search_movie.dart';

import 'get_popular_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])

void main(){
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  const String tQuery = 'Inception';

  final tMoviesList = [
    const Movie(id: 1, title: 'Test Movie 1', overView: 'Desc 1', posterPath: '/image1'),
    const Movie(id: 2, title: 'Test Movie 2', overView: 'Desc 2', posterPath: '/image2'),
  ];

  test('should get search movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(any))
        .thenAnswer((_) async => Right(tMoviesList));

    // act
    final result = await usecase(tQuery);

    // assert
    expect(result, equals(Right(tMoviesList)));
    verify(mockMovieRepository.searchMovies(tQuery));
    verifyNoMoreInteractions(mockMovieRepository);

  });
}