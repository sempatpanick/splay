import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import '../respositories/splay_repository.dart';

class GetMetaDataListCase {
  final SplayRepository repository;

  GetMetaDataListCase({required this.repository});

  Future<List<Metadata>> execute({required List<String> paths}) => repository.getMetaDataList(
        paths: paths,
      );
}
