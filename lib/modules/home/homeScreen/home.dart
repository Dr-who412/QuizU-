import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/modules/home/cubit/cubit.dart';
import 'package:quizu/modules/home/homeScreen/quizScreens/question.dart';
import '../../../shared/componant/componant.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Expanded(child: Text('Ready to test your \nknoweldge and challenge \nothers?',
            textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold
          ),)),
          Container(
            child: Lottie.asset('assets/clockanimated.json'),
          ),
          defeultButton( text: 'Quiz me',ontap: ()async{
            navigateAndFinsh(context,
                Question());
          }),
          SizedBox(height: 80,),
          Text('Answer as much questions \ncorrectly within 2 minutes',textAlign:TextAlign.center),
Spacer(),
        ],
      ),
    );
  }
}
