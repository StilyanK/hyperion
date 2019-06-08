import 'package:intl/intl.dart';

String Person() => Intl.message('Person', name: 'Person');

String Persons() => Intl.message('People', name: 'Persons');

String Person_list() => Intl.message('People', name: 'Person_list');

String Person_new() => Intl.message('New Person', name: 'Person_new');

String Add_person() => Intl.message('Add Person', name: 'Add_person');

String person_title(int id) =>
    id == null ? person_title_new() : person_title_e(id);

String person_title_new() =>
    Intl.message('New Person', name: 'person_title_new');

String person_title_e(int id) =>
    Intl.message('Person # $id', name: 'person_title_e', args: [id]);

String Age() => Intl.message('Age', name: 'Age');

String Name() => Intl.message('Name', name: 'Name');

String Phone() => Intl.message('Phone', name: 'Phone');

String Mail() => Intl.message('Mail', name: 'Mail');

String Comment() => Intl.message('Comment', name: 'Comment');

String Birth() => Intl.message('Birth', name: 'Birth');
