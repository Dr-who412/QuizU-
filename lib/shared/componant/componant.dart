import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quizu/modules/home/cubit/cubit.dart';
import 'package:quizu/modules/login/loginNumber.dart';
import 'package:quizu/shared/network/shared_preference/cachHelper.dart';
import 'package:quizu/shared/styles/colors.dart';

void navigateTo(BuildContext context,Widget widget){
  Navigator.push(context,MaterialPageRoute(builder: (context)=>widget,));
}
void logout(context)async{
  CacheHelper.removedata(key: 'token').then((value) {
    CacheHelper.removedata(key: 'hasName');
    navigateAndFinsh(context, LoginNumber());
    })
      .catchError((error){
        print(error.toString());
  });
  navigateAndFinsh(context, LoginNumber());
}
void navigateAndFinsh(BuildContext context,Widget widget){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context)=>widget,),
          (Route<dynamic> route) => false);
}
Widget logoQuizU(BuildContext context) => Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height / 6,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text('QuizU',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
Container(
  decoration: BoxDecoration(
    color:Colors.white,
borderRadius: BorderRadius.circular(24)
  ),
  margin: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
    padding: EdgeInsets.all(8),
    child: Image.asset('assets/clock.png',height: 32)),
    ],));
Widget defeultButton({
  required String? text,
  required ontap,
   color,
}) =>
    Card(
      elevation: 3.0,
      color: color??defeultOrangeColor,
      child: SizedBox(
        width: 120,
        child: TextButton(
          onPressed: ontap,
          child: Text(
            '$text',
            style: TextStyle(
              overflow: TextOverflow.visible,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
Widget OTPDigit({required controller}) => Container(
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black45),
        validator: (value) {
          if (value!.isEmpty) {
            return "please enter otp digit";
          }
          return null;
        },
        autofocus: true,
        decoration: InputDecoration(
            counter: SizedBox(),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: BorderSide(width: 4, color: Colors.black45),
            )),
      ),
    );

Widget textScore({
  required String? prefixText,
  required String? sufixText,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.person_outline),
          SizedBox(width: 8,),
          Text(
            '$prefixText',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Card(
           shape:RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(38)

           ) ,
            child: Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38)
            ),
              margin: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.star,color: defeultOrangeColor,),
                  Text('$sufixText'),
                ],
              )),
          elevation: 3.0,),
        ],
      ),
    );


Widget questionWidget({
  context,
  required String? question,
  required String? answer1,
  required String? answer2,
  required String? answer3,
  required String? answer4,
}) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 2,),
          Text(
            '$question',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(flex:1 ),
          Row(
            children: [
              SizedBox(width:20,),
              Expanded(child: defeultButton(text: '$answer1', ontap: () {
                HomeCubit.get(context).chackAnswer(context,'a');
              })),
              SizedBox(width:20,),
              Expanded(child: defeultButton(text: '$answer2', ontap: () {
                HomeCubit.get(context).chackAnswer(context,'b');
              })),
              SizedBox(width:20,),
            ],
          ),
          Row(
            children: [
              SizedBox(width:20,),
              Expanded(child: defeultButton(text: '$answer3', ontap: () {
                HomeCubit.get(context).chackAnswer(context,'c');
              })),
              SizedBox(width:20,),
              Expanded(child: defeultButton(text: '$answer4', ontap: () {
                HomeCubit.get(context).chackAnswer(context,'d');
              })),
              SizedBox(width:20,),
            ],
          ),
          Spacer(flex: 2,),
        ],
      ),
    );

Widget buildDropdown_Item(Country country) =>
    Container(
      child: Row(
        children: <Widget>[
          Expanded(child: CountryPickerUtils.getDefaultFlagImage(country)),
          SizedBox(
            width: 1,
          ),
          Expanded(
              child: Text(
                "+${country.phoneCode}(${country.isoCode})",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              )),

        ],
      ),
    );