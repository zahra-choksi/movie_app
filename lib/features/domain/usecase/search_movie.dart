

import 'package:dartz/dartz.dart';

import '../../../core/errors/server_failure.dart';
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;
  SearchMovies(this.repository);

  Future<Either<Failure,List<Movie>>> call(String query) async {
    return await repository.searchMovies(query);
  }
}