

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:movie_app/features/presentation/bloc/trending_movies/trending_movies_state.dart';

import '../../../domain/usecase/get_trending_movie.dart';

class TrendingMoviesBloc extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies getTrendingMovies;

  TrendingMoviesBloc({
    required this.getTrendingMovies
}) : super(TrendingMoviesInitial())  {
    on<FetchTrendingMovies>((event, emit)async {
      emit(TrendingMoviesLoading());
      final failureOrMovies = await getTrendingMovies.call();
      failureOrMovies.fold(
              (failure) => emit(TrendingMovieError(failure.toString())),
              (movies) => emit(TrendingMoviesLoaded(movies))
      );
    });
  }
}
