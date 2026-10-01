import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velo_chat/shared/common/token_storage.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());
