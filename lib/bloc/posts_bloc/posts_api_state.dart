import 'package:blocprovider/utils/enums.dart';
import 'package:equatable/equatable.dart';

import '../../model/posts_model.dart';

class PostsState extends Equatable {
  final PostStatus postStatus;
  final List<PostsModel> postList;
  final List<PostsModel> tempPostList;
  final String message;
  final String searchMessage;

  const PostsState({
    this.postStatus = PostStatus.loading,
    this.postList = const <PostsModel>[],
    this.tempPostList = const <PostsModel>[],
    this.message = '',
    this.searchMessage = '',
  });

  PostsState copyWith(
      {PostStatus? postStatus,
      List<PostsModel>? postList,
      String? message,
      List<PostsModel>? tempPostList,
      String? searchMessage}) {
    return PostsState(
      postStatus: postStatus ?? this.postStatus,
      postList: postList ?? this.postList,
      tempPostList: tempPostList ?? this.tempPostList,
      message: message ?? this.message,
      searchMessage: searchMessage ?? this.searchMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [postStatus, postStatus, tempPostList, message, searchMessage];
}
