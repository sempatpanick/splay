import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/directory_saved_entity.dart';

part 'directory_saved_model.g.dart';

@JsonSerializable()
class DirectorySavedModel extends Equatable {
  final String id;
  final String path;

  const DirectorySavedModel({
    required this.id,
    required this.path,
  });

  factory DirectorySavedModel.fromJson(Map<String, dynamic> json) =>
      _$DirectorySavedModelFromJson(json);

  Map<String, dynamic> toJson() => _$DirectorySavedModelToJson(this);

  DirectorySavedEntity toEntity() => DirectorySavedEntity(
        id: id,
        path: path,
      );

  @override
  List<Object?> get props => [
        id,
        path,
      ];
}
