import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/errors/server_exception.dart';
import 'package:movie_app/core/errors/server_failure.dart';
import 'package:movie_app/features/data/datasource/remote/movie_remote_data_source.dart';
import 'package:movie_app/features/data/models/movie_model.dart';
import 'package:movie_app/features/data/repository/movie_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/domain/entity/movie.dart';
import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])

void main (){
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(remoteDataSource: mockMovieRemoteDataSource);
  });

  final tMoviesList = [
    const Movie(id: 1, title: 'Test Movie 1', overView: 'Desc 1', posterPath: '/image1'),
    const Movie(id: 2, title: 'Test Movie 2', overView: 'Desc 2', posterPath: '/image2'),
  ];
  final tMovieModelList = [
    const MovieModel(id: 1, title: 'Test Movie 1', overView: 'Desc 1', posterPath: '/image1'),
    const MovieModel(id: 2, title: 'Test Movie 2', overView: 'Desc 2', posterPath: '/image2'),
  ];

  const String tQuery = 'Inception';

  test('should get popular movies from the remote data source', () async {
    // arrange
    when(mockMovieRemoteDataSource.getPopularMovies())
    .thenAnswer((_) async => tMovieModelList);

    // act
    final result = await repository.getPopularMovies();

    // assert
    verify(mockMovieRemoteDataSource.getPopularMovies());
    expect(result, isA<Right<Failure,List<Movie>>>());
  });

  test('should get trending movies from the remote data source', () async {
    // arrange
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenAnswer((_) async => tMovieModelList);

    // act
    final result = await repository.getTrendingMovies();

    // assert
    verify(mockMovieRemoteDataSource.getTrendingMovies());
    expect(result, isA<Right<Failure,List<Movie>>>());
  });

  test('should get search movies from the remote data source', () async {
    // arrange
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenAnswer((_) async => tMovieModelList);

    // act
    final result = await repository.searchMovies(tQuery);

    // assert
    verify(mockMovieRemoteDataSource.searchMovies(tQuery));
    expect(result, isA<Right<Failure,List<Movie>>>());
  });

  test('should return a server Failure when the call to remote data source is unsuccessful', ()async {
    // arrange
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenThrow(ServerException());

    // act
    final result = await repository.getPopularMovies();

    // assert
    expect(result, isA<Left<ServerFailure,List<Movie>>>());


  });

  test('should return a server Failure when the call to remote data source is unsuccessful', ()async {
    // arrange
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenThrow(ServerException());

    // act
    final result = await repository.getTrendingMovies();

    // assert
    expect(result, isA<Left<ServerFailure,List<Movie>>>());
  });

  test('should return a server Failure when the call to remote data source is unsuccessful', ()async {
    // arrange
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenThrow(ServerException());

    // act
    final result = await repository.searchMovies(tQuery);

    // assert
    expect(result, isA<Left<ServerFailure,List<Movie>>>());


  });
}