import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_converter/core/constant/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              showLanguageSheet(context);
            },
            icon: Icon(Icons.language),
          ),
        ),
      ],
    );
  }
}

void showLanguageSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _item(context, '🇺🇸 English', const Locale('en', 'US')),
            _item(context, '🇺🇿 Uzbek', const Locale('uz', 'UZ')),
            _item(context, '🇷🇺 Русский', const Locale('ru', 'RU')),
          ],
        ),
      );
    },
  );
}

Widget _item(BuildContext context, String title, Locale locale) {
  final isSelected = context.locale == locale;

  return ListTile(
    title: Text(title),
    trailing: isSelected ? Icon(Icons.check, color: AppColors.black) : null,
    onTap: () async {
      await context.setLocale(locale);
      if (context.mounted) {
        context.pop();
      }
    },
  );
}
