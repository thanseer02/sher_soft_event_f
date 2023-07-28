import 'dart:convert';

import 'package:eventhub/home.dart';
import 'package:eventhub/user/user_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connect.dart';
class add_events extends StatefulWidget {
  const add_events({super.key});

  @override
  State<add_events> createState() => _add_eventsState();
}

class _add_eventsState extends State<add_events> {
  final TextEditingController eventnamectrl =TextEditingController();
  final TextEditingController amountctrl =TextEditingController();
  final TextEditingController datectrl =TextEditingController();
  final TextEditingController no_peoplectrl =TextEditingController();
  final TextEditingController placectrl =TextEditingController();
  final TextEditingController emailctrl =TextEditingController();
  final GlobalKey<FormState> eventkey = GlobalKey<FormState>();
  Future<void> select_date() async {
    final DateTime? pick= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pick!=null && pick!=select_date) {
      print(pick);
      String formatteddate=DateFormat('yyyy-MM-dd').format(pick);
      print(formatteddate);
      datectrl.text=formatteddate ;

      setState(() {
        datectrl.text=formatteddate ;
      });
    }
  }
  // Future<String?> getLoginId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? login_id = prefs.getString('loginId');
  //   print('inside shared');
  //   print(login_id);
  //
  //   return login_id;
  // }
  @override
  void initState(){
    super.initState();
    getLoginId();
  }
  Future<void> add() async {
    print('inside');
    var log_id=await getLoginId();
    // var log_id=1;
    print(log_id);
    var data={
      'log_id':log_id,
      'event_name':eventnamectrl.text,
      'email':emailctrl.text,
      'no_of_people':no_peoplectrl.text,
      'date':datectrl.text,
      'amount':amountctrl.text,
      'place':placectrl.text
    };
    var response=await post(Uri.parse("${con.url}add_event/add_event.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>user_home()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Event added')));
    }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Event adding failed')));

      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>user_home()));
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text('Event Hub',style:  GoogleFonts.gruppo(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
      ),

      body: SafeArea(
        child: Form(
          key: eventkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: eventnamectrl,
                    validator: (val){
                      if (val==null || val.isEmpty) {
                        return 'Field required';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.black,),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffDCDADA),
                        hintText: 'Event name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: emailctrl,
                    validator: (val){
                      if (val==null || val.isEmpty) {
                        return 'Field required';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.black,),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffDCDADA),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width:150,
                        child: TextFormField(
                          controller: amountctrl,
                          validator: (val){
                            if (val==null || val.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black,),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffDCDADA),
                              hintText: 'Amount',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,

                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child:TextFormField(
                          controller: no_peoplectrl,
                          validator: (val){
                            if (val==null || val.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black,),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffDCDADA),
                              hintText: 'No. of people',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,

                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width:200,
                        child: TextFormField(
                          controller: placectrl,
                          validator: (val){
                            if (val==null || val.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black,),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffDCDADA),
                              hintText: 'Place',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,

                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child:TextFormField(
                          validator: (val){
                            if ( val!.isEmpty){
                              return 'Field required';
                            }
                            return null;
                          },
                          controller: datectrl,
                          onTap: (){
                            setState(() {
                              select_date();

                            });
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xffDCDADA),
                              hintText: 'Date',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,

                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //botton
                Container(
                  height: 60,
                  width: 150,
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
                        if (eventkey.currentState!.validate())
                        {
                          add();

                        }
                      }, child: Text('ADD',style: TextStyle(fontSize: 20),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
