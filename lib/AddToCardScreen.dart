import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapis/CheckOutScreen.dart';
import 'Model.dart';
import 'main.dart';


class AddToCardScreen extends StatefulWidget {
  const AddToCardScreen({Key? key}) : super(key: key);

  @override
  State<AddToCardScreen> createState() => _AddToCardScreenState();
}

class _AddToCardScreenState extends State<AddToCardScreen> {

  Map<String,dynamic> fetchObj={};

  var totalprice=0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("${myFavList.length}");

    myFavList.forEach((element) {

      totalprice+=element['obj'].price;

    });
  }

  @override
  Widget build(BuildContext context) {
    return myFavList.length==0?

    Container(

      child: Center(child: Text("No Item Add ")),
    )
        :Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Card"),
            Text("Total Price:${totalprice}")
          ],
        ),
        centerTitle: true,),
      bottomSheet: Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckOutScreen(),));
          },child: Text("Check Out"),)),
      body: ListView.builder(
        itemCount: myFavList.length,
        itemBuilder: (context, index) {


          fetchObj=myFavList[index];

          Model model=fetchObj['obj'];


          int count=fetchObj['quantity'];
          String color=fetchObj['color'];
          return Card(
            elevation: 4,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Center(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("${model.title}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Image.network("${model.image}",fit: BoxFit.fill),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text("Quantity:",style: TextStyle(fontSize: 24)),
                        Text("${count}",style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Color:",style: TextStyle(fontSize: 24)),
                        Stack(
                          children: [
                            Visibility(
                              visible: color=="red"?true:false,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: color=="red"?Colors.red: Colors.white,
                              ),
                            ),
                            Visibility(
                              visible: color=="orange"?true:false,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: color=="orange"?Colors.orange: Colors.white,
                              ),
                            ),
                            Visibility(
                              visible: color=="blue"?true:false,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: color=="blue"?Colors.blue: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Price:",style: TextStyle(fontSize: 24)),
                        SizedBox(
                          width: 5,
                        ),
                        Text("${count*model.price}",style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),),
                      ],
                    )
                  ],
                ),
               SizedBox(
                 height: 10,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   InkWell(
                     onTap: (){
                      setState(() {
                        myFavList.remove(fetchObj);
                      });
                     },
                     child: Text("remove",style: TextStyle(color: Colors.blue),),
                   ),
                   Divider(
                     thickness: 9,
                     color: Colors.grey,
                   ),
                   InkWell(
                     onTap: (){},
                     child: Text("edit",style: TextStyle(color: Colors.blue)),
                   ),
                 ],
               )
              ],
            ),
          );
        },),
    );
  }
}
