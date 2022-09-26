import 'package:flutter/material.dart';
import 'package:kite/settings/ui/screens/delete_account_screen.dart';
import 'package:kite/shared/constants/textstyle.dart';
import 'package:kite/shared/ui/widgets/custom_app_bar.dart';
import 'package:kite/util/custom_navigation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../shared/constants/color_gradient.dart';
import 'activity_settings.dart';

class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({Key? key}) : super(key: key);

  @override
  State<PrivacySecurityPage> createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  bool isSwitched = false;
  bool isSwitchedt = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy and Security'),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: gradient1),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Who can see your activity?',
              style: blueText2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Last seen', style: text1),
                TextButton(
                    onPressed: () {
                      customNavigator(
                          context,
                          ActivitySettingsPage(
                              title: 'Last Seen & Online',
                              heading: 'last seen'));
                    },
                    child: const Text('Contacts'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile Photo', style: text1),
                TextButton(
                    onPressed: () {
                      customNavigator(
                          context,
                          ActivitySettingsPage(
                              title: 'Profile Photo',
                              heading: 'Profile Photo'));
                    },
                    child: const Text('Contacts'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bio', style: text1),
                TextButton(
                    onPressed: () {
                      customNavigator(context,
                          ActivitySettingsPage(title: 'Bio', heading: 'Bio'));
                    },
                    child: const Text('Contacts'))
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Two step Verification',
                  style: text1,
                ),
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                }),
            SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Live Location',
                  style: text1,
                ),
                value: isSwitchedt,
                onChanged: (value) {
                  setState(() {
                    isSwitchedt = value;
                    print(isSwitchedt);
                  });
                }),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, primary: Colors.black),
                onPressed: () {},
                child: Text(
                  'Blocked',
                  style: text1,
                )),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, primary: Colors.black),
                onPressed: () {
                  customNavigator(context, const DeleteAccountPage());
                },
                child: Text(
                  'Delete my account',
                  style: text1,
                )),
          ],
        ),
      ),
    );
  }
}
