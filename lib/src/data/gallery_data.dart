import 'package:meta/meta.dart';

@immutable
final class GalleryData {
  final List<(String mediaId, int id)> items;

  GalleryData._(this.items);

  factory GalleryData.fromJson(Map<String, dynamic> json) {
    final items = <(String mediaId, int id)>[];
    for (final item in json['items']) {
      items.add((item['media_id'], item['id']));
    }
    return GalleryData._(items);
  }
}
