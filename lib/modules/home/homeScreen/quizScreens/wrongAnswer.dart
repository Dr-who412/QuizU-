import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/layout/homeLayout.dart';
import 'package:quizu/modules/home/homeScreen/quizScreens/question.dart';
import 'package:quizu/shared/componant/componant.dart';
class WrongAnswer extends StatelessWidget {
  const WrongAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            FloatingActionButton(
              elevation:6.0,
              backgroundColor: Colors.white,
              onPressed: () {  },
              child: TextButton(
                  onPressed: (){
                    navigateAndFinsh(context, HomeLayout());
                  }, child:Image.asset('assets/x.png')),
            ),
            Spacer(),
            Spacer(),
            Container(
              child: Lottie.asset('assets/lose.json',),
            ),
            SizedBox(height: 40,),
            Text('Wrong Answer',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
            Spacer(),
            Spacer(),
            Spacer(),
            defeultButton(text: 'Try Again', ontap: (){
              navigateAndFinsh(context, Question());
            }),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
