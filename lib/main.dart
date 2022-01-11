import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/local/shared_preferance.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/state_mangment/app_cubit.dart';
import 'package:shop_app/shared/state_mangment/app_state.dart';
import 'package:shop_app/shared/style/themes.dart';
import 'modules/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget = getStart();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  const MyApp(this.screen, {Key? key}) : super(key: key);
  final Widget screen;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..getProduct()..getCategory()..getFavorite()..getProfile(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            home:Directionality(
              textDirection:AppCubit.get(context).language=='en'?TextDirection.ltr:TextDirection.rtl,
              child:getStart(),
            ),


            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,

            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
          );
        }

      ),
    );
  }
}

Widget getStart() {
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  return widget;
}
