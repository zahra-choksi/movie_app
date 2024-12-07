import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String overView;
  final String posterPath;

  const Movie({
   required this.id,
   required this.title,
   required this.overView,
   required this.posterPath
});

  @override
  List<Object?> get props => [id , title , overView, posterPath];
}