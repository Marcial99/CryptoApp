import 'package:cryptocurrencies/models/criptoModel.dart';
import 'package:cryptocurrencies/models/cryptoTrendingModel.dart';
import 'package:cryptocurrencies/network/get_crypto_trending.dart';
import 'package:cryptocurrencies/network/get_currency_chart_data.dart';
import 'package:cryptocurrencies/network/get_currency_detail.dart';
import 'package:cryptocurrencies/views/cripto_detail.dart';
import 'package:cryptocurrencies/views/cripto_detail_future.dart';
import 'package:cryptocurrencies/views/cripto_search.dart';
import 'package:cryptocurrencies/views/cryptoview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class SalesData {
  SalesData(this.day, this.value);
  final DateTime day;

  final double value;
}
class _HomeState extends State<Home> {
  ApiGrafica? apiGrafica;
  ApiCriptomoneda? apiCriptomoneda;
  ApiTrending? apiTrending;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiGrafica= ApiGrafica();
    apiCriptomoneda = ApiCriptomoneda();
    apiTrending = ApiTrending();
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
          apiTrending!.getTrending()
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

    return Stack(
      children: [
        //SEARCH BAR
        SafeArea(
            child:
            Container(
    child:
              ListView(
                children: [
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
                onSubmitted: (value) {
                  Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>
                          CryptoSearch(value)
                          ,
                          transitionDuration: Duration(milliseconds: 800))
                  );
                },
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
            )
    ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Monedas en tendencia',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ]
    )
    )
    ),
        Container(
          padding: EdgeInsets.only(top: 360,
          left: 20,
          right: 20),

          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              CryptoTrendingModel trend = data[20].elementAt(index);

              List<SalesData> chartData = [
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![0][0]),trend.chart!.prices![0][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![1][0]),trend.chart!.prices![1][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![2][0]), trend.chart!.prices![2][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![3][0]), trend.chart!.prices![3][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![4][0]), trend.chart!.prices![4][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![5][0]),trend.chart!.prices![5][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![6][0]), trend.chart!.prices![6][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![7][0]), trend.chart!.prices![7][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![8][0]),trend.chart!.prices![8][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![9][0]),trend.chart!.prices![9][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![10][0]), trend.chart!.prices![10][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![11][0]),trend.chart!.prices![11][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![12][0]), trend.chart!.prices![12][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![13][0]),trend.chart!.prices![13][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![14][0]), trend.chart!.prices![14][1]),
                SalesData(DateTime.fromMillisecondsSinceEpoch(trend.chart!.prices![15][0]), trend.chart!.prices![15][1]),


              ];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>
                          CryptoDetailFuture(trend.chart!,CriptoModel(trend.id, trend.symbol, trend.name, '', trend.large, '', trend.priceBtc, 0))
                          ,
                          transitionDuration: Duration(milliseconds: 800))
                  );
                },
                  child:Container(
                margin: EdgeInsets.only(bottom: 10,
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(17, 17, 17, 1.0),
                  borderRadius: BorderRadius.circular(20)

                ),
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child:Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(trend.large!)
                          )
                        ),
                      ),
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                trend.name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Ubuntu'
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                  trend.symbol!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    fontFamily: 'Ubuntu'
                                ),
                              ),
                            ),

                          ],
                    )),
                    Flexible(
                      flex: 6,
                      fit: FlexFit.tight,
                      child: Container(
                        child: SfCartesianChart(
                            palette: [
                              Colors.green
                            ],
                            legend: Legend(
                                isVisible: false
                            ),

                            primaryXAxis: DateTimeAxis(
                                axisLine: AxisLine(
                                  width: 0,
                                ),

                                isVisible: false
                            ),
                            plotAreaBorderWidth: 0,
                            borderWidth: 0,
                            primaryYAxis: NumericAxis(
                                isVisible: false
                            ),
                            series: <ChartSeries>[
                              // Renders line chart
                              LineSeries<SalesData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (SalesData sales, _) => sales.day,
                                yValueMapper: (SalesData sales, _) => sales.value,

                              )

                            ]
                        ),
                      ),
                    )
                  ],
                ),
              ));

          },),
        )
    ]
    );
  }
}
