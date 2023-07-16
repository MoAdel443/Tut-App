import 'package:TutApp/Presentation/resources/Color_Manager.dart';
import 'package:TutApp/Presentation/resources/Values_Manager.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  static var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        children: [
          Container(
            color: ColorManager.ligthGrey.withOpacity(0.1),
            child: TextFormField(
              controller: searchController,
              keyboardType: TextInputType.text,
              onTap: () {},
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search",
                  border: OutlineInputBorder()),
            ),
          ),

        ],
      ),
    );
  }
}
