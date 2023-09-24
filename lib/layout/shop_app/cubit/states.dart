
import '../../../models/shop_app/Shop_login_model.dart';
import '../../../models/shop_app/change_favorites-model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}

class ShopChangeBottomNavStates extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}

class ShopSuccessHomeDataStates extends ShopStates{}

class ShopErrorHomeDataStates extends ShopStates{}

class ShopLoadingCategoryDataStates extends ShopStates{}

class ShopSuccessCategoryDataStates extends ShopStates{}

class ShopErrorCategoryDataStates extends ShopStates{}

class ShopChangeFavoritesStates extends ShopStates{}

class ShopSuccessChangeFavoritesStates extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}

class ShopErrorChangeFavoritesStates extends ShopStates{}

class ShopSuccessGetFavoritesStates extends ShopStates{}

class ShopErrorGetFavoritesStates extends ShopStates{}

class ShopLoadingFavoritesStates extends ShopStates{}

class ShopLoadingUserDataStates extends ShopStates{}

class ShopSuccessUserDataStates extends ShopStates{}

class ShopErrorProfileStates extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}


class AppChangeMode extends ShopStates {}