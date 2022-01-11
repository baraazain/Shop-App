import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/product_screen.dart';
import 'package:shop_app/modules/search_screen.dart';
import 'package:shop_app/modules/setting_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/state_mangment/app_cubit.dart';
import 'package:shop_app/shared/state_mangment/app_state.dart';

import '../modules/categorie_screen.dart';
import '../modules/favorite_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
   List<Widget> screens=[
     ProductScreen(),
     CategoryScreen(),
     FavoriteScreen(),
     SettingScreen(),
   ];

  @override
  Widget build(BuildContext context) {
      return  BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Shopping'),
              actions: [
                IconButton(
                    onPressed: (){
                  goTo(context,SearchScreen());
                    }, icon: Icon(Icons.search))
              ],
            ),
            body:screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                if(index==3)cubit.getProfile();
          /*      if(index==0)cubit.getProduct();
                if(index==1)cubit.getCategory();
                if(index==2)cubit.getFavorite();

*/                cubit.changeBottomIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items:  [
                BottomNavigationBarItem(icon:Icon(Icons.home),label:'Home'),
                BottomNavigationBarItem(icon:Icon(Icons.apps),label:'Category'),
                BottomNavigationBarItem(icon:Icon(Icons.favorite),label:'Favorite'),
                BottomNavigationBarItem(icon:Icon(Icons.settings),label:'Settings'),
              ],


            ),
          );
        },
      );
  }
}
