import 'package:flexi_quiz/core/extension/buildcontext.dart';
import 'package:flexi_quiz/core/log/logger.dart';
import 'package:flexi_quiz/data/helper/firebase_remote_config.dart';
import 'package:flexi_quiz/presentation/provider/authprovider/provider.dart';
import 'package:flexi_quiz/presentation/provider/productProvider/provider.dart';
import 'package:flexi_quiz/presentation/views/homepage/widgets/product_card.dart';
import 'package:flexi_quiz/presentation/views/loginpage/page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';

class HomePage extends StatefulWidget {
  static const homePageRoute = "/home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<ProductProvider>().fetchProducts();
        var remoteConfig = FirebaseRemoteConfigService().remoteConfig;
        remoteConfig.onConfigUpdated.listen((event) async {
          await remoteConfig.activate();
          setState(() {});
          discount =
              FirebaseRemoteConfigService().remoteConfig.getBool('discount');
        });
      },
    );
    super.initState();
  }

  bool discount =
      FirebaseRemoteConfigService().remoteConfig.getBool('discount');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        backgroundColor: context.colorSchema.primary,
        title: Text(
          "e-shop",
          style: context.textTheme.titleMedium
              ?.copyWith(color: context.colorSchema.secondary),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TalkerScreen(talker: talker),
                ));
              },
              icon: Icon(
                Icons.perm_device_information_rounded,
                color: context.colorSchema.secondary,
              )),
          IconButton(
              onPressed: () {
                context.read<AuthProvider>().logout();
                context.go(LoginPage.loginRoute);
              },
              icon: Icon(
                Icons.logout_rounded,
                color: context.colorSchema.secondary,
              ))
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (value.products != null) {
            return value.products!.fold(
              (l) {
                context.showErrorDialog(l);
                return Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: context.colorSchema.error,
                        size: 35,
                      ),
                      const Gap(8),
                      Text(
                        "Oh snap! Please refresh",
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              },
              (r) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: r.products!.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: r.products![index],
                      discount: discount,
                    );
                  },
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
