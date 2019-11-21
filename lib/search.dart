import 'package:flutter/material.dart';
import 'package:currency_converter/model/country_currency_map.dart';
import 'package:currency_converter/model/rates.dart';

class DataSearch extends SearchDelegate<String>{

  final _recent_countries = recent_countries;
  final _countries = countries;

  var ratesObject = new Rates();

  String _getImageName(String index) {
    return "assets/" + index + ".png";
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query="";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    var suggestion_list = query.isEmpty
        ? _recent_countries
        : _countries.where(
            (p) => p.toLowerCase().startsWith(query.toLowerCase())
    ).toList();

    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {},
          leading: Image(image: new AssetImage(
              _getImageName(parsedJson[suggestion_list[index]])),
              width: 25.0,
              height: 25.0),
          title: RichText(
            text: TextSpan(
              text: suggestion_list[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestion_list[index].substring(query.length),
                  style: TextStyle(color: Colors.grey)
                )
              ]

            )
          ),
        ),
        itemCount: suggestion_list.length,
    );
  }

}