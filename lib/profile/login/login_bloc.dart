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

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._registerRepository) : super(IsDataNotValidState()) {
    on<EmailChangedEvent>((event, emit) {
      email = event.value;
      isEmailValid = event.isValid;
      isEmailValid = event.value.isEmpty ? false : isEmailValid;
      if (isEmailValid && password.isNotEmpty) {
        emit(IsDataValidState());
      } else {
        emit(IsDataNotValidState());
      }
    },);

    on<PasswordChangedEvent>((event, emit) {
      password = event.value;
      isPasswordValid = event.isValid;
      isPasswordValid = event.value.isEmpty ? false : isPasswordValid;
      if (isEmailValid && password.isNotEmpty) {
        emit(IsDataValidState());
      } else {
        emit(IsDataNotValidState());
      }
    },);

    on<GoogleSignInEvent>((event, emit) async {
      String accessToken = await _googleSignInProcess();
      emit(LoadingState(true));
      Either<FailureEntity, LoginResponse> loginResponse =
          await _registerRepository
          .googleSignIn(GoogleSignInRequest(accessToken));
      emit(LoadingState(false));

      loginResponse.fold((fail) {
        emit(LoginFailed('error'));
      }, (successResponse) {
        if (successResponse.data != null &&
            successResponse.statusCode == 200) {
          LoggedUserData loggedUserData = LoggedUserData(
              successResponse.data!.id,
              successResponse.data!.email ?? '',
              successResponse.data!.fullName ?? '',
              successResponse.data!.phone ?? '',
              successResponse.data!.profilePictureUrl ?? '',
              successResponse.data!.description ?? '',
              successResponse.data!.token ?? '',
              successResponse.data!.refreshToken ?? '',
              successResponse.data!.firstName ?? '',
              successResponse.data!.lastName ?? '',
              successResponse.data!.twitterUrl ?? '',
              successResponse.data!.instagramUrl ?? '',
              successResponse.data!.facebookUrl ?? '');
          loggedUserData.store(LoginType.normal);
          emit(LoginSuccessState());
        } else {
          emit(LoginFailed(successResponse.message));
          return;
        }
      });
    },);

    on<FacebookSignInEvent>((event, emit) async {
      String? accessToken = await FacbookAuth().signInFB();
      if (accessToken != null) {
        emit(LoadingState(true));
        Either<FailureEntity, LoginResponse> loginResponse =
            await _registerRepository
            .facebookSignIn(GoogleSignInRequest(accessToken));
        emit(LoadingState(false));

        loginResponse.fold((fail) {
          emit(LoginFailed('error'));
        }, (successResponse) {
          if (successResponse.data != null &&
              successResponse.statusCode == 200) {
            LoggedUserData loggedUserData = LoggedUserData(
                successResponse.data!.id,
                successResponse.data!.email ?? '',
                successResponse.data!.fullName ?? '',
                successResponse.data!.phone ?? '',
                successResponse.data!.profilePictureUrl ?? '',
                successResponse.data!.description ?? '',
                successResponse.data!.token ?? '',
                successResponse.data!.refreshToken ?? '',
                successResponse.data!.firstName ?? '',
                successResponse.data!.lastName ?? '',
                successResponse.data!.twitterUrl ?? '',
                successResponse.data!.instagramUrl ?? '',
                successResponse.data!.facebookUrl ?? '');
            loggedUserData.store(LoginType.normal);
            emit(LoginSuccessState());
          } else {
            emit(LoginFailed(successResponse.message));
            return;
          }
        });
      }
    },);

    on<SubmitEvent>((event, emit) async {
      emit(LoadingState(true));
      Either<FailureEntity, LoginResponse> loginResponse =
          await _registerRepository
          .login(LoginRequest(email.trim(), password.trim()));
      emit(LoadingState(false));

      loginResponse.fold((fail) {
        emit(LoginFailed('error'));
      }, (successResponse) {
        if (successResponse.data != null &&
            successResponse.statusCode == 200) {
          LoggedUserData loggedUserData = LoggedUserData(
              successResponse.data!.id,
              successResponse.data!.email ?? '',
              successResponse.data!.fullName ?? '',
              successResponse.data!.phone ?? '',
              successResponse.data!.profilePictureUrl ?? '',
              successResponse.data!.description ?? '',
              successResponse.data!.token ?? '',
              successResponse.data!.refreshToken ?? '',
              successResponse.data!.firstName ?? '',
              successResponse.data!.lastName ?? '',
              successResponse.data!.twitterUrl ?? '',
              successResponse.data!.instagramUrl ?? '',
              successResponse.data!.facebookUrl ?? '');
          loggedUserData.store(LoginType.normal);
          emit(LoginSuccessState());
        } else {
          emit(LoginFailed(successResponse.message));
          return;
        }
      });
    },);
  }

  final ProfileRepository _registerRepository;
  bool isEmailValid = false, isPasswordValid = false;
  String email = '', password = '';

  Future<String> _googleSignInProcess() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    String? token = googleAuth?.idToken;
    return '${googleAuth?.accessToken}';
  }
}
