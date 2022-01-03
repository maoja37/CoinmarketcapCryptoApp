// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_coinmarket_api_app/models/charts_data.dart';
import 'package:crypto_coinmarket_api_app/models/data_model.dart';
import 'package:crypto_coinmarket_api_app/widgets/sliver_widget.dart';
import 'package:crypto_coinmarket_api_app/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:syncfusion_flutter_charts/charts.dart';

class CoinDetailScreen extends StatefulWidget {
  final DataModel coin;
  const CoinDetailScreen({Key? key, required this.coin}) : super(key: key);

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  List<bool> _isSelected = [true, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/';
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'")
        .parse(widget.coin.quoteModel.usdModel.lastUpdated);
    var inputData = DateTime.parse(parseDate.toString());
    var outPutFormat = DateFormat('dd/MM//yyyy hh:mm a');
    var outPutDate = outPutFormat.format(inputData);

    //we dont have a detail api so we are going to be usung some fake data on a chart dynamic way is a random values
    Random random = Random();
    int next(int min, int max) => random.nextInt(max - min);
    List<ChartData> data = [
      ChartData(next(1, 1000), 1),
      ChartData(next(1, 1000), 2),
      ChartData(next(1, 1000), 3),
      ChartData(next(1, 1000), 4),
      ChartData(next(1, 1000), 5),
      ChartData(next(1, 1000), 6),
      ChartData(next(1, 1000), 7),
      ChartData(next(1, 1000), 8),
      ChartData(next(1, 1000), 9),
      ChartData(next(1, 1000), 10),
      ChartData(next(1, 1000), 11),
      ChartData(next(1, 1000), 12),
      ChartData(next(1, 1000), 13),
      ChartData(next(1, 1000), 14),
      ChartData(next(1, 1000), 15),
      ChartData(next(1, 1000), 16),
      ChartData(next(1, 1000), 17),
      ChartData(next(1, 1000), 18),
      ChartData(next(1, 1000), 19),
      ChartData(next(1, 1000), 20),
    ];

    return Scaffold(
        backgroundColor: Color.fromRGBO(11, 12, 54, 1),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36)),
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 260,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/3.png',
                  fit: BoxFit.cover,
                ),
                titlePadding: EdgeInsets.only(left: 2, bottom: 20),
                title: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.fromLTRB(16, 24, 4.4, 0),
                  width: double.infinity,
                  height: 56,
                  child: ListTile(
                    leading: CachedNetworkImage(
                        imageUrl: (coinIconUrl + widget.coin.symbol + '.png')
                            .toLowerCase(),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                              'assets/icons/Dollar_Sign.svg',
                              color: Colors.white,
                            ),
                        height: 40,
                        width: 40),
                    title: Text(
                      widget.coin.name +
                          ' ' +
                          widget.coin.symbol +
                          ' #' +
                          widget.coin.cmcRank.toString(),
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                  minHeight: 360,
                  maxHeight: 360,
                  child: Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: Column(children: [
                      Text(
                        '\$' +
                            widget.coin.quoteModel.usdModel.prices
                                .toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        outPutDate,
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18.0,
                            color: Colors.grey),
                      ),
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    series: <ChartSeries<ChartData, String>>[
                                      LineSeries<ChartData, String>(
                                          dataSource: data,
                                          xValueMapper: (ChartData data, _) =>
                                              data.year.toString(),
                                          yValueMapper: (ChartData data, _) {
                                            return data.value;
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: 8.0),
                      ToggleButtons(
                        borderRadius: BorderRadius.circular(8),
                        borderColor: Colors.indigoAccent,
                        color: Colors.white,
                        fillColor: Colors.green,
                        selectedColor: Colors.white,
                        selectedBorderColor: Colors.indigoAccent,
                        children: [
                          ToggleButton(name: 'Today'),
                          ToggleButton(name: '1W '),
                          ToggleButton(name: '1M'),
                          ToggleButton(name: '3M'),
                          ToggleButton(name: '6M'),
                        ],
                        isSelected: _isSelected,
                        onPressed: (int newIndex) {
                          setState(() {
                            for (int i = 0; i < _isSelected.length; i++) {
                              if (i == newIndex) {
                                _isSelected[i] = true;
                              } else {
                                _isSelected[i] = false;
                              }
                              print(_isSelected);
                            }
                          });
                        },
                      )
                    ]),
                  )),
            ),
            SliverToBoxAdapter(
                child: Container(
              height: 400,
              width: double.infinity,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    Text('Circulating Supply: ', 
                    style: Theme.of(context).textTheme.subtitle1),
                    Text(widget.coin.circulatingSupply.toString(), style: Theme.of(context).textTheme.subtitle1   )
                   ],
                )
              ]),
            )),
            //  SliverFillRemaining()
          ],
        ));
  }
}
