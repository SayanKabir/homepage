import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homepage/components/blur_background.dart';
import 'package:homepage/components/hover_builder.dart';
import 'package:homepage/features/pinned_tabs/models/pinned_tab_model.dart';
import 'package:homepage/features/pinned_tabs/services/pinned_tabs_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PinnedTab extends StatelessWidget {
  final PinnedTabModel pinnedTabModel;

  const PinnedTab({
    super.key,
    required this.pinnedTabModel,
  });

  Future<void> launchMyURL() async {
    if (pinnedTabModel.url.isEmpty) {
      return;
    }

    final uri = Uri.parse(pinnedTabModel.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
    }
  }


  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, isHovered) {
        return GestureDetector(
          onTap: launchMyURL,
          child: AnimatedScale(
            scale: isHovered ? 1.25 : 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCirc,
            child : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Blur(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withValues(alpha: 0.2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        // Image.network(
                        //   faviconUrl,
                        //   width: 20,
                        //   height: 20,
                        //   errorBuilder: (context, error, stackTrace) {
                        //     debugPrint("Error loading favicon for $faviconUrl: $error");
                        //     return Icon(
                        //       icon,
                        //       size: 20,
                        //       color: Colors.white,
                        //     );
                        //   },
                        // ),
                        Text(
                          pinnedTabModel.displayName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        // if(isHovered)
                        //   HoverButton(iconData: Icons.delete, onPressed: (){}, darkBackground: true),
                      ],
                    ),
                  ),
                ),
                AnimatedScale(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCirc,
                  scale: isHovered ? 1 : 0,
                  child: Blur(
                    child: GestureDetector(
                      onTap: (){
                        final pinnedTabsService = PinnedTabsService();
                        pinnedTabsService.deletePinnedTab(pinnedTabModel);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                        color: Colors.black.withValues(alpha: 0.3),
                        child: FaIcon(FontAwesomeIcons.minus, size: 12, color: Colors.white,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
