import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'detailsPage.dart';
import 'model/data.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List<MaterialColor>_color =[Colors.deepOrange,Colors.orange,Colors.amber,Colors.blue,Colors.cyan,Colors.green,Colors.deepPurple];

  Future<List<Data>>getAllData() async{
    var api = 'https://jsonplaceholder.typicode.com/photos';
    var data = await http.get(api);
    var jsonData = json.decode(data.body);
    List<Data>listOf=[];
    for(var i in jsonData)
      {
        Data data = new Data(i["id"],i["title"],i["url"],i["thumbnailUrl"]);
        listOf.add(data);

      }
    return listOf;



  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Json Parsing'),
        actions: [
          new IconButton(
              icon: Icon(Icons.search),
              onPressed: ()=>debugPrint('search')),

          new IconButton(
              icon: Icon(Icons.add) ,
              onPressed: ()=>debugPrint('add')),

          new IconButton(
              icon: Icon(Icons.notifications) ,
              onPressed: ()=>debugPrint('notification')),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            new UserAccountsDrawerHeader(
                accountName: Text('code'),
                accountEmail: Text('xyz@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.deepOrange[100]
              ),
            ),
            new ListTile(
              leading: Icon(Icons.search,color: Colors.cyan[100],),
              title: Text('First page'),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),

            new ListTile(
              leading: Icon(Icons.add,color: Colors.cyan[100],),
              title: Text('second page'),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),

            new ListTile(
              leading: Icon(Icons.title,color: Colors.cyan[100],),
              title: Text('Third page'),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),

            new ListTile(
              leading: Icon(Icons.list,color: Colors.cyan[100],),
              title: Text('Fourth page'),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),

            new Divider(
              height: 5.0,
            ),
            new ListTile(
              leading: Icon(Icons.close,color: Colors.red,),
              title: Text('close'),
            ),
          ],
        ),
      ),
      body:
      ListView(
            children: [

              new Container(
                margin: EdgeInsets.all(10.0),
                height: 250,
                child: new FutureBuilder(
                  future: getAllData(),
                  builder: (BuildContext c,AsyncSnapshot snapshot) {
                    if (snapshot.data == null)
                      return
                        Center(
                          child: new Text("loading data"),
                        );
                    else
                      return
                        ListView.builder(

                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext c, int index) {
                              MaterialColor mcolor = _color[index % _color.length];
                              return Card(
                                  elevation: 10.0,
                                  child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        new Image.network(
                                          snapshot.data[index].url,
                                          height: 150.0,
                                          width: 150.0,
                                          fit: BoxFit.cover,
                                        ),

                                        SizedBox(height: 7.0,),
                                        new Container(
                                            height: 50.0,
                                            margin: EdgeInsets.all(6.0),
                                            child: new Row(
                                              children: [
                                                Container(
                                                  child: new CircleAvatar(

                                                    backgroundColor: mcolor,
                                                    child: Text(
                                                        snapshot.data[index].id
                                                            .toString()),
                                                    foregroundColor: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 6.0,),

                                                Container(
                                                  width: 80.0,
                                                  child: new Text(
                                                    snapshot.data[index]
                                                        .title,
                                                    maxLines: 2,),
                                                )
                                              ],
                                            )
                                        ),
                                      ])
                              );
                            }
                        );
                  } )
    ),

    ///end of first container
                                  new SizedBox(height: 7.0),
                 new Container(
                   height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.all(10.0),
                     child: new FutureBuilder(
                            future: getAllData(),
                   builder: (BuildContext c,AsyncSnapshot snapshot) {
                    if (snapshot.data == null)
                     return
                     Center(
                     child: new Text("loading data"),
                          );
                     else
                     return
                      ListView.builder(
                      scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                       itemBuilder: (BuildContext c, int index) {
                      MaterialColor mcolor = _color[index % _color.length];
                            return Card(
                             elevation: 10.0,
                                child: Container(
                                height: 80,
                                 child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                            new Expanded(
                             flex: 1,
                               child:
                               Image.network(
                                snapshot.data[index].url,
                                 height: 100.0,
                                 fit: BoxFit.cover,
                                            ),
                                         ),
                             SizedBox(height: 7.0,),

                               new Expanded(
                               flex: 2,
                               child: InkWell(
                                 onTap:()
                                   {
                                     Navigator.of(context).push( new MaterialPageRoute(builder: (BuildContext c)=>DetailsPage(snapshot.data[index])));
                                   },
                                   child: new Text
                                     (snapshot.data[index].title)
                               ),
                                           ),
                             SizedBox(height: 7.0,),
                               new Expanded(
                                   flex: 1,
                                   child: Align(
                                   alignment: Alignment.center,
                                    child: new CircleAvatar(
                                    backgroundColor: mcolor,
                                     child: Text(
                                             snapshot.data[index].id.toString()),
                                             foregroundColor: Colors.white,),
                                               )
                                            ),
                                        ]
                                     ),
                                   )
                                  );
                               });
                             })
                           )
                           ]
                          ),
                         );
                     }

}
