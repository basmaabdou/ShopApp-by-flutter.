import '../../modules/shop_app/login&register/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'component.dart';

void signOut(context){
  CacheHelper.removeDate(key: 'token').then((value) {
    navigateFinish(context, ShopLoginScreen());
  });
}

String? token='';

// To print full Text
void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}





// POST
// UPDATE
// DELETE

// GET
// /v2/everything?q=tesla&from=2023-07-09&sortBy=publishedAt&apiKey=28988366cd504af9b749397e49c45648


// home:startWidget,
// home:onBoarding!=null ? (token!=null ? ShopLayout() : ShopLoginScreen())  :  OnBoardingScreen(),
//    home: onBoarding !=null ?ShopLoginScreen():OnBoardingScreen(),

// const MyApp(this.isDark,this.onBoarding, {Key? key}) : super(key: key);
// final Widget? startWidget;
// MyApp( this.isDark, {this.startWidget});

// final bool? onBoarding;
// final String? token;

// to make app open in home page


// var token = CacheHelper.getData(key: 'token');
// Widget widget;
// if(onBoarding!=null){
//   if(token !=null) widget=ShopLayout();
//   widget=ShopLoginScreen();
// }else{
//   widget=OnBoardingScreen();
// }
// //
// runApp(MyApp(
//   isDark!,
//   startWidget: widget,
// ));


// bool onBoarding = CacheHelper.getData(key: 'onBoarding');
// String? token=CacheHelper.getData(key: 'token');


