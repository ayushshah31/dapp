import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545";
  final String _privateKey = "bbe0865481b17cf440bc5cfa7bc4873d1a4fe37d818d92f13916b813e168a6d2";

  Web3Client? _web3Client;

  bool isLoading = true;

  String? _abiCode;

  EthereumAddress? _contractAddress;
  Credentials? _credentials;
  DeployedContract? _contract;
  ContractFunction? _message;
  ContractFunction? _setMessage;

  String? deployedName;

  ContractLinking() {
    setup();
  }

  setup() async {
    _web3Client = Web3Client(
      _rpcUrl,
      Client(),
      socketConnector: () => IOWebSocketChannel.connect(_wsUrl).cast<String>(),
    );

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiFile = await rootBundle.loadString("build/contracts/HelloWorld.json");
    final jsonAbi = jsonDecode(abiFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode!, "HelloWorld"), _contractAddress!);
    _message = _contract!.function("message");
    _setMessage = _contract!.function("setMessage");
    getMessage();
  }

  getMessage() async {
    final _myMessage =
        await _web3Client!.call(contract: _contract!, function: _message!, params: []);
    deployedName = _myMessage[0].toString();
    isLoading = false;
    notifyListeners();
  }

  setMessage(String message) async {
    isLoading = true;
    notifyListeners();
    await _web3Client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!, function: _setMessage!, parameters: [message]));
    getMessage();
  }
}
