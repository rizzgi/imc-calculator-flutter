import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController kgController = TextEditingController();
  TextEditingController cmController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoData = "Informe os dados";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CALCULAR IMC'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          actions: [
            IconButton(onPressed: reloadData, icon: const Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person_outline_outlined,
                    size: 120,
                    color: Colors.greenAccent,
                  ),
                  TextFormField(
                    controller: kgController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Peso(kg)',
                        labelStyle: TextStyle(color: Colors.greenAccent)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.greenAccent, fontSize: 24),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                    controller: cmController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Altura(cm)',
                        labelStyle: TextStyle(color: Colors.greenAccent)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.greenAccent, fontSize: 24),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira sua altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                        child: const Text('CALCULAR'),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 60),
                            primary: Colors.greenAccent,
                            elevation: 4),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            calculate();
                          } else {
                            setState(() {
                              _infoData = "Informe todos os dados";
                            });
                          }
                        }),
                  ),
                  Text(
                    _infoData,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.greenAccent, fontSize: 24),
                  )
                ],
              ),
            )));
  }

  void reloadData() {
    kgController.text = "";
    cmController.text = "";
    setState(() {
      _infoData = "Informe os dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double kg = double.parse(kgController.text);
      double cm = double.parse(cmController.text) / 100;
      double res = kg / (cm * cm);
      if (res < 18.6) {
        _infoData = "Abaixo do peso (${res.toStringAsPrecision(4)})";
      } else if (res >= 18.6 && res < 24.9) {
        _infoData = "Peso ideal (${res.toStringAsPrecision(4)})";
      } else if (res >= 24.9 && res < 29.9) {
        _infoData = "Levemente acima do peso (${res.toStringAsPrecision(4)})";
      } else if (res >= 29.9 && res < 34.9) {
        _infoData = "Obesidade Grau I (${res.toStringAsPrecision(4)})";
      } else if (res >= 34.9 && res < 39.9) {
        _infoData = "Obesidade Grau II (${res.toStringAsPrecision(4)})";
      } else if (res >= 40) {
        _infoData = "Obesidade Grau III (${res.toStringAsPrecision(4)})";
      }
    });
  }
}
