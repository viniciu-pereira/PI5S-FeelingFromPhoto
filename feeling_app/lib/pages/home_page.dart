import 'dart:io';

import 'package:feeling_app/components/custom_button_picker.dart';
import 'package:feeling_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _imageFile;

  Future<void> _pickImage(bool fromGallery) async {
    final pickedFile = await ImagePicker().pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
    );
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, __) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if(controller.responseOK && !controller.isLoading) {
            return const Center(child: Text('RESPOSTA DA API'));
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomButtonPicker(
                    text: 'Importar foto',
                    pick: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: SizedBox(
                            height: 120,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.grey,
                                      width: 50,
                                      height: 4,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    button(context, true, () => _pickImage(true)),
                                    button(context, false,() => _pickImage(false)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white,
                          duration: const Duration(seconds: 4),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  if (_imageFile != null) ...{
                    Image.file(
                      _imageFile!,
                      width: 350,
                      height: 350,
                    )
                  } else ...{
                    const Text('Nenhuma imagem selecionada'),
                  },
                  const Spacer(),
                  CustomButtonPicker(
                    text: 'Enviar',
                    pick: () async {
                      await controller.sendImageToApi();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget button(BuildContext context, bool isGallery, Function pick) {
    return GestureDetector(
      onTap: () {
        pick();
      },
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                isGallery ? Icons.file_copy : Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              isGallery ? 'Escolher da Galeria' : 'Tirar Foto',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
