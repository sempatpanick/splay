import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../../../controllers/settings_controller.dart';

class SettingsPageWeb extends StatelessWidget {
  const SettingsPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GetX<SettingsController>(
      builder: (controller) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Directory",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.addNewDirectory,
                    tooltip: "Add Folder",
                    color: theme.primaryColor,
                    icon: const Icon(
                      CupertinoIcons.folder_badge_plus,
                    ),
                  ),
                ],
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.directories.length,
                itemBuilder: (context, index) {
                  final item = controller.directories[index];

                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item.path,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => controller.removeDirectorySaved(directory: item),
                      color: colorRed,
                      tooltip: "Remove",
                      icon: const Icon(Icons.delete_outline),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
