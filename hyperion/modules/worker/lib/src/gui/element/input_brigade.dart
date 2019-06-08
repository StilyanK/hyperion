part of person.gui;

class InputBrigade extends cl_form.InputLoader {
  InputBrigade(cl_app.Application ap) : super() {
    execute = () async {
      final sug = getSuggestion(); //Maybe get needle not suggestion?
      Map<String, dynamic> param;
      if (sug.isNotEmpty) {
        param = {'suggestion': sug};
      } else {
        param = {'id': getValue()};
      }
      return (await ap.serverCall<List>(
              RoutesBrigade.collectionSuggest.reverse([]), param, this))
          .cast<Map>();
    };

    domAction.addAction((e) => new BrigadeListChoose(
        (o) => setValue([o[$Brigade.brigade_id], o[$Brigade.address]]), ap));
  }
}
