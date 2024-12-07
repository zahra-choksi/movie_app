import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:movie_app/features/presentation/bloc/popular_movies/popular_movies_state.dart';
import '../../../domain/usecase/get_popular_movie.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesBloc({
    required this.getPopularMovies
}) : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>((event, emit)async {
      emit(PopularMoviesLoading());
      final failureOrMovies = await getPopularMovies.call();
      failureOrMovies.fold(
              (failure) => emit(PopularMoviesError(failure.toString())),
              (movies) => emit(PopularMoviesLoaded(movies))
      );
    });
  }
}
