import 'package:flutter/material.dart';
import 'package:currency_converter/model/country_currency_map.dart';


class DataSearch extends SearchDelegate<String>{

  final _recent_countries = recent_countries;
  final _countries = countries;
  Function toSet;

  DataSearch({this.toSet});

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
          onTap: () {
            var _country = suggestion_list[index];
            var _currency = parsed_country_currency[suggestion_list[index]];
            var _symbol = parsed_country_currency_symbol[_currency];
            var _image = _getImageName(parsed_country_currency[suggestion_list[index]]);
            toSet(_country, _currency, _symbol, _image);
            close(context, null);},
          leading: Image(image: new AssetImage(
              _getImageName(parsed_country_currency[suggestion_list[index]])),
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