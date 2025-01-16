import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homepage/components/blur_background.dart';
import 'package:homepage/components/hover_builder.dart';
import 'package:homepage/components/simple_button.dart';
import 'package:homepage/features/pinned_tabs/services/pinned_tabs_service.dart';

class AddPinnedTab extends StatefulWidget {
  const AddPinnedTab({super.key});

  @override
  State<AddPinnedTab> createState() => _AddPinnedTabState();
}

class _AddPinnedTabState extends State<AddPinnedTab> {
  final pinnedTabsService = PinnedTabsService();
  final nameController = TextEditingController();
  final urlController = TextEditingController(text: "https://");
  bool expanded = false;

  void addPinnedTabData() async {
    await pinnedTabsService.addNewPinnedTab(
      displayName: nameController.text,
      url: urlController.text,
    );
    setState(() {
      nameController.clear();
      urlController.clear();
      expanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
        builder: (context, isHovered) {
          return GestureDetector(
            onTap: (){
              setState(() {
                expanded = true;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCirc,
              child: AnimatedScale(
                scale: (isHovered && !expanded) ? 1.25 : 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCirc,
                child : Blur(
                  child: expanded
                  ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withValues(alpha: 0.2),
                    ),
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter display name here',
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                          ),
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                        TextField(
                          controller: urlController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Paste full url here',
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                          ),
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: MyTextButton(
                                onPressed: addPinnedTabData,
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    expanded = false;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: MyTextButton(
                                    onPressed: (){
                                      setState(() {
                                        expanded = false;
                                      });
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.xmark,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                  : Container(
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
                        Text(
                          'Add pinned tab',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
