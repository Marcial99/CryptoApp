import 'package:cryptocurrencies/models/chart_model.dart';
import 'package:cryptocurrencies/models/criptoModel.dart';
import 'package:cryptocurrencies/network/get_currency_chart_data.dart';
import 'package:cryptocurrencies/network/get_currency_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoSearch extends StatefulWidget {

  var id;
  CryptoSearch(this.id);
  @override
  _CryptoSearchState createState() => _CryptoSearchState();
}
class SalesData {
  SalesData(this.day, this.value);
  final DateTime day;

  final double value;
}
class _CryptoSearchState extends State<CryptoSearch> {

  ApiCriptomoneda? apiCriptomoneda;
  ApiGrafica? apiGrafica;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCriptomoneda=ApiCriptomoneda();
    apiGrafica = ApiGrafica();
  }

  final formateador=NumberFormat.currency(
      locale: 'es_MX',
      symbol: '\$',
      decimalDigits: 10
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:FutureBuilder(
          future: Future.wait([apiCriptomoneda!.getCripto(widget.id),apiGrafica!.getChart(widget.id)]),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError){
              return Center(
                child: Text('Error en la peticion'),
              );
            }else{
              if(snapshot.connectionState == ConnectionState.done ){

                if(snapshot.data[0]==null){
                  return Center(
                    child: Text('No se encontro la criptomoneda'),
                  );
                }else{

                  return detalle(snapshot.data!);
                }
              } else{
                return Center(child: CircularProgressIndicator());
              }
            }
          },
        ));
  }

  Widget detalle(List<dynamic> data){
    final CriptoModel cripto= data[0];
    List<SalesData> chartData = [
    ];
    for(var a=0; a<data[1].prices!.length;a++){
      chartData.add(SalesData(DateTime.fromMillisecondsSinceEpoch(data[1].prices![a][0]),data[1].prices![a][1]));
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(250, 247, 255, 1.0),
        body:

        Container(
          margin: EdgeInsets.only(top:50,
              left: 20,
              right: 20,
              bottom: 20),
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0,
                    blurRadius: 5
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child:
          ListView(
            children: [
              Container(
                child: Wrap(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(cripto.image!)
                          )
                      ),
                    ),
                    Text(cripto.name! +' ('+cripto.symbol!.toUpperCase()+')',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        fontSize: 40,
                      ),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('Fecha de creacion:'+cripto.genesisDate!),
              ),
              Container(
                child: Text('\nPrecio actual (USD): ' +formateador.format(cripto.currentPriceUsd) +'\n\nPrecio actual(MXN):'+formateador.format(cripto.currentPriceMxn!)),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Text('Grafica BTC/USD de los ultimos 15 dias',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                    )
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                child:
                Hero(
                  tag: 'detail'+cripto.id!,
                  child:SfCartesianChart(

                      tooltipBehavior: TooltipBehavior(enable: true,
                      ),
                      palette: [
                        Colors.blue
                      ],
                      legend: Legend(
                          isVisible: false
                      ),

                      primaryXAxis: DateTimeAxis(
                          axisLine: AxisLine(
                            width: 1,
                          ),
                          dateFormat:DateFormat.Md(),
                          autoScrollingMode: AutoScrollingMode.start,
                          isVisible: true,
                          interval: 2,

                          autoScrollingDeltaType: DateTimeIntervalType.days,
                          enableAutoIntervalOnZooming: true,
                          interactiveTooltip: InteractiveTooltip(
                            enable: true,

                          )
                      ),
                      plotAreaBorderWidth: 0,
                      borderWidth: 0,
                      primaryYAxis: NumericAxis(
                          isVisible: true
                      ),
                      enableAxisAnimation: false,
                      series: <ChartSeries>[
                        // Renders line chart
                        LineSeries<SalesData, DateTime>(
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) => sales.day,
                            yValueMapper: (SalesData sales, _) => sales.value,
                            name: 'Precio'
                        )

                      ]
                  ),
                ),

              ),
              Container(child:
              Text(cripto.description!,
                textAlign: TextAlign.justify,),),
            ],
          ),

        ));
  }
}
