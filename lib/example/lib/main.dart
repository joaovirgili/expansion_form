import 'package:expansion_form/filtro_widget.dart';
import 'package:expansion_form/shared/models/filtro_item_option_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var isFormValid = false;

  _onValidationChange(bool value) {
    setState(() {
      isFormValid = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtro example"),
      ),
      body: Column(
        children: <Widget>[
          Filtro(
            onValidateChange: _onValidationChange,
            items: [
              FiltroItemModel(
                name: "Estado",
                key: "estado",
                dependents: ["rede"],
                isRequired: true,
                options: [
                  FiltroItemOptionModel(
                    key: "ba",
                    name: "Bahia",
                  ),
                  FiltroItemOptionModel(
                    key: "rj",
                    name: "Rio de Janeiro",
                  ),
                ],
              ),
              FiltroItemModel(
                name: "Rede",
                key: "rede",
                dependents: ["loja"],
                isRequired: true,
                optionsDependency: {
                  "ba": [
                    FiltroItemOptionModel(
                      key: "walmart",
                      name: "Walmart",
                    ),
                    FiltroItemOptionModel(
                      key: "mix_bahia",
                      name: "Mix Bahia",
                    ),
                  ],
                  "rj": [
                    FiltroItemOptionModel(
                      name: "Pão de Açúcar",
                      key: "pao_de_acucar",
                    ),
                    FiltroItemOptionModel(
                      name: "Sonda",
                      key: "sonda",
                    ),
                  ],
                },
              ),
              FiltroItemModel(
                name: "Loja",
                key: "loja",
                isRequired: true,
                optionsDependency: {
                  "walmart": [
                    FiltroItemOptionModel(
                      key: "walmart_1",
                      name: "Walmart 1",
                    ),
                    FiltroItemOptionModel(
                      key: "walmart_2",
                      name: "Walmart 2",
                    ),
                    FiltroItemOptionModel(
                      name: "Mix Bahia 2",
                      key: "mix_bahia_2",
                    ),
                  ],
                  "mix_bahia": [
                    FiltroItemOptionModel(
                      name: "Mix Bahia 1",
                      key: "mix_bahia_1",
                    ),
                    FiltroItemOptionModel(
                      name: "Mix Bahia 2",
                      key: "mix_bahia_2",
                    ),
                  ],
                  "pao_de_acucar": [
                    FiltroItemOptionModel(
                      name: "Pão de Açúcar 1",
                      key: "pao_de_acucar_1",
                    ),
                    FiltroItemOptionModel(
                      name: "Pão de Açúcar 2",
                      key: "pao_de_acucar_2",
                    ),
                  ],
                  "sonda": [
                    FiltroItemOptionModel(
                      name: "Sonda 1",
                      key: "sonda_1",
                    ),
                    FiltroItemOptionModel(
                      name: "Sonda 2",
                      key: "sonda_2",
                    ),
                  ],
                },
              ),
            ],
          ),
          RaisedButton(
            onPressed: isFormValid ? () {} : null,
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
