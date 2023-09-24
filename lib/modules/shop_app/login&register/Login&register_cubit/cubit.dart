import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login&register/Login&register_cubit/states.dart';

import '../../../../models/shop_app/Shop_login_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_point.dart';


class ShopLoginRegisterCubit extends Cubit<ShopLoginRegisterStates>{
  ShopLoginRegisterCubit() : super(InitialLoginRegisterShop());

  static ShopLoginRegisterCubit get(context)=> BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoadingLoginState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }
    ).then((value) {
      loginModel=ShopLoginModel.fromJson(value.data);
      // print(loginModel!.status);
      // print(loginModel!.message);
      // print(loginModel!.data!.token);
      emit(ShopSuccessLoginState(loginModel!));
    }).catchError((error){
      emit(ShopErrorLoginState(error.toString()));
    });
  }


  IconData suffix= Icons.visibility;
  bool isPassword=true;
  void changePasswordIcons(){
    isPassword=! isPassword;
    suffix= isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ShopPasswordChangeState());
  }


  // register

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(ShopLoadingRegisterState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone
        }
    ).then((value) {
      loginModel=ShopLoginModel.fromJson(value.data);
      // print(loginModel!.status);
      // print(loginModel!.message);
      // print(loginModel!.data!.token);
      emit(ShopSuccessRegisterState(loginModel!));
    }).catchError((error){
      emit(ShopErrorRegisterState(error.toString()));
    });
  }

  }
