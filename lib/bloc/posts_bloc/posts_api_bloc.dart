import 'package:bloc/bloc.dart';
import 'package:blocprovider/bloc/posts_bloc/posts_api_event.dart';
import 'package:blocprovider/bloc/posts_bloc/posts_api_state.dart';
import 'package:blocprovider/repository/posts_repository.dart';
import 'package:blocprovider/utils/enums.dart';

import '../../model/posts_model.dart';

class PostBloc extends Bloc<PostsApiEvent, PostsState>{
   List<PostsModel> tempPostList = [];
  PostRepository postRepository = PostRepository();
  PostBloc(): super(const PostsState()){
    on<PostFetched>(fetchPostApi);
    on<SearchItem>(_filterList);
  }
  void _filterList(SearchItem event, Emitter<PostsState> emit)async{
    if(event.stSearch.isEmpty){
      emit(state.copyWith(tempPostList: [], searchMessage: ''));
    }else{
      // tempPostList = state.postList.where((element) => element.id.toString() == event.stSearch.toString()).toList();
      tempPostList = state.postList.where((element) => element.email.toString().toLowerCase().contains(event.stSearch.toLowerCase())).toList();
      if(tempPostList.isEmpty){
        emit(state.copyWith(tempPostList: tempPostList, searchMessage: 'No Data Found'));
      }else{
        emit(state.copyWith(tempPostList: tempPostList));
      }
    }
}
  void fetchPostApi(PostFetched event, Emitter<PostsState> emit)async{
    await postRepository.fetchPost().then((value) {
      emit(state.copyWith(postStatus: PostStatus.suecss,
      message: 'success',
        postList: value
      ));
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      emit(state.copyWith(postStatus: PostStatus.faliure, message: error.toString()));
    });
  }
}