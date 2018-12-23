import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class VendorConfiguration {

  String tmdb_api_key;

  final String name;
  final String server;

  ///
  /// A VendorConfiguration should be used to change the default settings in the
  /// ApolloTV app. Simply create your own class and extend [VendorConfiguration].
  ///
  /// [name] - The name of the vendor. If you are developing this independently,
  ///           use your GitHub name.
  ///
  /// [server] - The server address of the vendor. Used to determine which source
  ///           should be used.
  ///
  VendorConfiguration({
    @required this.name,
    @required this.server,

    this.tmdb_api_key
  });

  ///
  /// Returns the name of the Vendor, as provided when the configuration object
  /// was initialized.
  ///
  String getName(){
    return name;
  }

  ///
  /// Returns the server address declared by the Vendor.
  /// If the vendor does not use a server, this will be `localhost`
  ///
  String getServer(){
    return server;
  }

  ///
  /// This method will be called in order to authenticate with the vendor API.
  /// All keys generated by this method should be stored internally.
  /// However, they will not be used until this has completed.
  ///
  /// This method returns a [bool] to determine whether authentication was
  /// successful.
  ///
  Future<bool> authenticate();

  Future<dynamic> playMovie(String title, BuildContext context);
  Future<dynamic> playTVShow(
      String title,
      String releaseDate,
      int seasonNumber,
      int episodeNumber,
      BuildContext context
    );

  String getTMDBKey(){
    if(tmdb_api_key != null){
      return tmdb_api_key;
    }else{
      throw new Exception("Invalid TMDB API key for provider ${getName()}.");
    }
  }

  /// Whether this vendor configuration supports resolving on the client-side.
  bool get supportsClientSideResolver {
    return false;
  }

}