import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_constants.dart';
import '../../../../models/response/jobs/jobs_response.dart';
import '../../../../services/helpers/jobs_helper.dart';
import '../../../common/loader.dart';
import '../../../common/pages_loader.dart';
import '../../../common/styled_container.dart';
import '../../jobs/widgets/job_vertical_tile.dart';
import 'custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(kLight.value),
          automaticallyImplyLeading: false,
          title: ClipRRect(
            borderRadius: BorderRadius.circular(25.w),
            child: CustomField(
              controller: controller,
              onTap: () {
                setState(() {});
              },
            ),
          ),
        ),
        body: controller.text.isNotEmpty
            ? buildStyleContainer(
                context,
                SizedBox(
                  height: hieght * 0.23,
                  child: FutureBuilder<List<JobsResponse>>(
                    future: JobsHelper.searchJobs(controller.text),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const PageLoader();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.data!.isEmpty) {
                        return const Text('No Jobs Found');
                      } else {
                        final jobs = snapshot.data;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: jobs!.length,
                          itemBuilder: (context, index) {
                            var job = jobs[index];
                            return JobVerticalTile(
                              job: job,
                            );
                          },
                        );
                      }
                    }),
                  ),
                ),
              )
            : const NoSearchResults(text: 'Start Searching...'));
  }
}
