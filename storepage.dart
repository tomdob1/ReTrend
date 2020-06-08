import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';//https://www.youtube.com/watch?v=Wa0rdbb53I8
import 'firstscreen.dart';
import 'orderpage.dart';
import 'profilepage2.dart';
import 'shopdata.dart';
import 'package:geolocator/geolocator.dart';

final databaseReference = Firestore.instance;

class StorePage extends StatefulWidget{
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>{
  bool favBool;
  bool true1 = true;
  bool false1 = false;
  Geolocator _geolocator;
  Position _position;




  bool favcheck;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text('Select a Store'),
          automaticallyImplyLeading: false,
        backgroundColor: Color(0xffccccff),),


      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>( //https://heartbeat.fritz.ai/using-firebases-cloud-firestore-in-flutter-79a79ec5303a?gi=a9dd9ef679d1
            stream: Firestore.instance.collection('shops').orderBy('name', descending: false).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){ //https://codelabs.developers.google.com/codelabs/flutter-firebase/#4
            if (snapshot.hasError)
              return new Text('');
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
               return new Text("");
              default:
                return new ListView( //https://api.flutter.dev/flutter/widgets/ListView-class.html
                 children: snapshot.data.documents
                  .map((DocumentSnapshot document) {
                    return new Card(
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: ListTile( //https://api.flutter.dev/flutter/material/ListTile-class.html
                      leading: Image.asset("assets/appimages/" + document['image'], width: 70), //https://fluttermaster.com/load-image-from-assets-in-flutter/
                      title: Text(document['name']),
                     subtitle: Text(document['location']),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),

                      onTap: (){
                       int shopAvg1 = document['avgScore'];

                        String stringShopAvg1 = shopAvg1.toString();


                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>  //https://flutter.dev/docs/cookbook/navigation/passing-data
                            BoxScreen(shopName: document['name'],
                                shopLocation: document['location'],
                                shopDescription: document['description'],
                                shopImage: document['image'],
                                shopGold: document['gold'],
                                shopSilver: document['silver'],
                                shopBronze: document['bronze'],
                                shopFavourite: document['favourites'],
                                shopAvgScore: stringShopAvg1,
                                ),
                          ),
                        );
                      },

                      ),

                    );
                  }).toList(),
               );
              }
            },
          ),

        ),
      ),
    );
  }
}

class BoxScreen extends StatefulWidget{ //https://stackoverflow.com/questions/50818770/passing-data-to-a-stateful-widget
  String shopName;
  String shopLocation;
  String shopDescription;
  String shopImage;
  String shopAvgScore;
  int shopGold;
  int shopSilver;
  int shopBronze;
  String shopFavourite;


  BoxScreen({this.shopName, this.shopLocation, this.shopDescription, this.shopImage,  this.shopGold, this.shopSilver, this.shopBronze, this.shopFavourite, this.shopAvgScore});
  @override
  _BoxScreenState createState() => _BoxScreenState();

}

class _BoxScreenState extends State<BoxScreen> {
  bool favourite = false;

 @override
//http://tphangout.com/flutter-firestore-crud-reading-and-writing-data/

