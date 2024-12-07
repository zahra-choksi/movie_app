import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_app/features/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:movie_app/features/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_app/features/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movie_app/features/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:movie_app/injection_container.dart';
import 'features/presentation/pages/home_screen.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie app',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              create:(context) => getIt<PopularMoviesBloc>()..add(FetchPopularMovies())
          ),
          BlocProvider(
              create:(context) => getIt<TrendingMoviesBloc>()..add(FetchTrendingMovies())
          ),
          BlocProvider(
              create:(context) => getIt<SearchMoviesBloc>()
          )
        ],
        child: const HomeScreen(),
      ),

    );
  }
}
