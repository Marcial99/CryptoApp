import 'package:cryptocurrencies/models/criptoModel.dart';
import 'package:cryptocurrencies/network/get_currency_chart_data.dart';
import 'package:cryptocurrencies/network/get_currency_detail.dart';
import 'package:cryptocurrencies/views/cryptoview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiGrafica? apiGrafica;
  ApiCriptomoneda? apiCriptomoneda;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiGrafica= ApiGrafica();
    apiCriptomoneda = ApiCriptomoneda();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(

        future: Future.wait([apiGrafica!.getChart('bitcoin'),apiCriptomoneda!.getCripto('bitcoin'),
        apiGrafica!.getChart('ethereum'),apiCriptomoneda!.getCripto('ethereum'),
        apiGrafica!.getChart('binancecoin'),apiCriptomoneda!.getCripto('binancecoin'),
        apiGrafica!.getChart('tether'),apiCriptomoneda!.getCripto('tether'),
          apiGrafica!.getChart('solana'),apiCriptomoneda!.getCripto('solana'),
          apiGrafica!.getChart('cardano'),apiCriptomoneda!.getCripto('cardano'),
          apiGrafica!.getChart('ripple'),apiCriptomoneda!.getCripto('ripple'),
          apiGrafica!.getChart('polkadot'),apiCriptomoneda!.getCripto('polkadot'),
          apiGrafica!.getChart('dogecoin'),apiCriptomoneda!.getCripto('dogecoin'),
          apiGrafica!.getChart('shiba-inu'),apiCriptomoneda!.getCripto('shiba-inu'),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError){
            return Center(
              child: Text('Error'),
            );
          }else{
            if(snapshot.connectionState == ConnectionState.done){

              return inicio(snapshot.data!);
            } else{
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }

  Widget inicio(List<dynamic> data){

    return ListView(
      children: [
        //SEARCH BAR
        Container(
          margin: EdgeInsets.only(right: 20, left: 20, top:10),
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.black),
              boxShadow: [

              ]
          ),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Buscar criptomoneda',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 25,
                )),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Text('Top 10 criptomonedas',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
            height: 160,
            margin: EdgeInsets.only(right: 20,
                left: 10),
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                bottom: 10
            ),
            child:
            ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CryptoView(data[0],data[1]),
                CryptoView(data[2],data[3]),
                CryptoView(data[4],data[5]),
                CryptoView(data[6],data[7]),
                CryptoView(data[8],data[9]),
                CryptoView(data[10],data[11]),
                CryptoView(data[12],data[13]),
                CryptoView(data[14],data[15]),
                CryptoView(data[16],data[17]),
                CryptoView(data[18],data[19]),


              ],
            )),
      ],
    );
  }
}