  Widget build(BuildContext context){


    return Scaffold(

      appBar: AppBar(title: Text(widget.shopName), //https://stackoverflow.com/questions/50185357/how-to-change-icon-color-immediately-after-pressed-in-flutter
        backgroundColor: Color(0xffccccff),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        actions: <Widget> [//https://flutter.dev/docs/catalog/samples/basic-app-bar
                  IconButton( //https://stackoverflow.com/questions/52102646/how-to-change-color-of-icon-after-function-executes-within-ontap-flutter-listi
                    icon: Icon(Icons.favorite, //https://stackoverflow.com/questions/52302195/creating-a-variable-with-an-ontap-navigator-flutter
                              color: favourite ? Colors.red : null),//https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/#6
          onPressed: () {  //https://medium.com/@dev.n/the-complete-flutter-series-article-3-lists-and-grids-in-flutter-b20d1a393e39

                       if (favourite == true){
                        updateRecordFalse(widget.shopName);
                         setState(()
                          {
                            favourite = false;
                          });
                        }
                        else  if (favourite == false){
                          updateRecordTrue(widget.shopName);
                          setState(() {
                            favourite = true;
                          });
                        }
                    }

                  ),
                ],),
      body:
      Container(
        margin: EdgeInsets.only(top: 40, right: 10, left: 10, bottom: 200),
        //   padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Card( //https://stackoverflow.com/questions/50756745/custom-card-shape-flutter-sdk
          color: Color(0xffededf8), //https://stackoverflow.com/questions/51513429/rounded-corners-image-in-flutter
          shape: RoundedRectangleBorder( //https://stackoverflow.com/questions/50756745/custom-card-shape-flutter-sdk
          borderRadius: BorderRadius.circular(5.0),),
            child: Column(

              children:[
                Container(
                  color: Colors.white,
                child: Row(

                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 2, top: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), //https://stackoverflow.com/questions/51513429/rounded-corners-image-in-flutter

                          child: Image.asset('assets/appimages/'+widget.shopImage,
                            width: 90,
                            height: 90),
                        ),

                    ),
                   Container(
                    child: Column(

                      children: [
                        Container(

                          child: Column(

                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(widget.shopName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 30, top: 10.0),
                                child: Text(
                                  widget.shopLocation,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                  color: Color(0xff8c8c8c)),
                                ),
                              ),
                            ],
                          ),
                        ),
                     ],
                    ),

            ),

                ]
                ),
    ),
                        Divider( height: 0,color: Color(0xffe6e6ff), thickness: 1.0), //https://api.flutter.dev/flutter/material/Divider-class.html

                        SizedBox(),
                        SizedBox(),
                        Container(

                          padding: EdgeInsets.all(12),
                          child: Text(
                            widget.shopDescription,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87),
                          ),
                        ),
                        Spacer(), //https://stackoverflow.com/questions/45746636/flutter-trying-to-bottom-center-an-item-in-a-column-but-it-keeps-left-aligning
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                       child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                             RaisedButton( //https://api.flutter.dev/flutter/material/RaisedButton-class.html
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(5),),
                              color: Color(0xff94b8af),

                             onPressed:() {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                    BuyBoxScreen(shopName2: widget.shopName,
                                                shopGold2: widget.shopGold,
                                                shopSilver2: widget.shopSilver,
                                                shopBronze2: widget.shopBronze,
                                                shopImage2: widget.shopImage),
                              ),
                            );
                          },

                            child: Text("Purchase Box",
                                style: TextStyle(fontSize: 22)
                        ),
                      ),
                          ],
                        ),
                        ),
                ],
              ),


        ),
      ),
    );
  }

}

void updateRecordTrue(shopName){ //https://medium.com/47billion/how-to-use-firebase-with-flutter-e4a47a7470ce
  int value;
  if (shopName == "Beyond Retro"){
    value = 1;
  }
  else if (shopName == "Rokit"){
    value = 2;
  }
  else if (shopName == "COW"){
    value = 3;
  }
  else if (shopName == "Urban Fox"){
    value = 4;
  }
  else if (shopName == "Brag"){
    value = 5;
  }
  else if (shopName == "Flip"){
    value = 6;
  }
  else if (shopName == "Reign"){
    value = 7;

  }else if (shopName == "Blue Rinse"){
    value = 8;
  }
 String valueString = value.toString();
  try {
    databaseReference
        .collection('shops')
        .document(valueString)
        .updateData({'favourites': 'true'});
  } catch (e){
    print (e.toString());
  }
}

