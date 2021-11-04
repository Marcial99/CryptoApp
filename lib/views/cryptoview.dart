import 'package:cryptocurrencies/models/chart_model.dart';
import 'package:cryptocurrencies/models/criptoModel.dart';
import 'package:cryptocurrencies/views/cripto_detail.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CryptoView extends StatefulWidget {

  final ChartModel chartData;
  final CriptoModel criptoModel;
  CryptoView(this.chartData,this.criptoModel);

  @override
  _CryptoViewState createState() => _CryptoViewState();
}
class SalesData {
  SalesData(this.day, this.value);
  final DateTime day;
  
  final double value;
}
class _CryptoViewState extends State<CryptoView> {

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
    return
      InkWell(
        onTap: () {

          Navigator.push(
              context,
              PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>
                  CryptoDetail(widget.chartData,widget.criptoModel)
                  ,
                  transitionDuration: Duration(milliseconds: 800))
          );
        },
        child:
      Container(
      margin: EdgeInsets.only(
        top: 10,
        right: 10,
        bottom: 10,
        left: 10
      ),
      padding: EdgeInsets.only(
        left: 10
      ),
      width: 140,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 1,
            blurRadius: 5
          ),
        ],
        color: Color.fromRGBO(17, 17, 17, 1.0),
        borderRadius: BorderRadius.circular(20)
      ),
      child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.criptoModel.image!)
                        )
                      ),
                    ),
                    Container(
                      child: Text(widget.criptoModel.symbol!.toUpperCase(),
                      ),

                    )
                  ],
                ),
              ),
              Flexible(
                  flex: 8,

                  child:
                  Column(
                    children: [
                      Container(
                        height:100,
                        child:
                        Hero(
                          tag:'detail'+widget.criptoModel.id!,
                        child:
                        SfCartesianChart(
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
                        )),
                      )
                      ,

                    ],

                  ),
                  )

            ],
          ),

    ));


  }
}
