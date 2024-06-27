
import 'package:equatable/equatable.dart';

abstract class PostsApiEvent extends Equatable{
  List<Object> get props => [];
}
class PostFetched extends PostsApiEvent{}
class SearchItem extends PostsApiEvent{
  final String stSearch;
  SearchItem(this.stSearch);
}