void updateRecordFalse(shopName){ //https://medium.com/47billion/how-to-use-firebase-with-flutter-e4a47a7470ce
  int value;
  if (shopName == "Beyond Retro"){
    value = 1;
  }
  else if (shopName == "Rokit"){
    value = 2;
  }
  else if (shopName == "Cow"){
    value = 3;
  }
  else if (shopName == "Rokit"){
    value = 4;
  }
  else if (shopName == "Brag"){
    value = 5;
  }
  else if (shopName == "Flip"){
    value = 6;
  }
  String valueString = value.toString();
  try {
    databaseReference
        .collection('shops')
        .document(valueString)
        .updateData({'favourites': 'false'});
  } catch (e){
    print (e.toString());
  }
}


class BuyBoxScreen extends StatefulWidget{
  String shopName2;
  int shopGold2;
  int shopSilver2;
  int shopBronze2;
  String shopImage2;

  BuyBoxScreen({this.shopName2, this.shopGold2, this.shopSilver2, this.shopBronze2, this.shopImage2});
  @override
  _BuyBoxScreenState createState() => _BuyBoxScreenState();
}

class _BuyBoxScreenState extends State<BuyBoxScreen>{
 // String shopGoldString = shopGold2.toString();

  @override

  Widget build(BuildContext context){
    int gold = widget.shopGold2;  //https://stackoverflow.com/questions/54954182/flutter-convert-int-variable-to-string
    int silver = widget.shopSilver2;
    int bronze = widget.shopBronze2;
    String goldString = gold.toString();
    String silverString = silver.toString();
    String bronzeString = bronze.toString();

    return Scaffold( //https://flutter.dev/docs/development/ui/layout#card
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Color(0xffccccff),
        title:
        Text(widget.shopName2 + " Mystery Box"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Text("Select a Box",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 105,
                  width: 360,
                  child: Card(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.white,

                    child: InkWell(
                        onTap:(){
                          String boxType = "Gold";
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                                PaymentScreen(shopNamePurchase: widget.shopName2, boxCostPurchase: goldString, boxTypePurchase: boxType, shopImagePurchase: widget.shopImage2),
                            ),
                          );
                        },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 5, left: 10),
                                child: Image.asset("assets/appimages/Goldbox.png", height: 90, width: 90),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20, left: 2),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Gold Box",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                                    SizedBox(height: 20),
                                    Text("Retail value of £130", style: TextStyle( fontSize: 12.0, color: Color(0xFF737373))),
                                  ],
                                ),
                              ),
                              Text("£"+goldString, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            ]
                        ),
                      ),
                      ),
                  ),
            ),
            SizedBox(height: 40.0),
            Container(
                height: 105,
                  width: 360,
                  child: Card(
                    margin: EdgeInsets.only(left: 10, right: 10),

                   child:InkWell(
                     onTap:(){
                      String boxType = "Silver";
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            PaymentScreen(shopNamePurchase: widget.shopName2, boxCostPurchase: silverString, boxTypePurchase: boxType, shopImagePurchase: widget.shopImage2),
                        ),
                      );
                    },
                     child: Container(
                       margin: EdgeInsets.only(right: 20),
                       child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Container(
                               margin: EdgeInsets.only(top: 5, left: 10),
                               child: Image.asset("assets/appimages/Silverbox.png", height: 90, width: 90),
                             ),
                             Container(
                               margin: EdgeInsets.only(top: 20),
                               child:Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Text("Silver Box",
                                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                                   SizedBox(height: 20),
                                   Text("Retail value of £90", style: TextStyle( fontSize: 12.0, color: Color(0xFF737373))),
                                 ],
                               ),
                             ),
                             Text("£"+silverString, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                           ]
                       ),
                     ),
                   ),
                  ),
            ),
            SizedBox(height: 40.0),
            Container(
              height: 105,
                  width: 360,
                  child: Card(
                    margin: EdgeInsets.only(left: 10, right: 10),

                    child: InkWell(
                      onTap:(){
                        String boxType = "Bronze";
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              PaymentScreen(shopNamePurchase: widget.shopName2, boxCostPurchase: bronzeString, boxTypePurchase: boxType, shopImagePurchase: widget.shopImage2),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5, left: 10),
                            child: Image.asset("assets/appimages/Bronzebox.png", height: 90, width: 90),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 2),
                              child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Bronze Box",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                              SizedBox(height: 20),
                              Text("Retail value of £50", style: TextStyle( fontSize: 12.0, color: Color(0xFF737373))),
                            ],
                              ),
                          ),
                          Text("£"+bronzeString, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          ]
                      ),
                    ),
                  ),
            ),
            ),
                  ],
        ),
                 ),



        );





  }
}


