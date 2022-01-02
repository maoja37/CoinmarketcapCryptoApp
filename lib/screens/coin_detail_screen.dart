// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_coinmarket_api_app/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoinDetailScreen extends StatefulWidget {
  final DataModel coin;
  const CoinDetailScreen({Key? key, required this.coin}) : super(key: key);

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        'https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/';
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
                        imageUrl:
                            (coinIconUrl + widget.coin.symbol + '.png').toLowerCase(),
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
            SliverFillRemaining(child: Column(),)
          ],
        ));
  }
}
