class SQLModelPemasukan {
  int id = -1;
  int id_wallet;
  int id_kategori;
  String judul;
  String deskripsi;
  double nilai;
  DateTime waktu;

  SQLModelPemasukan({
    required this.id,
    required this.id_wallet,
    required this.id_kategori,
    required this.judul,
    required this.deskripsi,
    required this.nilai,
    required this.waktu,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_wallet': id_wallet,
      'id_kategori': id_kategori,
      'judul': judul,
      'deskripsi': deskripsi,
      'nilai': nilai,
      'waktu': waktu.toIso8601String(),
    };
  }

  String titleWithLimitedString(int n){
    return judul.length > n? "${judul.substring(0, n)}..." : judul;
  }

  String get type {
    return id_kategori == 1 ? "Bank" : "Wallet";
  }

  String formatWaktu() {
    final List<String> namaBulan = [
      '', // indeks 0 tidak digunakan
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    String hari = waktu.day.toString();
    String bulan = namaBulan[waktu.month];
    String tahun = waktu.year.toString();
    String jam = waktu.hour.toString().padLeft(2, '0');
    String menit = waktu.minute.toString().padLeft(2, '0');

    return '$hari $bulan $tahun, $jam:$menit';
  }

  // Metode untuk membuat objek DataPengeluaran dari Map (output SQL)
  static SQLModelPemasukan fromMap(Map<String, dynamic> map) {
    return SQLModelPemasukan(
      id: map['id'] ?? -1,
      id_wallet: map['id_wallet'] ?? -1,
      id_kategori: map['id_kategori'] ?? -1,
      judul: map['judul'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      nilai: map['nilai'] ?? 0.0,
      waktu: DateTime.parse(map['waktu'] ?? ''),
    );
  }
}