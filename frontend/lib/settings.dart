import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'navbar.dart';

class Settings extends StatelessWidget {
  String edition = "US & Canada";
  String version = "1.0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pushNamed("/homepage")),
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: NavBar(3),
        body: Container(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: 'Privacy',
                tiles: [
                  SettingsTile(
                    leading:
                        Icon(Icons.lock_outline, color: Colors.orangeAccent),
                    title: 'Change Password',
                    onTap: () {},
                  ),
                  SettingsTile(
                    leading: Icon(Icons.email, color: Colors.orangeAccent),
                    title: 'Change Email',
                    onTap: () {},
                  ),
                ],
              ),
              SettingsSection(
                title: 'About',
                tiles: [
                  SettingsTile(
                    title: 'Terms of Use',
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Data Policy',
                    onTap: () {},
                  ),
                  SettingsTile(
                    title: 'Edition',
                    subtitle: 'US & Canada',
                    enabled: false,
                    trailing: Icon(Icons.pin_drop),
                  ),
                  SettingsTile(
                    title: 'Version',
                    subtitle: '1.0',
                    enabled: false,
                    trailing: Icon(Icons.check),
                  )
                ],
              ),
              SettingsSection(
                title: '',
                tiles: [
                  SettingsTile(title: 'Log Out', trailing: Icon(Icons.logout))
                ],
              ),
            ],
          ),
        ));
  }
}
