import 'package:flutter/material.dart';
import 'package:homepage/features/pinned_tabs/views/add_pinned_tab.dart';
import 'package:homepage/features/pinned_tabs/widgets/pinned_tab.dart';
import 'package:homepage/features/pinned_tabs/models/pinned_tab_model.dart';
import 'package:homepage/features/pinned_tabs/services/pinned_tabs_service.dart';

class PinnedTabs extends StatefulWidget {
  const PinnedTabs({super.key});

  @override
  State<PinnedTabs> createState() => _PinnedTabsState();
}

class _PinnedTabsState extends State<PinnedTabs> {
  final pinnedTabsService = PinnedTabsService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PinnedTabModel>>(
      stream: pinnedTabsService.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(height: 0,);
          // return Center(
          //   child: SpinKitPulse(
          //     color: Colors.black.withValues(alpha: 0.7),
          //     size: 100,
          //   ),
          // );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //   child: Text(
              //     'No pinned tabs found',
              //     style: TextStyle(color: Colors.white.withValues(alpha: 0.7),),
              //   ),
              // ),
              SizedBox(height: 10,),
              const AddPinnedTab(), // Option to add a new pinned tab
            ],
          );
        }

        final pinnedTabs = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            const SizedBox(height: 10,),
            ...pinnedTabs.map((tab) => PinnedTab(pinnedTabModel: tab,),),
            const AddPinnedTab(), // Option to add a new pinned tab
          ],
        );
      },
    );
  }
}