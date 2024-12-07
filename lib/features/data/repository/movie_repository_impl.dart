import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/server_failure.dart';
import 'package:movie_app/features/data/datasource/remote/movie_remote_data_source.dart';
import 'package:movie_app/features/data/models/movie_model.dart';
import 'package:movie_app/features/domain/entity/movie.dart';
import 'package:movie_app/features/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure,List<Movie>>> getPopularMovies()async {
    try {
      final movies = await remoteDataSource.getPopularMovies();
      return right(movies);
    } catch(e){
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<Movie>>> getTrendingMovies() async {
    try {
      final movies = await remoteDataSource.getTrendingMovies();
      return right(movies);
    } catch(e){
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<Movie>>> searchMovies(String query) async {
    try {
      final movies = await remoteDataSource.searchMovies(query);
      return right(movies);
    } catch(e){
      return Left(ServerFailure());
    }
  }


}