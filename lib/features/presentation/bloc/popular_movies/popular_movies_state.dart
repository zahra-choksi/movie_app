import '../../../domain/entity/movie.dart';

abstract class PopularMoviesState {}

final class PopularMoviesInitial extends PopularMoviesState {}

final class PopularMoviesLoading extends PopularMoviesState{}

final class PopularMoviesLoaded extends PopularMoviesState{
  final List<Movie> movies;
  PopularMoviesLoaded(this.movies);
}

final class PopularMoviesError extends PopularMoviesState{
  final String message;
  PopularMoviesError(this.message);
}
