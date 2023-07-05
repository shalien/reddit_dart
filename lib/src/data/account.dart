import 'package:meta/meta.dart';

import '../things/created.dart';

import '../things/thing.dart';

@immutable
class Account extends Thing implements Created {
  final double? _created;

  @override
  double? get created => _created;

  final double? _createdUtc;

  @override
  double? get createdUtc => _createdUtc;

  final int commentKarma;

  final bool? hasMail;

  final bool? hasModMail;

  final bool? hasVerifiedEmail;

  final int inboxCount;

  final bool isFriend;

  final bool isGold;

  final bool isMod;

  final String? modhash;

  final bool over18;

  Account(
    this._created,
    this._createdUtc, {
    required String id,
    required String name,
    required this.commentKarma,
    required this.hasMail,
    required this.hasModMail,
    required this.hasVerifiedEmail,
    required this.inboxCount,
    required this.isFriend,
    required this.isGold,
    required this.isMod,
    required this.modhash,
    required this.over18,
  }) : super(id: id, name: name);

  Account.fromJson(Map<String, dynamic> json)
      : commentKarma = json['comment_karma'],
        hasMail = json['has_mail'],
        hasModMail = json['has_mod_mail'],
        hasVerifiedEmail = json['has_verified_email'],
        inboxCount = json['inbox_count'],
        isFriend = json['is_friend'],
        isGold = json['is_gold'],
        isMod = json['is_mod'],
        modhash = json['modhash'],
        over18 = json['over_18'],
        _created = json['created'],
        _createdUtc = json['created_utc'],
        super.fromJson(json);
}
