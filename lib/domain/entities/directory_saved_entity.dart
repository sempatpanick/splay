import 'package:equatable/equatable.dart';

import '../../data/models/directory_saved_model.dart';

class DirectorySavedEntity extends Equatable {
  final String id;
  final String path;

  const DirectorySavedEntity({required this.id, required this.path});

  DirectorySavedModel toModel() => DirectorySavedModel(id: id, path: path);

  @override
  List<Object?> get props => [id, path];
}
