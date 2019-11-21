import 'package:currency_converter/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Create a custom stateful widget
class Home extends StatefulWidget {
  var data;

  Home({Key key, this.data}) : super(key: key);

  // It is necessary to create states of every
  // stateful widget
  @override
  State<StatefulWidget> createState() {
    debugPrint(data);
    return new CustomState(data: data);
  }
}

// This class creates a state for the CustomStatefulWidget
// Note: how it extends State and its of type <CustomStatefulWidget>
class CustomState extends State<Home> {
  static String title = "Currency Converter";
  var data;

  CustomState({data});


  Widget _buildAppBar() {
    return new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: new FlutterLogo(
          size: 30.0,
          colors: Colors.green,
        ),
        centerTitle: true,
        // The action widgets are the right icons in the appBar
        leading: new IconButton(
            icon: new Icon(
              Icons.account_circle,
              color: Colors.greenAccent,
            ),
            onPressed: () => debugPrint("account pressed")),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.message,
                color: Colors.greenAccent,
              ),
              onPressed: () => debugPrint("Send icon Tapped!")),
        ]);
  }

  // build body
  Widget _buildBody() {
    // AnchoredOverlay creates a child and an overlay
    // The overlay widget can move over freely above
    // the child. Here the overlay widget is a CenterAbout
    // which centers its child at a given position
    return _layout();
  }

  Widget _layout (){
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/home.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter
              )
          ),
        ),
        Center(

        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 320,
          margin: EdgeInsets.only(top: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: "Currency",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                    )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      onTap: () {
                        showSearch(context: context, delegate: DataSearch());
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'enter country or currency...',
                          prefixIcon: Icon(Icons.monetization_on),
                          labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    onTap: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                    obscureText: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'enter country or currency...',
                        prefixIcon: Icon(Icons.monetization_on),
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: (){},//since this is only a UI app
                    child: Text('Convert',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'SFUIDisplay',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Color(0xffff2d55),
                    elevation: 0,
                    minWidth: 400,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
    )
      ],
    );
  }

  Scaffold createScafflod() {
    /*
      Scaffold has many in-built widgets like AppBar,
      floatingActionButton, bottomNavigationBar, body etc..
      So, we declare the properties of these widgets and return
      the scaffold
     */

    return new Scaffold(
      // Creates and sets params for AppBar
      //appBar: _buildAppBar(),

      // Creates and sets params for body of scaffold
      body: _buildBody(),

      // build bottomNavigationBar
      //bottomNavigationBar: _buildBottomBar()
    );
  }

  @override
  Widget build(BuildContext context) {
    return createScafflod();
  }
}