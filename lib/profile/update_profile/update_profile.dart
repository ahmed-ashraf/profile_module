import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_module/profile/update_profile/update_profile_bloc.dart';
import 'package:provider/provider.dart';

import '../../components/basic/dialoges.dart';
import '../../components/basic/loading_indicator.dart';
import '../../components/basic/rounded_button.dart';
import '../../components/basic/rounded_input_field.dart';
import '../../storage/logged_user_data.dart';
import '../../storage/user_data_notifier.dart';
import '../profile_repository.dart';
import 'state.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  late Future<XFile?> _profileImageFile;
  XFile? _profileImageFileRes;


  @override
  Widget build(BuildContext mainContext) {
    double maxWidth = 500;
    Size size = MediaQuery.of(mainContext).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(mainContext)!.edit),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: BlocProvider<UpdateProfileCubit>(
          create: (context) => UpdateProfileCubit(ProfileRepository()),
          child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
            listener: (context, state) {
              if (state is SuccessState) {
                showInfoDialog(
                    context, '', AppLocalizations.of(context)!.success,
                    onPress: () {
                  Navigator.pop(context);
                });
                Provider.of<UserDataNotifier>(mainContext, listen: false)
                    .loggedUserData = LoggedUserData.get()!;
              }

              if (state is FailState) {
                if (state.msg.isEmpty) {
                  showErrorInFlushBar(
                      context,
                      AppLocalizations.of(context)!.error,
                      AppLocalizations.of(context)!.operation_failed);
                } else {
                  showErrorInFlushBar(context,
                      AppLocalizations.of(context)!.error, state.msg);
                }
              }
            },
            builder: (context, state) {
              bool isLoading = false;
              if (state is LoadingState) {
                isLoading = state.isLoading;
              }
              RoundedButton submitBtn = RoundedButton(
                text: AppLocalizations.of(context)!.save,
                press: () {
                  context.read<UpdateProfileCubit>().update();
                },
              );
              if (state is IsDataNotValidState) {
                submitBtn = RoundedButton(
                  text: AppLocalizations.of(context)!.save,
                  color: Colors.black38,
                );
              }
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 100,
                          child: Stack(
                            children: [
                              ClipOval(
                                child: _profileImageFileRes == null
                                    ? Image.network(
                                  context.read<UpdateProfileCubit>().profileImg,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                )
                                    : Image.file(
                                  File(_profileImageFileRes!.path),
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: const ShapeDecoration(
                                    color: Colors.grey,
                                    shape: CircleBorder(),
                                  ),
                                  child: IconButton(
                                    color: Colors.black,
                                    iconSize: 20,
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _profileImageFile =
                                          ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 25);
                                      _profileImageFile.then((value) {
                                        setState(() {
                                          _profileImageFileRes = value;
                                          context.read<UpdateProfileCubit>().profileImageFileRes = _profileImageFileRes;
                                        });
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          width: size.width * 0.9,
                          child: RoundedInputField(
                            text:
                                '${context.read<UpdateProfileCubit>().firstname} ${context.read<UpdateProfileCubit>().lastname}',
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!.full_name,
                            onChanged: (value) {
                              context.read<UpdateProfileCubit>().fullName =
                                  value;
                            },
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          width: size.width * 0.9,
                          child: RoundedInputField(
                            text: context.read<UpdateProfileCubit>().email,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!.email,
                            onChanged: (value) {
                              context.read<UpdateProfileCubit>().email = value;
                            },
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          width: size.width * 0.9,
                          child: RoundedInputField(
                            text: context.read<UpdateProfileCubit>().phone,
                            keyboardType: TextInputType.phone,
                            hintText: AppLocalizations.of(context)!.mobile,
                            onChanged: (value) {
                              context.read<UpdateProfileCubit>().phone = value;
                            },
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          width: size.width * 0.9,
                          child: RoundedInputField(
                            text:
                                context.read<UpdateProfileCubit>().description,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!.description,
                            onChanged: (value) {
                              context.read<UpdateProfileCubit>().description =
                                  value;
                            },
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          width: size.width * 0.9,
                          child: RoundedInputField(
                            text: context.read<UpdateProfileCubit>().facebook,
                            keyboardType: TextInputType.url,
                            hintText: AppLocalizations.of(context)!.facebook,
                            onChanged: (value) {
                              context.read<UpdateProfileCubit>().facebook =
                                  value;
                            },
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          width: size.width * 0.9,
                          child: RoundedInputField(
                            text: context.read<UpdateProfileCubit>().twitter,
                            keyboardType: TextInputType.url,
                            hintText: AppLocalizations.of(context)!.twitter,
                            onChanged: (value) {
                              context.read<UpdateProfileCubit>().twitter =
                                  value;
                            },
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          width: size.width * 0.9,
                          child: RoundedInputField(
                            text: context.read<UpdateProfileCubit>().instagram,
                            keyboardType: TextInputType.url,
                            hintText: AppLocalizations.of(context)!.instagram,
                            onChanged: (value) {
                              context.read<UpdateProfileCubit>().instagram =
                                  value;
                            },
                          ),
                        ),
                        submitBtn
                      ],
                    ),
                  ),
                  isLoading
                      ? Container(
                    child: const Center(
                        child: SizedBox(child: LoadingIndicator())),
                    decoration:
                    const BoxDecoration(color: Color(0x4B575757)),
                  )
                      : Container(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
