import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/layout/homeLayout.dart';
import 'package:quizu/modules/login/LoginName.dart';
import 'package:quizu/shared/componant/constant.dart';
import 'package:quizu/shared/network/remote/http/httpHelper.dart';
import 'package:quizu/shared/network/shared_preference/cachHelper.dart';
import 'package:quizu/shared/styles/styles.dart';
import 'package:quizu/shared/styles/thems.dart';
import 'modules/home/cubit/cubit.dart';
import 'modules/login/loginNumber.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  TOKEN=CacheHelper.getdata(key: 'token')??'';
  bool hasName=CacheHelper.getdata(key: 'hasName')??false;
  Widget startWidget;
  if(TOKEN!.isNotEmpty){
    if(hasName){
      startWidget=HomeLayout();
    }else{
    startWidget=LoginName();
    }
  } else{
    startWidget=LoginNumber();
  }
  runApp( MyApp( startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  final  startWidget;
   MyApp({super.key,this. startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(



      providers: [
        BlocProvider (
          create: (BuildContext context) => HomeCubit()..getLeaderBoard()..getProfile()..getPreviceScore(),
        ),
      ],
      child: MaterialApp(

          builder: (context, child) => ResponsiveWrapper.builder(
              child,
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: Color(0xFFF5F5F5))),


      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:theme,
      home: startWidget,
    ),
    );


  }
}

