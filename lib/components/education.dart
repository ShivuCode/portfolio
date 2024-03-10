import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:velocity_x/velocity_x.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  List education = [
    [
      "March 2018,",
      "I completed my 10th grade at Government High School Nani Daman, achieving a score of 56%."
    ],
    [
      "March 2020,",
      "I successfully completed my 12th grade at Technical Training Institute, Moti Daman, with an impressive score of 79%."
    ],
    [
      "Running",
      " I am pursuing my undergraduate bachelor's degree studies at VNSGU University."
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenWidth > 1200 ? 600 : 650,
      margin: const EdgeInsets.only(top: 20),
      width: context.screenWidth < 900
          ? context.screenWidth * 0.9
          : context.screenWidth * 0.5,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text("Education",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600)),
            Timeline.tileBuilder(
              theme: TimelineThemeData(
                  color: Vx.purple400, direction: Axis.vertical),
              shrinkWrap: true,
              builder: TimelineTileBuilder.fromStyle(
                itemCount: education.length,
                contentsBuilder: (context, index) {
                  return FutureBuilder(
                    future: Future.delayed(Duration(seconds: index)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  education[index][0],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.indigo,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  education[index][1],
                                  style: TextStyle(
                                    fontSize:
                                        context.screenWidth < 500 ? 12 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                },
                contentsAlign: ContentsAlign.alternating,
              ),
            )
          ],
        ),
      ),
    );
  }
}
