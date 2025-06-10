import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart'; // dependency to call/txt/email

// Function to make a phone call
void _makePhoneCall(String phoneNumber) async { // separate class for neatness
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(launchUri)) { // I looked this up ':D
    await launchUrl(launchUri);
  } else {
    print("Could not launch phone dialer.");// error feedback
  }
}

// Function to send an SMS
void _sendSMS(String phoneNumber) async {// separate class for neatness
  final Uri launchUri = Uri(scheme: 'sms', path: phoneNumber);
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    print("Could not launch SMS app.");// error feedback
  }
}

// Function to send an email
void _sendEmail(String emailAddress) async {// separate class for neatness
  final Uri launchUri = Uri(scheme: 'mailto', path: emailAddress);
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    print("Could not launch Email app.");// error feedback
  }
}



class ProfilePage extends StatefulWidget {
  final String loginName;
  ProfilePage({required this.loginName});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  // declares late vars
  late TextEditingController _controllerFName;
  late TextEditingController _controllerLName;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerName;

  @override
  void initState() {
    super
        .initState(); //slots in these actions into the parent's initial actions
    _controllerFName = TextEditingController();
    _controllerLName = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerName = TextEditingController();
    SharedPreferences.getInstance().then((prefs) {
      _controllerFName.text = prefs.getString("FirstName") ?? "";
      _controllerLName.text = prefs.getString("LastName") ?? "";
      _controllerPhone.text = prefs.getString("Phone") ?? "";
      _controllerEmail.text = prefs.getString("Email") ?? "";
    });
  }

  @override
  void dispose() {
    // cleans up resources
    _controllerFName.dispose();
    _controllerLName.dispose();
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    _controllerName.dispose();
    super.dispose();
  }

  void buttonClicked() {
    setState(() {
      //checks password, looked up .text
      SharedPreferences.getInstance().then((
          prefs) { //Saves profile details in shared preferences
        prefs.setString("FirstName", _controllerFName.text);
        prefs.setString("LastName", _controllerLName.text);
        prefs.setString("Phone", _controllerPhone.text);
        prefs.setString("Email", _controllerEmail.text);
        print("Saved Email: ${prefs.getString("Email")}"); //for testing
        prefs.setString("LoginName", _controllerName.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Back ${widget.loginName}')),
      body: Padding( // Wraps everything with a unified padding
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controllerFName,
              decoration: InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 10), // Spacing between fields
            TextField(
              controller: _controllerLName,
              decoration: InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controllerPhone,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Spacing
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    _makePhoneCall(_controllerPhone.text);
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.textsms),
                  onPressed: () {
                    _sendSMS(_controllerPhone.text);
                  },
                ),

              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.email),
                  onPressed: () {
                    _sendEmail(_controllerEmail.text);
                  },
                ),
              ],
            ),
            SizedBox(height: 20), // Space before the button
            ElevatedButton(
                onPressed: buttonClicked, child: Text("Save Profile")),
          ],
        ),
      ),
    );
  }
}
