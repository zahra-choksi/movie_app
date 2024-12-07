import '../../../domain/entity/movie.dart';

abstract class TrendingMoviesState {}

final class TrendingMoviesInitial extends TrendingMoviesState {}

final class TrendingMoviesLoading extends TrendingMoviesState{}

final class TrendingMoviesLoaded extends TrendingMoviesState{
  final List<Movie> movies;
  TrendingMoviesLoaded(this.movies);
}

final class TrendingMovieError extends TrendingMoviesState{
  final String message;
  TrendingMovieError(this.message);
}
