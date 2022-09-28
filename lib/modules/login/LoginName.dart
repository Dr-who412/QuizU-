import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/layout/homeLayout.dart';
import 'package:quizu/shared/componant/componant.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:quizu/shared/componant/constant.dart';
import 'package:quizu/shared/network/remote/http/httpHelper.dart';

import '../../shared/network/remote/http/endPoint.dart';
import '../../shared/network/shared_preference/cachHelper.dart';
import '../../shared/styles/colors.dart';

class LoginName extends StatefulWidget {
   LoginName({Key? key}) : super(key: key);

  @override
  State<LoginName> createState() => _LoginNameState();
}

class _LoginNameState extends State<LoginName> {
  var nameController=TextEditingController();
  bool isLoading=false;
 void newUser( )async{
   await postData(baseUrl: '$NAME',token: TOKEN, body:{
     'name':'${nameController.text}',
   }).then((value){
     CacheHelper.saveData(key: 'hasName', value:true );
     setState(() {
       isLoading=false;
     });
     navigateAndFinsh(context, HomeLayout());
   })
       .catchError((error){
     setState(() {
       isLoading=false;
     });
     print(error);
   });
 }
  @override
  Widget build(BuildContext context) {
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
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/login.json',height: 60,),

                      Text('QuizU',style: TextStyle(color: defeultOrangeColor,fontSize: 42,fontWeight: FontWeight.bold),),

                    ],)),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 36.0),
                        child: Text(
                          'What’s your name?',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name can't be empty";
                            }
                            return null;
                          },
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 80,
              ),
              isLoading==true?CircularProgressIndicator():defeultButton(
                  text: "Done",
                  ontap: () {
                    newUser();
                    print("Done");
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