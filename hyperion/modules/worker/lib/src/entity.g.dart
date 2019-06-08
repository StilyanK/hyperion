// GENERATED CODE - DO NOT MODIFY BY HAND

part of worker.entity;

// **************************************************************************
// EntitySerializableGenerator
// **************************************************************************

abstract class $Brigade {
  static const String brigade_id = 'brigade_id';
  static const String address = 'address';
  static const String material = 'material';
  static const String quadrature = 'quadrature';
  static const String lv_per_quadrature = 'lv_per_quadrature';
  static const String total_money = 'total_money';
}

void _$BrigadeFromMap(Brigade obj, Map data) => obj
  ..brigade_id = data[$Brigade.brigade_id]
  ..address = data[$Brigade.address]
  ..material = data[$Brigade.material]
  ..quadrature = setDouble(data[$Brigade.quadrature])
  ..lv_per_quadrature = setDouble(data[$Brigade.lv_per_quadrature])
  ..total_money = setDouble(data[$Brigade.total_money]);

Map<String, dynamic> _$BrigadeToMap(Brigade obj, [asJson = false]) =>
    <String, dynamic>{
      $Brigade.brigade_id: obj.brigade_id,
      $Brigade.address: obj.address,
      $Brigade.material: obj.material,
      $Brigade.quadrature: obj.quadrature,
      $Brigade.lv_per_quadrature: obj.lv_per_quadrature,
      $Brigade.total_money: obj.total_money
    };

abstract class $Car {
  static const String car_id = 'car_id';
  static const String car_name = 'car_name';
  static const String insurance_expires = 'insurance_expires';
  static const String vignette_expires = 'vignette_expires';
  static const String year_check_expires = 'year_check_expires';
}

void _$CarFromMap(Car obj, Map data) => obj
  ..car_id = data[$Car.car_id]
  ..car_name = data[$Car.car_name]
  ..insurance_expires = setDateTime(data[$Car.insurance_expires])
  ..vignette_expires = setDateTime(data[$Car.vignette_expires])
  ..year_check_expires = setDateTime(data[$Car.year_check_expires]);

Map<String, dynamic> _$CarToMap(Car obj, [asJson = false]) => <String, dynamic>{
      $Car.car_id: obj.car_id,
      $Car.car_name: obj.car_name,
      $Car.insurance_expires: asJson
          ? obj.insurance_expires?.toIso8601String()
          : obj.insurance_expires,
      $Car.vignette_expires: asJson
          ? obj.vignette_expires?.toIso8601String()
          : obj.vignette_expires,
      $Car.year_check_expires: asJson
          ? obj.year_check_expires?.toIso8601String()
          : obj.year_check_expires
    };

abstract class $RelationCostBrigade {
  static const String relation_cost_brigade_id = 'relation_cost_brigade_id';
  static const String brigade_id = 'brigade_id';
  static const String cost_id = 'cost_id';
  static const String note = 'note';
  static const String price = 'price';
}

void _$RelationCostBrigadeFromMap(RelationCostBrigade obj, Map data) => obj
  ..relation_cost_brigade_id =
      data[$RelationCostBrigade.relation_cost_brigade_id]
  ..brigade_id = data[$RelationCostBrigade.brigade_id]
  ..cost_id = data[$RelationCostBrigade.cost_id]
  ..note = data[$RelationCostBrigade.note]
  ..price = setDouble(data[$RelationCostBrigade.price]);

Map<String, dynamic> _$RelationCostBrigadeToMap(RelationCostBrigade obj,
        [asJson = false]) =>
    <String, dynamic>{
      $RelationCostBrigade.relation_cost_brigade_id:
          obj.relation_cost_brigade_id,
      $RelationCostBrigade.brigade_id: obj.brigade_id,
      $RelationCostBrigade.cost_id: obj.cost_id,
      $RelationCostBrigade.note: obj.note,
      $RelationCostBrigade.price: obj.price
    };

abstract class $RelationBrigade {
  static const String relation_salary_worker_id = 'relation_salary_worker_id';
  static const String worker_id = 'worker_id';
  static const String work_days = 'work_days';
  static const String brigade_id = 'brigade_id';
  static const String advance = 'advance';
  static const String salary = 'salary';
}

void _$RelationBrigadeFromMap(RelationBrigade obj, Map data) => obj
  ..relation_salary_worker_id = data[$RelationBrigade.relation_salary_worker_id]
  ..worker_id = data[$RelationBrigade.worker_id]
  ..work_days = data[$RelationBrigade.work_days]
  ..brigade_id = data[$RelationBrigade.brigade_id]
  ..advance = setDouble(data[$RelationBrigade.advance])
  ..salary = setDouble(data[$RelationBrigade.salary]);

Map<String, dynamic> _$RelationBrigadeToMap(RelationBrigade obj,
        [asJson = false]) =>
    <String, dynamic>{
      $RelationBrigade.relation_salary_worker_id: obj.relation_salary_worker_id,
      $RelationBrigade.worker_id: obj.worker_id,
      $RelationBrigade.work_days: obj.work_days,
      $RelationBrigade.brigade_id: obj.brigade_id,
      $RelationBrigade.advance: obj.advance,
      $RelationBrigade.salary: obj.salary
    };

abstract class $Worker {
  static const String worker_id = 'worker_id';
  static const String name = 'name';
  static const String salary_type = 'salary_type';
  static const String salary_coefficient = 'salary_coefficient';
  static const String salary_per_day = 'salary_per_day';
}

void _$WorkerFromMap(Worker obj, Map data) => obj
  ..worker_id = data[$Worker.worker_id]
  ..name = data[$Worker.name]
  ..salary_type = data[$Worker.salary_type]
  ..salary_coefficient = setDouble(data[$Worker.salary_coefficient])
  ..salary_per_day = setDouble(data[$Worker.salary_per_day]);

Map<String, dynamic> _$WorkerToMap(Worker obj, [asJson = false]) =>
    <String, dynamic>{
      $Worker.worker_id: obj.worker_id,
      $Worker.name: obj.name,
      $Worker.salary_type: obj.salary_type,
      $Worker.salary_coefficient: obj.salary_coefficient,
      $Worker.salary_per_day: obj.salary_per_day
    };

abstract class $Dictionary {
  static const String dictionary_id = 'dictionary_id';
  static const String content = 'content';
}

void _$DictionaryFromMap(Dictionary obj, Map data) => obj
  ..dictionary_id = data[$Dictionary.dictionary_id]
  ..content = data[$Dictionary.content];

Map<String, dynamic> _$DictionaryToMap(Dictionary obj, [asJson = false]) =>
    <String, dynamic>{
      $Dictionary.dictionary_id: obj.dictionary_id,
      $Dictionary.content: obj.content
    };
