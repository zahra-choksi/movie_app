import '../../domain/entity/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.overView,
    required super.posterPath
  });

  factory MovieModel.fromJson(Map<String,dynamic> json){
    return MovieModel(
        id: json ['id'],
        title: json ['title'],
        overView: json ['overview'],
        posterPath: json ['poster_path']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id': id,
      'title' :title,
      'overview' : overView,
      'poster_path' :posterPath,
    };
  }
}