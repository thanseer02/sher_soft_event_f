import 'dart:convert';
import 'package:eventhub/connect.dart';
import 'package:eventhub/home.dart';
import 'package:eventhub/user/user_home.dart';
import 'package:eventhub/user/user_register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class user_login extends StatefulWidget {
  const user_login({super.key});

  @override
  State<user_login> createState() => _user_loginState();
}

class _user_loginState extends State<user_login> {
  bool isLoggedIn = false;

  var log_id;
  final TextEditingController mobile_noctrl=TextEditingController();
  final TextEditingController passwordctrl=TextEditingController();
  var visible_password=true;
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
  Future<void> login() async {
    var data={
      'mobile_no':mobile_noctrl.text,
      'password':passwordctrl.text,
    };
    var response=await post(Uri.parse("${con.url}login/login.php"),body: data);
    print(response.body);
    print(response.statusCode);
    if (jsonDecode(response.body)['result']=='success') {
      id(jsonDecode(response.body)['log_id']);
      print(jsonDecode(response.body)['log_id']);
      isLoggedIn = true;
      // print('object');
      // print(isLoggedIn);
      // Navigator.pushReplacementNamed(context, '/home');

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>user_home()), (Route<dynamic> route) => false);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>user_home()));
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>user_home()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('logIn')));
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed')));

    }
    @override
    void initState(){
      super.initState();
      getLoginId();
    }
  }

  Future<void> id(String log_id) async {
    var data={
      'log_id':log_id,
    };
    var response=await post(Uri.parse("${con.url}login/profile.php"),body: data);
    print(response.body);
    log_id=jsonDecode(response.body)['log_id'];
    if (log_id!=null) {
      savedata(log_id);
      print('data saved ${log_id}');
    }  
    @override
    void initState(){
      super.initState();
      getLoginId();
    }
  }

  // void handleLogin(BuildContext context) async {
  //   // Perform login process (e.g., verify credentials)
  //   // If login is successful, set isLoggedIn to true and store it in SharedPreferences
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isLoggedIn', true);
  //
  //   // Navigate to the home page after login
  //   Navigator.pushReplacementNamed(context, '/home');
  // }

  void savedata(String loginId,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginId', loginId);
    print(loginId);
    print('data');

  }
  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login_id = prefs.getString('loginId');
    return login_id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home())); },
            icon: Icon(Icons.arrow_back_ios_new),
            
          ) ,
        ),
        body: SafeArea(
      child: SingleChildScrollView(
      child: Form(
      key: _formkey,
      child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text('Event Hub',style: GoogleFonts.gruppo(
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
                controller: mobile_noctrl,
                style: TextStyle(color: Colors.black,fontSize: 18),
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person,color: Color(0xff068DA9),),
                    filled: true,
                    fillColor: Color(0xffDCDADA),
                    hintText: 'Mobile number',
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
                    print('loggin');
                    setState(() {
                      isLoggedIn !=isLoggedIn;
                    });
                    print(isLoggedIn);
                    login();
                  }, child: Text('Login',style: TextStyle(fontSize: 20),)),
            ),
            SizedBox(
              height:35,
            ),
            Text('or ',style: TextStyle(fontSize: 14,color: Colors.white),),
            SizedBox(
              height:35,
            ),
            Text('Login With ',style: TextStyle(fontSize: 14,color: Colors.white),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an Account? ',style: TextStyle(color: Colors.white),),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>user_register()));
                }, child: Text('Signup'))
              ],
            ),

          ]),
    ))));
  }
}
