import 'package:equatable/equatable.dart';

import '../../model/favourite_item_model.dart';

enum ListStatus { loading, success, failure }

class FavouriteListStates extends Equatable {
  final List<FavouriteItemModel> favouriteItemList;
  final List<FavouriteItemModel> tempFavouriteList;
  final ListStatus listStatus;
  const FavouriteListStates(
      {this.favouriteItemList = const [],
      this.tempFavouriteList = const [],
      this.listStatus = ListStatus.loading});
  FavouriteListStates copyWith(
      {List<FavouriteItemModel>? favouriteItemList,
      List<FavouriteItemModel>? tempFavouriteList,
      ListStatus? listStatus}) {
    return FavouriteListStates(
        favouriteItemList: favouriteItemList ?? this.favouriteItemList,
        tempFavouriteList: tempFavouriteList ?? this.tempFavouriteList,
        listStatus: listStatus ?? this.listStatus);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [favouriteItemList, tempFavouriteList, listStatus];
}
