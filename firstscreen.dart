import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'storepage.dart';
import 'favouritepage.dart';
import 'orderpage.dart';
import 'profilepage2.dart';

class FirstScreen extends StatefulWidget{
  @override
  _FirstScreenState createState() => _FirstScreenState();
}


class _FirstScreenState extends State<FirstScreen>{

  int appBarTab = 0;
  List<Widget> pages;
  Widget setPage;
  StorePage storePage;
  FavouritePage favouritePage;
  OrderPage orderPage;
  ProfilePage profilePage;


  @override
  void initState(){
    super.initState();
    storePage = StorePage();
    favouritePage = FavouritePage();
    orderPage = OrderPage();
    profilePage = ProfilePage();


    pages = [storePage, favouritePage, orderPage, profilePage];

    setPage = storePage;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            setState((){
              appBarTab = index;
              setPage = pages[index];
            });
          },
          currentIndex: appBarTab,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text("Favourites")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text("Orders")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Preferences")
            ),
          ]
      ),
      body: setPage,
    );
  }
}


