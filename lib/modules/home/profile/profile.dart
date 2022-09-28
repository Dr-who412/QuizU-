import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/modules/home/cubit/cubit.dart';
import 'package:quizu/modules/home/cubit/state.dart';
import '../../../shared/componant/componant.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      logout(context);
                    }, child: Image.asset('assets/logout.png')),
              ),
              Container(
                height: MediaQuery.of(context).size.height/3,
                child: Lottie.asset('assets/profile.json'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${cubit.profileModel?.userName}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('Mobile:  ${cubit.profileModel?.mobile}'),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ' My Scores',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              height: 1.7),
                        ),
                        ConditionalBuilder(
                          condition: cubit.previceScore.isNotEmpty,
                          builder: (context) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cubit.previceScore.length,
                              itemBuilder: (context, index) => textScore(
                                  prefixText:
                                      '${cubit.previceScore[index]?.date}',
                                  sufixText:
                                      '${cubit.previceScore[index]?.score}'),
                            );
                          },
                          fallback: (context) => Center(
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              8),
                                  child: Text('no Score yet',style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black26,),))),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
