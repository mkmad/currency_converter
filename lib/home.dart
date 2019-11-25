import 'package:currency_converter/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;
import 'package:flip_card/flip_card.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'charts_helper.dart';


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

  var currency_one;
  var currency_two;

  var cur_one;
  var cur_two;

  var symbol_one;
  var symbol_two;

  var image_one = "assets/USD.png";
  var image_two = "assets/USD.png";

  var top_margin = 300.0;
  var container_height = 320.0;

  var start_at = "";
  var end_at = "";

  var api_endpoint = "https://api.exchangeratesapi.io/latest?symbols=";
  var historical_api_endpoint = "https://api.exchangeratesapi.io/history?";

  var hideContainer = true;
  bool fetching_results = false;
  List<charts.Series<TimeSeriesSales, DateTime>> chart_data;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  String resp;

  void resizeContainer(double margin, double height){
    setState(() {
      this.top_margin = margin;
      this.container_height = height;
    });
  }

  Future<Map<String,dynamic>> _makeGetRequest(String sym1, String sym2) async {
    // make GET request
    String url = api_endpoint + sym1 + ',' + sym2 + ";base=" + sym1;
    print(url);
    Response response = await get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    var rates = jsonResponse['rates']['$sym2'].toStringAsFixed(2);
    var response_text = "1.00 $sym1 = $rates $sym2";
    setState(() {
      resp = response_text;
    });
    print(resp);
    // TODO convert json to object...

    return jsonResponse;
  }

  Future<Map<String,dynamic>> _makeGetHistoricalRequest(String sym1, String sym2, String start, String end) async {
    // make GET request
    String url = historical_api_endpoint + "start_at=" + start + ";end_at=" + end + ";symbols=" + sym2 + ";base=" + sym1;
    print(url);
    Response response = await get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse['rates']);
    List<TimeSeriesSales> values = new List<TimeSeriesSales>();
    jsonResponse['rates'].forEach((key, value) =>
      values.add(new TimeSeriesSales(DateTime.parse(key), value[sym2]))
    );

    setState(() {
      chart_data = createData(data: values);
      fetching_results = false;
    });
    print(jsonResponse);

  }

  static List<charts.Series<TimeSeriesSales, DateTime>> createData({data}) {
    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  void hide_container(bool val){
    setState(() {
      this.hideContainer = val;
    });
  }

  void callback1(String country, String currency, String symbol, String image) {
    setState(() {
      this.currency_one = country;
      this.cur_one = currency;
      this.symbol_one = symbol;
      this.image_one = image == null ? "assets/USD.png" : image;
    });
  }

  void callback2(String country, String currency, String symbol, String image) {
    setState(() {
      this.currency_two = country;
      this.cur_two = currency;
      this.symbol_two = symbol;
      this.image_two = image == null ? "assets/USD.png" : image;
    });
  }


  Widget _buildAppBar() {
    return new AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0.0,
//        title: new FlutterLogo(
//          size: 30.0,
//          colors: Colors.green,
//        ),
//        centerTitle: true,
//        // The action widgets are the right icons in the appBar
//        leading: new IconButton(
//            icon: new Icon(
//              Icons.account_circle,
//              color: Colors.greenAccent,
//            ),
//            onPressed: () => debugPrint("account pressed")),
//        actions: <Widget>[
//          new IconButton(
//              icon: new Icon(
//                Icons.message,
//                color: Colors.greenAccent,
//              ),
//              onPressed: () => debugPrint("Send icon Tapped!")),
//        ]
    );
  }

  // build body
  Widget _buildBody() {
    // AnchoredOverlay creates a child and an overlay
    // The overlay widget can move over freely above
    // the child. Here the overlay widget is a CenterAbout
    // which centers its child at a given position
    return _layout();
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
          width: 3.0
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(30.0) //
      ),
    );
  }

  Widget _layout () {
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

    child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        key: cardKey,
        flipOnTouch: false,
        front: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: MediaQuery.of(context).size.width - 20,
            height: this.container_height,
            margin: EdgeInsets.only(top: this.top_margin),
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
                          text: "Enter Currency",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          resizeContainer(300.0, 320.0);
                          hide_container(true);
                          showSearch(context: context, delegate: DataSearch(toSet: callback1));
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: currency_one != null? "  " + currency_one: 'enter country or currency...',
                            prefixIcon: Container(
                                height: 6.0,
                                width: 6.0,
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: _boxDecoration(), //       <--- BoxDecoration here
                                child: symbol_one != null? Center(
                                    child:
                                    Text(
                                      symbol_one,
                                      style: TextStyle(fontSize: 20.0),
                                    )) : Icon(Icons.monetization_on)
                            ),
                            suffixIcon: Container(
                              padding: const EdgeInsets.only(right: 10.0),
                              width: 5.0,
                              height: 5.0,
                              child: Image(image: new AssetImage(image_one)),
                            ),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
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
                        FocusScope.of(context).requestFocus(new FocusNode());
                        resizeContainer(300.0, 320.0);
                        hide_container(true);
                        showSearch(context: context, delegate: DataSearch(toSet: callback2));
                      },
                      obscureText: true,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: currency_two != null? "  " + currency_two : 'enter country or currency...',
                          prefixIcon: Container(
                              height: 6.0,
                              width: 6.0,
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.all(5.0),
                              decoration: _boxDecoration(), //       <--- BoxDecoration here
                              child: symbol_two != null? Center(
                                  child:
                                  Text(
                                    symbol_two,
                                    style: TextStyle(fontSize: 20.0),
                                  )) : Icon(Icons.monetization_on)
                          ),
                          suffixIcon: Container(
                              padding: const EdgeInsets.only(right: 10.0),
                              width: 5.0,
                              height: 5.0,
                              child: Image(image: new AssetImage(image_two)),
                          ),

                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          resp = "";
                          fetching_results = true;
                        });
                        _makeGetRequest(cur_one, cur_two);
                        _makeGetHistoricalRequest(cur_one, cur_two, "2018-01-01", "2019-01-01");
                        resizeContainer(200.0, 400.0);
                        hide_container(false);


                      },//since this is only a UI app
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
                  hideContainer ? Container() : Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(resp != "" ? resp : "Failed to fetch results",
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 27.0),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: MaterialButton(
                              onPressed: () => cardKey.currentState.toggleCard(),//since this is only a UI app
                              child: Text("Details",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'SFUIDisplay',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: Color(0xffff2d55),
                              elevation: 0,
                              minWidth: 50,
                              height: 50,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                        ),
                      ],
                    )
                  )

                ],
              ),
            ),
          ),
      back: Container(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          width: MediaQuery.of(context).size.width - 20,
          height: this.container_height,
          margin: EdgeInsets.only(top: this.top_margin),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          ),
          child: hideContainer ? Container() :Column(
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                child: fetching_results ? CircularProgressIndicator() : SimpleTimeSeriesChart(chart_data, animate: false),
              ),

              MaterialButton(
                onPressed: () => cardKey.currentState.toggleCard(),//since this is only a UI app
                child: Text("back",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFUIDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Color(0xffff2d55),
                elevation: 0,
                minWidth: 50,
                height: 50,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              ],
            )
              ),
            )
          ),
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