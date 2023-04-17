import 'package:get/get.dart';

class FaqController extends GetxController {
  List<bool> selected = List.generate(5, (index) => false);
  onchange(index) {
    for (int i = 0; i < selected.length; i++) {
      if (i == index) {
        if (selected[i]) {
          selected[i] = false;
        } else {
          selected[i] = true;
        }
      } else {
        selected[i] = false;
      }
      update(['faq']);
    }
  }

  List data = [
    {
      'title':
          "How is Indeed different from other places where I can post jobs?",
      "description":
          'With our job search engine, job seekers get access to millions of jobs from all over the Web and employers reach relevant talent for every type of position. And you have complete flexibility – there are no contracts or long-term commitments.'
    },
    {
      'title': "Will my jobs appear in mobile search results?",
      "description":
          'All organic, or “free”, jobs on Findzilla are included in mobile search results to reach mobile job seekers. With Findzilla Apply, mobile job seekers can apply directly to jobs from tablets and mobile devices using an Findzilla Resume.'
    },
    {
      'title': "What is Indeed Apply?",
      "description":
          'Findzilla Apply offers a seamless application experience so candidates can easily apply to jobs straight from mobile devices. Job seekers can apply instantly from desktop and mobile with an Findzilla Resume, which is sent to your ATS or to you via email if you posted your job directly on Findzilla.'
    },
    {
      'title': "How do I apply for a position?",
      "description":
          'Visit our Applicants page and view our current open positions. After reviewing the requirements, if your skills meet the specific requirements for one or more positions, please click “Apply for this Job” and complete all fields on the application. If no position meets your current interest, you can Submit Resume to us for future consideration.'
    },
    {
      'title': "Can we meet in person?",
      "description":
          'It is normally not required to meet in person as part of Findzilla process. We often utilize phone and video interviewing as needed for the search.'
    },
  ];
}
