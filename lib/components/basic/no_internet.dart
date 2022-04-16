import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../storage/theme_colors.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 80,
                height: 80,
                child: SvgPicture.asset('assets/cloud_off.svg',
                    color: ThemeColors.primaryColorMid)),
            const SizedBox(
              height: 30,
            ),
            Text(AppLocalizations.of(context)!.no_internet_connection),
          ],
        ),
      ),
    );
  }
}
