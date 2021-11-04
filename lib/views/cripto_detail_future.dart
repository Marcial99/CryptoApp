import 'package:cryptocurrencies/models/chart_model.dart';
import 'package:cryptocurrencies/models/criptoModel.dart';
import 'package:cryptocurrencies/network/get_currency_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoDetailFuture extends StatefulWidget {

  final ChartModel chartData;
  final CriptoModel criptoModel;
  CryptoDetailFuture(this.chartData,this.criptoModel);
  @override
  _CryptoDetailFutureState createState() => _CryptoDetailFutureState();
}
class SalesData {
  SalesData(this.day, this.value);
  final DateTime day;

  final double value;
}
class _CryptoDetailFutureState extends State<CryptoDetailFuture> {

  ApiCriptomoneda? apiCriptomoneda;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCriptomoneda=ApiCriptomoneda();
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
      future: apiCriptomoneda!.getCripto(widget.criptoModel.id),
          builder: (context, AsyncSnapshot<CriptoModel?> snapshot) {
            if (snapshot.hasError){
              return Center(
                child: Text('No se encontro la criptomoneda'),
              );
            }else{
              if(snapshot.connectionState == ConnectionState.done){

                return detalle(snapshot.data!);
              } else{
                return Center(child: CircularProgressIndicator());
              }
            }
          },
    ));
  }

  Widget detalle(CriptoModel cripto){
    final List<SalesData> chartData = [
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![0][0]),widget.chartData.prices![0][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![1][0]),widget.chartData.prices![1][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![2][0]), widget.chartData.prices![2][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![3][0]), widget.chartData.prices![3][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![4][0]), widget.chartData.prices![4][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![5][0]),widget.chartData.prices![5][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![6][0]), widget.chartData.prices![6][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![7][0]), widget.chartData.prices![7][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![8][0]),widget.chartData.prices![8][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![9][0]),widget.chartData.prices![9][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![10][0]), widget.chartData.prices![10][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![11][0]), widget.chartData.prices![11][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![12][0]), widget.chartData.prices![12][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![13][0]),widget.chartData.prices![13][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![14][0]), widget.chartData.prices![14][1]),
      SalesData(DateTime.fromMillisecondsSinceEpoch(widget.chartData.prices![15][0]), widget.chartData.prices![15][1]),


    ];
    return Scaffold(
        backgroundColor: Colors.black,
        body:

        Container(
          padding: EdgeInsets.all(20),
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        fontSize: 40,
                      ),)
                  ],
                ),
              ),
              Container(
                child: Text('Fecha de creacion:'+cripto.genesisDate!),
              ),
              Container(
                child: Text('Precio actual (USD): ' +formateador.format(cripto.currentPriceUsd) +'\nPrecio actual(MXN):'+formateador.format(cripto.currentPriceMxn!)),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                child: Text('Grafica BTC/USD de los ultimos 15 dias',
                    style: TextStyle(
                      color: Colors.white,
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
                        Colors.green
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
