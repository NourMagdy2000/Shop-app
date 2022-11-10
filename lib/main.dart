import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/Layout/layout.dart';
import 'package:shop/app_cubit/login_cubit/login_cubit.dart';
import 'package:shop/app_cubit/login_cubit/login_states.dart';
import 'package:shop/app_cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/network/end_point.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/network/remote/api/dio_helper.dart';
import 'package:shop/screens/login_screen.dart';
import 'package:shop/screens/onboarding_screen.dart';
import 'package:shop/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget widget;
  Dio_helper.init();
  await Cache_helper.init();
  if (Cache_helper.getData(key: 'onBoarding') != null) {
    if (Cache_helper.getData(key: 'token') != null) {
      token = Cache_helper.getData(key: 'token');
      widget = ShopLayout_screen();
    } else {
      widget = Login_screen();
    }
  } else {
    widget = Onboarding_screen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget Startwidget;
  MyApp(this.Startwidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => login_cubit()),
        BlocProvider(
            create: (BuildContext context) => shopCuibt()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getCartData()
              ..getProfileData())
      ],
      child: BlocConsumer<login_cubit, login_states>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light_theme,
            home: Directionality(
              child: this.Startwidget,
              textDirection: TextDirection.ltr,
            ),
            // ////////////////////// dark mode ////////
            darkTheme: dark_theme,
            themeMode: ThemeMode.light,
            // themeMode: NewsCuibt.get(context).isDark
            //     ? ThemeMode.dark
            //     : ThemeMode.light,
          );
        },
      ),
    );
  }
}
