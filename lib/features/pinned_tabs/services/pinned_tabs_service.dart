import 'package:homepage/features/pinned_tabs/models/pinned_tab_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PinnedTabsService {
  final pinnedTabsTable = Supabase.instance.client.from('pinned_tabs');
  final auth = Supabase.instance.client.auth;

  // CREATE
  Future<void> addNewPinnedTab({required String displayName, required String url}) async {
    try {
      await pinnedTabsTable.insert({
        'user_id': auth.currentUser?.id,
        'display_name': displayName,
        'url': url,
      });
    } catch (e) {
      throw Exception('Failed to add pinned tab: $e');
    }
  }

  // READ STREAM
  final stream = Supabase.instance.client
      .from('pinned_tabs')
      .stream(primaryKey: ['id', 'user_id'])
      .order('created_at', ascending: true) // Sort by created_at in descending order
      .map((data) => data
      .map((pinnedTabMap) => PinnedTabModel.fromMap(pinnedTabMap))
      .toList());

  // UPDATE
  Future<void> updatePinnedTab({
    required String id, // Unique ID of the pinned tab
    required String displayName,
    required String url,
  }) async {
    try {
      await pinnedTabsTable.update({
        'display_name': displayName,
        'url': url,
      }).eq('id', id).eq('user_id', auth.currentUser!.id);
    } catch (e) {
      throw Exception('Failed to update pinned tab: $e');
    }
  }

  // DELETE
  Future<void> deletePinnedTab(PinnedTabModel pinnedTab) async {
    try {
      await pinnedTabsTable.delete().eq('id', pinnedTab.id).eq('user_id', auth.currentUser!.id);
    } catch (e) {
      throw Exception('Failed to delete pinned tab: $e');
    }
  }
}