import 'package:get_it/get_it.dart';

import 'common/utils.dart';
import 'data/datasources/splay_file_data_source.dart';
import 'data/repositories/splay_repository_impl.dart';
import 'domain/respositories/splay_repository.dart';
import 'domain/usecases/get_files_from_directory_case.dart';
import 'domain/usecases/get_meta_data_list_case.dart';

final locator = GetIt.instance;

void init() {
  // use case
  locator.registerLazySingleton(() => GetFilesFromDirectoryCase(repository: locator()));
  locator.registerLazySingleton(() => GetMetaDataListCase(repository: locator()));

  // repository
  locator.registerLazySingleton<SplayRepository>(
    () => SplayRepositoryImpl(
      fileDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<SplayFileDataSource>(
    () => SplayFileDataSourceImpl(),
  );

  // helper
  locator.registerLazySingleton(() => Utils());

  // external
}
