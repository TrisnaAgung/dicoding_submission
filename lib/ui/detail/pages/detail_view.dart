import 'package:dicoding_submission/repository/models/dataUniversitas.dart';
import 'package:dicoding_submission/ui/detail/widgets/bloc/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.dataUniv, required this.loginData})
      : super(key: key);
  final DataUniv dataUniv;
  final SharedPreferences loginData;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool favorite = false;
  bool showFav = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<DetailBloc>().add(
        InitialDetail(dataUniv: widget.dataUniv, loginData: widget.loginData));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailBloc, DetailState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          favorite = state.fav;
          showFav = true;

          if (!state.first) {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text(((favorite)
                  ? "Berhasil Menambahkan ke Daftar Favorite"
                  : "Berhasil Menghapus dari Daftar Favorite")),
            ));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              widget.dataUniv.title,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.black, fontSize: 18)),
            ),
            centerTitle: true,
            titleSpacing: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          floatingActionButton: Visibility(
            visible: showFav,
            child: FloatingActionButton(
              onPressed: () async {
                context.read<DetailBloc>().add(FavoriteDetail(
                    dataUniv: widget.dataUniv,
                    loginData: widget.loginData,
                    fav: favorite));
              },
              backgroundColor: Colors.white,
              child: (favorite)
                  ? Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: Colors.pink,
                    ),
            ),
          ),
          body: home(state),
        );
      },
    );
  }

  Widget home(DetailState state) {
    if (state.status.isLoading) {
      return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Image.asset(
                    widget.dataUniv.path,
                    height: 250,
                  ),
                ),
                Container(
                  child: Html(
                    data: widget.dataUniv.content,
                    style: {
                      "p": Style.fromTextStyle(GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 18, color: Colors.grey[850]))),
                      "body": Style(margin: EdgeInsets.all(0)),
                    },
                  ),
                ),
              ],
            )),
      );
    }
  }
}
