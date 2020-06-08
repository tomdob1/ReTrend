import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'storepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //https://www.youtube.com/watch?v=Wa0rdbb53I8

class FavouritePage extends StatefulWidget{
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>{
  String compare = "true";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Color(0xffccccff),
        title: Text("Favourites"),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(//https://heartbeat.fritz.ai/using-firebases-cloud-firestore-in-flutter-79a79ec5303a?gi=a9dd9ef679d1
         stream: Firestore.instance.collection('shops').where('favourites', isEqualTo: 'true').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) //https://stackoverflow.com/questions/59697260/flutter-snapshot-of-streambuilder-has-no-data-after-condition-is-met
            return new Text('');
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
          return new Text('');
            default:
          return new ListView( //https://api.flutter.dev/flutter/widgets/ListView-class.html
              children: snapshot.data.documents
              .map((DocumentSnapshot document) {
          return new Card(
            child: ListTile( //https://api.flutter.dev/flutter/material/ListTile-class.html
            leading: Image.asset("assets/appimages/" + document['image'],
                width: 60,
                height: 90), //https://fluttermaster.com/load-image-from-assets-in-flutter/
            title: Text(document['name']),
            subtitle: Text(document['location']),
            trailing: Icon(Icons.favorite, color: Colors.red,),
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
    );
  }
}