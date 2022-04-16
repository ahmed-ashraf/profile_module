import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';
import '../profile_repository.dart';
import 'state.dart';
import '../errors/failure_entity.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ProfileRepository _profileRepository;

  ForgetPasswordCubit(this.email, this._profileRepository) : super(InitState());

  String email = '';
  String code = '';
  String newPassword = '';

  void forgetPassword() async {
    emit(LoadingState());
    FocusManager.instance.primaryFocus?.unfocus();
    Either<FailureEntity, RegisterResponse> response =
        await _profileRepository.forgetPassword(ForgetPasswordRequest(email));
    response.fold((l) {
      emit(FailState('Error'));
    }, (r) {
      if (r.statusCode == 200) {
        emit(SuccessState(r.message));
      } else {
        emit(FailState(r.message));
      }
    });
  }

  void updatePassword() async {
    emit(LoadingState());
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      Either<FailureEntity, RegisterResponse> response = await _profileRepository.verifyForgetPassword(
          VerifyForgetPasswordRequest(email, code, newPassword));
      response.fold((l) => FailState('Error'), (r) {
        if (r.statusCode == 200) {
          emit(SuccessState(r.message));
        } else {
          emit(FailState(r.message));
        }
      });
    } catch (e) {}
  }
}
