// ignore_for_file: prefer_const_constructors

import 'package:crypto_coinmarket_api_app/models/big_data_models.dart';
import 'package:crypto_coinmarket_api_app/repository/repository.dart';
import 'package:crypto_coinmarket_api_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late Future<BigDataModel> _futureCoins;
  late Repository repository;

  @override
  void initState() {
    repository = Repository();
    _futureCoins = repository.getCoins();
    print(_futureCoins);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BigDataModel>(
      future: _futureCoins,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var coinsData = snapshot.data!.dataModel;
            return CoinListWidget(coins: coinsData,);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('$snapshot.error', style: TextStyle(color: Colors.white, fontSize: 22),),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