class PaymentScreen extends StatefulWidget{
  String shopNamePurchase;
  String boxCostPurchase;
  String boxTypePurchase;
  String shopImagePurchase;
  PaymentScreen({this.shopNamePurchase, this.boxCostPurchase, this.boxTypePurchase, this.shopImagePurchase});
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}


class _PaymentScreenState extends State<PaymentScreen>{
 final _formKey = GlobalKey<FormState>();
 final postcode = TextEditingController();
 final email = TextEditingController();
 final fName = TextEditingController(); //https://flutter.dev/docs/cookbook/forms/retrieve-input
 final sName = TextEditingController();
 final addr = TextEditingController();
 final city = TextEditingController();
 final cardNo = TextEditingController();
 final cardSecurity = TextEditingController();
 final cardExpiry =  TextEditingController();

 void dispose() {

   postcode.dispose();
   email.dispose();
   fName.dispose();
   sName.dispose();
   addr.dispose();
   city.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false, // https://medium.com/zipper-studios/the-keyboard-causes-the-bottom-overflowed-error-5da150a1c660
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Color(0xffccccff),
        title: Text("Complete Your Order"),
      ),
      body: Container(
             //padding: EdgeInsets.all(10.0),
              child: Column(
                children: [




                SizedBox(

                  height: 640,
                  child: Container(
                  margin: EdgeInsets.all(2.0),
                  child: Card(
                  child: ListView( //https://flutter.dev/docs/cookbook/lists/basic-list
                    scrollDirection: Axis.vertical,
                   children: <Widget>[
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Enter Delivery Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                     ]),
                     Form(

                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                      Container(
                      margin: EdgeInsets.only(left: 5),
                       child: TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                              },
                          ),
                      ),
                          SizedBox(height: 10.0),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child:TextFormField(
                              controller: fName,
                              decoration: const InputDecoration(
                                hintText: 'First Name',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                                },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: sName,
                              decoration: const InputDecoration(
                                hintText: 'Surname',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your surname';
                                }
                                return null;
                                },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: addr,
                              decoration: const InputDecoration( //https://flutter.dev/docs/cookbook/forms/retrieve-input
                                hintText: 'Address',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                                },
                            ),
                          ),
                          SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child:
                          TextFormField(
                            controller: city,
                            decoration: const InputDecoration(
                              hintText: 'City',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                              },
                          ),
                      ),
                          SizedBox(height: 10.0),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: TextFormField(
                            controller: postcode,
                            decoration: const InputDecoration(
                              hintText: 'Postcode',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your postcode';
                              }
                              return null;
                              },
                          ),
                        ),

