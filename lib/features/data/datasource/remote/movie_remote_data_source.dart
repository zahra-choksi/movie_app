import 'package:movie_app/features/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {

  Future<List<MovieModel>> getTrendingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> searchMovies(String query);
}