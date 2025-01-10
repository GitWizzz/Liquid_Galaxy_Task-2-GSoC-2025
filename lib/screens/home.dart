import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/ssh.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liquid Galaxy App'),
      ),
      body: Column(
        children: [
          // Liquid Galaxy Logo
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset('assets/images/lg_logo.png', height: 100),
                const Text(
                  'liquid galaxy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Buttons Layout
          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                customButton(
                  text: 'Lg Logo',
                  onPressed: () async {
                    try {
                      String logoKml =
                      await rootBundle.loadString('assets/kmls/lg_logo.kml');
                      await LGCommands.execCommand(
                        "echo '$logoKml' > /var/www/html/kml/slave_3.kml",
                      );
                      print('Logo displayed successfully.');
                    } catch (e) {
                      print('Error displaying logo: $e');
                    }
                  },
                ),
                customButton(
                  text: 'Mount-Everest',
                  onPressed: () async {
                    try {
                      String content =
                      await rootBundle.loadString('assets/kmls/kml_1.kml');
                      await LGCommands.sendFile(
                          '/var/www/html/Kml_1.kml', content);
                      await LGCommands.execCommand(
                          'echo "http://lg1:81/kml_1.kml" > /var/www/html/kmls.txt');
                      await LGCommands.execCommand(
                          'echo "flytoview=<LookAt><longitude>86.91538060524995</longitude><latitude>27.98941572729132</latitude><altitude>3000</altitude><tilt>45</tilt><heading>0</heading><range>5000</range></LookAt>" > /tmp/query.txt');
                      print('Mount Everest KML displayed successfully.');
                    } catch (e) {
                      print('Error displaying Mount Everest KML: $e');
                    }
                  },
                ),
                customButton(
                  text: 'Patna',
                  onPressed: () async {
                    try {
                      String content =
                      await rootBundle.loadString('assets/kmls/kml_2.kml');
                      await LGCommands.sendFile(
                          '/var/www/html/kml_2.kml', content);
                      await LGCommands.execCommand(
                          'echo "http://lg1:81/kml_2.kml" > /var/www/html/kmls.txt');
                      await LGCommands.execCommand(
                          'echo "flytoview=<LookAt><longitude>85.1376</longitude><latitude>25.5941</latitude><altitude>3000</altitude><tilt>45</tilt><heading>0</heading><range>4000</range></LookAt>" > /tmp/query.txt');
                      print('KML sent successfully.');
                    } catch (e) {
                      print('Error sending KML: $e');
                    }
                  },
                ),
                customButton(
                  text: 'Clean KML',
                  onPressed: () async {
                    try {
                      String removeKml =
                      await rootBundle.loadString('assets/kmls/lg_remove.kml');
                      await LGCommands.sendFile(
                          '/var/www/html/lg_remove.kml', removeKml);
                      await LGCommands.execCommand(
                          'echo "http://lg1:81/lg_remove.kml" > /var/www/html/kmls.txt');
                      await LGCommands.execCommand('echo "" > /tmp/query.txt');
                      print('KML removed successfully.');
                    } catch (e) {
                      print('Error removing KML: $e');
                    }
                  },
                ),
                customButton(
                  text: 'Clean Logo',
                  onPressed: () async {
                    try {
                      String emptyKml =
                      await rootBundle.loadString('assets/kmls/lg_remove.kml');
                      await LGCommands.execCommand(
                        "echo '$emptyKml' > /var/www/html/kml/slave_3.kml",
                      );
                      print('Logo removed successfully.');
                    } catch (e) {
                      print('Error removing logo: $e');
                    }
                  },
                ),
              ],
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }

  Widget customButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
