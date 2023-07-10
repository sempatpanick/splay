import 'dart:async';
import 'dart:io';

import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:path/path.dart';

abstract class SplayFileDataSource {
  Future<List<FileSystemEntity>> getFilesFromDirectory({required String path});
  Future<List<Metadata>> getMetaDataList({required List<String> paths});
}

class SplayFileDataSourceImpl implements SplayFileDataSource {
  @override
  Future<List<FileSystemEntity>> getFilesFromDirectory({required String path}) async {
    final dir = Directory(path);
    var tempFiles = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: false);
    lister.listen(
      (file) => tempFiles.add(file),
      // should also register onError
      onDone: () => completer.complete(tempFiles),
    );
    final files = await completer.future;
    final searchMusic = files.where((item) => extension(item.path) == '.mp3').toList();
    return searchMusic;
  }

  @override
  Future<List<Metadata>> getMetaDataList({required List<String> paths}) async {
    List<Metadata> data = [];
    for (var item in paths) {
      final metadata = await MetadataRetriever.fromFile(File(item));
      data.add(metadata);
    }

    return data;
  }
}
