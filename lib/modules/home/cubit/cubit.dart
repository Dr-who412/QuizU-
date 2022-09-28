import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/modules/home/Profile/profile.dart';
import 'package:quizu/modules/home/cubit/state.dart';
import 'package:quizu/modules/home/homeScreen/quizScreens/question.dart';
import 'package:quizu/modules/home/leaderBoard/leaerBoarder.dart';
import 'package:quizu/shared/componant/componant.dart';
import 'package:quizu/shared/componant/constant.dart';
import 'package:quizu/shared/network/remote/http/httpHelper.dart';
import 'package:quizu/shared/network/shared_preference/cachHelper.dart';
import '../../../models/ProfileModel.dart';
import '../../../models/leaderBoard.dart';
import '../../../models/questionModel.dart';
import '../../../models/scoreModel.dart';
import '../../../shared/network/remote/http/endPoint.dart';
import '../homeScreen/home.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitalState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List Screens = [
    Home(),
    LeaderBoarder(),
    Profile(),
  ];
  void changeNavBar(index) {
    currentIndex = index;
    emit(ChangeNavigationBarState());
  }

  List<LeaderBoardModel?> leaderBoard = [];
  void getLeaderBoard() {
    emit(GetLeaderBoardLoadingState());
    getData(baseUrl: '$TOPSCORES', token: TOKEN).then((value) {
      for (var score in json.decode(value.body)) {
        var data = LeaderBoardModel.fromJson(score);
        leaderBoard.add(data);
      }
      emit(GetLeaderBoardSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetLeaderBoardErrorState());
    });
  }

  ProfileModel? profileModel;
  void getProfile() {
    emit(GetProfileLoadingState());
    getData(baseUrl: 'UserInfo', token: TOKEN).then((value) {
      print(value.body);
      profileModel = ProfileModel.fromJson(json.decode(value.body));
      emit(GetProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileErrorState());
    });
  }

  List<QuestionModel?> questionModel = [];
  void getQuestion() async {
    emit(GetQuestionLoadingState());
    await getData(baseUrl: 'Questions', token: TOKEN).then((value) {
      for (var question in json.decode(value.body)) {
        var data = QuestionModel.fromJson(question);
        questionModel.add(data);
      }
      print(questionModel[1]?.question);
      emit(GetQuestionSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetQuestionErrorState());
    });
  }

  var cachScore;
  void postScore() async {
    oldScore = score;
    ScoreModel? scoreModel = ScoreModel(
        score: '$score',
        date:
            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');
    previceScore.add(scoreModel);

    await postData(baseUrl: SCORE, token: TOKEN, body: {
      "score": '${oldScore ?? 0}',
    }).then((v) {
      emit(PushScoreSuccessState());
    }).catchError((error) {
      emit(PushScoreErrorState());
      print(error.toString());
    });
  }

  var questionIndex = 0;
  void skipQuestion() {
    if (questionIndex < questionModel.length - 1) {
      questionIndex++;
      emit(SkipQuestionState());
    } else {
      emit(QuestionEndState());
    }
  }

  int? sec = 00;
  int? min = 2;
  Timer? timer;
  bool isSkip = true;
  void startTimer() {
    questionIndex = 0;
    score = 0;
    timer?.cancel();
    int? count = 120;
    sec = 00;
    min = 2;
    isSkip = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count! > 0) {
        count = count! - 1;
        if (sec == 0 && (min == 2 || min == 1)) {
          sec = 59;
          min = min! - 1;
          emit(TimerChangeState());
        } else {
          sec = sec! - 1;
          emit(TimerChangeState());
        }
      } else {
        emit(TimerEndState());
        timer.cancel();
      }
    });
  }

  int? score = 0;
  late int? oldScore = score;
  List<ScoreModel?> previceScore = [];
  void chackAnswer(context, String? answer) {
    if (answer == questionModel[questionIndex]?.correct) {
      score = score! + 1;
      print(score);
      skipQuestion();
    } else {
      timer?.cancel();
      emit(WrongAnswerState());
    }
  }

  void skipping() {
    if (isSkip) {
      isSkip = false;
      skipQuestion();
    }
  }

  void getPreviceScore() async {
    List<dynamic> data =
        jsonDecode(await CacheHelper.getdata(key: 'prescores')??'')??[];
    print(data[0]);
    data.map<List<ScoreModel>>((e) {
      previceScore.add(ScoreModel.fromjson(e));

      List<ScoreModel> pre = [];
      return pre;
    }).toList();
    print(previceScore);
  }
}
