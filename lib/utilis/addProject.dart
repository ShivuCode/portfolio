import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:velocity_x/velocity_x.dart';

import '../components/project_detail.dart';
import '../model/projectModel.dart';

class AddProject extends StatefulWidget {
  const AddProject({
    super.key,
    required this.projectName,
    required this.description,
    required this.url,
    required this.giturl,
  });

  final String projectName;
  final String description;
  final String url;
  final String giturl;
  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProjectDetails(
                      project: Project(
                          title: widget.projectName,
                          description: widget.description,
                          url: widget.url,
                          giturl: widget.giturl),
                    )));
      },
      onHover: (value) => setState(() {
        isHovering = value;
      }),
      child: AnimatedContainer(
        alignment: Alignment.bottomLeft,
        duration: const Duration(milliseconds: 300),
        width: context.screenWidth < 600
            ? context.screenWidth * 0.9
            : context.screenWidth < 1000
                ? (context.screenWidth * 0.89) / 2
                : (context.screenWidth * 0.89) / 3,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(
              widget.url,
            ),
            fit: BoxFit.cover,
            colorFilter: isHovering
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.srcOver,
                  )
                : null,
          ),
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: isHovering ? 1.0 : 0.8,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.black54),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        widget.projectName,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )),
                      IconButton(
                        onPressed: () {
                          _showPopupMenu(context);
                        },
                        iconSize: 15,
                        icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                        color: Colors.white,
                      )
                    ],
                  ),
                  Text(
                    widget.description,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + button.size.width, // Adjust the position as needed
        offset.dy,
        offset.dx + button.size.width + 10, // Adjust the position as needed
        offset.dy + button.size.height,
      ),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(
              Icons.delete,
            ),
            title: const Text(
              'Delete',
            ),
            onTap: () async {
              // if (await DbHelper.deleteProject(widget.id)) {
              //   toast(context, "Deleted");
              // } else {
              //   toast(context, "Try again");
              // }
              Navigator.pop(context); // Close the menu
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(
              Icons.info,
            ),
            title: const Text(
              'More Info',
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProjectDetails(
                            project: Project(
                                title: widget.projectName,
                                description: widget.description,
                                url: widget.url,
                                giturl: widget.giturl),
                          )));
            },
          ),
        ),
      ],
    );
  }
}
