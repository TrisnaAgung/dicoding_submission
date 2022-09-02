import 'package:dicoding_submission/repository/models/dataUniversitas.dart';
import 'package:dicoding_submission/ui/detail/widgets/bloc/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool like = false;
  bool showLike = false;

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
        print(state);
        if (state.status.isSuccess) {
          like = state.like;
          showLike = true;
        }
      },
      builder: (context, state) {
        return Scaffold(
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
            visible: showLike,
            child: FloatingActionButton(
              onPressed: () async {
                context.read<DetailBloc>().add(LikeDetail(
                    dataUniv: widget.dataUniv,
                    loginData: widget.loginData,
                    like: like));
              },
              backgroundColor: Colors.white,
              child: (like)
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
      return Container();
    }
  }
}
