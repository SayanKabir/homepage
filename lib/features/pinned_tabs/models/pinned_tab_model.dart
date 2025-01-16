class PinnedTabModel {
  final String id;
  final String userId;
  final String displayName;
  final String url;

  PinnedTabModel({
    required this.id,
    required this.userId,
    required this.displayName,
    required this.url,
  });

  factory PinnedTabModel.fromMap(Map<String, dynamic> map) {
    return PinnedTabModel(
      id: map['id'],
      userId: map['user_id'],
      displayName: map['display_name'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'display_name': displayName,
      'url': url,
    };
  }
}