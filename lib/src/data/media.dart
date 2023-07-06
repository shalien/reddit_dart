import 'package:meta/meta.dart';

@immutable
class Media {
  final String? type;

  final Oembed? oembed;

  final RedditVideo? redditVideo;

  Media({this.type, this.oembed, this.redditVideo});

  Media.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        oembed =
            json['oembed'] != null ? Oembed.fromJson(json['oembed']) : null,
        redditVideo = json['reddit_video'] != null
            ? RedditVideo.fromJson(json['reddit_video'])
            : null;
}

@immutable
class RedditVideo {
  final int? bitrateKbps;
  final String? fallbackUrl;
  final bool? hasAudio;
  final int? height;
  final int? width;

  final String? scrubberMediaUrl;
  final String? dashUrl;
  final int? duration;

  final String? hlsUrl;

  final bool? isGif;

  final String? transcodingStatus;

  RedditVideo({
    this.bitrateKbps,
    this.fallbackUrl,
    this.hasAudio,
    this.height,
    this.width,
    this.scrubberMediaUrl,
    this.dashUrl,
    this.duration,
    this.hlsUrl,
    this.isGif,
    this.transcodingStatus,
  });

  RedditVideo.fromJson(Map<String, dynamic> json)
      : bitrateKbps = json['bitrate_kbps'],
        fallbackUrl = json['fallback_url'],
        hasAudio = json['has_audio'],
        height = json['height'],
        width = json['width'],
        scrubberMediaUrl = json['scrubber_media_url'],
        dashUrl = json['dash_url'],
        duration = json['duration'],
        hlsUrl = json['hls_url'],
        isGif = json['is_gif'],
        transcodingStatus = json['transcoding_status'];
}

@immutable
class Oembed {
  final String? providerUrl;
  final String? version;
  final String? title;

  final int? thumbnailWidth;
  final int? width;
  final int? height;

  final String? html;

  final String? providerName;

  final String? thumbnailUrl;

  final String? type;

  final int? thumbnailHeight;

  Oembed({
    this.providerUrl,
    this.version,
    this.title,
    this.thumbnailWidth,
    this.width,
    this.height,
    this.html,
    this.providerName,
    this.thumbnailUrl,
    this.type,
    this.thumbnailHeight,
  });

  Oembed.fromJson(Map<String, dynamic> json)
      : providerUrl = json['provider_url'],
        version = json['version'],
        title = json['title'],
        thumbnailWidth = json['thumbnail_width'],
        width = json['width'],
        height = json['height'],
        html = json['html'],
        providerName = json['provider_name'],
        thumbnailUrl = json['thumbnail_url'],
        type = json['type'],
        thumbnailHeight = json['thumbnail_height'];
}
