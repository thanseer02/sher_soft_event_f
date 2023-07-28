import 'dart:convert';

import 'package:eventhub/user/user_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../connect.dart';
class user_register extends StatefulWidget {
  const user_register({super.key});

  @override
  State<user_register> createState() => _user_registerState();
}

class _user_registerState extends State<user_register> {
  var visible_password=true;
  var visible_confirmpassword=true;
  bool _isValid = true;
  var namectrl=TextEditingController();
  var user_namectrl=TextEditingController();
  var mobile_noctrl=TextEditingController();
  var passwordctrl=TextEditingController();
  var confirm_passwordctrl=TextEditingController();
  final GlobalKey<FormState> _registerkey=GlobalKey<FormState>();
  bool validateMobileNumber(String mobileNumber) {
    RegExp mobileRegex = RegExp(r'^[0-9]{10}$');
    return mobileRegex.hasMatch(mobileNumber);
  }

  Future<void> senddata() async {
    var data={
      'name':namectrl.text,
      'user_name':user_namectrl.text,
      'mobile_no':mobile_noctrl.text,
      'password':passwordctrl.text,
    };
    var response=await post(Uri.parse("${con.url}login/register.php"),body: data);
    print(response.body);
    if (jsonDecode(response.body)['result']=='success') {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>user_home()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered')));

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registraion Failed')));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Form(
            key: _registerkey,
            child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Text('Event Hub',style: GoogleFonts.gruppo(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color(0xff068DA9),
            ),),//app name
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all( 10),
              child: TextFormField(
                validator: (val){
                  if ( val!.isEmpty){
                    return 'field required';
                  }
                },
                controller: namectrl,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffDCDADA),
                    hintText: ' Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,

                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all( 10),
              child: TextFormField(
                validator: (val){
                  if ( val!.isEmpty){
                    return 'field required';
                  }
                  return null;
                },
                controller: user_namectrl,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffDCDADA),
                    hintText: 'User name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  setState(() {
                    _isValid = validateMobileNumber(value);
                  });
                },
                validator: (val){
                  if ( val!.isEmpty){
                    return 'field required';
                  }
                },
                controller: mobile_noctrl,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    errorText: _isValid ? null : 'Invalid mobile number',
                    filled: true,
                    fillColor: Color(0xffDCDADA),
                    hintText: 'Mobile no',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,

                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all( 10),
              child: TextFormField(
                validator: (val){
                  if (val!.length<=6 && val.isEmpty){
                    return 'password reqired or too short';
                  }
                },
                obscureText: visible_password,
                controller: passwordctrl,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        visible_password=!visible_password;
                        print(visible_password);
                      });
                    }, icon:(visible_password)?Icon(Icons.visibility_off,color: Color(0xff068DA9)):Icon(Icons.visibility,color: Color(0xff068DA9))),

                    filled: true,
                    fillColor: Color(0xffDCDADA),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,

                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all( 10),
              child: TextFormField(
                validator: (val){
                  if ( val!.isEmpty){
                    return 'field required';
                  }
                },
                controller: confirm_passwordctrl,
                obscureText: visible_confirmpassword,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        visible_confirmpassword=!visible_confirmpassword;
                      });
                    },
                        icon:(visible_confirmpassword) ? Icon(Icons.visibility_off,color: Color(0xff068DA9),) :Icon(Icons.visibility,color: Color(0xff068DA9))
                    ),
                    filled: true,
                    fillColor: Color(0xffDCDADA),
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,

                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                height: 45,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        backgroundColor: Color(0xff068DA9)),
                    onPressed: (){
                      print(namectrl.text);
                      print(user_namectrl.text);
                      print(mobile_noctrl.text);
                      print(passwordctrl.text);
                      if (_registerkey.currentState!.validate()) {
                        if (passwordctrl.text==confirm_passwordctrl.text) {
                          senddata();
                        }
                        else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password missmatch')));
                        }
                      }
                    }, child: Text('Register')),
              ),
            ),



          ],
        ),
      ),
    ),

      ),
    );
  }
}
