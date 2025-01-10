import 'package:dartssh2/dartssh2.dart';
import 'dart:typed_data';

class LGCommands {
  static const String lgIp = '192.168.56.101';
  static const int lgPort = 22;
  static const String username = 'lg';
  static const String password = 'lg';


  static Future<void> execCommand(String command) async {
    try {
      final socket = await SSHSocket.connect(lgIp, lgPort);
      final client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );

      final result = await client.execute(command);
      print('Command output: $result');

      client.close();
    } catch (e) {
      print('Error executing command: $e');
    }
  }

  // Method to send a file
  static Future<void> sendFile(String path, String content) async {
    try {
      final socket = await SSHSocket.connect(lgIp, lgPort);
      final client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );

      final sftp = await client.sftp();
      final file = await sftp.open(path, mode: SftpFileOpenMode.create | SftpFileOpenMode.write);
      await file.write(Stream.value(Uint8List.fromList(content.codeUnits)));
      await file.close();
      print('File sent successfully to $path');

      client.close();
    } catch (e) {
      print('Error sending file: $e');
    }  }
}