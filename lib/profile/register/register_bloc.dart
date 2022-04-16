import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../storage/logged_user_data.dart';
import '../errors/failure_entity.dart';
import '../models/models.dart';
import '../profile_repository.dart';
import '../utils/facebook_auth.dart';
import 'event.dart';
import 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._registerRepository) : super(IsDataNotValidState()) {
    on((event, emit) async {
      if (event is NameChangedEvent) {
        fullname = event.value;
        isNameValid = event.isValid;
        isNameValid = event.value.isEmpty ? false : isNameValid;
      } else if (event is AcceptTerms) {
        isAccepted = event.isAccepted;
      } else if (event is EmailChangedEvent) {
        email = event.value;
        isEmailValid = event.isValid;
        isEmailValid = event.value.isEmpty ? false : isEmailValid;
      } else if (event is PasswordChangedEvent) {
        password = event.value;
        iSPasswordValid = event.isValid;
        iSPasswordValid = event.value.isEmpty ? false : iSPasswordValid;
      }
      if (event is GoogleSignInEvent) {
        String accessToken = await _googleSignInProcess();
        emit(LoadingState(true));
        Either<FailureEntity, LoginResponse> loginResponse =
            await _registerRepository
                .googleSignIn(GoogleSignInRequest(accessToken));
        emit(LoadingState(false));

        loginResponse.fold((l) => emit(RegisterFailed('error')), (r) {
          if (r.data != null && r.statusCode == 200) {
            LoggedUserData loggedUserData = LoggedUserData(
                r.data!.id,
                r.data!.email ?? '',
                r.data!.fullName ?? '',
                r.data!.phone ?? '',
                r.data!.profilePictureUrl ?? '',
                r.data!.description ?? '',
                r.data!.token ?? '',
                r.data!.refreshToken ?? '',
                r.data!.firstName ?? '',
                r.data!.lastName ?? '',
                r.data!.twitterUrl ?? '',
                r.data!.instagramUrl ?? '',
                r.data!.facebookUrl ?? '');
            loggedUserData.store(LoginType.google);
            emit(RegisterSuccessState());
          } else {
            emit(RegisterFailed(r.message));
            return;
          }
        });
      } else if (event is FacebookSignInEvent) {
        String? accessToken = await FacbookAuth().signInFB();
        if (accessToken != null) {
          emit(LoadingState(true));
          Either<FailureEntity, LoginResponse> loginResponse =
              await _registerRepository
                  .facebookSignIn(GoogleSignInRequest(accessToken));
          emit(LoadingState(false));

          loginResponse.fold((l) => emit(RegisterFailed('error')), (r) {
            if (r.data != null && r.statusCode == 200) {
              LoggedUserData loggedUserData = LoggedUserData(
                  r.data!.id,
                  r.data!.email ?? '',
                  r.data!.fullName ?? '',
                  r.data!.phone ?? '',
                  r.data!.profilePictureUrl ?? '',
                  r.data!.description ?? '',
                  r.data!.token ?? '',
                  r.data!.refreshToken ?? '',
                  r.data!.firstName ?? '',
                  r.data!.lastName ?? '',
                  r.data!.twitterUrl ?? '',
                  r.data!.instagramUrl ?? '',
                  r.data!.facebookUrl ?? '');
              loggedUserData.store(LoginType.google);
              emit(RegisterSuccessState());
            } else {
              emit(RegisterFailed(r.message));
              return;
            }
          });
        }
      } else if (event is SubmitEvent) {
        emit(LoadingState(true));
        var name = fullname.split(' ');
        Either<FailureEntity, RegisterResponse> registerResponse =
            await _registerRepository.register(RegisterRequest(name[0].trim(),
                name[1].trim(), email.trim(), email.trim(), password.trim()));
        emit(LoadingState(false));
        registerResponse.fold((l) => emit(RegisterFailed('error')), (r) {
          if (r.statusCode == 200) {
            emit(EmailRegisterSuccessState(email));
          } else {
            emit(RegisterFailed(r.message));
          }
        });
      }
      if (isEmailValid && iSPasswordValid && isAccepted && isNameValid) {
        emit(IsDataValidState());
      } else {
        emit(IsDataNotValidState());
      }
    });
  }

  final ProfileRepository _registerRepository;
  bool isEmailValid = false,
      iSPasswordValid = false,
      isAccepted = false,
      isNameValid = false;
  String email = '', password = '', fullname = '';

  Future<String> _googleSignInProcess() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    String? token = googleAuth?.idToken;
    return '${googleAuth?.accessToken}';
  }
}
