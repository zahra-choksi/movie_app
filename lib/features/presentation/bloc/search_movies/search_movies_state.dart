import '../../../domain/entity/movie.dart';

abstract class SearchMoviesState {}

final class SearchMoviesInitial extends SearchMoviesState {}

final class SearchMoviesLoading extends SearchMoviesState{}

final class SearchMoviesLoaded extends SearchMoviesState{
  final List<Movie> movies;
  SearchMoviesLoaded(this.movies);
}

final class SearchMoviesError extends SearchMoviesState{
  final String message;
  SearchMoviesError(this.message);
}
