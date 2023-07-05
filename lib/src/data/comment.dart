import 'package:meta/meta.dart';

import '../things/created.dart';
import '../things/thing.dart';
import '../things/votable.dart';

@immutable
class Comment extends Thing implements Votable, Created {
  final String? approvedBy;

  final String? author;

  final String? authorFlairCssClass;

  final String? authorFlairText;

  final String? bannedBy;

  final String? body;

  final String? bodyHtml;

  final DateTime? edited;

  final int gilded;

  final String linkAuthor;

  final String linkId;

  final String linkTitle;

  final String linkUrl;

  final int numReports;

  final String? parentId;

  final List<Thing> replies;

  final bool saved;

  final int score;

  final String subreddit;

  final String subredditId;

  final String? distinguished;

  final double? _created;

  @override
  double? get created => _created;

  final double? _createdUtc;

  @override
  double? get createdUtc => _createdUtc;

  final int? _downs;

  @override
  int? get downs => _downs;

  final bool? _likes;

  @override
  bool? get likes => _likes;

  final int? _ups;

  @override
  int? get ups => _ups;

  Comment(id, name, kind, this._created, this._createdUtc, this._downs,
      this._likes, this._ups,
      {this.approvedBy,
      this.author,
      this.authorFlairCssClass,
      this.authorFlairText,
      this.bannedBy,
      this.body,
      this.bodyHtml,
      this.edited,
      this.gilded = 0,
      required this.linkAuthor,
      required this.linkId,
      required this.linkTitle,
      required this.linkUrl,
      this.numReports = 0,
      this.parentId,
      required this.replies,
      this.saved = false,
      this.score = 0,
      required this.subreddit,
      required this.subredditId,
      this.distinguished})
      : super(id: id, name: name, kind: kind);

  Comment.fromJson(Map<String, dynamic> json)
      : approvedBy = json['approved_by'],
        author = json['author'],
        authorFlairCssClass = json['author_flair_css_class'],
        authorFlairText = json['author_flair_text'],
        bannedBy = json['banned_by'],
        body = json['body'],
        bodyHtml = json['body_html'],
        edited = json['edited'] == false
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['edited'] * 1000),
        gilded = json['gilded'],
        linkAuthor = json['link_author'],
        linkId = json['link_id'],
        linkTitle = json['link_title'],
        linkUrl = json['link_url'],
        numReports = json['num_reports'],
        parentId = json['parent_id'],
        replies = (json['replies'] as List<Map<String, dynamic>>)
            .map((e) => Thing.resolveThing(e) as Thing)
            .toList(),
        saved = json['saved'],
        score = json['score'],
        subreddit = json['subreddit'],
        subredditId = json['subreddit_id'],
        distinguished = json['distinguished'],
        _created = json['created'],
        _createdUtc = json['created_utc'],
        _downs = json['downs'],
        _likes = json['likes'],
        _ups = json['ups'];
}
