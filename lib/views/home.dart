// ignore_for_file: prefer_final_fields, prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/services/auth_services.dart';
import 'package:contacts_app/services/crud_services.dart';
import 'package:contacts_app/views/update_contact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Stream<QuerySnapshot> _stream;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    _stream = CRUDService().getContacts();
    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }



  // search Function to perform search
  searchContacts(String search) {
    _stream = CRUDService().getContacts(searchQuery: search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text(
          "Contacts",
          style: GoogleFonts.dancingScript(
            fontSize: 24,
            color: Colors.brown,
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: TextFormField(
                onChanged: (value) {
                  searchContacts(value);
                  setState(() {});
                },
                focusNode: _searchFocusNode,
                controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Search",
                  labelStyle: GoogleFonts.dancingScript(
                    fontSize: 16,
                    color: Colors.brown,
                  ),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            _searchFocusNode.unfocus();
                            _stream = CRUDService().getContacts();
                            setState(() {});
                          },
                          icon: Icon(Icons.close),
                        )
                      : null,
                ),
              ),
            ),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width * 8, 80),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add");
        },
        child: Icon(Icons.person_add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 32,
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email
                          .toString()[0]
                          .toUpperCase(),
                      style: GoogleFonts.dancingScript(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    style: GoogleFonts.dancingScript(
                      fontSize: 16,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                AuthService().logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Logged Out"),
                  ),
                );
                Navigator.pushReplacementNamed(context, "/login");
              },
              leading: Icon(Icons.logout_outlined),
              title: Text(
                "Logout",
                style: GoogleFonts.dancingScript(
                  fontSize: 16,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.pink[100], // Set the background color to peach
        child: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading"),
              );
            }
            return snapshot.data!.docs.length == 0
                ? Center(
                    child: Text("No Contacts Found ..."),
                  )
                : ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateContact(
                                  name: data["name"],
                                  phone: data["phone"],
                                  email: data["email"],
                                  docID: document.id,
                                ),
                              ),
                            ),
                            leading: CircleAvatar(
                              child: Text(
                                data["name"][0],
                                style: GoogleFonts.dancingScript(
                                  fontSize: 16,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                            title: Text(
                              data["name"],
                              style: GoogleFonts.dancingScript(
                                fontSize: 16,
                                color: Colors.brown,
                              ),
                            ),
                            subtitle: Text(
                              data["phone"],
                              style: GoogleFonts.dancingScript(
                                fontSize: 16,
                                color: Colors.brown,
                              ),
                            ),
                            trailing: Icon(Icons.call),
                             
                          );
                        })
                        .toList()
                        .cast(),
                  );
          },
        ),
      ),
    );
  }
}

