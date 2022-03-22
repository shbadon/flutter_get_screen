import 'dart:io' show Directory, File, stdin, stdout;
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

void main(List<String> arguments) async {
  print(
      'Welcome to Flutter Get Screen Program. This program creates a screen in your existing directory pattern. This program was created by "Shuoib Hossain Badon"');

  await createScreen();

  while (true) {
    stdout.write('\nDo you create another screen? (y/N) :');
    String _createAnotherFile = stdin.readLineSync().toString();
    if (_createAnotherFile == 'y' || _createAnotherFile == 'N') {
      if (_createAnotherFile == 'y') {
        await createScreen();
      } else {
        break;
      }
    }
  }
  print('\nProgram Finished.');
}

Future<void> createScreen() async {
  stdout.write('Enter your file name :');
  String _fileName = stdin.readLineSync().toString();
  while (_fileName.isEmpty) {
    stdout.write('Please enter your file name:');
    _fileName = stdin.readLineSync().toString();
    if (_fileName.isNotEmpty) {
      break;
    }
  }
  _fileName = _fileName.toLowerCase();
  final package = path.current.split('/').last.split('\\').last;
  final info = await getInfo();
  final screenBody = await getScreenBody(_fileName, package, info);
  final controllerBody = await getControllerBody(_fileName, package, info);
  final modelBody = await getModelBody(_fileName, package, info);

  await createFile(
    _fileName,
    '${path.current}/lib/views/screens/$_fileName/${_fileName}_screen.dart',
    screenBody,
  );
  await createDirectory(
      '${path.current}/lib/views/screens/$_fileName/components');

  await createFile(
    _fileName,
    '${path.current}/lib/models/${_fileName}_screen_model.dart',
    modelBody,
  );

  await createFile(
    _fileName,
    '${path.current}/lib/controllers/${_fileName}_screen_controller.dart',
    controllerBody,
  );
}

Future<void> createFile(String name, String path, String body) async {
  try {
    final File file = await File(path).create(recursive: true);

    await file.writeAsString(body);
    print('${name.titleCase} file create... \u2713');
  } catch (error) {
    print('${name.titleCase} file create... \u2713 :  Error:- $error');
  }
}

Future<void> createDirectory(String path) async {
  try {
    await Directory(path).create(recursive: true);
    print('Components Directory create... \u2713');
  } catch (error) {
    print('Components Directory create... \u2713 :  Error:- $error');
  }
}

Future<String> getScreenBody(String name, String package, String info) async {
  return '''
  $info
  
import 'package:$package/$package.dart';
  
class ${name.pascalCase}Screen extends StatelessWidget {
  const ${name.pascalCase}Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

  ''';
}

Future<String> getControllerBody(
    String name, String package, String info) async {
  return '''
  $info 
  
// import 'package:$package/$package.dart';
  
class ${name.pascalCase}ScreenController {

}
  ''';
}

Future<String> getModelBody(String name, String package, String info) async {
  return '''
  $info 
  
// import 'package:$package/$package.dart';
  
class ${name.pascalCase}ScreenModel {

}
  ''';
}

Future<String> getInfo() async {
  final time = DateFormat('MMM dd, yyyy').add_jm().format(DateTime.now());
  return '''
  
/*                                     *\\
          **File Created By**
      name:- Shuoib Hossain 
      time:- $time
      contract:-shuibe873@gmail.com
\\*                                     */
''';
}

// dart compile exe bin/flutter_get_screen.dart && dart compile aot-snapshot bin/flutter_get_screen.dart
