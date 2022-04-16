import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../storage/logged_user_data.dart';
import '../errors/failure_entity.dart';
import '../models/models.dart';
import '../profile_repository.dart';
import 'state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  ProfileRepository _profileRepository;

  String _fullName = LoggedUserData.get()!.fullName;

  set fullName(String value) {
    _fullName = value;
    var name = _fullName.split(' ');
    firstname = name[0];
    lastname = name[1];
  }

  XFile? profileImageFileRes;

  String profileImg = LoggedUserData.get()!.profilePictureUrl;
  String firstname = LoggedUserData.get()!.firstName;
  String lastname = LoggedUserData.get()!.lastName;
  String email = LoggedUserData.get()!.email;
  String phone = LoggedUserData.get()!.phone;
  String description = LoggedUserData.get()!.description;
  String facebook = LoggedUserData.get()!.facebookUrl;
  String twitter = LoggedUserData.get()!.twitterUrl;
  String instagram = LoggedUserData.get()!.instagramUrl;

  UpdateProfileCubit(this._profileRepository) : super(InitState());

  void update() async {
    emit(LoadingState(true));

    Either<FailureEntity, RegisterResponse> response =
        await _profileRepository.updateProfile(
            UpdateProfileRequest(
                Firstname: firstname,
                Lastname: lastname,
                Phone: phone,
                Description: description,
                FbAccount: facebook,
                TwitterAccount: twitter,
                InstagramAccount: instagram),
            profileImageFileRes);
    emit(LoadingState(false));
    response.fold((l) => emit(FailState('')), (r) {
      if (r.statusCode == 200) {
        emit(SuccessState(r.message));
        LoggedUserData userData = LoggedUserData.get()!;
        userData.instagramUrl = instagram;
        userData.twitterUrl = twitter;
        userData.facebookUrl = facebook;
        userData.firstName = firstname;
        userData.lastName = lastname;
        userData.description = description;
        userData.email = email;
        userData.phone = phone;
        userData.update();
      } else {
        emit(FailState(r.message));
      }
    });
  }
}
