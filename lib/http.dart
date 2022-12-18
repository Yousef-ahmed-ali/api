import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class HttpTest extends StatefulWidget {
  const HttpTest({Key? key}) : super(key: key);

  @override
  State<HttpTest> createState() => _HttpTestState();
}
enum ScreenStates  {init,done,eror,empty, loading}
class _HttpTestState extends State<HttpTest> {

  ScreenStates _states = ScreenStates.init;
  List<dynamic> mydata=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  Widget build(BuildContext context) {
    // if(_states==ScreenStates.done)
    // {
    //   return HttpTest();
    // }
    // if  (_states==ScreenStates.done)
    // {
    //   return HttpTest();
    // }
    // if  (_states==ScreenStates.eror)
    // {
    //   return Scaffold( body: Center(child: Text("hi")),);
    // }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ListView.separated(
            separatorBuilder: (context,index)
            {
              return SizedBox(height: 20,);
            },
            itemCount: mydata.length,
              itemBuilder:  (context, index) {
                final item = mydata![index];

               DateTime dateTime= DateTime.parse(item["createdAt"]);
                return Slidable(
                  key: const ValueKey(0),

                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(item["image"].toString(),
                            height: 44,
                            width: 44,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               item ["name"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text("",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey.shade600)),
                            ],
                          ),
                        ),
                        Text(timeago.format(dateTime).toString()),

                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                );}
          )

      ),
    );
  }

  Future<void> get ()async
  {
    //_states = ScreenStates.loading;
    var url = Uri.parse('https://63950d904df9248eadb282fd.mockapi.io/api/v1/contacts');
    var response = await http.get(url);

    mydata =jsonDecode(response.body);
    print(mydata);
    print('Response status: ${response.statusCode}');
    print('Response status: ${response.body}');
    setState(() {
      _states = ScreenStates.done;
    });
  }
}