                          SizedBox(height: 40),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Enter Card Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ]),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: cardNo,
                              decoration: const InputDecoration(
                                hintText: 'Card Number',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Card Number';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: cardExpiry,
                              decoration: const InputDecoration(
                                hintText: 'Card Expiry Date',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Card Expiry Date';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: cardSecurity,
                              decoration: const InputDecoration(
                                hintText: 'Card Security',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your card security number';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10),

                        ],
                      ),
                    ),
                     Container(

                         margin: EdgeInsets.only(left: 5, top: 10, right: 5),
                         child: Column(
                             children: [
                               SizedBox(height: 40),
                               Text("Summary",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                               SizedBox(height: 15),
                               Row(
                                   children: [

                                     Text('Box Type: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                     Container(
                                       margin: EdgeInsets.only(left: 230),
                                       child: Text(widget.boxTypePurchase),
                                     ),

                                   ]
                               ),
                               Divider(height: 10, color: Colors.black),
                               SizedBox(height: 20),
                               Row(
                                   children: [
                                     Text('Store: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                     Container(
                                       margin: EdgeInsets.only(left: 260),
                                       child: Text(widget.shopNamePurchase),
                                     ),
                                   ]
                               ),
                               Divider(height: 10, color: Colors.black),
                               SizedBox(height: 20),
                               Row(
                                   children: [
                                     Text('Total Cost: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                     Container(
                                       margin: EdgeInsets.only(left: 215),
                                       child: Text('£'+widget.boxCostPurchase+'.00'),
                                     ),

                                   ]
                               ),


                               Divider(height: 10, color: Colors.black),

                             ]

                         )),

                         ],
                       ),

                ),
                    ),
                ),


                  Container(
                    width: 350,
                    child: RaisedButton(
                      color: Color(0xff94b8af),
                      child: Text("Complete Order",
                          style: TextStyle(color: Colors.black)),
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                          createRecord(fName, sName, email, addr, city, postcode);
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                                OrderSummary(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                   ]),
      ),





    );




  }

 void createRecord(fName, sName, email, addr, city, postcode) async { //https://medium.com/@atul.sharma_94062/how-to-use-cloud-firestore-with-flutter-e6f9e8821b27 https://flutter-academy.com/async-in-flutter-futures/
   var date = new DateTime.now(); //https://code.luasoftware.com/tutorials/google-cloud-firestore/understanding-date-in-firestore/
   var day = date.day.toString(); //https://api.flutter.dev/flutter/dart-core/DateTime-class.html
   var month = date.month.toString(); //https://androidkt.com/format-datetime-in-flutter/
   var year = date.year.toString();
   var hour = date.hour.toString();
   var minute = date.minute.toString();
   var second = date.second.toString();

   String dateFinish = day+"-"+month+"-"+year+" "+hour+":"+minute+":"+second;
   final docs = await databaseReference.collection('preferences').getDocuments(); //https://stackoverflow.com/questions/55692806/how-do-i-save-data-from-cloud-firestore-into-a-variable-in-flutter
   final preferences = docs.documents.first.data; //https://stackoverflow.com/questions/58473539/how-to-get-a-specific-firestore-document-with-a-streambuilder
   String dress = preferences['dress'];
   String jumper = preferences['jumper'];
   String trousers = preferences['trousers'];
   String shoes = preferences['shoes'];
   String style = preferences['style'];
   String pref1 = preferences['pref1'];
   String pref2 = preferences['pref2'];
   String pref3 = preferences['pref3'];
   String pref4 = preferences['pref4'];



   DocumentReference ref = await databaseReference //https://medium.com/@kfarsoft/deeping-firestore-queries-with-flutter-2210fd3b49e1
       .collection('orders').add({
     'fName' : fName.text,
     'sName' : sName.text,
     'email' : email.text,
     'address' : addr.text,
     'city' : city.text,
     'postcode' : postcode.text,
     'orderStatus' : 'Pending',
     'dateTime' : date, //https://api.flutter.dev/flutter/dart-core/DateTime-class.html
     'orderDate': dateFinish,
     'shop': widget.shopNamePurchase,
     'boxType' : widget.boxTypePurchase,
     'boxCost' : widget.boxCostPurchase,
     'dress': dress,
     'jumper': jumper,
     'trousers': trousers,
     'shoes': shoes,
     'style': style,
     'pref1': pref1,
     'pref2': pref2,
     'pref3': pref3,
     'pref4': pref4,
     'boxImage' : widget.boxTypePurchase+'box.png',
     'shopImage' : widget.shopImagePurchase,
   });

 }

}






