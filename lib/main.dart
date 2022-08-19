import 'package:dapp/contract_linking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'hello_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (context) => ContractLinking(),
      child: MaterialApp(
        title: 'Flutter DAPP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HelloPage(),
      ),
    );
  }
}
