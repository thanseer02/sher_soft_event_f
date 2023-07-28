import 'package:eventhub/admin/admin_home.dart';
import 'package:eventhub/user/user_register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class admin_login extends StatefulWidget {
  const admin_login({super.key});

  @override
  State<admin_login> createState() => _admin_loginState();
}

class _admin_loginState extends State<admin_login> {
  final TextEditingController adminctrl=TextEditingController();
  final TextEditingController passwordctrl=TextEditingController();
  var visible_password=true;
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
  void login(){
    if (adminctrl.text=='12345' && passwordctrl.text=='12345' ){
      print(adminctrl.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('LogIn',style: TextStyle(color: Colors.white),)));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_home()));
    }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error',style: TextStyle(color: Colors.red),)));
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Text('Event Hub  Admin ',style: GoogleFonts.gruppo(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff068DA9),
                              // fontFamily: 'Times New Roman'
                            ),),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 30),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              return null;
                            },
                            controller: adminctrl,
                            style: TextStyle(color: Colors.black,fontSize: 18),
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.person,color: Color(0xff068DA9),),
                                filled: true,
                                fillColor: Color(0xffDCDADA),
                                hintText: 'Admin code',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:0.0,horizontal: 18),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            controller: passwordctrl,
                            style: TextStyle(color: Colors.black,fontSize: 18),
                            obscureText: visible_password,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: (){
                                  setState(() {
                                    visible_password=!visible_password;
                                    print(visible_password);
                                  });
                                }, icon:(visible_password)?Icon(Icons.visibility_off,color: Color(0xff068DA9),):Icon(Icons.visibility,color: Color(0xff068DA9),)),

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
                          padding: const EdgeInsets.only(left: 225.0),
                          child: TextButton(onPressed: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>forgot()));
                          }, child: Text('forget password?',style:GoogleFonts.alexandria(color: Colors.white),)),
                        ),
                        Container(
                          height: 50,
                          width: 220,
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
                                if (_formkey.currentState!.validate()) {
                                  login();
                                  // print(adminctrl.text);
                                  // print(passwordctrl.text);


                                }  
                              }, child: Text('Login',style: TextStyle(fontSize: 20),)),
                        ),


                      ]),
                ))));
  }
}
