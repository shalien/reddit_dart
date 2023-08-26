import 'package:meta/meta.dart';
import '../things/thing.dart';

@immutable
class Subreddit extends Thing {
  final num? accountsActive;
  final num? commentScoreHideMins;
  final String? description;
  final String? descriptionHtml;
  final String displayName;
  final String? headerImg;
  final List<int>? headerSize;
  final String? headerTitle;
  final bool? over18;
  final String publicDescription;
  final bool? publicTraffic;
  final num? subscribers;
  final String submissionType;
  final String submitLinkLabel;
  final String submitTextLabel;
  final String subredditType;
  final String title;
  final String url;
  final bool? userIsBanned;
  final bool? userIsContributor;
  final bool? userIsModerator;
  final bool? userIsSubscriber;

  Subreddit({
    required String id,
    required String name,
    required this.accountsActive,
    required this.commentScoreHideMins,
    required this.description,
    required this.descriptionHtml,
    required this.displayName,
    required this.headerImg,
    required this.headerSize,
    required this.headerTitle,
    required this.over18,
    required this.publicDescription,
    required this.publicTraffic,
    required this.subscribers,
    required this.submissionType,
    required this.submitLinkLabel,
    required this.submitTextLabel,
    required this.subredditType,
    required this.title,
    required this.url,
    required this.userIsBanned,
    required this.userIsContributor,
    required this.userIsModerator,
    required this.userIsSubscriber,
  }) : super(id: id, name: name);

  Subreddit.fromJson(Map<String, dynamic> json)
      : accountsActive = json['accounts_active'],
        commentScoreHideMins = json['comment_score_hide_mins'],
        description = json['description'],
        descriptionHtml = json['description_html'],
        displayName = json['display_name'],
        headerImg = json['header_img'],
        headerSize = null,
        headerTitle = json['header_title'],
        over18 = json['over18'],
        publicDescription = json['public_description'],
        publicTraffic = json['public_traffic'],
        subscribers = json['subscribers'],
        submissionType = json['submission_type'],
        submitLinkLabel = json['submit_link_label'],
        submitTextLabel = json['submit_text_label'],
        subredditType = json['subreddit_type'],
        title = json['title'],
        url = json['url'],
        userIsBanned = json['user_is_banned'],
        userIsContributor = json['user_is_contributor'],
        userIsModerator = json['user_is_moderator'],
        userIsSubscriber = json['user_is_subscriber'],
        super.fromJson(json);
}
