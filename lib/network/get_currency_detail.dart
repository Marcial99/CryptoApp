import 'dart:convert';
import 'package:cryptocurrencies/models/chart_model.dart';
import 'package:cryptocurrencies/models/criptoModel.dart';
import 'package:http/http.dart' as http;

class ApiCriptomoneda {


  Future<CriptoModel?> getCripto(var id) async {

    var URL = Uri.parse('https://api.coingecko.com/api/v3/coins/'+id.toString());

    final response = await http.get(URL);

    if (response.statusCode == 200) {

      var popular = jsonDecode(response.body) as Map<String,dynamic>;

      CriptoModel listaCripto = CriptoModel(
        popular['id'],
        popular['symbol'],
        popular['name'],
        popular['description']['en'],
        popular['image']['large'],
        popular['genesis_date'].toString(),
        double.parse(popular['market_data']['current_price']['usd'].toString()),
         double.parse(popular['market_data']['current_price']['mxn'].toString())
      );

      return listaCripto;
    } else {
      return null;
    }
  }
}
