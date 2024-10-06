# libcaesium_dart

A Flutter FFI plugin for [libcaesium](https://github.com/Lymphatus/libcaesium), a powerful image compression library written in Rust.

## About

libcaesium_dart provides Dart bindings for the libcaesium library, allowing Flutter developers to easily integrate high-performance image compression capabilities into their applications. This project uses [flutter_rust_bridge](https://github.com/fzyzcjy/flutter_rust_bridge) to generate the FFI bindings.

## Features

- Compress JPEG, PNG, and WebP images.
- Maintain image quality while reducing file size
- Cross-platform support (iOS, Android, Windows, macOS, Linux)
- Easy integration with Flutter projects

***Do note that it cannot convert image format. So if you input a JPEG image, you cannot output a WebP image.***

## Project Structure

- `rust/`: Contains the Rust source code for the FFI wrapper.
- `lib/`: Contains the Dart code that defines the API of the plugin.

## Getting Started

To use libcaesium_dart in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  libcaesium_dart: ^0.1.0  # Replace with the latest version
```

Then, import and use the library in your Dart code:

```dart
import 'package:libcaesium_dart/libcaesium_dart.dart';

// Use the library functions here
```

## Usage

Here's a basic example of how to use the libcaesium_dart plugin to compress an image:

```dart
import 'package:libcaesium_dart/libcaesium_dart.dart';

Future<void> compressImage() async {
  await compress(
    inputPath: 'path/to/input/image.jpg',
    outputPath: 'path/to/output/image.jpg',
    quality: 80,
    pngOptimizationLevel: 3,
    keepMetadata: true,
    optimize: true,
  );
}
```

For more detailed usage examples, please refer to the `example` folder in the repository.

## Building and Bundling Native Code

This project is configured as an FFI plugin. The native build systems are automatically invoked for the target platforms when building your Flutter application.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

This project is based on [libcaesium](https://github.com/Lymphatus/libcaesium), created by Lymphatus. We are grateful for their work on the core compression library.

For more information on Flutter development, check out the [online documentation](https://docs.flutter.dev), which offers tutorials, samples, and a full API reference.
