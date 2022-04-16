import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../components/basic/rounded_button.dart';
import '../../routes/routes.dart';
import '../../storage/theme_colors.dart';
import '../../storage/user_data_notifier.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserDataNotifier>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            ClipOval(
              child: Image.network(
                value.loggedUserData.profilePictureUrl,
                fit: BoxFit.cover,
                width: 90,
                height: 90,
                errorBuilder: (context, url, error) =>
                    Container(
                      width: 90,
                      height: 90,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.person_sharp,
                        size: 50,
                        color:
                        ThemeColors.primaryColorDark,
                      ),
                    ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '${value.loggedUserData.firstName} ${value.loggedUserData.lastName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              value.loggedUserData.email,
              style: const TextStyle(color: ThemeColors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 260,
              child: RoundedButton(
                text: AppLocalizations.of(context)!.update_profile,
                color: const Color(0xfff5f5f5),
                textColor: Colors.black87,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * 0.8 + 5,
              child: Row(
                children: [
                  SizedBox(
                      width: size.width * 0.8 * 0.3,
                      child: Column(
                        children: const [
                          Text(
                            "103",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Total products",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ThemeColors.grey),
                          ),
                        ],
                      )),
                  const SizedBox(
                      height: 50, child: VerticalDivider(color: Colors.grey)),
                  SizedBox(
                      width: size.width * 0.8 * 0.3,
                      child: Column(
                        children: const [
                          Text(
                            "103",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Followers",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ThemeColors.grey),
                          ),
                        ],
                      )),
                  const SizedBox(
                      height: 50, child: VerticalDivider(color: Colors.grey)),
                  SizedBox(
                      width: size.width * 0.8 * 0.3,
                      child: Column(
                        children: const [
                          Text(
                            "103",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Following",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ThemeColors.grey),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 3,
              color: Colors.black,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 15, bottom: 15),
                  child: Text(
                    value.loggedUserData.description,
                    style: TextStyle(color: ThemeColors.grey),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalizations.of(context)!.follow_me_on,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/twitter-with-circle.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/instagram-with-circle.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/vine-with-circle.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          "Posted audios",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      color: ThemeColors.primaryColorDark,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          "Playlists",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: Color(0x1C000000),
                    ),
                  ),
                ],
              ),
            ),
            RoundedButton(
              text: "upload product",
              press: () =>
                  Navigator.of(context).pushNamed(Routes.uploadMusic),
            )
          ],
        );
      },
    );
  }
}
