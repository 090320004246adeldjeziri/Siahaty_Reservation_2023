import 'package:cabina/cabine_item.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<CabItem> _savedItems = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Liste de Favoirs '),
        ),
        body: _savedItems.isNotEmpty
            ? ListView.builder(
                itemCount: _savedItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_savedItems[index].title),
                  );
                },
              )
            : const Center(
                child: Text(
                  'Pas Encore',
                  style: TextStyle(fontFamily: "Poppins", fontSize: 22),
                ),
              ),
      ),
    );
  }
}
