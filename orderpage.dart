import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firstscreen.dart';

final databaseReference = Firestore.instance;


class OrderPage extends StatefulWidget{

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          backgroundColor: Color(0xffccccff),
        title: Text("Orders", style: TextStyle(color: Colors.black))
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>( //https://heartbeat.fritz.ai/using-firebases-cloud-firestore-in-flutter-79a79ec5303a?gi=a9dd9ef679d1
        stream: Firestore.instance.collection('orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return new Text('');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('');
          default:
            return new ListView( //https://api.flutter.dev/flutter/widgets/ListView-class.html
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new Card(
                  margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(document['shop']+" "+document['boxType']+" Box", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text('Order Number: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            Text( document.documentID, style: TextStyle(fontSize: 13)),
                            ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                              Text('Date: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            Text( document['orderDate'].toString(), style: TextStyle(fontSize: 13)),
                            ],
                        ),
                        SizedBox(height: 5),
                            Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                color: Color(0xff94b8af),
                               child: Text("Order Details"),
                                onPressed: (){
                                  Navigator.push(
                                    context, new MaterialPageRoute(builder: (context) =>  OrderDetails(docDate: document['orderDate'], docShop: document['shop'])), //https://codingwithjoe.com/flutter-navigation-the-basics/
                                  );
                                },
                              ),
                              SizedBox(width: 10),
                              RaisedButton(
                                color: Color(0xff94b8af),
                               child: Text("Review Order"),
                                onPressed: (){
                                  Navigator.push(
                                    context, new MaterialPageRoute(builder: (context) =>  ReviewOrder(docDate: document['orderDate'], docShop: document['shop'], docImage: document['shopImage'])), //https://codingwithjoe.com/flutter-navigation-the-basics/
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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


class OrderDetails extends StatefulWidget{
  String docDate;
  String docShop;
  OrderDetails({this.docDate, this.docShop});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>{

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text("Order Details"),
        backgroundColor: Color(0xffccccff),
      ),
      body:  Container(

        child: StreamBuilder<QuerySnapshot>( //https://heartbeat.fritz.ai/using-firebases-cloud-firestore-in-flutter-79a79ec5303a?gi=a9dd9ef679d1
          stream: Firestore.instance.collection('orders').where('orderDate', isEqualTo: widget.docDate).where('shop', isEqualTo: widget.docShop).orderBy('dateTime', descending: true).snapshots(),
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
                         SizedBox(height: 20),
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
                                      Text(document.documentID, style: TextStyle(fontSize: 14),),
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
                                                     ]),)],
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


class ReviewOrder extends StatefulWidget{
  String docDate;
  String docShop;
  String docImage;
  ReviewOrder({this.docDate, this.docShop, this.docImage});


  @override

  _ReviewOrderState createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder>{
  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;
  final review = TextEditingController();
  String _star = "";

  void dispose() {

    review.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Color(0xffccccff),
        title: Text("How Was Your Order"),
      ),
      body: Container(
        child: Card(

          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
               child: Row(
                children: [

                  Image.asset('assets/appimages/'+widget.docImage, height: 80, width: 80),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Review your order with "+widget.docShop,
                          style: TextStyle(fontSize: 18)),
                        SizedBox(height:5),
                        Text("placed on "+widget.docDate,style: TextStyle(fontSize: 18)),
                        ]),
                  )]),
                ),
              SizedBox(height: 10),
              SizedBox(width: 20),
              Text(_star, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.star,
                    color: star1 ?  Colors.red : null),
                    onPressed: () {
                      setState(()
                      {
                      star1 = true;
                      star2 = false;
                      star3 = false;
                      star4 = false;
                      star5 = false;
                      _star = "1/5 Rating";
                      });
                    }
                    ),

                  IconButton(
                      icon: Icon(Icons.star,
                          color: star2 ? Colors.red : null),
                      onPressed: () {

                          setState(()
                          {
                            star1 = true;
                            star2 = true;
                            star3 = false;
                            star4 = false;
                            star5 = false;
                            _star = "2/5 Rating";
                          });
                      }
                  ),
                  IconButton(
                      icon: Icon(Icons.star,
                          color: star3 ? Colors.red : null),
                      onPressed: () {

                          setState(() {
                            star1=true;
                            star2 = true;
                            star3 = true;
                            star4 = false;
                            star5 = false;
                            _star = "3/5 Rating";
                          });


                      }
                  ),IconButton(
                      icon: Icon(Icons.star,
                          color: star4 ? Colors.red: null),
                      onPressed: () {
                          setState(()
                          {
                            star1 = true;
                            star2 = true;
                            star3 = true;
                            star4 = true;
                            star5 = false;
                            _star = "4/5 Rating";
                          });

                      }
                  ),
                  IconButton(
                      icon: Icon(Icons.star,
                          color: star5 ? Colors.red : null),
                      onPressed: () {
                        setState(() {
                          star1 = true;
                          star2 = true;
                          star3 = true;
                          star4 = true;
                          star5 = true;
                          _star = "5/5 Rating";
                        });
                      }

                  ),

              ]
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child:TextField(
                  controller: review,
                  keyboardType: TextInputType.multiline, //https://stackoverflow.com/questions/45900387/multi-line-textfield-in-flutter
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Enter your review',

                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal:10),
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              RaisedButton(
                color: Color(0xff94b8af),
                child:Text("Submit Review"),
                onPressed: (){
                  submitReview(star1, star2, star3, star4, star5, review);
                Navigator.push(
                 context, new MaterialPageRoute(builder: (context) =>  ReviewSubmitted())//https://codingwithjoe.com/flutter-navigation-the-basics/
                 );
                },
              )
    ]),),
            ]
          )
            ,
        ),
      ),
    );


  }

  void submitReview(star1, star2, star3, star4, star5, review) async{
    int score;
    if (star5 == true){
      score = 5;
    }
    else if (star4 == true){
      score = 4;
    }
    else if (star3 == true){
      score =3;
    }
    else if (star2 == true){
      score = 2;
    }
    else if (star1 == true){
      score = 1;
    }
    final docs = await databaseReference.collection('shops').getDocuments();
    final shops = docs.documents.first.data;
    double avgScore = shops['avgScore'];
    double reviewNo = shops['avgReview'];

    double totalScore = avgScore*reviewNo;
    double newScore = totalScore + score;
    double newReviewNo = reviewNo + 1;

    double newAvgScore = newScore / newReviewNo;
    print(score);

    DocumentReference ref = await databaseReference.collection('reviews').add({
      'stars': score,
      'shop' : widget.docShop,
      'review': review.text,
    });
    databaseReference.collection('shops')
        .document(widget.docShop)
        .updateData({
      'avgScore': newAvgScore,
      'avgReview': newReviewNo,
    });

    print(ref);
  }

  }

class ReviewSubmitted extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Color(0xffccccff),
        title: Text("Review Submitted"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20),
        child: Column(
          children: [
            SizedBox(height: 60),
            Text("Thankyou for submitting your review.", style: TextStyle(fontSize: 18)),
        SizedBox(height: 20),
        Container(
          width: 360,
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
      ]),),
    );
  }
}