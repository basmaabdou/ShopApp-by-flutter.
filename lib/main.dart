import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/bloc_observed.dart';
import 'package:shop_app/shared/componant/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/cubit/states.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/shop_app/login&register/Login&register_cubit/cubit.dart';
import 'modules/shop_app/login&register/shop_login_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/shop_app/search/cubit/cubit.dart';
void main() async{
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark',);
  bool? onBoarding= CacheHelper.getData(key: 'onBoarding',);
  token=CacheHelper.getData(key: 'token' );
  print(token);

  Widget widget;
  if(onBoarding!=null){
    if(token !=null) {
      widget = ShopLayout();
    }else {
      widget = ShopLoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
  }
//
  runApp(MyApp(
    isDark:isDark,
    startWidget: widget,
  ));



}


class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool? isDark;
  // final bool? onBoarding;
  final Widget? startWidget;
  MyApp( {this.isDark, this.startWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData()),
        BlocProvider(create: (context)=>ShopLoginRegisterCubit()),
        BlocProvider(create: (context)=>SearchCubit()),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            //light
            theme: lightTheme,
            // dark and edit
            darkTheme: darkTheme,
            // determine dark or light
            themeMode: ShopCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            // home:onBoarding!= null? ShopLoginScreen() : OnBoardingScreen(),
            home: startWidget,
          );
        },
      ),
    );

  }


}
