import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quizu/modules/home/cubit/cubit.dart';
import 'package:quizu/modules/home/cubit/state.dart';
import 'package:quizu/shared/componant/componant.dart';

import '../modules/home/Profile/profile.dart';
import '../modules/home/homeScreen/home.dart';
import '../modules/home/leaderBoard/leaerBoarder.dart';
import '../shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: logoQuizU(context),
            centerTitle: true,
            elevation: 3.0,
            backgroundColor: defeultOrangeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(24),bottomRight: Radius.circular(24)),
            ),
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: Card(
            elevation: 5.0,
            color: defeultOrangeColor,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 4),
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.3, color: Colors.black26),
                borderRadius: BorderRadius.circular(18)),
            child: Padding(

              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeNavBar(index);
                },
                elevation: 0.0,
                currentIndex: cubit.currentIndex,
                backgroundColor: Colors.transparent,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: 'home'),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/cups.png',
                        color: cubit.currentIndex == 1
                            ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
                            : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                        height: 22,
                      ),
                      label: 'leaderboard'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'profile'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
