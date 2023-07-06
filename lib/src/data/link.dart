import 'package:meta/meta.dart';

import '../things/created.dart';
import '../things/thing.dart';
import '../things/votable.dart';
import 'media.dart';

@immutable
class Link extends Thing implements Votable, Created {
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

  final String? author;

  final String? authorFlairCssClass;

  final String? authorFlairText;

  final bool clicked;

  final String domain;

  final bool hidden;

  final bool isSelf;

  final String? linkFlairCssClass;

  final String? linkFlairText;

  final bool locked;

  final Media? media;

  final Media? mediaEmbed;

  final int numComments;

  final bool over18;

  final String permalink;

  final int score;

  final String selftext;

  final String? selftextHtml;

  final String thumbnail;

  final String title;

  final String url;

  final dynamic edited;

  final String? distinguished;

  final bool stickied;

  final bool? isGallery;

  final bool? isVideo;

  final String? postHint;

  Link(id, name, kind, this._created, this._createdUtc, this._downs,
      this._likes, this._ups,
      {this.author,
      this.authorFlairCssClass,
      this.authorFlairText,
      required this.clicked,
      required this.domain,
      required this.hidden,
      required this.isSelf,
      required this.linkFlairCssClass,
      required this.linkFlairText,
      required this.locked,
      required this.media,
      required this.mediaEmbed,
      required this.numComments,
      required this.over18,
      required this.permalink,
      required this.score,
      required this.selftext,
      required this.selftextHtml,
      required this.thumbnail,
      required this.title,
      required this.url,
      this.edited,
      required this.distinguished,
      required this.stickied,
      required this.isGallery,
      required this.isVideo,
      required this.postHint})
      : super(id: id, name: name, kind: kind);

  Link.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        authorFlairCssClass = json['author_flair_css_class'],
        authorFlairText = json['author_flair_text'],
        clicked = json['clicked'],
        domain = json['domain'],
        hidden = json['hidden'],
        isSelf = json['is_self'],
        linkFlairCssClass = json['link_flair_css_class'],
        linkFlairText = json['link_flair_text'],
        locked = json['locked'],
        media = json['media'] != null ? Media.fromJson(json['media']) : null,
        mediaEmbed = json['media_embed'] != null
            ? Media.fromJson(json['media_embed'])
            : null,
        numComments = json['num_comments'],
        over18 = json['over_18'],
        permalink = json['permalink'],
        score = json['score'],
        selftext = json['selftext'],
        selftextHtml = json['selftext_html'],
        thumbnail = json['thumbnail'],
        title = json['title'],
        url = json['url'],
        edited = json['edited'],
        distinguished = json['distinguished'],
        stickied = json['stickied'],
        _created = json['created'],
        _createdUtc = json['created_utc'],
        _downs = json['downs'],
        _likes = json['likes'],
        _ups = json['ups'],
        isGallery = json['is_gallery'],
        isVideo = json['is_video'],
        postHint = json['post_hint'],
        super.fromJson(json);

  bool get linkIsVideo =>
      postHint == 'hosted:video' ||
      postHint == 'rich:video' ||
      postHint == 'video' ||
      isVideo == true ||
      media?.oembed?.type == 'video';

  bool get linkIsImage => postHint == 'image' || media?.oembed?.type == 'photo';
}
