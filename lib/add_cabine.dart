import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'admin/cab_req.dart';
import 'cabine_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CabineInfoPage extends StatefulWidget {
  const CabineInfoPage({super.key});

  @override
  _CabineInfoPageState createState() => _CabineInfoPageState();
}

class _CabineInfoPageState extends State<CabineInfoPage> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageList = []; // if u have problem update to no final
  List<String> imageUrlList = [];

  void selectImage() async {
    final XFile? selected =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selected != null && selected.path.isNotEmpty) {
      setState(() {
        _imageList.add(selected);
      });
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  void clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _placeController.clear();
    _numberController.clear();
    _imageList.clear();
    setState(() {});
  }

  ReqItemCab addCabine() {
    return ReqItemCab(
        title: _titleController.text,
        prix: _priceController.text,
        place: _placeController.text,
        imgUrl: [""],
        number: _numberController.text,
        description: _descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseStorage fs = FirebaseStorage.instance;

    _uploadImg(File file) async {
      String fileUploadName =
          DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
      Reference ref = fs.ref().child('').child(fileUploadName);
      UploadTask uT = ref.putFile(file);
      uT.snapshotEvents.listen((event) {
        print('${event.bytesTransferred}\t${event.totalBytes}');
      });
      await uT.whenComplete(() async {
        var uploadPath = await uT.snapshot.ref.getDownloadURL();
        imageUrlList.add(uploadPath);
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: const Text('Ajouter une cabine'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Informations de la cabine',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Titre de la cabine',
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description de la cabine',
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    hintText: 'Prix de la cabine',
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    hintText: 'Position de cabine',
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    hintText: 'Votre Numero ',
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Ajouter images de cabine',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _imageList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(File(_imageList[index].path));
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () => selectImage(),
                      tooltip: 'Choicer une image',
                      heroTag: 'imagePickerButton',
                      child: const Icon(Icons.add_a_photo),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        // Check if all fields are filled
                        if (_titleController.text.isEmpty ||
                            _descriptionController.text.isEmpty ||
                            _priceController.text.isEmpty ||
                            _placeController.text.isEmpty ||
                            _numberController.text.isEmpty ||
                            _imageList.isEmpty) {
                          Fluttertoast.showToast(
                            msg:
                                "Veuillez remplir tous les champs et ajouter une image",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        // Show a toast message indicating the request is sent
                        Fluttertoast.showToast(
                          msg: "Votre Demande est envoyée",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER_RIGHT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );

                        // Create a list of image URLs
                        imageUrlList.clear();

                        for (XFile imageFile in _imageList) {
                          File file = File(imageFile.path);
                          await _uploadImg(file);
                        }

                        // Create a ReqItemCab object
                        ReqItemCab cabine = ReqItemCab(
                          title: _titleController.text,
                          prix: _priceController.text,
                          place: _placeController.text,
                          imgUrl: imageUrlList,
                          number: _numberController.text,
                          description: _descriptionController.text,
                        );

                        try {
                          // Add the cabine data to Firestore
                          await firestore
                              .collection('cabinsreq')
                              .add(cabine.toJson());
                          // fetchDataFromFirestore();

                          // Clear the form fields and image list
                          clearForm();

                          // Show a success toast message
                          Fluttertoast.showToast(
                            msg: "La cabine a été envoyée à l'administrateur",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } catch (error) {
                          // Show an error toast message
                          Fluttertoast.showToast(
                            msg: "Une erreur s'est produite",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          print(error);
                        }
                      },
                      label: const Text('Envoyer la demande'),
                      icon: const Icon(Icons.send),
                      heroTag: 'sendButton',
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
