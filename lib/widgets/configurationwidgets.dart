import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:network_dash/helper/layer_data.dart';

import '../helper/dropped_files.dart';
import '../helper/fields.dart';

class ConfigMenu extends StatefulWidget {
  const ConfigMenu({super.key});

  @override
  State<ConfigMenu> createState() => _ConfigMenuState();
}

class _ConfigMenuState extends State<ConfigMenu> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InputSection(),
                  ),
                  Expanded(
                    flex: 2,
                    child: SettingSection(),
                  )
                ],
              ),
            ),
            Expanded(child: LayerSelection())
          ],
        ),
      ),
    );
  }
}

class DropZoneWidget extends StatefulWidget {
  final ValueChanged<DroppedFile> onDroppedFile;

  const DropZoneWidget({
    super.key,
    required this.onDroppedFile,
  });

  @override
  State<DropZoneWidget> createState() => _DropZoneWidgetState();
}

class _DropZoneWidgetState extends State<DropZoneWidget> {
  bool isHighlighted = false;
  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.black,
      dashPattern: const [6, 3],
      borderType: BorderType.Rect,
      radius: const Radius.circular(12),
      child: Container(
        height: 200,
        width: 250,
        color:
            isHighlighted ? const Color(0x11EBF0F7) : const Color(0x991e201e),
        child: Stack(
          children: [
            DropzoneView(
              onCreated: (DropzoneViewController ctrl) => controller = ctrl,
              onDrop: acceptFile,
              onHover: () => setState(() => isHighlighted = true),
              onLeave: () => setState(() => isHighlighted = false),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cloud_upload, size: 80, color: Colors.white),
                  const Text(
                    'Drop Files Here',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final events = await controller.pickFiles();
                      if (events.isEmpty) return;
                      acceptFile(events.first);
                    },
                    icon: const Icon(Icons.search, size: 32),
                    label: const Text('Choose Files',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    final name = await controller.getFilename(event);
    final bytes = await controller.getFileSize(event);
    final mime = await controller.getFileMIME(event);
    final url = await controller.createFileUrl(event);

    print('Dropped file: $name');
    print('Bytes: $bytes');
    print('Mime: $mime');
    print('Url: $url');

    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
    );

    widget.onDroppedFile(droppedFile);
  }
}

class InputSection extends StatefulWidget {
  const InputSection({super.key});

  @override
  State<InputSection> createState() => _InputSectionState();
}

class _InputSectionState extends State<InputSection> {
  late DroppedFile file;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flexible(
          fit: FlexFit.loose,
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0x991e201e),
                borderRadius: BorderRadius.circular(20)),
            height: 400,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                  child: Text("Input data",
                      style: TextStyle(color: Color(0xffECDFCC), fontSize: 32)),
                ),
                DropZoneWidget(
                  onDroppedFile: (file) => setState(() {
                    this.file = file;
                  }),
                ),
              ],
            ),
          )),
    );
  }
}

class SettingSection extends StatefulWidget {
  const SettingSection({super.key});

  @override
  State<SettingSection> createState() => _SettingSectionState();
}

class _SettingSectionState extends State<SettingSection> {
  // Variables to hold the values from TextFields and Dropdowns
  String dropout = '';
  String epochs = '';
  String batchSize = '';
  String testPercentage = '';
  String learningRate = '';
  String modelType = 'Linear';

  void onConfirm() {
    // Here you can process the values returned from the custom widgets
    print('Dropout: $dropout');
    print('Epochs: $epochs');
    print('Batch Size: $batchSize');
    print('Test Percentage: $testPercentage');
    print('Learning Rate: $learningRate');
    print('Model Type: $modelType');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0x991e201e),
            borderRadius: BorderRadius.circular(20)),
        height: 400,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
              child: Text("Tuning",
                  style: TextStyle(color: Color(0xffECDFCC), fontSize: 32)),
            ),
            // Custom TextField and Dropdown widgets
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: CustomTextField(
                    labelText: "Dropout %",
                    onChanged: (value) {
                      setState(() {
                        dropout = value;
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CustomTextField(
                    labelText: "Epochs",
                    onChanged: (value) {
                      setState(() {
                        epochs = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: CustomTextField(
                    labelText: "Batch Size",
                    onChanged: (value) {
                      setState(() {
                        batchSize = value;
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CustomTextField(
                    labelText: "Test %",
                    onChanged: (value) {
                      setState(() {
                        testPercentage = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: CustomTextField(
                    labelText: "Learning Rate",
                    onChanged: (value) {
                      setState(() {
                        learningRate = value;
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CustomDropdown(
                    options: const [
                      "Linear",
                      "Binary Classification",
                      "Multi Classification"
                    ],
                    onChanged: (String? option) {
                      setState(() {
                        if (option != null) {
                          modelType = option;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: onConfirm,
                child: const Text("Confirm"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LayerSelection extends StatefulWidget {
  const LayerSelection({super.key});

  @override
  State<LayerSelection> createState() => _LayerSelectionState();
}

class _LayerSelectionState extends State<LayerSelection> {
  final data = LayerData();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0x991e201e),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 400,  // Set a fixed height for the container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,  // Center the title horizontally
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Layer Configuration",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.layers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildMenuEntry(data, index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuEntry(LayerData data, int index) {
  bool isFirst = index == 0;
  bool isLast = index == data.layers.length - 1;
  String label = 'Layer $index';

  if (isFirst) {
    label = 'Input Layer';
  } else if (isLast) {
    label = 'Output Layer';
  }

  List<String> options = ['relu', 'leakyRelu', 'sigmoid', 'softmax'];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,  // Center the elements horizontally
    children: [
      SizedBox(
      height: 50,
      ),
      // Add a SizedBox to control width for the TextField
      SizedBox(
        width: 150,  // Adjust width as per your requirement
        child: CustomTextField(
          labelText: label,
          onChanged: (event) {
            // Handle text field change
          },
        ),
      ),
      const SizedBox(height: 8),  // Add some spacing between the widgets
      SizedBox(
        width: 150,  // Ensure Dropdown gets enough width
        child: CustomDropdown(
          options: options,
          onChanged: (event) {
            // Handle dropdown change
          },
        ),
      ),
    ],
  );
}