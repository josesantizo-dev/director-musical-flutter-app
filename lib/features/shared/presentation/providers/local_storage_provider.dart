import 'package:director_musical_app/features/shared/domain/adapters/local_storage_adapter.dart';
import 'package:director_musical_app/features/shared/infrastructure/adapters/local_storage_adapter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider<LocalStorageAdapter>((ref) {
  return LocalStorageImpl();
});
