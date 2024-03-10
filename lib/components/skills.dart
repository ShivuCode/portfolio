import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/database/skillService.dart';
import 'package:portfolio/utilis/skillRemoveBtn.dart';
import 'package:portfolio/utilis/skillitem.dart';
import 'package:velocity_x/velocity_x.dart';

class Skill extends StatefulWidget {
  const Skill({Key? key}) : super(key: key);

  @override
  State<Skill> createState() => _SkillState();
}

class _SkillState extends State<Skill> {
  List plItems = [];
  List fItems = [];
  List oItems = [];
  TextEditingController item = TextEditingController();
  fetchData() async {
    plItems = await SkillService.getSkills('pl');
    fItems = await SkillService.getSkills('fw');
    oItems = await SkillService.getSkills('other');
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              alignment: Alignment.center,
              child: const Text(
                "My Skills",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              )),
          Container(
            padding: const EdgeInsets.all(20),
            width: context.screenWidth < 900
                ? context.screenWidth * 0.9
                : (context.screenWidth * 0.9) / 3,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Programming Languages",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const Divider(),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    if (plItems.isNotEmpty)
                      ...List.generate(plItems.length, (index) {
                        return AddSkill(
                          name: plItems[index],
                          color: colors[generateRandomNumber()],
                        );
                      }),
                    addWidget('pl', "Programming Language you know?"),
                    if (plItems.isNotEmpty)
                      SkillRemove(
                        listKey: 'pl',
                        callback: fetchData,
                      ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: context.screenWidth < 900
                ? context.screenWidth * 0.9
                : (context.screenWidth * 0.9) / 3,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("FrameWorks",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const Divider(),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    if (fItems.isNotEmpty)
                      ...List.generate(fItems.length, (index) {
                        return AddSkill(
                          name: fItems[index],
                          color: colors[generateRandomNumber()],
                        );
                      }),
                    addWidget('fw', "Frameworks you know?"),
                    if (fItems.isNotEmpty)
                      SkillRemove(
                        listKey: 'fw',
                        callback: fetchData,
                      ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: context.screenWidth < 900
                ? context.screenWidth * 0.9
                : (context.screenWidth * 0.9) / 3,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Other Tools",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const Divider(),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    if (oItems.isNotEmpty)
                      ...List.generate(oItems.length, (index) {
                        return AddSkill(
                          name: oItems[index],
                          color: colors[generateRandomNumber()],
                        );
                      }),
                    addWidget('other', "Other tools you know?"),
                    if (oItems.isNotEmpty)
                      SkillRemove(
                        listKey: 'other',
                        callback: fetchData,
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  addWidget(key, title) => ElevatedButton.icon(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: SingleChildScrollView(
              child: Container(
                width: context.screenWidth < 900
                    ? context.screenWidth * 0.8
                    : context.screenWidth * 0.6,
                padding: const EdgeInsets.all(15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: item,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(label: Text("Skill")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 45)),
                        onPressed: () async {
                          if (await SkillService.addSkill(key, item.text)) {
                            // ignore: use_build_context_synchronously
                            toast(context, "Added");
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            fetchData();
                          } else {
                            // ignore: use_build_context_synchronously
                            toast(context, "Try again");
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Save")),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
      icon: const Icon(Icons.add),
      style: ElevatedButton.styleFrom(minimumSize: const Size(40, 35)),
      label: const Text(
        "Add",
        style: TextStyle(fontSize: 12),
      ));
}
