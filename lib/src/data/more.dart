import 'package:meta/meta.dart';

import '../things/thing.dart';

@immutable
class More extends Thing {
  final List<String> children;

  More({required String id, required String name, required this.children})
      : super(id: id, name: name);

  More.fromJson(Map<String, dynamic> json)
      : children = json['children'].cast<String>(),
        super.fromJson(json);
}
