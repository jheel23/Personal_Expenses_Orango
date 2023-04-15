import 'dart:io'; //To know which platform app is running On

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

//Context: Thing that allows my widget to figure out where my widget is!
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
  //   runApp(MyApp());

  runApp(MyApp());
}
/*If in the above code we didnt use "then" ,it'll create a problem suppose if the user opens the app in 
  landscape mode itself then it won't recognize it and will run the app on landscape even though the app not supprted on LANDSCAPE
  If we used "then" as above then it wont be a problem coz our app will open only after orientation is portrait or whatever selected*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/Orango2.png'),
          splashTransition: SplashTransition.fadeTransition,
          duration: 2500,
          splashIconSize: double.infinity,
          nextScreen: MyHomePage()),
      theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: TextStyle(fontSize: 18),
              labelLarge: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w400)),
          fontFamily: 'Quicksand',
          primarySwatch: Colors.orange,
          primaryColor: Colors
              .orange /*It automatically choses the theme of the app based on the color you choose */),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String titleinput;
  final List<Transaction> _userTransaction = [];

  void _addnewtransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        date: chosenDate,
        amount: txamount,
        title: txtitle);
    setState(() {
      _userTransaction.add(newTx); //Manipulating the LIST
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _addTransactionScreen(BuildContext ctx) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: NewTransaction(_addnewtransaction),
        );
      },
    );
  }

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  bool _showChart = false;
  List<Widget> _buildLandscape(MediaQueryData mediaQuerry,
      PreferredSizeWidget app_Bar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Show Chart',
            style: TextStyle(fontSize: 15),
          ),
          Switch.adaptive(
              activeColor: Theme.of(context)
                  .colorScheme
                  .secondary, //IOS Specific to make the color of button same as AppTheme
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart //By default DART assumes bool = True
          ? Container(
              height: (mediaQuerry.size.height -
                      app_Bar.preferredSize.height -
                      mediaQuerry.padding.top) *
                  0.7,
              child: Chart(_recentTransaction))
          : txListWidget
    ];
  }

  List<Widget> _buildPortrait(MediaQueryData mediaQuerry,
      PreferredSizeWidget app_Bar, Widget txListWidget) {
    return [
      Container(
          height: (mediaQuerry.size.height -
                  app_Bar.preferredSize.height -
                  mediaQuerry.padding.top) *
              0.3,
          child: Chart(_recentTransaction)),
      txListWidget
    ];
  }

  PreferredSizeWidget _buildAppBar(double optimizedText) {
    return Platform.isIOS
        ? /*Same as title in Appbar*/ CupertinoNavigationBar(
            middle: Text('Orango!'),
            trailing: Row(
              mainAxisSize: MainAxisSize
                  .min, //By Default it takes all length it can get which wont allow our title to render thats why set it to minimumu
              children: [
                GestureDetector(
                  onTap: () => _addTransactionScreen(context),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ))
        : AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 10,
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () => _addTransactionScreen(context),
                icon: Icon(Icons.add_circle),
                iconSize: 30,
              )
            ],
            title: Text(
              'Orango!',
              style: TextStyle(fontSize: 30 * optimizedText),
            ),
          ) as PreferredSizeWidget;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
    final optimizedText = mediaQuerry.textScaleFactor;
    final isLandscape = mediaQuerry.orientation == Orientation.landscape;
    //We put the AppBar into a final variable coz it never changes hence then we can use it as a const variable input
    final PreferredSizeWidget app_Bar = _buildAppBar(optimizedText);

    final txListWidget = Container(
        height: (mediaQuerry.size.height -
                app_Bar.preferredSize.height -
                mediaQuerry.padding.top) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    final pageBody = SafeArea(
      //It'll adjust everything to match device requirements like notch and all
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscape(mediaQuerry, app_Bar, txListWidget),
            if (!isLandscape)
              ..._buildPortrait(mediaQuerry, app_Bar, txListWidget)
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: app_Bar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS //IOS OPTIMIZATIONS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _addTransactionScreen(context),
                    child: Icon(Icons.add, size: 36),
                    backgroundColor: Theme.of(context).primaryColor),
            appBar: app_Bar,
            body: pageBody);
  }
}
