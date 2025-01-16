import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:homepage/user_prefs/models/user_prefs_model.dart';
import 'package:homepage/secrets/secrets.dart';
import 'package:homepage/user_prefs/services/user_prefs_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({super.key});

  @override
  State<BackgroundWidget> createState() => BackgroundWidgetState();
}

class BackgroundWidgetState extends State<BackgroundWidget> {
  final unsplashApiUrl = 'https://api.unsplash.com/photos/random';
  String? imageUrl;
  bool isLoading = false;

  Future<void> fetchBackgroundImage(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('$unsplashApiUrl?client_id=$UNSPLASH_API_KEY&query=$query'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          imageUrl = data['urls']['full'];
        });
      } else {
        throw Exception('Failed to fetch background image: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching image: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> refreshImage() async {
    // final query = context.read<UserPrefsProvider>().backgroundQuery;
    final userPrefsService = UserPrefsService();
    final query = await userPrefsService.fetchUserPref(TAG_BACKGROUND_IMAGE_QUERY);
    final backgroundQuery = (query == null || query.isEmpty) ? 'nature' : query;
    fetchBackgroundImage(backgroundQuery);
  }

  @override
  void initState() {
    super.initState();
    refreshImage();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SpinKitPulse(
          color: Colors.green.withValues(alpha: 0.7),
          size: 300,
        ),
      );
    }

    if (imageUrl != null) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Center(
      child: SpinKitPulse(
        color: Colors.green.withValues(alpha: 0.7),
        size: 900,
      ),
    );
  }
}