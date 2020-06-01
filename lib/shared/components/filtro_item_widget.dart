import 'package:expansion_form/shared/components/app_expansion_tile.dart';
import 'package:expansion_form/shared/components/filtro_option_widget.dart';
import 'package:expansion_form/shared/models/filtro_item_option_model.dart';
import 'package:flutter/material.dart';

class FiltroItemWidget extends StatefulWidget {
  final List<FiltroItemOptionModel> options;
  final String name;
  final bool expanded;
  final Function onCollapsed;
  final Function(FiltroItemOptionModel) onSelectOption;
  final FiltroItemOptionModel selectedOption;
  final Function(bool) onExpansionChange;

  const FiltroItemWidget({
    Key key,
    @required this.name,
    this.selectedOption,
    this.options,
    this.onSelectOption,
    this.onCollapsed,
    this.expanded = false,
    this.onExpansionChange,
  }) : super(key: key);

  @override
  FiltroItemWidgetState createState() => FiltroItemWidgetState();
}

class FiltroItemWidgetState extends State<FiltroItemWidget> {
  GlobalKey<AppExpansionTileState> expansionKey;

  _onSelect(FiltroItemOptionModel selected) {
    if (widget.onSelectOption != null) {
      widget.onSelectOption(selected);
    }
  }

  @override
  void initState() {
    expansionKey = GlobalKey<AppExpansionTileState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppExpansionTile(
        onExpansionChanged: widget.onExpansionChange,
        onCollapsed: widget.onCollapsed,
        initiallyExpanded: widget.expanded,
        key: expansionKey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.name),
            SizedBox(width: 10),
            if (_hasSelection())
              Expanded(
                child: Container(
                  child: Text(
                    "${widget.selectedOption.name}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
              )
          ],
        ),
        children: widget.options
                ?.map((e) => FiltroItemOptionWidget(
                      groupValue: widget.selectedOption,
                      itemOption: e,
                      onChanged: _onSelect,
                    ))
                ?.toList() ??
            [],
      ),
      decoration: BoxDecoration(color: Color(0xfff1f4f6)),
    );
  }

  collapse() => expansionKey.currentState.collapse();
  expand() => expansionKey.currentState.expand();
  _hasSelection() => widget.selectedOption != null;
}
