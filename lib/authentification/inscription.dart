import 'dart:io';

import 'package:cabina/authentification/login.dart';
import 'package:cabina/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _imgUrl;
  final ImagePicker _picker = ImagePicker();
  late final XFile _profileImg;
  final _prenomController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _userName.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void clearForm() {
    _prenomController.clear();
    _emailController.clear();
    _userName.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _phoneController.clear();
    _usernameController.clear();
    setState(() {});
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage fs = FirebaseStorage.instance;

  Future<void> _uploadImg(File file) async {
    String fileUploadName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference ref = fs.ref().child('').child(fileUploadName);
    UploadTask uT = ref.putFile(file);
    uT.snapshotEvents.listen((event) {
      print('${event.bytesTransferred}\t${event.totalBytes}');
    });
    await uT.whenComplete(() async {
      var uploadPath = await uT.snapshot.ref.getDownloadURL();
      setState(() {
        _imgUrl = uploadPath;
      });
      saveUserToFirestore(); 
    });
  }

  void selectImage() async {
    final XFile? selected =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selected != null && selected.path.isNotEmpty) {
      setState(() {
        _profileImg = selected;
      });
      _uploadImg(File(_profileImg.path));
    }
  }

  void saveUserToFirestore() {
    final name = _userName.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final prenom = _prenomController.text;
    final username = _usernameController.text;

    Userx user = Userx(
      name: name,
      email: email,
      phone: phone,
      prenom: prenom,
      username: username,
      img: _imgUrl ?? '',
    );

    firestore.collection('user').add({
      'name': user.username,
      'email': user.email,
      'phone': user.phone,
      'prenom': user.prenom,
      'username': user.name,
      'img': user.img,
    }).then((value) {
      clearForm();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:const Icon(Icons.verified_user),
          content: const Text(
              'Inscription Terminer , retour a page login and connecter !.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }).catchError((error) {
      // Handle any errors that occurred while saving the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while saving the user.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    void easyOnPressedFunction() async {
      if (_formKey.currentState!.validate()) {
        try {
          final userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
          if (userCredential.user != null) {
            // User registered successfully
            selectImage();
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'Le mot de passe est trop faible. Veuillez choisir un mot de passe plus fort.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (e.code == 'email-already-in-use') {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content:
                    const Text('Un compte existe déjà avec cette adresse e-mail.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (e.code == '') {
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Vérifiez votre connexion !'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child:const Text('OK'),
                  ),
                ],
              ),
            );
          }
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  "Une erreur s'est produite lors de la création du compte."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text('Inscription'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //TODO u need to add circle avarat there and use it for selection profile img !!
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: _userName,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Saisir votre Nom utilisateur",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer un pseudo nom';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Saisir votre Nom  ",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer votre Nom';
                            } 
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: _prenomController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Saisir votre prenom  ",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer votre prenom';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Saisir votre adresse mail ",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer une adresse e-mail';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer un mot de passe';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          obscureText: true, // Set obscureText to true
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "créer votre mot de passe",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez confirmer le mot de passe';
                            } else if (value != _passwordController.text) {
                              return 'Les mots de passe ne correspondent pas';
                            }
                            return null;
                          },
                          controller: _confirmPasswordController,
                          obscureText: true, // Set obscureText to true
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Confirmer le mot de passe",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer un numéro de téléphone';
                            }
                            return null;
                          },
                          controller: _phoneController,
                          obscureText: false, 
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Numéro de téléphone",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CircleAvatar(
                              child: GestureDetector(
                                  onTap: selectImage,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: const Text(
                                      "Selecte Profile Image !",
                                      style: TextStyle(color: Colors.yellow),
                                    ),
                                  )))),

                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: easyOnPressedFunction,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                "Connecter",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])),
          ),
        ),
      ),
    );
  }
}
