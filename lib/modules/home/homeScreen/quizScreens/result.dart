import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/layout/homeLayout.dart';
import 'package:quizu/modules/home/cubit/cubit.dart';
import 'package:quizu/modules/home/cubit/state.dart';
import 'package:quizu/shared/componant/componant.dart';

import '../home.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigateAndFinsh(context, HomeLayout());
        return true;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                elevation: 6.0,
                backgroundColor: Colors.white,
                onPressed: () {},
                child: TextButton(
                    onPressed: () {
                      navigateAndFinsh(context, HomeLayout());
                    },
                    child: Image.asset('assets/x.png')),
              ),
              Spacer(),
              Container(
                child: Lottie.asset('assets/flaganimate.json',),
              ),
              Spacer(),
              Text('You have completed'),
              SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  '${HomeCubit.get(context).score}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('correct Answer'),
              Spacer(),
              TextButton(
                    onPressed: ()
                       async {
                        await Share.share('check out ${HomeCubit.get(context).profileModel?.userName} new Score in quizU', subject: 'i just get a new score ${HomeCubit.get(context).score}'
                        );


                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/share.png'),
                        Text(
                          'Share',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
