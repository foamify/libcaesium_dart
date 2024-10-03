import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:libcaesium_dart/libcaesium_dart.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final XFile? file = await openFile(acceptedTypeGroups: [
                const XTypeGroup(
                  label: 'Image',
                  extensions: ['png', 'jpg', 'jpeg', 'webp', 'tiff'],
                ),
              ]);
              if (file == null) {
                print('No file selected');
                return;
              }
              print('Starting image compression process');
              final startTime = DateTime.now();
              print('File selected: ${file.path}');
              final inputSize = await File(file.path).length();
              print('Input file size: $inputSize bytes');
              var outputPath = file.path;
              final tempDir =
                  await Directory.systemTemp.createTemp('image_compression');
              final extension = file.path.split('.').last;
              final fileName =
                  '${DateTime.now().millisecondsSinceEpoch}.$extension';
              outputPath = '${tempDir.path}${Platform.pathSeparator}$fileName';
              print('Temporary output path: $outputPath');
              try {
                print('Compressing image...');
                await compress(
                  inputPath: file.path,
                  outputPath: outputPath,
                  quality: 80,
                  pngOptimizationLevel: 3,
                  keepMetadata: true,
                  // optimize: !file.path.endsWith('.webp'),
                  optimize: false, // faster and better for png as well??
                );
                final endTime = DateTime.now();
                final duration = endTime.difference(startTime);
                final outputSize = await File(outputPath).length();
                print('Image compressed successfully: $outputPath');
                print('Compression time: ${duration.inMilliseconds} ms');
                print('Output file size: $outputSize bytes');
                print(
                    'Size reduction: ${(inputSize - outputSize) / inputSize * 100}%');
                await Process.run('open', ['-R', outputPath]);
              } catch (e) {
                print('Error during compression: $e');
              }
            },
            child: const Text('Compress Image'),
          ),
        ),
      ),
    );
  }
}
