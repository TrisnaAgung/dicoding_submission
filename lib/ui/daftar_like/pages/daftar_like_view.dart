import 'package:dicoding_submission/repository/models/dataUniversitas.dart';
import 'package:dicoding_submission/ui/daftar_like/pages/daftar_like_item.dart';
import 'package:dicoding_submission/ui/daftar_like/widgets/bloc/daftar_like_bloc.dart';
import 'package:dicoding_submission/ui/home/pages/home_item.dart';
import 'package:dicoding_submission/ui/home/widgets/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarLikePage extends StatelessWidget {
  const DaftarLikePage(
      {Key? key, required this.loginData, required this.dataUniv})
      : super(key: key);
  final List<DataUniv> dataUniv;
  final SharedPreferences loginData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Like",
          style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<DaftarLikeBloc, DaftarLikeState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (state.data.isEmpty) {
              return RefreshIndicator(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      // height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top),
                      height: (MediaQuery.of(context).size.height - 100),
                      // constraints: BoxConstraints.expand(),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/images/ic_no_item.png",
                              height: 70,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Tidak Ada Data",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onRefresh: () async {
                    context.read<DaftarLikeBloc>().add(RefreshDaftar(
                        dataUniv: state.data, loginData: loginData));
                  });
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<DaftarLikeBloc>().add(RefreshDaftar(
                      dataUniv: state.data, loginData: loginData));
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            state.data.length == null ? 0 : state.data.length,
                        itemBuilder: (context, index) {
                          return DaftarLikeItem(
                            dataUniv: state.data,
                            context: context,
                            dataUniversitas: state.data[index],
                            loginData: loginData,
                          );
                        }),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
