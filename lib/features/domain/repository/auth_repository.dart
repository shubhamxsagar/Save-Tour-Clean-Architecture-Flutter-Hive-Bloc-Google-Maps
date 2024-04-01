import 'package:arpan/common/toast.dart';
import 'package:arpan/core/error/failures.dart';
import 'package:arpan/features/data/mobile_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';

enum RegisterResponse { success, failure, alreadyExists }

class AuthRepository {
  late Box<LockModel> _lock;
  Future<void> init() async {
    Hive.registerAdapter(LockModelAdapter());
    _lock = await Hive.openBox<LockModel>('lock_box');
  }

  Future<RegisterResponse> registerUser(final int code) async {
    final alreadyExists = _lock.values.any((element) => element.code == code);
    if (alreadyExists) {
      return RegisterResponse.alreadyExists;
    }
    try {
      _lock
          .add(LockModel(code))
          .whenComplete(() => showToast('Registered as $code'));
      return RegisterResponse.success;
    } on Exception catch (e) {
      return RegisterResponse.failure;
    }
  }

  // for authenticating/ login the user using the code...
  Future<int?> authenticate(final int code) async {
    final success = await _lock.values.any((element) => element.code == code);
    if (success) {
      showToast('Log-in as $code');
      return code;
    } else {
      return null;
    }
  }
}
