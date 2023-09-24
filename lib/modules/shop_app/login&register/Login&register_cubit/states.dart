
import '../../../../models/shop_app/Shop_login_model.dart';

abstract class ShopLoginRegisterStates{}

class InitialLoginRegisterShop extends ShopLoginRegisterStates{}

class ShopLoadingLoginState extends ShopLoginRegisterStates{}

class ShopSuccessLoginState extends ShopLoginRegisterStates{
  final ShopLoginModel loginModel;

  ShopSuccessLoginState(this.loginModel);

}

class ShopErrorLoginState extends ShopLoginRegisterStates{
  final String error;

  ShopErrorLoginState(this.error);

}

class ShopPasswordChangeState extends ShopLoginRegisterStates{}

//register

// class InitialRegisterShop extends ShopLoginRegisterStates{}

class ShopLoadingRegisterState extends ShopLoginRegisterStates{}

class ShopSuccessRegisterState extends ShopLoginRegisterStates{
  final ShopLoginModel loginModel;

  ShopSuccessRegisterState(this.loginModel);
}

class ShopErrorRegisterState extends ShopLoginRegisterStates{
  final String error;

  ShopErrorRegisterState(this.error);

}
