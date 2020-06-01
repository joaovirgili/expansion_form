// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FiltroController on _FiltroControllerBase, Store {
  final _$itemsAtom = Atom(name: '_FiltroControllerBase.items');

  @override
  List<FiltroItemModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<FiltroItemModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  final _$selectedOptionsAtom =
      Atom(name: '_FiltroControllerBase.selectedOptions');

  @override
  ObservableMap<String, FiltroItemOptionModel> get selectedOptions {
    _$selectedOptionsAtom.reportRead();
    return super.selectedOptions;
  }

  @override
  set selectedOptions(ObservableMap<String, FiltroItemOptionModel> value) {
    _$selectedOptionsAtom.reportWrite(value, super.selectedOptions, () {
      super.selectedOptions = value;
    });
  }

  final _$expandedsAtom = Atom(name: '_FiltroControllerBase.expandeds');

  @override
  ObservableMap<String, bool> get expandeds {
    _$expandedsAtom.reportRead();
    return super.expandeds;
  }

  @override
  set expandeds(ObservableMap<String, bool> value) {
    _$expandedsAtom.reportWrite(value, super.expandeds, () {
      super.expandeds = value;
    });
  }

  final _$_FiltroControllerBaseActionController =
      ActionController(name: '_FiltroControllerBase');

  @override
  dynamic setSelectedOption(String key, FiltroItemOptionModel option) {
    final _$actionInfo = _$_FiltroControllerBaseActionController.startAction(
        name: '_FiltroControllerBase.setSelectedOption');
    try {
      return super.setSelectedOption(key, option);
    } finally {
      _$_FiltroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setOptionsByKey(String key, List<FiltroItemOptionModel> options) {
    final _$actionInfo = _$_FiltroControllerBaseActionController.startAction(
        name: '_FiltroControllerBase.setOptionsByKey');
    try {
      return super.setOptionsByKey(key, options);
    } finally {
      _$_FiltroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
selectedOptions: ${selectedOptions},
expandeds: ${expandeds}
    ''';
  }
}
