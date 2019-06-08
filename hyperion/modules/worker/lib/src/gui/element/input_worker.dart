part of person.gui;

/// InputLoaders are elements which has a visible value
/// the person's name and a "true" value - the person's id
/// In the DB we only save the id
/// InputLoader's has two options for setting the value:
/// ```
/// person.setValue(id) // auto retrieve's the visible value
/// person.setValue([id, 'Ivan Ivanov']); // we provide the visible value
/// ```                                   // and omit the server call
///
class InputWorker extends cl_form.InputLoader {
  InputWorker(cl_app.Application ap) : super() {
    execute = () async {
      final sug = getSuggestion(); //Maybe get needle not suggestion?
      Map<String, dynamic> param;
      if (sug.isNotEmpty) {
        // If we are here it means that we wrote something in the field
        // and we send only the suggestion value
        param = {'suggestion': sug};
      } else {
        // This is a special case - we've set the Id to the field
        // [InputPerson.setValue(id)] and
        // we make a call to the server to extract the "visible" data
        param = {'id': getValue()};
      }
      return (await ap.serverCall<List>(
              RoutesWorker.collectionSuggest.reverse([]), param, this))
          .cast<Map>();
    };

    // Action for listing all persons using Listing UI
    domAction.addAction((e) => new PersonListChoose(
        (o) => setValue([o[$Worker.worker_id], o[$Worker.name]]), ap));
  }
}
