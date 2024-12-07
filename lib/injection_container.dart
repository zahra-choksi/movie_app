import 'package:get_it/get_it.dart';
import 'package:movie_app/features/data/datasource/remote/movie_remote_data_source.dart';
import 'package:movie_app/features/data/datasource/remote/movie_remote_data_source_impl.dart';
import 'package:movie_app/features/data/repository/movie_repository_impl.dart';
import 'package:movie_app/features/domain/repository/movie_repository.dart';
import 'package:movie_app/features/domain/usecase/get_popular_movie.dart';
import 'package:movie_app/features/domain/usecase/get_trending_movie.dart';
import 'package:movie_app/features/domain/usecase/search_movie.dart';
import 'package:movie_app/features/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_app/features/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_app/features/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void init(){
  // Bloc
  getIt.registerFactory(() => PopularMoviesBloc(getPopularMovies: getIt()));
  getIt.registerFactory(() => TrendingMoviesBloc(getTrendingMovies: getIt()));
  getIt.registerFactory(() => SearchMoviesBloc(searchMovies: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetPopularMovies(getIt()));
  getIt.registerLazySingleton(() => GetTrendingMovies(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));

  // repositories
  getIt.registerLazySingleton<MovieRepository>(() =>MovieRepositoryImpl(remoteDataSource: getIt()));

  // data sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(() =>MovieRemoteDataSourceImpl(client: getIt()));

  //Http service
  getIt.registerLazySingleton(() => http.Client());

}