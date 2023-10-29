import 'package:contacts_app/services/crud_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(title: Text("Add Contact",  style: GoogleFonts.dancingScript(
            fontSize: 24,
            color: Colors.brown,
          ))),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Enter any name" : null,
                    controller: _nameController,
                    style: GoogleFonts.dancingScript(
                      fontSize: 16,
                      color: Colors.brown,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      labelStyle: GoogleFonts.dancingScript(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    controller: _phoneController,
                    style: GoogleFonts.dancingScript(
                      fontSize: 16,
                      color: Colors.brown,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Phone",
                      labelStyle: GoogleFonts.dancingScript(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    controller: _emailController,
                    style: GoogleFonts.dancingScript(
                      fontSize: 16,
                      color: Colors.brown,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      labelStyle: GoogleFonts.dancingScript(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        CRUDService().addNewContacts(
                            _nameController.text, _phoneController.text, _emailController.text);
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.brown),
                    ),
                    child: Text(
                      "Create",
                      style: GoogleFonts.dancingScript(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
