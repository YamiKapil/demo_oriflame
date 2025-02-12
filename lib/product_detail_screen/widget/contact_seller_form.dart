import 'package:demo_project/constants/color_constants.dart';
import 'package:demo_project/utils/notification_util.dart';
import 'package:demo_project/widgets/general_button.dart';
import 'package:flutter/material.dart';

class ContactSellerForm extends StatefulWidget {
  const ContactSellerForm({super.key});

  @override
  State<ContactSellerForm> createState() => _ContactSellerFormState();
}

class _ContactSellerFormState extends State<ContactSellerForm> {
  final TextEditingController message = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NotificationUtil _notificationUtil = NotificationUtil.instance;

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Message",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: message,
              decoration: InputDecoration(
                // labelText: "Message",
                // hintText: "Please enter your message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: ColorConstants.primaryColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Field cannot be empty";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: GeneralButton(
                buttonText: "Send",
                onPress: () async {
                  if (_formKey.currentState!.validate()) {
                    final bool isAllowed =
                        await _notificationUtil.checkingPermission(context);
                    if (isAllowed) {
                      final bool success =
                          await _notificationUtil.createLocalNotification();
                      if (success) {
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      }
                    } else {
                      _notificationUtil.awesomeNotifications
                          .requestPermissionToSendNotifications();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
