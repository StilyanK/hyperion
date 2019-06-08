part of worker.entity;

@MSerializable()
class Dictionary {
  int dictionary_id;
  String content;

  Dictionary();

  void init(Map data) => _$DictionaryFromMap(this, data);

  Map<String, dynamic> pair() => {'k': dictionary_id, 'v': content};

  Map<String, dynamic> toJson() => _$DictionaryToMap(this, true);

  Map<String, dynamic> toMap() => _$DictionaryToMap(this);
}

class DictionaryCollection<E extends Dictionary> extends Collection<E> {
  List<Map<String, dynamic>> pair() =>
      map((object) => {'k': object.dictionary_id, 'v': object.content})
          .toList();
}
