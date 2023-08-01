import 'package:eventhub/admin/admin_login.dart';
import 'package:eventhub/connect.dart';
import 'package:eventhub/user/user_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class home extends StatelessWidget {
   home({super.key});
  var log_id=getLoginId();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Center(
                child: Text('Event Hub',style: GoogleFonts.gruppo(fontSize: 50,color: Color(0xff068DA9),fontWeight: FontWeight.bold ),),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 300,
                  height: 70,
                  child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9))),

                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>user_login()));
                        // print('data saved ${log_id}');
                        // print( log_id);

                      }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person,size: 35,color:  Color(0xff068DA9),),
                      Text('User',style: GoogleFonts.mukta(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff068DA9),
                        // fontFamily: 'Times New Roman'
                      ),),
                    ],
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 300,
                  height: 70,
                  child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9))),

                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_login()));
                      }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.admin_panel_settings,size: 35,color:  Color(0xff068DA9),),
                      Text('Admin',style: GoogleFonts.mukta(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff068DA9),
                        // fontFamily: 'Times New Roman'
                      ),),
                    ],
                  )),
                ),
              ),
            ],
          )),
    );
  }
}
