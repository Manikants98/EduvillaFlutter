// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mkx/APIs/apis.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController profileUrlController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController zipcodeController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController cityController = TextEditingController();

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Update Profile",
                      style: TextStyle(fontSize: 30),
                    ),
                    Text("Ready to get started? Update Profile now!"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: profileUrlController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Profile URL',
                      labelText: "Profile Url"),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Name',
                      labelText: "Name"),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: dobController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Date Of Birth',
                      labelText: "DOB"),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: genderController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Gender',
                      labelText: "Gender"),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Phone Number',
                      labelText: "Phone"),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: zipcodeController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Zipcode',
                      labelText: "Zipcode"),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Country',
                      labelText: "Cuntry"),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your State',
                      labelText: "State"),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your City',
                      labelText: "City"),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var message = await updateProfile(
                          nameController.text,
                          genderController.text,
                          countryController.text,
                          cityController.text,
                          stateController.text,
                          phoneController.text,
                          profileUrlController.text,
                          zipcodeController.text,
                          dobController.text);
                      if (message.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profile Updated Succefully'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
