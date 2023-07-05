import 'package:meta/meta.dart';

import '../things/created.dart';
import '../things/thing.dart';

@immutable
class Message extends Thing implements Created {
  final double? _created;

  @override
  double? get created => _created;

  final double? _createdUtc;

  @override
  double? get createdUtc => _createdUtc;

  final String? author;

  final String? body;

  final String? bodyHtml;

  final String? context;

  final String? firstMessage;

  final String? firstMessageName;

  final bool? likes;

  final String? linkTitle;

  final bool? isNew;

  final String? parentId;

  final String? replies;

  final String? subject;

  final String? subreddit;

  final bool wasComment;

  Message(
    this._created,
    this._createdUtc, {
    required String id,
    required String name,
    required this.author,
    required this.body,
    required this.bodyHtml,
    required this.context,
    required this.firstMessage,
    required this.firstMessageName,
    required this.likes,
    required this.linkTitle,
    required this.isNew,
    required this.parentId,
    required this.replies,
    required this.subject,
    required this.subreddit,
    required this.wasComment,
  }) : super(id: id, name: name);

  Message.fromJson(Map<String, dynamic> json)
      : _created = json['created'],
        _createdUtc = json['created_utc'],
        author = json['author'],
        body = json['body'],
        bodyHtml = json['body_html'],
        context = json['context'],
        firstMessage = json['first_message'],
        firstMessageName = json['first_message_name'],
        likes = json['likes'],
        linkTitle = json['link_title'],
        isNew = json['new'],
        parentId = json['parent_id'],
        replies = json['replies'],
        subject = json['subject'],
        subreddit = json['subreddit'],
        wasComment = json['was_comment'],
        super.fromJson(json);
}
