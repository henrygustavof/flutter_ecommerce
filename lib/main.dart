import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/pages/cart_page.dart';
import 'package:flutter_ecommerce/pages/login_page_google.dart';
import 'package:flutter_ecommerce/redux/actions.dart';
import 'package:flutter_ecommerce/redux/reducers.dart';
import 'package:flutter_ecommerce/pages/login_page.dart';
import 'package:flutter_ecommerce/pages/products_page.dart';
import 'package:flutter_ecommerce/pages/register_page.dart';
import 'package:flutter_ecommerce/widgets/messaging_widget.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
      
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Ropas Fashion',
          routes: {
            '/': (BuildContext context) => ProductsPage(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getProductsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getCartProductsAction);
                }),
            '/notification': (BuildContext context) => MessagingWidget(),
            '/login': (BuildContext context) => LoginPage(),
            '/loginGoogle': (BuildContext context) => LoginGooglePage(),
            '/register': (BuildContext context) => RegisterPage(),
            '/cart': (BuildContext context) => CartPage(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getCardsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getCardTokenAction);
                })
          },
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.lightBlue[800], //Colors.cyan[400],
              accentColor: Colors.cyan[600], //Colors.deepOrange[200],
              textTheme: TextTheme(
                  headline:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  body1: TextStyle(fontSize: 18.0))),
        ));
  }
}
