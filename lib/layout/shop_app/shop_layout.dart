import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/shop_app/search/shop_search_screen.dart';
import '../../shared/componant/component.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:  (BuildContext context, Object? state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              TextButton(
                  onPressed: (){
                    navigateTo(context, ShopSearchScreen());
                  },
                  child: Icon(Icons.search)
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Product'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Category'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'favorite'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Setting'
              ),
            ],
          ),
        );
      },
    );
  }
}
