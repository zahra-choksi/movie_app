

import 'package:dartz/dartz.dart';

import '../../../core/errors/server_failure.dart';
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;
  GetPopularMovies(this.repository);

  Future<Either<Failure,List<Movie>>> call() async {
    return await repository.getPopularMovies();
  }
}