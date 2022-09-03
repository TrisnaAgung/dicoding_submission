import 'package:dicoding_submission/ui/daftar_favorite/pages/daftar_favorite_view.dart';
import 'package:dicoding_submission/ui/daftar_favorite/widgets/bloc/daftar_favorite_bloc.dart';
import 'package:dicoding_submission/ui/home/pages/home_item.dart';
import 'package:dicoding_submission/ui/home/widgets/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.loginData}) : super(key: key);
  final SharedPreferences loginData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Home",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.black)),
              ),
              centerTitle: true,
              titleSpacing: 0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              actions: <Widget>[
                Visibility(
                  visible: (state.status.isLoading) ? false : true,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<DaftarFavoriteBloc>(
                            create: (context) => DaftarFavoriteBloc()
                              ..add(InitialDaftar(
                                  dataUniv: state.data, loginData: loginData)),
                            child: DaftarFavoritePage(
                              dataUniv: state.data,
                              loginData: loginData,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            body: (state.status.isLoading)
                ? Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      context.read<HomeBloc>().add(RefreshData());
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.data.length == null
                                ? 0
                                : state.data.length,
                            itemBuilder: (context, index) {
                              return HomeItem(
                                dataUniversitas: state.data[index],
                                loginData: loginData,
                              );
                            }),
                      ),
                    ),
                  ));
      },
    );
  }
}
