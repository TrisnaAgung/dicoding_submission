import 'package:dicoding_submission/repository/models/dataUniversitas.dart';
import 'package:dicoding_submission/ui/detail/pages/detail_view.dart';
import 'package:dicoding_submission/ui/detail/widgets/bloc/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeItem extends StatelessWidget {
  const HomeItem(
      {Key? key, required this.dataUniversitas, required this.loginData})
      : super(key: key);
  final DataUniv dataUniversitas;
  final SharedPreferences loginData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<DetailBloc>(
              create: (context) => DetailBloc(),
              child: DetailPage(
                dataUniv: dataUniversitas,
                loginData: loginData,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: Container(
            child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    // padding: EdgeInsets.only(left: 10, right: 10),
                    child: Image.asset(
                      dataUniversitas.path,
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataUniversitas.title,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[850],
                                  fontWeight: FontWeight.bold)),
                        ),
                        Html(
                          data: (dataUniversitas.content.length > 310)
                              ? dataUniversitas.content.substring(0, 310) +
                                  "...."
                              : dataUniversitas.content,
                          style: {
                            "p": Style.fromTextStyle(GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12, color: Colors.grey[850]))),
                            "body": Style(margin: EdgeInsets.all(0)),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
