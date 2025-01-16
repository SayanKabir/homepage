import 'package:supabase_flutter/supabase_flutter.dart';

const String TAG_USERNAME = 'username';
const String TAG_BACKGROUND_IMAGE_QUERY = 'bg_query';
const String TAG_HIDE_BOTTOM_FLOATING_BAR = 'auto_hide';

class UserPrefsModel {
  final String userId;
  final String tag;
  final String value;

  UserPrefsModel({
    required this.userId,
    required this.tag,
    required this.value,
  });

  factory UserPrefsModel.fromMap(Map<String, dynamic> map) {
    return UserPrefsModel(
      userId: map['user_id'],
      tag: map['tag'],
      value: map['value'],
    );
  }

  Map<String, dynamic> toMap() {
    final userID = Supabase.instance.client.auth.currentUser?.id;
    return {
      'user_id': userID,
      'tag': tag,
      'value': value,
    };
  }
}