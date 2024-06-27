import 'package:bloc/bloc.dart';
import 'package:blocprovider/bloc/favourite_list_bloc/favourite_list_state.dart';
import 'package:blocprovider/repository/favourite_repository.dart';

import '../../model/favourite_item_model.dart';
import 'favouritte_list_event.dart';

class FavouriteListBloc extends Bloc<FavouriteEvents, FavouriteListStates> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> tempFavouriteList = [];

  FavouriteRepository favouriteRepository;
  FavouriteListBloc(this.favouriteRepository)
      : super(const FavouriteListStates()) {
    on<FetchFavouriteList>(fetchList);
    on<FavouriteItem>(_addFavouriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unselectItem);
    on<DeleteItem>(_deleteItem);
  }
  void fetchList(
      FetchFavouriteList event, Emitter<FavouriteListStates> emit) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.success));
  }

  void _addFavouriteItem(
      FavouriteItem event, Emitter<FavouriteListStates> emit) async {
    final index =
        favouriteList.indexWhere((element) => element.id == event.item.id);
    if(event.item.isFavourite){
      if(tempFavouriteList.contains(favouriteList[index])){
        tempFavouriteList.remove(favouriteList[index]);
        tempFavouriteList.add(event.item);
      }
    }else{
      if(tempFavouriteList.contains(favouriteList[index])){
        tempFavouriteList.remove(favouriteList[index]);
        tempFavouriteList.add(event.item);
      }
    }
    favouriteList[index] = event.item;
    emit(state.copyWith(favouriteItemList: List.from(favouriteList), tempFavouriteList: List.from(tempFavouriteList)));
  }
  void _selectItem(SelectItem event, Emitter<FavouriteListStates> emit) async {
    tempFavouriteList.add(event.item);
    emit(state.copyWith(tempFavouriteList: List.from(tempFavouriteList)));
  }
  void _unselectItem(UnSelectItem event, Emitter<FavouriteListStates> emit) async {
    tempFavouriteList.remove(event.item);
    emit(state.copyWith(tempFavouriteList: List.from(tempFavouriteList)));
  }
  void _deleteItem(DeleteItem event, Emitter<FavouriteListStates> emit) async {
   for(int i =0; i<tempFavouriteList.length; i++){
     favouriteList.remove(tempFavouriteList[i]);
   }
   tempFavouriteList.clear();
    emit(state.copyWith(favouriteItemList: List.from(favouriteList),
      tempFavouriteList: List.from(tempFavouriteList)));
  }
}

