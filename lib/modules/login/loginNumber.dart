import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/modules/login/LoginOTP.dart';
import 'package:quizu/shared/componant/componant.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:phone_number/phone_number.dart';
import 'package:quizu/shared/componant/constant.dart';

import '../../shared/network/remote/http/httpHelper.dart';
import '../../shared/styles/colors.dart';

class LoginNumber extends StatefulWidget {
  LoginNumber({Key? key}) : super(key: key);

  @override
  State<LoginNumber> createState() => _LoginNumberState();
}

class _LoginNumberState extends State<LoginNumber> {
  var mobileController = TextEditingController();
  var textfaildKey = GlobalKey<FormFieldState>();
  String selectedCountry = 'SA';
  var selectedKey = 966;
  String selectedCode = 'SA';
   PhoneNumberUtil? plugin;
  bool? isValid=false;
  PhoneNumber? phoneNumber;
  String? formatted;
  String? springFieldUSASimple;
  RegionInfo? region;
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
                      Container(child: Lottie.asset('assets/login.json',height: 60,)),

                      Text('QuizU',style: TextStyle(color: defeultOrangeColor,fontSize: 42,fontWeight: FontWeight.bold),),

                    ],)),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 4),
                        child: Text(
                          'Mobile',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.black12,
                        ),
                        child: TextFormField(
                          controller: mobileController,
                          key: textfaildKey,
                          onChanged: (v)async{
                             springFieldUSASimple = '+${selectedKey}${mobileController.text}';

// Parsing
                            phoneNumber = await PhoneNumberUtil().parse('$springFieldUSASimple');
                            region = RegionInfo(name:'$selectedCountry',prefix:selectedKey,code: '$selectedCode');

// Validate
// Format
                            isValid = await plugin?.validate(springFieldUSASimple!,regionCode: '${region?.code}');

                          },
                          validator: (value) {

                            if (value!.isEmpty) {
                              return "please enter your number";
                            }else if( isValid==false){
                              return " please enter a valid number";
                            }
                            return null;
                          },
                          maxLines: 1,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: '53 555 5555',
                            hintStyle: TextStyle(color: Colors.black26),
                            prefixIcon: Container(
                              width: 58,
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.all(10),
                              child: CountryPickerDropdown(
                                initialValue: 'SA',
                                itemBuilder: buildDropdown_Item,
                                isExpanded: false,
                                iconSize: 18,
                                isDense: true,

                                selectedItemBuilder: (country) {
                                  return Container(
                                      margin: EdgeInsets.all(1),
                                      child: CountryPickerUtils
                                          .getDefaultFlagImage(country));
                                },
                                // itemFilter: (c)=> ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                                priorityList: [
                                  CountryPickerUtils.getCountryByIsoCode('GB'),
                                  CountryPickerUtils.getCountryByIsoCode('CN'),
                                ],
                                isFirstDefaultIfInitialValueNotProvided: true,
                                sortComparator: (Country a, Country b) =>
                                    a.isoCode.compareTo(b.isoCode),
                                onValuePicked: (Country country) {
                                  setState(() {
                                    selectedCountry = country.name;
                                    selectedKey = int.parse(country.phoneCode);
                                    selectedCode = country.iso3Code;
                                  });
                                  print("${country.iso3Code}");
                                  print("${selectedKey}");
                                },
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  )),

              SizedBox(
                height: 80,
              ),
              defeultButton(
                  text: "Start",
                  ontap: () async{
                    print("start");
                    formatted = await PhoneNumberUtil().format(springFieldUSASimple!, '${region?.code}');

                    if (textfaildKey.currentState!.validate()) {
                      navigateTo(context,LoginOTP(mobile:'${selectedKey}${mobileController.text}'));
                    }
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              )
            ],
          ),
        ),
      ),
    );
  }
}
