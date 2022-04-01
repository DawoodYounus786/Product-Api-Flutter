import 'dart:ui';

import 'package:flutter/material.dart';

import 'Model.dart';
import 'main.dart';

class Detail extends StatefulWidget {

  Model model;
  Detail(this.model);


  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Model? model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    model=widget.model;

  }
  Map<String,dynamic> addToCardObject={};



  int count=0;
  String color="blue";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Category: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                Text("${model!.category}",style: TextStyle(fontSize: 16),),
              ],
            ),

            Row(
              children: [

                Text("Cost: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                Text("${model!.price}",style: TextStyle(fontSize: 16),),
              ],
            ),

          ],
        ),
      ),

      bottomSheet: Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(onPressed: (){
            addToCardObject={
              "obj":model,
              "color":color,
              "quantity":count
            };

            myFavList.add(addToCardObject);
            
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added")));

            Navigator.pop(context);

          },child: Text("Add To Card"),)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              //title

              Align(
                  alignment: Alignment.center,
                  child: Text("${model!.title}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),


              SizedBox(height: 10,),
              // image


              Container(
                width: double.infinity,
                height: 250,
                child: Image.network("${model!.image}",fit: BoxFit.fill,),
              ),
              SizedBox(height: 10,),

              //description
              Text("Description: ${model!.description}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),


              // quantity



              Row(

                children: [

                  Text("Select Quatity"),

                  IconButton(onPressed: (){
                    setState(() {
                      count++;
                    });
                  }, icon: Icon(Icons.add_circle)),

                  Text("${count}"),
                  IconButton(onPressed: (){
                    setState(() {
                      count--;
                    });
                  }, icon: Icon(Icons.remove_circle_outline)),
                ],
              ),
              SizedBox(height: 10,),

              //color


              Row(
                children: [
                  Text("Select Color"),

                  SizedBox(width: 15,),
                  InkWell(
                    onTap: ()
                    {
                      setState(() {
                        color="blue";
                      });
                    },
                    child: CircleAvatar(
                      radius:color=="blue"? 20:14,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 10,),

                  InkWell(
                    onTap: (){
                      setState(() {
                        color="red";
                      });
                    },
                    child: CircleAvatar(
                      radius:color=="red"? 20:14,
                      backgroundColor: Colors.red,
                    ),
                  ),
                  SizedBox(width: 10,),

                  InkWell(
                    onTap: (){
                      setState(() {
                        color="orange";
                      });
                    },

                    child: CircleAvatar(
                      radius:color=="orange"? 20:14,
                      backgroundColor: Colors.orange,
                    ),
                  ),

                ],
              ),

              SizedBox(height: 50,),

              //check out




            ],
          ),
        ),
      ),
    );
  }
}
