import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_app/features/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movie_app/features/presentation/bloc/trending_movies/trending_movies_state.dart';
import 'package:movie_app/features/presentation/pages/movies_list.dart';

import '../bloc/popular_movies/popular_movies_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final bckImage = 'https://w0.peakpx.com/wallpaper/732/875/HD-wallpaper-anonymous-black-cool-dark-guy-foux-hacker-scary-tech.jpg';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hii  Zahra ',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            Text(
              'TDD - Movie App',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
          ],
        ),
        actions:  const [
          Padding(
              padding: EdgeInsets.all(20),
            child: Icon(
                Icons.search,
              color: Colors.white,
            ),

            ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 290,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(bckImage),
                    fit: BoxFit.cover
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Trending Movies",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
              BlocBuilder<TrendingMoviesBloc,TrendingMoviesState>(
                  builder: (context,state){
                    if(state is TrendingMoviesLoading){
                      return const CircularProgressIndicator();
                    } else if (state is TrendingMoviesLoaded){
                      return MoviesList(movies: state.movies);
                    } else if (state is TrendingMovieError){
                      return Text(state.message);
                    }
                    return Container();
                  }
                  ),

              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Popular Movies",
                style:  TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
              BlocBuilder<PopularMoviesBloc,PopularMoviesState>(
                  builder: (context,state){
                    if(state is PopularMoviesLoading){
                      return const CircularProgressIndicator();
                    } else if (state is PopularMoviesLoaded){
                      return MoviesList(movies: state.movies);
                    } else if (state is PopularMoviesError){
                      return Text(state.message);
                    }
                    return Container();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
