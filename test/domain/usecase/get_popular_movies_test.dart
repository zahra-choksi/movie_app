import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:movie_app/features/domain/entity/movie.dart';
import 'package:movie_app/features/domain/repository/movie_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/features/domain/usecase/get_popular_movie.dart';
import 'package:flutter_test/flutter_test.dart';


import 'get_popular_movies_test.mocks.dart';
@GenerateNiceMocks([MockSpec<MovieRepository>()])

void main(){
  late GetPopularMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetPopularMovies(mockMovieRepository);
  });

  final tMoviesList = [
    const Movie(id: 1, title: 'Test Movie 1', overView: 'Desc 1', posterPath: '/image1'),
    const Movie(id: 2, title: 'Test Movie 2', overView: 'Desc 2', posterPath: '/image2'),
  ];

  test('should get popular movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getPopularMovies())
        .thenAnswer((_) async => Right(tMoviesList));

    // act
    final result = await usecase();

    // assert
    expect(result, equals(Right(tMoviesList)));
    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);

  });
}