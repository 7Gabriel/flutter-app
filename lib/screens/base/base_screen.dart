import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
   return PageView(
     controller: pageController,
     physics: const NeverScrollableScrollPhysics(),
     children: <Widget>[
       LoginScreen(),
       Scaffold(
         drawer: CustomDrawer(),
         appBar: AppBar(
           title: const Text('Home'),
         ),
       ),
       Container(color: Colors.red,),
       Container(color: Colors.yellow,),
       Container(color: Colors.green,)
     ],
   );
  }

}