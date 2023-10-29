import 'package:contacts_app/services/crud_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact(
      {Key? key,
      required this.docID,
      required this.name,
      required this.phone,
      required this.email});
  final String docID, name, phone, email;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    _nameController.text = widget.name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // Set the background color to peach
      appBar: AppBar(title: Text("Update Contact",  style: GoogleFonts.dancingScript(
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
                        CRUDService().updateContact(
                            _nameController.text,
                            _phoneController.text,
                            _emailController.text,
                            widget.docID);
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.brown),
                    ),
                    child: Text(
                      "Update",
                      style: GoogleFonts.dancingScript(
                        fontSize: 16,
                        color: Colors.white,
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
                  child: OutlinedButton(
                    onPressed: () {
                      CRUDService().deleteContact(widget.docID);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 160, 116, 100)),
                    ),
                    child: Text(
                      "Delete",
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
