import '../respositories/splay_repository.dart';

class IsDirectorySavedCase {
  final SplayRepository repository;

  IsDirectorySavedCase({required this.repository});

  Future<bool> execute({required String id}) =>
      repository.isAddedToSavedDirectory(id: id);
}