class OrderSummary extends StatefulWidget {

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  // String shopGoldString = shopGold2.toString();


  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var nowmin1 = now.subtract(new Duration(seconds: 10));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Color(0xffccccff),
        title: Text("Thankyou for your order"),
      ),
      body: Container( //https://stackoverflow.com/questions/50663556/how-to-fetch-records-by-comparing-with-date-in-flutter-cloud-firestore-plugin
        child: StreamBuilder<QuerySnapshot>( //https://heartbeat.fritz.ai/using-firebases-cloud-firestore-in-flutter-79a79ec5303a?gi=a9dd9ef679d1
          stream: Firestore.instance.collection('orders').where('dateTime', isLessThanOrEqualTo: now).where('dateTime', isGreaterThanOrEqualTo: nowmin1).snapshots(), //https://stackoverflow.com/questions/48937864/firestore-queries-on-flutter
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
           return new Text('');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
          return new Text('');
            default:
          return new ListView( //https://api.flutter.dev/flutter/widgets/ListView-class.html
           children: snapshot.data.documents.map((DocumentSnapshot document) {
          return new Container(
            child: Column(
            children: <Widget>[
          Card(
            child: Column(
                children: <Widget>[
                 Text("Order Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 10),
                  Column(
                  children: [

                    Row(

                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 22, left: 10, bottom: 10),
                          child: Image.asset('assets/appimages/'+document['shopImage'], width: 80, height: 90),
                        ),
                        Container(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Order Number: ', textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(document.documentID, style: TextStyle(fontSize: 12),),
                              ],),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Text('Order Status: ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(document['orderStatus']),
                            ],),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Text('Order Date: ',style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(document['orderDate'].toString()),
                            ],),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Box Type: ',style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(document['boxType']),
                             ],),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text('Shop: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(document['shop']),
                            ],),]),)],
                            ),]),])),

          Card(
            child: Column(
              children: <Widget>[
                Text("Sizes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 22, left: 10, bottom: 10),

                          child: Image.asset('assets/appimages/'+document['boxImage'], width: 80, height: 90),
                        ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Dress Size: ', textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(document['dress']),
                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Jumper Size ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(document['jumper']),
                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Trouser Size',style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(document['trousers']),
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Shoe Size: ',style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(document['shoes']),
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Style: ',style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(document['style']),
                      ],),]),)],
                    ),]),])),
          Card(
            child: Column(
              children: <Widget>[
              Text("Preferences", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              Column(
                children: [

                Row(
                  children: [
                  Container(
                    margin: EdgeInsets.only(right: 22, left: 10, bottom: 10),
                    child: Image.asset('assets/appimages/'+document['pref1']+'.png', width: 80, height: 90),
                ),
                  Container(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Preference 1: ', textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(document['pref1']),
                ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Preference 2: ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(document['pref2']),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Preference 3: ',style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(document['pref3']),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Preference 4 ',style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(document['pref4']),
                ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Shop: ',style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(document['shop']),
            ],),]),)],
            ),]),])),

        Card(
          child: Column(
            children: <Widget>[
              Text("Delivery Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 22, left: 10, bottom: 10),
                      child: Image.asset('assets/appimages/logo2.png', width: 80, height: 90),
                    ),
                    Container(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Name: ', textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(document['fName']+" "+document['sName']),
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Address: ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(document['address']),
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('City: ',style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(document['city'].toString()),
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Postcode: ',style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(document['postcode']),
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Email: ',style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(document['email']),
            ],),]),)],
        ),]),])),
          Container(
            width: 380,
              child: RaisedButton(

                color: Color(0xff94b8af),
                child: Text("Back Home"),
                onPressed: (){
                  Navigator.push(
                    context, new MaterialPageRoute(builder: (context) =>  FirstScreen()), //https://codingwithjoe.com/flutter-navigation-the-basics/
                  );
                },
              ),
          ),







    ]),
    );

    }).toList(),
    );



    }
    },
    ),
    ),

    );
  }
}
