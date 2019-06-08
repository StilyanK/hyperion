import 'package:communicator/shared.dart';

class RoutesWorker {
  static get itemGet => new UrlPattern('r/worker/item/get');

  static get itemSave => new UrlPattern(r'/worker/item/save');

  static get itemDelete => new UrlPattern(r'/worker/item/delete');

  static get collectionGet => new UrlPattern(r'/worker/collection/get');

  static get collectionDelete => new UrlPattern(r'/worker/collection/delete');

  static get collectionSuggest => new UrlPattern(r'/worker/collection/suggest');
}

class RoutesBrigade {
  static get itemGet => new UrlPattern('r/brigade/item/get');

  static get itemSave => new UrlPattern(r'/brigade/item/save');

  static get itemDelete => new UrlPattern(r'/brigade/item/delete');

  static get collectionGet => new UrlPattern(r'/brigade/collection/get');

  static get collectionDelete => new UrlPattern(r'/brigade/collection/delete');

  static get collectionSuggest =>
      new UrlPattern(r'/brigade/collection/suggest');

  static get getSalaryType => new UrlPattern(r'/brigade/get/salary');
}

class RoutesSalaryWorker {
  static get itemGet => new UrlPattern('r/salary_worker/item/get');

  static get itemSave => new UrlPattern(r'/salary_worker/item/save');

  static get itemDelete => new UrlPattern(r'/salary_worker/item/delete');

  static get collectionGet => new UrlPattern(r'/salary_worker/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/salary_worker/collection/delete');

  static get collectionSuggest =>
      new UrlPattern(r'/salary_worker/collection/suggest');

  static get getGridData => new UrlPattern(r'/grid-data/get');
}

class RoutesCar {
  static get itemGet => new UrlPattern('r/car/item/get');

  static get itemSave => new UrlPattern(r'/car/item/save');

  static get itemDelete => new UrlPattern(r'/car/item/delete');

  static get collectionGet => new UrlPattern(r'/car/collection/get');

  static get collectionDelete => new UrlPattern(r'/car/collection/delete');

  static get collectionSuggest => new UrlPattern(r'/car/collection/suggest');
}


class RoutesDictionary {
  static get itemGet => new UrlPattern('r/dictionary/item/get');

  static get itemSave => new UrlPattern(r'/dictionary/item/save');

  static get itemDelete => new UrlPattern(r'/dictionary/item/delete');

  static get collectionGet => new UrlPattern(r'/dictionary/collection/get');

  static get collectionDelete => new UrlPattern(r'/dictionary/collection/delete');

  static get collectionSuggest => new UrlPattern(r'/dictionary/collection/suggest');
}

