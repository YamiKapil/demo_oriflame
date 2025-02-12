import "package:flutter/material.dart";

class GeneralBottomSheet {
  static showGeneralBottomSheet(
    BuildContext context,
    String headerTitle, {
    required Widget child,
    bool? isDismissible = true,
    Function? onCloseFun,
  }) async {
    return await showModalBottomSheet(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        minHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      isDismissible: isDismissible!,
      useRootNavigator: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    headerTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (onCloseFun != null) {
                        onCloseFun;
                      }
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(height: 12),
              Flexible(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
