// KELAS ABSTRAK
abstract class Transportasi {
  String id, nama; 
  double _tarifDasar; // Private
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  double get tarifDasar => _tarifDasar;
  double hitungTarif(int jumlahPenumpang) => _tarifDasar * kapasitas;

  void tampilanInfo() {
    print ('$nama (ID: $id) -Kapasitas: $kapasitas orang');
  }
}

// KELAS TURUNAN
class Taksi extends Transportasi {
  double jarak;
  Taksi (String id, String nama, double tarif, int kapasitas, this.jarak) : super (id, nama, tarif, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) => tarifDasar * jarak;
}

class Bus extends Transportasi {
  bool adaWifi;
  Bus (String id, String nama, double tarif, int kapasitas, this.adaWifi) : super (id, nama, tarif, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) => (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);
}

class Pesawat extends Transportasi {
  String kelas;
  Pesawat (String id, String nama, double tarif, int kapasitas, this.kelas) : super (id, nama, tarif, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) => tarifDasar * jumlahPenumpang * (kelas == "Bisnis" ? 1.5 : 1.0);
}

// KELAS PEMESANAN
class Pemesanan {
  static int _counter = 0;
  String idPemesanan, namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(this.namaPelanggan, this.transportasi, this.jumlahPenumpang) : idPemesanan = 'PSN${++_counter}', 
    totalTarif = transportasi.hitungTarif(jumlahPenumpang);

  void cetakStruk() {
    print('\n===STRUK $idPemesanan===');
    print('Nama Pelanggan: $namaPelanggan');
    print('Transportasi: ${transportasi.nama}');
    print('Jumlah Penumpang: $jumlahPenumpang');
    print('Total Tarif: $totalTarif');
  }

  Map<String, dynamic> toMap() => {
    'id': idPemesanan,
    'pelanggan': namaPelanggan,
    'transportasi': transportasi,
    'jumlahPenumpang': jumlahPenumpang,
    'totalTarif': totalTarif
  };
}

// FUNGSI GLOBAL
Pemesanan buatPemesanan (Transportasi t, String nama, int penumpang) {
  return Pemesanan(nama, t, penumpang);
}

void tampilSemuaPemesanan (List<Pemesanan> daftar) {
  print('\n>>> SEMUA PEMESANAN<<<');
  for(var p in daftar) p.cetakStruk();
  print('\nTotal: ${daftar.length} pemesanan');
}

// PROGRAM UTAMA
void main() {
  print('===SMARTRIDE TRANSPORTASI===');
  
  //Buat Transportasi
  var taksi = Taksi('TX01', 'Blue Bird', 5000, 4, 10);
  var bus = Bus('BS01', 'TransJakarta', 3500, 40, true);
  var pesawat = Pesawat('PS01', 'Garuda Indonesia', 500000, 180, 'Bisnis');

  //Buat Pemesanan
  List<Pemesanan> daftar = [
    buatPemesanan(taksi, 'Icad', 2),
    buatPemesanan(bus, 'Asgar', 5),
    buatPemesanan(pesawat, 'Fahrur Rizky', 3),
  ];

  //Tampilkan Semua
  tampilSemuaPemesanan(daftar);

  print('\n>>> Contoh Map: ${daftar[0].toMap()}');
}