class Api {
  static String server = 'http://192.168.43.85/finalUAS';

  static String urlAddPelanggan = '${Api.server}/add_pelanggan.php';

  static String urlGetListPelanggan = '${Api.server}/get_list_pelanggan.php';

  static String urlUpdatePelanggan = '${Api.server}/update_pelanggan.php';

  static String urlDeletePelanggan = '${Api.server}/delete_pelanggan.php';

  static String urlRegister = '${Api.server}/register_user.php';

  static String urlLogin = '${Api.server}/login_user.php';

  static String urlGetListWishlist = '${Api.server}/get_list_wishlist.php';

  static String urlCheckWishlist = '${Api.server}/check_wishlist.php';

  static String urlAddWishlist = '${Api.server}/add_wishlist.php';

  static String urlDeleteWishlist = '${Api.server}/delete_wishlist.php';
}
