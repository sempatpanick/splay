import 'package:get_it/get_it.dart';

import 'common/utils.dart';
import 'data/datasources/db/database_helper.dart';
import 'data/datasources/db/database_helper_desktop.dart';
import 'data/datasources/splay_file_data_source.dart';
import 'data/datasources/splay_local_data_source.dart';
import 'data/repositories/splay_repository_impl.dart';
import 'domain/respositories/splay_repository.dart';
import 'domain/usecases/get_directory_saved_by_id_case.dart';
import 'domain/usecases/get_directory_saved_case.dart';
import 'domain/usecases/get_files_from_directory_case.dart';
import 'domain/usecases/get_meta_data_list_case.dart';
import 'domain/usecases/is_directory_saved_case.dart';
import 'domain/usecases/remove_directory_saved_case.dart';
import 'domain/usecases/save_directory_case.dart';

final locator = GetIt.instance;

void init() {
  // use case
  locator.registerLazySingleton(() => GetFilesFromDirectoryCase(repository: locator()));
  locator.registerLazySingleton(() => GetMetaDataListCase(repository: locator()));
  locator.registerLazySingleton(() => GetDirectorySavedCase(repository: locator()));
  locator.registerLazySingleton(() => GetDirectorySavedByIdCase(repository: locator()));
  locator.registerLazySingleton(() => IsDirectorySavedCase(repository: locator()));
  locator.registerLazySingleton(() => SaveDirectoryCase(repository: locator()));
  locator.registerLazySingleton(() => RemoveDirectorySavedCase(repository: locator()));

  // repository
  locator.registerLazySingleton<SplayRepository>(
    () => SplayRepositoryImpl(
      fileDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<SplayFileDataSource>(
    () => SplayFileDataSourceImpl(),
  );
  locator.registerLazySingleton<SplayLocalDataSource>(
    () => SplayLocalDataSourceImpl(
      databaseHelper: locator(),
      databaseHelperDesktop: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton(() => DatabaseHelper());
  locator.registerLazySingleton(() => DatabaseHelperDesktop());
  locator.registerLazySingleton(() => Utils());

  // external
}
