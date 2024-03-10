import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/database/skillService.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class SkillRemove extends StatefulWidget {
  String listKey;
  SkillRemove({super.key, required this.listKey, required this.callback});
  final VoidCallback callback;
  @override
  State<SkillRemove> createState() => _SkillRemoveState();
}

class _SkillRemoveState extends State<SkillRemove> {
  List list = [];
  fetchData() async {
    List data = await SkillService.getSkills(widget.listKey);
    list = [];
    setState(() {
      list.addAll(data);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async {
          showDialog(
            barrierDismissible: false,
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
                    const Text(
                      "Your skills",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      runSpacing: 6,
                      spacing: 6,
                      children: List.generate(
                        list.length,
                        (index) => Builder(
                          builder: (context) => ElevatedButton.icon(
                            onPressed: () async {
                              if (await SkillService.removeSkill(
                                  widget.listKey, list[index])) {
                                fetchData();
                              } else {
                                // ignore: use_build_context_synchronously
                                toast(context, "Something went wrong");
                              }
                            },
                            icon: const Icon(FontAwesomeIcons.xmark),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 35),
                            ),
                            label: Text(
                              list[index],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          widget.callback();
                        },
                        child: const Text("Save"))
                  ]),
                ),
              ),
            ),
          );
        },
        icon: const Icon(
          FontAwesomeIcons.xmark,
          size: 20,
        ),
        style: ElevatedButton.styleFrom(minimumSize: const Size(40, 35)),
        label: const Text(
          "Remove",
          style: TextStyle(fontSize: 10),
        ));
  }
}
