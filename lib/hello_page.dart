import 'package:dapp/contract_linking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contractLinking = Provider.of<ContractLinking>(context);
    final messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter dApp')),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: contractLinking.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Form(
                  child: Column(
                    children: <Widget>[
                      Text("Welcome to dApp ${contractLinking.deployedName}"),
                      TextFormField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: "Enter Message",
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        child: const Text("Set Message"),
                        onPressed: () {
                          contractLinking.setMessage(messageController.text);
                          messageController.clear();
                        },
                      ),
                    ],
                  ),
                )),
        ),
      ),
    );
  }
}
