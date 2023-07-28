import 'dart:convert';

import 'package:eventhub/admin/edit.dart';
import 'package:eventhub/home.dart';
import 'package:eventhub/user/add_events.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../connect.dart';
class admin_home extends StatefulWidget {
  const admin_home({super.key});

  @override
  State<admin_home> createState() => _admin_homeState();
}

class _admin_homeState extends State<admin_home> {
  @override
 // var log_id;
  var flag;
  var event_id;
  var event;
  Future<String?>? log_idFuture;
  List <dynamic>_found_event=[];

  Future<dynamic> getdata() async {
    // var log_id = await log_idFuture;
    // var data={
    //   'log_id':log_id
    // };
   // print(log_idFuture);
    var response=await get(Uri.parse("${con.url}add_event/admin_view.php"));
    // print(response.body);
    print(response.statusCode);
  //  event=jsonDecode(response.body);
  //  print( "variable $event");
    if (response.statusCode == 200 && jsonDecode(response.body)[0]['result']=='success') {
      print(response.body);
       event=jsonDecode(response.body);

        _found_event=event;
       // print('inside setState');

       print('-------------EVENT-------------');
       print(event);
       print('-------------------------------');
       print('-------------_found_event-------------');
       print(_found_event);
       print('-------------------------------');

      flag=1;
      return jsonDecode(response.body);
    }
    else {
      flag=0;
      const CircularProgressIndicator();
      print('error');
    }


  }

  void initState() {
    super.initState();
    log_idFuture = getLoginId();
    print(log_idFuture);// Assign the future to log_idFuture
    getdata();

  }


  Future <void> deletedata() async {
    var data={
      'event_id':event_id
    };
    print(event_id);
    var response=await post(Uri.parse("${con.url}add_event/delete.php"),body: data);
    if (response.statusCode==200) {
      return jsonDecode(response.body);
    }
    else
      {
        return null;
      }
  }




  void search(String value){
    setState(() {
      _found_event=event.where((evt){
        final  event_name = evt['event_name']!.toLowerCase();
        final  amount = evt['amount']!.toLowerCase();
        final  place = evt['place']!.toLowerCase();
        final  date = evt['date']!.toLowerCase();
        final  no_of_people = evt['no_of_people']!.toLowerCase();
        return event_name.contains(value.toLowerCase())||
            amount.contains(value.toLowerCase())||
            place.contains(value.toLowerCase())||
            date.contains(value.toLowerCase())||
            no_of_people.contains(value.toLowerCase());
      }).toList();
      print('>>>>>>>>>>>>>>>>FILTERED>>>>>>>>>>');
      print(_found_event);
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
        }, icon: Icon(Icons.arrow_back_ios)),
        // title: Text('Event Hub Admin Pannel',style:  GoogleFonts.gruppo(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
        title:  Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            height: 40,
            width: 200,
            child: TextFormField(
              onChanged: search,
              style: TextStyle(color: Colors.black,),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffDCDADA),
                  suffixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,

                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            ),
          ),
        ),
        // actions: [
        //   IconButton(onPressed: (){
        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>add_events()));
        //   }, icon: Icon(Icons.add,color: Colors.white,size: 35,))
        // ],
      ),
      body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child:  flag==0?Center(child: CircularProgressIndicator(
              backgroundColor: Colors.teal,
              color: Colors.white,
            )): ListView.builder(
                itemCount: _found_event.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                       child: Column(
                         children: [
                           SizedBox(height: 5,),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 IconButton(onPressed: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>edit(
                                       event_name: _found_event[index]['event_name'],
                                       amount: _found_event[index]['amount'],
                                       date: _found_event[index]['date'],
                                       place: _found_event[index]['place'],
                                       no_of_people: _found_event[index]['no_of_people'],
                                     event_id: _found_event[index]['event_id'],)));
                                 }, icon: Icon(Icons.edit,color: Colors.teal,)),

                                 Text('${_found_event[index]['event_name']}'.toUpperCase(),style: TextStyle(
                                     fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                 ),),

                                 IconButton(onPressed: (){
                                   event_id=_found_event[index]['event_id'];
                                   print('new $event_id');
                                   setState(() {
                                     deletedata();
                                   });
                                 }, icon: Icon(Icons.delete,color: Colors.red,)),


                      ],
                             ),
                           ),

                           // Padding(
                           //   padding: const EdgeInsets.all(8.0),
                           //   child: Text('${snapshot.data[index]['event_name']}'.toUpperCase(),style: TextStyle(
                           //       fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                           //   ),),
                           // ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [

                                 Text('${_found_event[index]['place']}',style: TextStyle(
                                     fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                 ),),
                                 Text('${_found_event[index]['date']}',style: TextStyle(
                                     fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                 ),)

                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [

                                 Text('${_found_event[index]['amount']}',style: TextStyle(
                                     fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                 ),),
                                 Text('${_found_event[index]['no_of_people']}',style: TextStyle(
                                     fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                 ),)

                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [

                                 Text('${_found_event[index]['name']}',style: TextStyle(
                                     fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                 ),),
                                 Text('${_found_event[index]['user_name']}',style: TextStyle(
                                     fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                 ),)

                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [

                                 Text('${_found_event[index]['mobile_no']}',style: TextStyle(
                                     fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                 ),),
                                 Text('${_found_event[index]['email']}',style: TextStyle(
                                     fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                 ),)

                               ],
                             ),
                           ),





                         ],
                       ),
                    ),
                  );

                }
            ),
          )),
    );
  }
}
