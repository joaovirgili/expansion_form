import 'package:expansion_form/shared/models/filtro_item_option_model.dart';
import 'package:mobx/mobx.dart';
part 'filtro_controller.g.dart';

class FiltroController = _FiltroControllerBase with _$FiltroController;

abstract class _FiltroControllerBase with Store {
  @observable
  List<FiltroItemModel> items;

  @observable
  ObservableMap<String, FiltroItemOptionModel> selectedOptions =
      <String, FiltroItemOptionModel>{}.asObservable();

  @observable
  ObservableMap<String, bool> expandeds = <String, bool>{}.asObservable();

  @action
  setSelectedOption(String key, FiltroItemOptionModel option) {
    final item = getItem(key);
    selectedOptions[key] = option;
    execForDependents(item, (e) => selectedOptions[e.key] = null);
  }

  @action
  setOptionsByKey(String key, List<FiltroItemOptionModel> options) {
    final item = getItem(key);
    item.options = options;
    execForDependents(item, (e) => e.options = []);
  }

  onExpansionChange(String key, bool value) => expandeds[key] = value;

  FiltroItemModel getItem(String key) =>
      items.firstWhere((element) => element.key == key);

  execForDependents(FiltroItemModel item, Function(FiltroItemModel) callback) {
    items
        .where((element) => item.dependents.contains(element.key))
        .forEach((e) {
      callback(e);
      execForDependents(e, callback);
    });
  }
}
