import 'layer_model.dart';

class LayerData{
  final layers = <LayerModel>[
    LayerModel(0, 'relu'),
    LayerModel(0, 'relu'),
    LayerModel(0, 'relu'),
    LayerModel(0, 'relu'),
    LayerModel(0, 'softmax'),
  ];
}