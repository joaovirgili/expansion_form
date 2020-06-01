import 'package:mobx/mobx.dart';

part 'filtro_item_option_model.g.dart';

class FiltroItemModel = _FiltroItemModelBase with _$FiltroItemModel;

abstract class _FiltroItemModelBase with Store {
  /// Key to identify this Item.
  String key;

  /// Item's name that is shown.
  String name;

  /// If item is required on validate
  bool isRequired = true;

  @observable
  List<FiltroItemOptionModel> options;

  Map<String, List<FiltroItemOptionModel>> optionsDependency;

  /// Dependens keys.
  List<String> dependents;

  _FiltroItemModelBase({
    this.key,
    this.name,
    this.options,
    this.optionsDependency,
    this.isRequired = false,
    this.dependents = const <String>[],
  });

  bool operator ==(o) => o is _FiltroItemModelBase && key == o.key;
  int get hashCode => key.hashCode;
}

class FiltroItemOptionModel {
  /// Key to identify this Option.
  String key;

  /// Option's name that is shown.
  String name;

  FiltroItemOptionModel({this.key, this.name});

  bool operator ==(o) => o is FiltroItemOptionModel && key == o.key;
  int get hashCode => key.hashCode;
}
