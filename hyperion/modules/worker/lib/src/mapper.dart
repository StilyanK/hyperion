library person.mapper;

import 'dart:async';

import 'package:mapper/mapper.dart';

import 'entity.dart' as entity;

part 'db/mapper/brigade.dart';
part 'db/mapper/car.dart';
part 'db/mapper/relation_cost_brigade.dart';
part 'db/mapper/relation_salary_worker.dart';
part 'db/mapper/worker.dart';
part 'db/mapper/dictionary.dart';

mixin AppMixin implements Application {
  Manager m;

  WorkerMapper get worker => new WorkerMapper(m.convert(new App()))
    ..notifier = entityWorker
    ..entity = (() => new Worker())
    ..collection = () => new WorkerCollection();

  BrigadeMapper get brigade => new BrigadeMapper(m.convert(new App()))
    ..entity = (() => new Brigade())
    ..collection = () => new BrigadeCollection();

  RelationBrigadeMapper get relationSalaryWorker =>
      new RelationBrigadeMapper(m.convert(new App()))
        ..entity = (() => new RelationBrigade())
        ..collection = () => new RelationBrigadeCollection();

  CarMapper get car => new CarMapper(m.convert(new App()))
    ..entity = (() => new Car())
    ..notifier = notifierCar
    ..collection = () => new CarCollection();

  DictionaryMapper get dictionary => new DictionaryMapper(m.convert(new App()))
    ..entity = (() => new Dictionary())
   // ..notifier = notifierCar
    ..collection = () => new DictionaryCollection();



}

class App extends Application with AppMixin {}

/// If we want to listen for update, insert, delete events for this entity
final EntityNotifier<Worker> entityWorker = new EntityNotifier<Worker>();
final EntityNotifier<Car> notifierCar = new EntityNotifier<Car>();
