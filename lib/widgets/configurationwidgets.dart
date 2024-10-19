import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:dotted_border/dotted_border.dart';

import '../helper/droppedfiles.dart';
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

class LayerData {
  int size;
  String activation;

  LayerData({required this.size, required this.activation});
}

class LayerSelection extends StatefulWidget {
  const LayerSelection({super.key});

  @override
  State<LayerSelection> createState() => _LayerSelectionState();
}

class _LayerSelectionState extends State<LayerSelection> {
  List<LayerData> layers = [
    LayerData(size: 100, activation: 'relu'),
    LayerData(size: 32, activation: 'relu'),
    LayerData(size: 20, activation: 'relu')
  ];

  void addLayer() {
    setState(() {
      layers.add(LayerData(size: 10, activation: 'relu'));
    });
  }

  void removeLayer(int index) {
    setState(() {
      layers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Flexible(
        fit: FlexFit.loose,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x991e201e),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                child: Center(
                  child: const Text(
                    "Tuning",
                    style: TextStyle(
                      color: Color(0xffECDFCC),
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: layers.length,
                  itemBuilder: (context, index) {
                    String layerLabel;

                    if (index == 0) {
                      layerLabel = 'Input';
                    } else if (index == layers.length - 1) {
                      layerLabel = 'Output';
                    } else {
                      layerLabel = 'Layer ${index}';
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  layers[index].size =
                                      int.tryParse(value) ?? 10;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: layerLabel == 'Output'
                                    ? 'Output size'
                                    : 'Layer size',
                                labelText: layerLabel,
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        if (layerLabel != 'Input')
                          DropdownButton<String>(
                            value: layers[index].activation,
                            items:
                                ['relu', 'sigmoid', 'tanh'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                layers[index].activation = newValue ?? 'relu';
                              });
                            },
                          ),
                        if (layerLabel != 'Input')
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => removeLayer(index),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: addLayer,
                  child: Text('+ Add Layer'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Code to start training
                    print("Training started with layers: $layers");
                  },
                  child: Text('Train'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
