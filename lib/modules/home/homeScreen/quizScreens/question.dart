import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/modules/home/homeScreen/quizScreens/result.dart';
import 'package:quizu/modules/home/homeScreen/quizScreens/wrongAnswer.dart';
import '../../../../layout/homeLayout.dart';
import '../../../../shared/componant/componant.dart';
import '../../../../shared/network/shared_preference/cachHelper.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  void initState() {
    // TODO: implement initState
    HomeCubit.get(context).getQuestion();
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigateAndFinsh(context, HomeLayout());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 4, left: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: BlocConsumer<HomeCubit, HomeState>(
                    buildWhen: (prev, stste) {
                      if (stste is TimerChangeState) {
                        return true;
                      }
                      return false;
                    },
                    listener: (context, state) {

                      if (state is WrongAnswerState) {
                        navigateAndFinsh(context, WrongAnswer());
                      } else {

                        if (state is PushScoreSuccessState) {
                          print("pushed");

                          CacheHelper.saveData(
                              key: "prescores",
                              value:'${jsonEncode(HomeCubit.get(context).previceScore)}' )
                              .then((value) {
                            print("cached");
                            navigateAndFinsh(context, Result());
                          });
                        }
                        if (state is TimerEndState) {
                          if (HomeCubit.get(context).score==0 ){
                            navigateAndFinsh(context, WrongAnswer());

                          }else{
                          HomeCubit.get(context).postScore();
                          }
                        }
                        if (state is QuestionEndState) {
                          HomeCubit.get(context).postScore();

                        }
                      }
                    },
                    builder: (context, state) {
                      var cubit = HomeCubit.get(context);
                      return Text(
                        '${cubit.min}:${cubit.sec}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            height: 1.7),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  child: Lottie.asset('assets/clockanimated.json',width: MediaQuery.of(context).size.height/12),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (prev, stste) {
                if (stste is GetQuestionSuccessState) {
                  HomeCubit.get(context).startTimer();
                  return true;
                }
                if (stste is SkipQuestionState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                var cubit = HomeCubit.get(context);
                return ConditionalBuilder(
                  condition: cubit.questionModel.isNotEmpty,
                  builder: (context) {
                    return questionWidget(
                      context: context,
                      question:
                          '${cubit.questionModel[cubit.questionIndex]?.question}',
                      answer1:
                          'A. ${cubit.questionModel[cubit.questionIndex]?.a}.',
                      answer2:
                          'B. ${cubit.questionModel[cubit.questionIndex]?.b}',
                      answer3:
                          'C. ${cubit.questionModel[cubit.questionIndex]?.c}',
                      answer4:
                          'D. ${cubit.questionModel[cubit.questionIndex]?.d}',
                    );
                  },
                  fallback: (context) => Center(
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height / 8),
                          child: CircularProgressIndicator())),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (prev, stste) {
                if (stste is SkipQuestionState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return HomeCubit.get(context).isSkip
                    ? OutlinedButton(
                        onPressed: () {
                          HomeCubit.get(context).skipping();
                        },
                        child: Image.asset(
                          'assets/skip.png',
                        ))
                    : SizedBox();
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
