import 'package:cryptocurrencies/models/chart_model.dart';
import 'package:cryptocurrencies/models/criptoModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoDetail extends StatefulWidget {

  final ChartModel chartData;
  final CriptoModel criptoModel;
  CryptoDetail(this.chartData,this.criptoModel);
  @override
  _CryptoDetailState createState() => _CryptoDetailState();
}
class SalesData {
  SalesData(this.day, this.value);
  final DateTime day;

  final double value;
}
class _CryptoDetailState extends State<CryptoDetail> {

  final formateador=NumberFormat.currency(
  locale: 'es_MX',
  symbol: '\$',
  );
  @override
  Widget build(BuildContext context) {
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
                          image: NetworkImage(widget.criptoModel.image!)
                        )
                      ),
                    ),
                    Text(widget.criptoModel.name! +' ('+widget.criptoModel.symbol!.toUpperCase()+')',
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
                  child: Text('Fecha de creacion:'+widget.criptoModel.genesisDate!),
                ),
              Container(
                child: Text('Precio actual (USD): ' +formateador.format(widget.criptoModel.currentPriceUsd) +'\nPrecio actual(MXN):'+formateador.format(widget.criptoModel.currentPriceMxn!)),
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
    tag: 'detail'+widget.criptoModel.id!,
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
                Text(widget.criptoModel.description!,
                textAlign: TextAlign.justify,),),
            ],
          ),

    ));
  }
}
