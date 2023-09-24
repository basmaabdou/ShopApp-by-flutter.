import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';

import '../../../../models/shop_app/seach_model.dart';
import '../../../../shared/componant/constants.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_point.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(ShopSearchInitialStates());

  static SearchCubit get(context) =>BlocProvider.of(context);

  SearchModel? searchModel;
  void searchProduct(String text){
    emit(ShopSearchLoadingStates());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
      'text':text
    }).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessStates());
    }).catchError((error){
      emit(ShopSearchErrorStates());
    });
  }

}