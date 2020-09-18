import 'package:Prolx/ui/SignUpEmail.dart';
import 'package:Prolx/ui/addProduct.dart';
import 'package:Prolx/ui/categoryList.dart';
import 'package:Prolx/ui/loginEmail.dart';
import 'package:Prolx/ui/mainScreen.dart';
import 'package:Prolx/ui/navigation.dart';
import 'package:Prolx/ui/productPage.dart';
import 'package:Prolx/ui/registration.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MainScreen(),
        );
      case '/login_email':
        return MaterialPageRoute(
          builder: (_) => LoginEmail(),
        );
      case '/signUp_email':
        return MaterialPageRoute(
          builder: (_) => SignUP(),
        );
      case '/registration':
        return MaterialPageRoute(
          builder: (_) => Registration(),
        );
      case '/navigation':
        return MaterialPageRoute(
          builder: (_) => Navigation(),
        );
      case '/categoryList':
        return MaterialPageRoute(
          builder: (_) => CategoryList(
            cat: args,
          ),
        );
      case '/addProduct':
        return MaterialPageRoute(
          builder: (_) => AddProduct(),
        );
      // case '/description':
      //   return MaterialPageRoute(
      //     builder: (_) => Description(productId: args),
      //   );

      // If args is not of the correct type, return an error page.
      default:
        return _errorRoute();
    }
  }

  static Route<void> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('/'),
        ),
        body: Center(
          child: Text('/'),
        ),
      );
    });
  }
}
