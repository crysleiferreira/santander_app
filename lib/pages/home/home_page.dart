import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:santander_app/models/user_model/user_model.dart';
import 'package:santander_app/services/api.dart';
import 'package:santander_app/shared/app_colors.dart';
import 'package:santander_app/shared/app_images.dart';

import '../../shared/app_settings.dart';
import '../../widgets/balance.dart';
import '../../widgets/card.dart';
import '../../widgets/features.dart';
import '../../widgets/header.dart';
import '../../widgets/info_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    user = await ApiApp.fetchUser(1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            drawer: const Drawer(),
            appBar: AppBar(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              title: Center(
                child: SvgPicture.asset(
                  AppImages.logo,
                  height: 24,
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(
                    AppImages.notification,
                    height: 24,
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      HeaderWidget(
                        user: user!,
                      ),
                      const SizedBox(
                        height: 160,
                      ),
                      FeaturesWidget(features: user!.features!),
                      const SizedBox(
                        height: 10,
                      ),
                      CardWidget(card: user!.card!),
                      const SizedBox(
                        height: 10,
                      ),
                      InfoCardsWidget(news: user!.news!),
                    ],
                  ),
                  Positioned(
                    top: (AppSettings.screenHeight / 5) - 40,
                    child: BalanceWidget(account: user!.account!),
                  )
                ],
              ),
            ),
          );
  }
}
