import 'dart:convert';
import 'package:eventhub/connect.dart';
import 'package:eventhub/home.dart';
import 'package:eventhub/user/add_events.dart';
import 'package:eventhub/user/user_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
class user_home extends StatefulWidget {
  const user_home({super.key});

  @override
  State<user_home> createState() => _user_homeState();
}

class _user_homeState extends State<user_home> {
  bool isLoggedIn =true;
  var log;
  var log_id=getLoginId();
  var flag;
  Future<String?>? log_idFuture;

  Future<void> refreshData() async {

    await getdata();
    setState(() {
      getdata();
    });
  }
  @override
  void initState() {
    super.initState();
    log_idFuture = getLoginId(); // Assign the future to log_idFuture
    setState(() {
      refreshData();
      getdata();

    });
  }

  Future<dynamic> getdata() async {
    var log_id = await log_idFuture;
    var data={
      'log_id':log_id
    };
    print(log_id);
    var response=await post(Uri.parse("${con.url}add_event/view_event.php"),body: data);
    // print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 && jsonDecode(response.body)[0]['result']=='success') {
      // print(response.body);
      flag=1;
      return jsonDecode(response.body);
    }
    else {
        flag=0;
        const CircularProgressIndicator();
        print('error');
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>add_events()));

        },
        child: Icon(Icons.add,color: Colors.black,),),

      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>user_login()));
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>user_login()), (Route<dynamic> route) => false);
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text('Event Hub',style:  GoogleFonts.gruppo(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              isLoggedIn=!isLoggedIn;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));

          }, icon: Icon(Icons.logout,color: Colors.white,size: 35,))
        ],
      ),
      body: SafeArea(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            child:  RefreshIndicator(
              onRefresh: refreshData ,
              child: FutureBuilder(
                  future: getdata(),
                  builder: (context,snapshot){
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    if (!snapshot.hasData || snapshot.data.length==0) {
                    return const Center(
                    child: Text('No data',style: TextStyle(fontSize: 20,color: Colors.white),),
                    );
                    }
                    return
                      // flag==0?Center(child: CircularProgressIndicator(
                      // backgroundColor: Colors.teal,
                      // color: Colors.white,
                      // )):
                      ListView.builder(
                          // reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                      height: 150,
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
                              child: Text('${snapshot.data[index]['event_name']}'.toUpperCase(),style: TextStyle(
                                fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  Text('${snapshot.data[index]['place']}',style: TextStyle(
                                      fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                  ),),
                                  Text('${snapshot.data[index]['date']}',style: TextStyle(
                                      fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                  ),)

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  Text('${snapshot.data[index]['amount']}',style: TextStyle(
                                      fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                  ),),
                                  Text('${snapshot.data[index]['no_of_people']}',style: TextStyle(
                                      fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'
                                  ),)

                                ],
                              ),
                            )


                          ],
                        ),
                      ),
                      );

                    }
                  );
                }
              ),
            ),
          )),
    );
  }
}
