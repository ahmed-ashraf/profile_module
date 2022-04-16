import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../storage/logged_user_data.dart';
import '../errors/failure_entity.dart';
import '../models/models.dart';
import '../profile_repository.dart';
import 'event.dart';
import 'state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final ProfileRepository _registerRepository;

  VerifyBloc(this._registerRepository) : super(VerifyState()) {
    on((event, emit) async {
      if (event is SubmitEvent) {
        emit(LoadingState(true));
        Either<FailureEntity, LoginResponse> loginResponse =
            await _registerRepository
                .verify(VerifyRequest(event.email, event.code));
        emit(LoadingState(false));

        loginResponse.fold((l) => emit(ErrorState('error')), (r) {
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
            loggedUserData.store(LoginType.normal);
            emit(VerifySuccessState());
          } else {
            emit(ErrorState(r.message));
            return;
          }
        });
      } else if (event is ResendEvent) {
        emit(LoadingState(true));
        Either<FailureEntity, RegisterResponse> loginResponse =
            await _registerRepository
                .resendCode(ResendVerifyRequest(event.email));
        emit(LoadingState(false));

        loginResponse.fold((l) => emit(ErrorState('error')), (r) {
          if (r.statusCode == 200) {
            emit(VerifyCodeResent(""));
          } else {
            emit(ErrorState(r.message));
            return;
          }
        });
      }
    });
  }
}
