import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:networking/posts.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Dio dio = Dio();

  Future<List<Post>> getData() async {
    var response = await dio.get("https://jsonplaceholder.typicode.com/users");
    if (response.statusCode == 200) {
      return listfromJson(response.data);
    } else {
      throw Exception();
    }
  }

  // Future<String>? response;
  //
  // Future<String> post(String body, String title, int userId) async {
  //   var response = await dio.post("https://jsonplaceholder.typicode.com/posts",
  //       data: {"title": title, "body": body, "userId": userId});
  //   return response.data.toString();
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(child: Column(
                  children: [
                    Text("name = ${snapshot.data?[index].name}"),
                    Text("addres  = ${snapshot.data?[index].address}"),
                    Text("email = ${snapshot.data?[index].email}"),
                    Text("phone = ${snapshot.data?[index].phone}"),
                    SizedBox(height: 30)
                  ],
                ));
              },
            );
          },
        ),

        // child: olumn(
        //   children: [
        //     FutureBuilder(
        //       future: response,
        //       builder: (context, snapshot) {
        //         return Text(snapshot.data.toString(),
        //             style: TextStyle(fontSize: 30));
        //       },
        //     ),
        //     MaterialButton(
        //         onPressed: () {
        //           setState(() {
        //             response = post("Kot", "Ismoil", 3452);
        //           });
        //         },
        //         child: Text("Post", textAlign: TextAlign.center),
        //         color: Colors.pink)
        //   ],
        // ),
      ),
    );
  }
}
