import 'dart:convert';

class UrlThreatAnalysisResponse {
  final Data data;
  final Meta meta;

  UrlThreatAnalysisResponse({required this.data, required this.meta});

  factory UrlThreatAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return UrlThreatAnalysisResponse(
      data: Data.fromJson(json['data']),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Data {
  final String id;
  final String type;
  final Attributes attributes;
  final Links links;

  Data({
    required this.id,
    required this.type,
    required this.attributes,
    required this.links,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      type: json['type'],
      attributes: Attributes.fromJson(json['attributes']),
      links: Links.fromJson(json['links']),
    );
  }
}

class Attributes {
  final int date;
  final String status;
  final Map<String, dynamic> results;
  final Stats stats;

  Attributes({
    required this.date,
    required this.status,
    required this.results,
    required this.stats,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      date: json['date'],
      status: json['status'],
      results: json['results'] ?? {},
      stats: Stats.fromJson(json['stats']),
    );
  }
}

class Stats {
  final int harmless;
  final int malicious;
  final int suspicious;
  final int timeout;
  final int undetected;

  Stats({
    required this.harmless,
    required this.malicious,
    required this.suspicious,
    required this.timeout,
    required this.undetected,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      harmless: json['harmless'],
      malicious: json['malicious'],
      suspicious: json['suspicious'],
      timeout: json['timeout'],
      undetected: json['undetected'],
    );
  }
}

class Links {
  final String item;
  final String self;

  Links({required this.item, required this.self});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      item: json['item'],
      self: json['self'],
    );
  }
}

class Meta {
  final UrlInfo urlInfo;

  Meta({required this.urlInfo});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      urlInfo: UrlInfo.fromJson(json['url_info']),
    );
  }
}

class UrlInfo {
  final String id;
  final String url;

  UrlInfo({required this.id, required this.url});

  factory UrlInfo.fromJson(Map<String, dynamic> json) {
    return UrlInfo(
      id: json['id'],
      url: json['url'],
    );
  }
}
