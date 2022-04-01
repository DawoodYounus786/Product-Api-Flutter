import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


import 'package:http/http.dart' as http;


import 'AddToCardScreen.dart';
import 'DetailScreen.dart';
import 'Model.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


List<Map<String,dynamic>> myFavList=[];
class _HomeState extends State<Home> {



  List<Model>? getModel;

  Future<dynamic> news()async{
    try{
      var url = Uri.parse('https://fakestoreapi.com/products/');
      var response = await http.get(url);
      if(response.statusCode==200){

        var responceddd=response.body;
        List<Model> model=modelFromJson(responceddd);
        return model;
      }
      else{
        print('Request failed with status: ${response.statusCode}.');
        return "0";
      }
    }
    catch(e){
      print("dawood error ${e}");
      return "0";
    }
  }

  @override
  Widget build(BuildContext context) {

    var x={"name":"Ali"};
    // x['name']
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text("News Apis"),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddToCardScreen(),));

            }, icon: Icon(Icons.favorite_border))
          ],
        ),
        body:FutureBuilder(
          future: news(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.data=="0"){
              return Text("Some thing wrong");
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData){

              getModel=snapshot.data;
              return ListView.builder(
                itemCount: getModel!.length,
                itemBuilder: (context, index) {

                  return Container(
                    margin: EdgeInsets.all(5),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail(getModel![index]),));
                      },
                      child: Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(height: 5,),
                              Container(
                                width: double.infinity,
                                height: 300,
                                child: CachedNetworkImage(
                                  imageUrl: "${getModel![index].image}",fit: BoxFit.fill,
                                  placeholder: (context, url) => Container(
                                      width: 50,
                                      height: 50,
                                      child: Center(child: CircularProgressIndicator())),

                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              SizedBox(height: 5,),

                              Text("${getModel![index].title}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Row(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [

                                      Text("Category: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                      Text("${getModel![index].category}",style: TextStyle(fontSize: 16),),
                                    ],
                                  ),

                                  Row(
                                    children: [

                                      Text("Cost: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                      Text("${getModel![index].price}",style: TextStyle(fontSize: 16),),
                                    ],
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },);
            }
            return Container();
          },)
    );
  }
}
