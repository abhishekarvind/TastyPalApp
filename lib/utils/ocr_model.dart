// import 'package:google_ml_kit/google_ml_kit.dart';
//
// class ocr {
//   Future<String> recognizeText(String imagePath) async {
//     // Create a TextRecognizer instance
//     final recognizer = TextRecognizer();
//
//     // Recognize text from the image
//     final RecognizedText recognizedText =
//         await recognizer.processImage(InputImage.fromFilePath(imagePath));
//
//     // Extract the recognized text
//     String text = "";
//     for (TextBlock block in recognizedText.blocks) {
//       for (TextLine line in block.lines) {
//         for (TextElement element in line.elements) {
//           text += element.text + " ";
//         }
//       }
//     }
//
//     return text;
//   }
// }
