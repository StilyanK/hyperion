part of person.ctrl;

void routesWorker(Router router) {
  router
      .serve(RoutesWorker.itemGet, method: 'POST')
      .listen((req) => new IWorker(req).get());
  router
      .serve(RoutesWorker.itemSave, method: 'POST')
      .listen((req) => new IWorker(req).save());
  router
      .serve(RoutesWorker.itemDelete, method: 'POST')
      .listen((req) => new IWorker(req).delete());
  router
      .serve(RoutesWorker.collectionGet, method: 'POST')
      .listen((req) => new CWorker(req).get());
  router
      .serve(RoutesWorker.collectionSuggest, method: 'POST')
      .listen((req) => new CWorker(req).suggest());
  router
      .serve(RoutesWorker.collectionDelete, method: 'POST')
      .listen((req) => new CWorker(req).delete());
}

void routesBrigade(Router router) {
  router
      .serve(RoutesBrigade.itemGet, method: 'POST')
      .listen((req) => new IBrigade(req).get());
  router
      .serve(RoutesBrigade.itemSave, method: 'POST')
      .listen((req) => new IBrigade(req).save());
  router
      .serve(RoutesBrigade.itemDelete, method: 'POST')
      .listen((req) => new IBrigade(req).delete());
  router
      .serve(RoutesBrigade.getSalaryType, method: 'POST')
      .listen((req) => new IBrigade(req).getSalaryType());
  router
      .serve(RoutesBrigade.collectionSuggest, method: 'POST')
      .listen((req) => new CBrigade(req).suggest());
  router
      .serve(RoutesBrigade.collectionGet, method: 'POST')
      .listen((req) => new CBrigade(req).get());
  router
      .serve(RoutesBrigade.collectionDelete, method: 'POST')
      .listen((req) => new CBrigade(req).delete());
}

void routesCar(Router router) {
  router
      .serve(RoutesCar.itemGet, method: 'POST')
      .listen((req) => new ICar(req).get());
  router
      .serve(RoutesCar.itemSave, method: 'POST')
      .listen((req) => new ICar(req).save());
  router
      .serve(RoutesCar.itemDelete, method: 'POST')
      .listen((req) => new ICar(req).delete());
  router
      .serve(RoutesCar.collectionGet, method: 'POST')
      .listen((req) => new CCar(req).get());
  router
      .serve(RoutesCar.collectionSuggest, method: 'POST')
      .listen((req) => new CCar(req).suggest());
  router
      .serve(RoutesCar.collectionDelete, method: 'POST')
      .listen((req) => new CCar(req).delete());
}

void routesDictionary(Router router) {
  router
      .serve(RoutesDictionary.itemGet, method: 'POST')
      .listen((req) => new IDictionary(req).get());
  router
      .serve(RoutesDictionary.itemSave, method: 'POST')
      .listen((req) => new IDictionary(req).save());
  router
      .serve(RoutesDictionary.itemDelete, method: 'POST')
      .listen((req) => new IDictionary(req).delete());
//  router
//      .serve(RoutesDictionary.collectionGet, method: 'POST')
//      .listen((req) => new CCar(req).get());
//  router
//      .serve(RoutesDictionary.collectionSuggest, method: 'POST')
//      .listen((req) => new CCar(req).suggest());
//  router
//      .serve(RoutesDictionary.collectionDelete, method: 'POST')
//      .listen((req) => new CCar(req).delete());
}

