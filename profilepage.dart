import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //https://stackoverflow.com/questions/59529177/how-to-read-data-from-firestore-flutter
  String _dressSize;
  String _jumperSize;
  String _trouserSize;
  String _shoeSize;
  String _style;
  String _preference1;
  String _preference2;
  String _preference3;
  String _preference4;
  List<String> _dressSizes = [
    '4',
    '6',
    '8',
    '10',
    '12',
    '14',
    '16',
    '18',
    '20',
    '22',
    '24',
    '26'
  ];
  List<String> _jumperSizes = [
    'X-Small',
    'Small',
    'Medium',
    'Large',
    'X-Large'
  ];
  List<String> _trouserSizes = ['28/30', '28/32', '30/30', '30/32', '32/32'];
  List<String> _shoeSizes = [
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  List<String> _styles = ['Oversized', 'Fitted', 'Colourful', 'Retro'];
  List<String> _prefrences1 = ['T-Shirt', 'Jeans', 'Shoes', 'Jumper', 'Dress'];
  List<String> _prefrences2 = ['T-Shirt', 'Jeans', 'Shoes', 'Jumper', 'Dress'];
  List<String> _prefrences3 = ['T-Shirt', 'Jeans', 'Shoes', 'Jumper', 'Dress'];
  List<String> _prefrences4 = ['T-Shirt', 'Jeans', 'Shoes', 'Jumper', 'Dress'];
  //final _formKey2 = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    //https://stackoverflow.com/questions/46611369/get-all-from-a-firestore-collection-in-flutter
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Customise Your Order"),
        ),
        body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>( //https://heartbeat.fritz.ai/using-firebases-cloud-firestore-in-flutter-79a79ec5303a?gi=a9dd9ef679d1
          stream: Firestore.instance.collection('shops').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){ //https://codelabs.developers.google.com/codelabs/flutter-firebase/#4
          if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState){
          case ConnectionState.waiting:
          return new Text("Collecting data");
          default:
          return new ListView(
            children: snapshot.data.documents
                .map((DocumentSnapshot document) {
                  return new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Card(
                                child: Column(
                                    children: [
                                      Text("Sizes", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        children: <Widget>[
                                          Container(

                                            child: Text("Dress Size",
                                                style: TextStyle(fontSize: 16)),
                                          ),
                                          Container(
                                            child: DropdownButton( //https://stackoverflow.com/questions/49273157/how-to-implement-drop-down-list-in-flutter
                                              hint: Text(document['dress']),
                                              //https://stackoverflow.com/questions/58095879/drop-down-inside-listview-in-flutter
                                              value: _dressSize,
                                              onChanged: (newValue) {
                                                setState(() { //https://stackoverflow.com/questions/56592409/get-data-from-firestore-when-button-is-clicked-in-flutter
                                                  _dressSize = newValue;
                                                });
                                              },
                                              items: _dressSizes.map((dressSize) {
                                                return DropdownMenuItem(
                                                  child: new Text(dressSize),
                                                  value: dressSize,
                                                );
                                              }).toList(),

                                            ),
                                          )

                                        ],
                                      ),
                                      Divider(height: 1),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Text("Jumper Size",
                                                  style: TextStyle(fontSize: 16)),
                                            ),
                                            Container(
                                              child: DropdownButton(
                                                hint: Text('Jumper Size'),
                                                value: _jumperSize,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _jumperSize = newValue;
                                                  });
                                                },
                                                items: _jumperSizes.map((
                                                    jumperSize) {
                                                  return DropdownMenuItem(
                                                    child: new Text(jumperSize),
                                                    value: jumperSize,
                                                  );
                                                }).toList(),

                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 1),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: <Widget>[
                                            Container(
                                              child: Text("Trouser Size",
                                                  style: TextStyle(fontSize: 16)),
                                            ),
                                            Container(
                                              child: DropdownButton(
                                                hint: Text('Trouser Size'),
                                                value: _trouserSize,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _trouserSize = newValue;
                                                  });
                                                },
                                                items: _trouserSizes.map((
                                                    trouserSize) {
                                                  return DropdownMenuItem(
                                                    child: new Text(trouserSize),
                                                    value: trouserSize,
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 1),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: <Widget>[
                                            Container(

                                              child: Text("Shoe Size",
                                                  style: TextStyle(fontSize: 16)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              width: 110,
                                              child: DropdownButton(
                                                hint: Text('Shoe Size'),

                                                value: _shoeSize,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _shoeSize = newValue;
                                                  });
                                                },
                                                items: _shoeSizes.map((shoeSize) {
                                                  return DropdownMenuItem(
                                                    child: new Text(shoeSize),
                                                    value: shoeSize,
                                                  );
                                                }).toList(),

                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 1), Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 14),
                                              child: Text("Style",
                                                  style: TextStyle(fontSize: 16)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              width: 110,
                                              child: DropdownButton(
                                                hint: Text('Style'),
                                                value: _style,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _style = newValue;
                                                  });
                                                },
                                                items: _styles.map((style) {
                                                  return DropdownMenuItem(
                                                    child: new Text(style),
                                                    value: style,
                                                  );
                                                }).toList(),

                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),

                              Card(
                                  child: Container(
                                    child: Column(
                                        children: [
                                          Text("Order Preference",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            children: <Widget>[
                                              Container(

                                                child: Text("Preference 1",
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ),
                                              Container(
                                                child: DropdownButton(
                                                  hint: Text('Preference 1'),
                                                  value: _preference1,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _preference1 = newValue;
                                                    });
                                                  },
                                                  items: _prefrences1.map((
                                                      preference1) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                          preference1),
                                                      value: preference1,
                                                    );
                                                  }).toList(),

                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(height: 1),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            children: <Widget>[
                                              Container(

                                                child: Text("Preference 2",
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ),
                                              Container(
                                                child: DropdownButton(
                                                  hint: Text('Preference 2'),
                                                  value: _preference2,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _preference2 = newValue;
                                                    });
                                                  },
                                                  items: _prefrences2.map((
                                                      preference2) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                          preference2),
                                                      value: preference2,
                                                    );
                                                  }).toList(),

                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(height: 1),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            children: <Widget>[
                                              Container(

                                                child: Text("Preference 3",
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ),
                                              Container(
                                                child: DropdownButton(
                                                  hint: Text('Preference 3'),
                                                  value: _preference3,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _preference3 = newValue;
                                                    });
                                                  },
                                                  items: _prefrences3.map((
                                                      preference3) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                          preference3),
                                                      value: preference3,
                                                    );
                                                  }).toList(),

                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(height: 1),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: <Widget>[

                                                Container(
                                                  child: Text("Preference 4",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ),


                                                Container(

                                                  child: DropdownButton(
                                                    hint: Text('Preference 4',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    value: _preference4,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        _preference4 = newValue;
                                                      });
                                                    },
                                                    items: _prefrences4.map((
                                                        preference4) {
                                                      return DropdownMenuItem(
                                                        child: new Text(
                                                            preference4),
                                                        value: preference4,
                                                      );
                                                    }).toList(),

                                                  ),
                                                  // hint: Text("hello"), //https://stackoverflow.com/questions/49273157/how-to-implement-drop-down-list-in-flutter
                                                ),
                                              ]),
                                        ]),))
                            ],
                      ),
                    ),

                    SizedBox(height: 10.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RaisedButton(
                              color: Color(0xff94b8af),
                              child: Text("Save", style: TextStyle(
                                  color: Colors.black)),
                              onPressed: () {
                                updatePreferences(
                                    _dressSize,
                                    _jumperSize,
                                    _trouserSize,
                                    _shoeSize,
                                    _style,
                                    _preference1,
                                    _preference2,
                                    _preference3,
                                    _preference4);
                              }
                          )
                        ],
                      ),
                    ),
                          ]);

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


void updatePreferences(dress, jumper, trousers, shoes, style, pref1, pref2,
    pref3, pref4) {
  try {
    databaseReference //https://firebase.google.com/docs/reference/android/com/google/firebase/firestore/DocumentSnapshot
        .collection('preferences')
        .document('1')
        .updateData({
      'dress': dress,
      'jumper': jumper,
      'trousers': trousers,
      'shoes': shoes,
      'style': style,
      'pref1': pref1,
      'pref2': pref2,
      'pref3': pref3,
      'pref4': pref4,
    });
  } catch (e) {
    print(e.toString());
  }
}




