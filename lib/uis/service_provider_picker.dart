import 'package:flutter/material.dart';
import 'package:untitled1/models/data_models.dart';

import '../screens/theme_utils.dart';

class ServiceProviderSelector extends StatefulWidget {
  const ServiceProviderSelector({Key? key, required this.items, this.onPressed})
      : super(key: key);

  final List<NetworkProviderModel> items;
  final Function(NetworkProviderModel)? onPressed;

  @override
  State<ServiceProviderSelector> createState() =>
      _ServiceProviderSelectorState();
}

class _ServiceProviderSelectorState extends State<ServiceProviderSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
          color: ThemedDarkBg,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select a network provider",
                  style: WhiteText.copyWith(fontSize: 16, wordSpacing: 1.2),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  NetworkProviderModel provider = widget.items[index];
                  return Material(
                    color: Colors.transparent,
                    child: Container(
                      margin: const EdgeInsets.all(16.0)
                          .copyWith(bottom: index == 3 ? 16 : 0),
                      decoration: BoxDecoration(
                          color: provider.color.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        onTap: widget.onPressed == null
                            ? null
                            : () {
                                widget.onPressed!(provider);
                              },
                        splashColor: provider.color.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 32),
                          child: Row(
                            children: [
                              Icon(
                                provider.icon,
                                color: Colors.white,
                                size: 32,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.title,
                                    style: WhiteText.copyWith(
                                        fontSize: 18,
                                        letterSpacing: 1.3,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  if (provider.description != null)
                                    Text(
                                      provider.description!,
                                      style: WhiteText.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class ServiceProviderModel {
  final String title;
  final String? description;
  final IconData icon;
  final Color color;

  ServiceProviderModel(this.title, this.description, this.icon, this.color);
}

