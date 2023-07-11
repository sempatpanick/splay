import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class FileMetaDataEntity extends Equatable {
  final String title;
  final FileSystemEntity file;
  final Metadata metaData;

  const FileMetaDataEntity({
    required this.title,
    required this.file,
    required this.metaData,
  });

  @override
  List<Object?> get props => [
        title,
        file,
        metaData,
      ];
}
