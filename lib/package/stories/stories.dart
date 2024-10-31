import 'package:flutter/material.dart';
import 'package:piptest/package/stories/story_screen.dart';
import 'package:piptest/package/stories/story_var.dart';

class Stories extends StatefulWidget {
  const Stories({
    super.key,
    // required this.storiesKey,
    required this.storyBorderColor,
  });

  // final GlobalKey storiesKey;
  final Color storyBorderColor;

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Remove margin once stories is completed
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      height: 122,
      color: Colors.transparent,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: storyCircleImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showGeneralDialog(
                  barrierLabel: "Label",
                  barrierDismissible: false,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: Duration(milliseconds: 200),
                  context: context,
                  pageBuilder: (context, anim1, anim2) {
                    return StoryScreen(
                      currentStory: index,
                    );
                  },
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                          .animate(anim1),
                      child: child,
                    );
                  },
                );
              },
              child:
                  // index == 0
                  //     ? Tooltips(
                  //         globalKey: widget.storiesKey,
                  //         title: 'Stories',
                  //         description:
                  //             'These are the stories that contain latest offers.',
                  //         child: Container(
                  //           margin: const EdgeInsets.only(
                  //             left: 6,
                  //             right: 6,
                  //             top: 6,
                  //             bottom: 0,
                  //           ),
                  //           child: Column(
                  //             children: [
                  //               Stack(
                  //                 children: [
                  //                   Container(
                  //                     height: 82,
                  //                     width: 82,
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.transparent,
                  //                       shape: BoxShape.circle,
                  //                       border: Border.all(
                  //                         color: Color.fromRGBO(165, 88, 164, 1),
                  //                         width: 2.5,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     margin: EdgeInsets.all(8.5),
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       shape: BoxShape.circle,
                  //                     ),
                  //                     width: 65,
                  //                     child: ClipRRect(
                  //                       borderRadius: BorderRadius.circular(40),
                  //                       child: Image.network(
                  //                         storyCircleImages[index],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               Text(
                  //                 storyCircleNames[index],
                  //                 style: TextStyle(
                  //                   height: 1,
                  //                   color: Colors.white,
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     :
                  // Container(
                  // key: index == 0 ? widget.storiesKey : null,
                  // margin: const EdgeInsets.symmetric(
                  //   horizontal: 10,
                  //   vertical: 10,
                  // ),
                  //   width: 80,
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Colors.white,
                  //   ),
                  //   child:
                  // ),
                  Container(
                margin: const EdgeInsets.only(
                  left: 6,
                  right: 6,
                  top: 6,
                  bottom: 0,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 82,
                          width: 82,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: widget.storyBorderColor,
                              width: 2.5,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          width: 65,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.network(
                              storyCircleImages[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      storyCircleNames[index],
                      style: TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
