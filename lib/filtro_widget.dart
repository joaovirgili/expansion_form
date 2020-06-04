import 'package:expansion_form/filtro_controller.dart';
import 'package:expansion_form/shared/components/filtro_item_widget.dart';
import 'package:expansion_form/shared/models/filtro_item_option_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Filtro extends StatefulWidget {
  const Filtro({
    Key key,
    @required this.items,
    this.onValidateChange,
  }) : super(key: key);

  /// List of [FiltroItemModel] that makes up the filter.
  /// Each Item may have multiples [FiltroItemOptionModel] as options or optionsDependecy.
  ///
  /// For simple Item that doens't depends on another. Use `options`.
  /// For example:
  ///
  /// ```dart
  ///   FiltroItemModel(
  ///     name: "Country",
  ///     key: "country",
  ///     dependents: ["city"],
  ///     options: [
  ///       FiltroItemOptionModel(
  ///         key: "br",
  ///         name: "Brazil",
  ///       ),
  ///       FiltroItemOptionModel(
  ///         key: "us",
  ///         name: "United States",
  ///       ),
  ///     ],
  ///   ),
  /// ```
  ///
  /// If you need option that depends on the value of another Item. Use `optionsDependecy`
  /// For example, if we have Item for countries and Item for cities:
  /// ```dart
  ///   FiltroItemModel(
  ///     name: "City",
  ///     key: "city",
  ///     optionsDependency: {
  ///       "br": [
  ///         FiltroItemOptionModel(
  ///           key: "rj",
  ///           name: "Rio de Janeiro",
  ///         ),
  ///         FiltroItemOptionModel(
  ///           key: "ssa",
  ///           name: "Salvador",
  ///         ),
  ///       ],
  ///       "rj": [
  ///         FiltroItemOptionModel(
  ///           name: "ny",
  ///           key: "New York",
  ///         ),
  ///         FiltroItemOptionModel(
  ///           name: "la",
  ///           key: "Los Angeles",
  ///         ),
  ///       ],
  ///     },
  ///   ),
  /// ```
  final List<FiltroItemModel> items;

  final Function(bool) onValidateChange;

  @override
  FiltroState createState() => FiltroState();
}

class FiltroState extends State<Filtro> {
  List<GlobalKey<FiltroItemWidgetState>> keys = [];
  bool formValid = false;
  final controller = FiltroController();

  /// Generate and store a GlobalKey for each Item
  List<GlobalKey<FiltroItemWidgetState>> _generateGlobalKeys() {
    return widget.items.map((e) {
      return GlobalKey<FiltroItemWidgetState>();
    }).toList();
  }

  /// Callback for item collapse
  _onItemCollapsed(FiltroItemModel item) async {
    final itemIndex = _getItemIndex(item.key);
    if (!_isLastItem(itemIndex)) {
      await Future.delayed(Duration(milliseconds: 400));
      _expandItemByIndex(itemIndex + 1);
    }
  }

  /// Callback for option select
  _onSelectOption(FiltroItemModel item, FiltroItemOptionModel selected) {
    controller.setSelectedOption(item.key, selected);
    final index = _getItemIndex(item.key);
    if (!_isLastItem(index)) {
      final _item = widget.items[index + 1];
      final options = _item.options ?? _item.optionsDependency[selected.key];
      controller.setOptionsByKey(_item.key, options);
    }
    _collapseItemByKey(item.key);
    if (widget.onValidateChange != null) {
      if (isValid() != formValid) {
        formValid = isValid();
        widget.onValidateChange(formValid);
      }
    }
  }

  /// Fill some properties on controller
  _initController() {
    controller.items = widget.items
        .map((e) => FiltroItemModel(
              key: e.key,
              name: e.name,
              options: e.options ?? [],
              dependents: e.dependents,
            ))
        .toList();

    controller.items.forEach((e) {
      controller.expandeds[e.key] = false;
    });
  }

  bool isValid() {
    var valid = true;
    widget.items.forEach((e) {
      if (e.isRequired && _getSelectedOption(e.key) == null) {
        valid = false;
      }
    });
    return valid;
  }

  @override
  void initState() {
    keys = _generateGlobalKeys();
    _initController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _expandItemByIndex(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
        ),
      ),
      child: Observer(builder: (_) {
        return ListView(
          children: controller.items
              .map((e) => FiltroItemWidget(
                    key: _getGlobalKey(e.key),
                    name: e.name,
                    options: e.options,
                    expanded: controller.expandeds[e.key],
                    onCollapsed: () => _onItemCollapsed(e),
                    onSelectOption: (selected) => _onSelectOption(e, selected),
                    selectedOption: _getSelectedOption(e.key),
                    onExpansionChange: (value) =>
                        controller.onExpansionChange(e.key, value),
                  ))
              .toList(),
        );
      }),
    );
  }

  _getSelectedOption(String key) => controller.selectedOptions[key];

  /// Get Item GlobalKey by key
  _getGlobalKey(String key) =>
      keys[widget.items.indexWhere((e) => e.key == key)];

  /// Get Item by key
  int _getItemIndex(String key) => widget.items.indexWhere((e) => e.key == key);

  /// Get if it's last Item from list
  _isLastItem(int index) => index == widget.items.length - 1;

  /// Expands Item by index
  _expandItemByIndex(int index) => keys[index].currentState.expand();

  /// Collapse Item by index
  _collapseItemByIndex(int index) => keys[index].currentState.collapse();

  /// Collapse Item by key
  _collapseItemByKey(String key) => _collapseItemByIndex(_getItemIndex(key));
}
