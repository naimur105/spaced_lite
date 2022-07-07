import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/ui/smart_widgets/projects/projects_viewmodel.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: model.projects.length,
              itemBuilder: (context, index) => Card(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(64, 75, 96, .9)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        title: Text(
                          model.projects[index].projectCode,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                        subtitle: Text(model.projects[index].projectCode,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                        trailing: Switch(
                            value: model.projects[index].isActive,
                            onChanged: (bool newValue) {
                              model.toggleProjectActivity(
                                  model.projects[index], newValue);
                            }),
                      ),
                    ),
                  )),
      viewModelBuilder: () => ProjectsViewModel(),
    );
  }
}
