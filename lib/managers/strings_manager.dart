class StringsManager {
  static const String appName = 'INITURE';
  static const String firstTimeLogin =
      'Email verifikasi akun telah dikirim. Silakan verifikasi akun Anda untuk login.';
  static const String firstTimeLoginTitle = 'Login Pertama untuk Melanjutkan';
  static const String loginTxt = 'Masuk';
  static const String loginAccTxt = 'Masuk ke akun Anda';
  static const String emailTxt = 'Alamat Email';
  static const String passwordTxt = 'Kata Sandi';
  static const String forgotPassTxt = 'Lupa Kata Sandi?';
  static const String noAccTxt = 'Belum punya akun? ';
  static const String alreadyHaveAccTxt = 'Sudah punya akun? ';
  static const String welcomTxt = 'Selamat Datang Kembali';
  static const String offlineTxt = "Anda Sedang Offline.";
  static const String myProductsTxt = "Produk Saya";
  static const String allProductsTxt = "Semua Produk";
  static const String myCartTxt = "Keranjang Saya";
  static const String myOrdersTxt = "Pesanan Saya";
  static const String favouriteTxt = "Produk Favorit";
  static const String ordersPlacedTxt = "Log Pesanan";
  static const String addressTxt = "Alamat";
  static const String addProdTxt = "Tambah Produk";
  static const String editProdTxt = "Edit Produk";
  static const String prodNameTxt = "Nama Produk";
  static const String prodImgTxt = "Gambar Produk";
  static const String priceTxt = "Harga";
  static const String stockQtyTxt = "Jumlah Stok";

  static const String descriptionTxt = 'Deskripsi';
  static const String registerNowTxt = 'Buat akun Anda';
  static const String noProducttTxt = "Tidak ada produk ditemukan!";

  static const String offlineMsgTxt =
      "Tidak ada koneksi Internet. Pastikan Wifi atau data seluler Anda aktif, lalu coba lagi.";
  static const String openWifiTxt = "Buka Pengaturan Wifi";
  static const String openDataTxt = "Buka Pengaturan Data";

  static const String registerTxt = 'Daftar';
  static const String nameTxt = 'Nama Lengkap';
  static const String phoneTxt = 'Nomor Telepon';
  static const String changePasswordTxt = 'Ubah Kata Sandi';
  static const String oldPasswordTxt = 'Kata Sandi Lama';
  static const String newPasswordTxt = 'Kata Sandi Baru';
  static const String newRePasswordTxt = 'Masukkan Ulang Kata Sandi';
  static const String privacyPolicyTxt = 'Kebijakan Privasi';
  static const String updateProfileTxt = 'Perbarui Profil';

  // Hint Text
  static const String emailHintTxt = 'contoh@gmail.com';
  static const String phoneHintTxt = '0123XXXXXXX';
}

class ErrorManager {
  // form field error
  static const String kProductNameNullError = 'Silakan masukkan nama produk';
  static const String kaddressNullError = 'Silakan masukkan alamat Anda';
  static const String kUserNameNullError = 'Silakan masukkan nama Anda';
  static const String kInvalidPriceError =
      'Silakan masukkan harga yang lebih besar dari 0.';
  static const String kInvalidStockError =
      'Silakan masukkan stok yang lebih besar dari 0.';
  static const String kFieldEmptyError = 'Silakan masukkan nilai';
  static const String kPriceEmptyError = 'Silakan masukkan harga yang valid.';
  static const String kStockEmptyError = 'Silakan masukkan stok yang valid.';
  static const String kEmailNullError = 'Silakan masukkan email yang valid';
  static const String kPhoneNullError = 'Silakan masukkan nomor telepon';
  static const String kDescriptionNullError = 'Silakan masukkan deskripsi';

  static const String kPasswordNullError = 'Silakan masukkan kata sandi';
  static const String kPasswordNotMatchingError = 'Kata sandi tidak cocok';
  static const String kPasswordShortError =
      'Silakan masukkan kata sandi minimal 8 karakter';
  static const String kPasswordNotSameError =
      'Konfirmasi Kata Sandi harus sama dengan Kata Sandi Baru';

  static const String kGenderNullError = 'Silakan pilih jenis kelamin';
}
