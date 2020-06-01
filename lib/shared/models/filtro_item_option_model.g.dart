// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtro_item_option_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FiltroItemModel on _FiltroItemModelBase, Store {
  final _$optionsAtom = Atom(name: '_FiltroItemModelBase.options');

  @override
  List<FiltroItemOptionModel> get options {
    _$optionsAtom.reportRead();
    return super.options;
  }

  @override
  set options(List<FiltroItemOptionModel> value) {
    _$optionsAtom.reportWrite(value, super.options, () {
      super.options = value;
    });
  }

  @override
  String toString() {
    return '''
options: ${options}
    ''';
  }
}
