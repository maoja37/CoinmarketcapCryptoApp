// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_coinmarket_api_app/models/charts_data.dart';
import 'package:crypto_coinmarket_api_app/models/data_model.dart';
import 'package:crypto_coinmarket_api_app/screens/coin_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinListWidget extends StatelessWidget {
  final List<DataModel> coins;
  const CoinListWidget({Key? key, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/';

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text('Crypto Currency',
                style: Theme.of(context).textTheme.headline5),
          ),
          SizedBox(height: 8),
          Expanded(
              child: ListView.builder(
                  itemExtent: 160,
                  itemCount: coins.length,
                  itemBuilder: (context, index) {
                    List<ChartData> data = [
                      ChartData(
                          coins[index].quoteModel.usdModel.percentageChange_90d,
                          2160),
                      ChartData(
                          coins[index].quoteModel.usdModel.percentageChange_60d,
                          1440),
                      ChartData(
                          coins[index].quoteModel.usdModel.percentageChange_30d,
                          720),
                      ChartData(
                          coins[index].quoteModel.usdModel.percentageChange_24h,
                          24),
                      ChartData(
                          coins[index].quoteModel.usdModel.percentageChange_1h,
                          1),
                    ];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CoinDetailScreen(coin: coins[index])));
                      },
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 16,
                              ),
                              height: 96,
                              width: 96,
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                      imageUrl: (coinIconUrl +
                                              coins[index].symbol +
                                              '.png')
                                          .toLowerCase(),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          SvgPicture.asset(
                                            'assets/icons/Dollar_Sign.svg',
                                            color: Colors.white,
                                          ),
                                      height: 50,
                                      width: 50),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(coins[index].symbol,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    '\$' +
                                        coins[index]
                                            .quoteModel
                                            .usdModel
                                            .prices
                                            .toStringAsFixed(2),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 16),
                                          height: 96,
                                          width: double.infinity,
                                          child: SfCartesianChart(
                                            plotAreaBorderWidth: 0,
                                            primaryXAxis:
                                                CategoryAxis(isVisible: false),
                                            primaryYAxis:
                                                CategoryAxis(isVisible: false),
                                            legend: Legend(isVisible: false),
                                            tooltipBehavior:
                                                TooltipBehavior(enable: false),
                                            series: <
                                                ChartSeries<ChartData, String>>[
                                              LineSeries<ChartData, String>(
                                                  dataSource: data,
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.year.toString(),
                                                  yValueMapper:
                                                      (ChartData data, _) {
                                                    return data.value;
                                                  }),
                                            ],
                                          ),),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        margin: EdgeInsets.only(right: 16),
                                        alignment: Alignment.center,
                                        width: 62,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: coins[index]
                                                      .quoteModel
                                                      .usdModel
                                                      .percentageChange_7d >=
                                                  0
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Text(
                                          coins[index]
                                              .quoteModel
                                              .usdModel
                                              .percentageChange_7d
                                              .toStringAsFixed(2)+'%',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
