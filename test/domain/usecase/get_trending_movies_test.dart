import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/features/domain/entity/movie.dart';
import 'package:movie_app/features/domain/repository/movie_repository.dart';
import 'package:movie_app/features/domain/usecase/get_trending_movie.dart';

import 'get_popular_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])

void main(){
  late GetTrendingMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTrendingMovies(mockMovieRepository);
  });

  final tMoviesList = [
    const Movie(id: 1, title: 'Test Movie 1', overView: 'Desc 1', posterPath: '/image1'),
    const Movie(id: 2, title: 'Test Movie 2', overView: 'Desc 2', posterPath: '/image2'),
  ];

  test('should get trending movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getTrendingMovies())
        .thenAnswer((_) async => Right(tMoviesList));

    // act
    final result = await usecase();

    // assert
    expect(result, equals(Right(tMoviesList)));
    verify(mockMovieRepository.getTrendingMovies());
    verifyNoMoreInteractions(mockMovieRepository);

  });
}