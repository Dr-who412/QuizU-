import 'dart:convert';

import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:quizu/layout/homeLayout.dart';
import 'package:quizu/models/loginModel.dart';
import 'package:quizu/modules/login/LoginName.dart';
import 'package:quizu/shared/componant/componant.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:quizu/shared/network/remote/http/httpHelper.dart';
import 'package:quizu/shared/network/shared_preference/cachHelper.dart';

import '../../shared/componant/constant.dart';
import '../../shared/network/remote/http/endPoint.dart';

class LoginOTP extends StatefulWidget {
  final mobile;
   LoginOTP({Key? key,this.mobile}) : super(key: key);

  @override
  State<LoginOTP> createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {
var controllwe1=TextEditingController();

   var controllwe2=TextEditingController();

   var controllwe3=TextEditingController();

   var controllwe4=TextEditingController();
bool? isLoading=false;
void  login()async{
  print("start");
  setState(() {
    isLoading=true;
  });
  await postData(baseUrl: '$LOGIN', body:{
    'OTP':'0000',
    'mobile':'${widget.mobile}'
  }).then((value){
     LoginModel? user=LoginModel.fromJson(jsonDecode(value.body));
     print('${user.token}');
    CacheHelper.saveData(key: 'token', value:'Bearer ${user.token}' )
        .then((value) {
      TOKEN='Bearer ${user.token}';
      setState(() {
        isLoading=false;
      });
          navigateAndFinsh(context, LoginName());
    }).catchError((error){
      print(error.toString());
    });
  })
      .catchError((error){
    setState(() {
      isLoading=false;
    });
    print(error);
    print('error');

  });
  }

  @override


  @override
  Widget build(BuildContext context) {
    controllwe1.text='0';
    controllwe3.text='0';
    controllwe2.text='0';
    controllwe4.text='0';

    return Scaffold(
      body: SafeArea(
        top: true,
        left: true,
        right: true,
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logoQuizU(context),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 4),
                        child: Text(
                          'Please enter the OTP sent to \nyour mobile',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(child: OTPDigit(controller: controllwe1)),
                              SizedBox(width: 22,),
                              Expanded(child: OTPDigit(controller: controllwe2)),
                              SizedBox(width: 22,),
                              Expanded(child: OTPDigit(controller: controllwe3)),
                              SizedBox(width: 22,),
                              Expanded(child: OTPDigit(controller: controllwe4)),
                            ],
                          )
                      )
                    ],
                  )),
              SizedBox(
                height: 80,
              ),
              isLoading==true?CircularProgressIndicator():defeultButton(
                  text: "Check",
                  ontap: () {
                    login();
                  }),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 6,
              )
            ],
          ),
        ),
      ),
    );;
  }
}