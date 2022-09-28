import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/modules/home/cubit/cubit.dart';
import 'package:quizu/modules/home/cubit/state.dart';
import '../../../shared/componant/componant.dart';

class LeaderBoarder extends StatelessWidget {
  const LeaderBoarder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(

                  child: Lottie.asset('assets/cup.json'),
                ),
                Text(
                  'Leaderboard',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 38, height: 1.7),
                ),
                ConditionalBuilder(
                  condition: cubit.leaderBoard.isNotEmpty,
                  builder: (context) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.leaderBoard.length,
                      itemBuilder: (context, index) => textScore(
                          prefixText: '${cubit.leaderBoard[index]?.name}',
                          sufixText: '${cubit.leaderBoard[index]?.score}'),
                    );
                  },
                  fallback: (context) => Center(
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height / 8),
                          child: CircularProgressIndicator())),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
