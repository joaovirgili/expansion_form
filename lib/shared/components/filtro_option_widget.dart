import 'package:expansion_form/shared/models/filtro_item_option_model.dart';
import 'package:flutter/material.dart';

class FiltroItemOptionWidget extends StatelessWidget {
  final FiltroItemOptionModel groupValue;
  final FiltroItemOptionModel itemOption;
  final void Function(FiltroItemOptionModel) onChanged;

  final selectedStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  FiltroItemOptionWidget({
    @required this.itemOption,
    @required this.groupValue,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onChanged(this.itemOption),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xfff1f4f6)),
          ),
        ),
        child: Row(
          children: <Widget>[
            Radio<FiltroItemOptionModel>(
              activeColor: Theme.of(context).primaryColor,
              groupValue: this.groupValue,
              value: this.itemOption,
              onChanged: this.onChanged,
            ),
            Text(this.itemOption.name),
          ],
        ),
      ),
    );
  }
}
