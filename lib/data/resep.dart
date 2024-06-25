class resep {
  String name, htm, tutorial, image;

  resep(
      {required this.name,
      required this.htm,
      required this.tutorial,
      required this.image});
}

List<resep> dataResep = [
  resep(
      name: 'Coto Makassar',
      htm: '35K',
      tutorial:
          '1. Rebus daging dengan air, serai, daun salam, daun jeruk, dan lengkuas hingga empuk.Angkat daging, potong-potong dadu, dan sisihkan air rebusan (kaldu). 2. Tumis bumbu halus dengan minyak goreng hingga harum. 3. Masukkan bumbu tumis ke dalam kaldu rebusan daging,tambahkan potongan daging ke dalam kaldu,masak hingga bumbu meresap dan kuah sedikit mengental.  4. Sajikan coto dalam mangkuk, taburi dengan bawang merah goreng, daun bawang, dan seledri. Tambahkan perasan jeruk nipis sesuai selera.',
      image: 'assets/cotomakassar.jpg'),
  resep(
      name: 'Soto Ayam',
      htm: '30K',
      tutorial:
          '1. Rebus ayam dengan air, daun salam, serai, daun jeruk, dan lengkuas hingga ayam matang dan empuk.Angkat ayam, suwir-suwir dagingnya, dan sisihkan kaldu ayam. 2. Tumis bumbu halus dengan minyak hingga harum dan matang.Masukkan tumisan bumbu ke dalam kaldu ayam, aduk rata. 3. Masukkan kembali suwiran ayam ke dalam kaldu.Tambahkan daun bawang dan seledri yang sudah diiris halus.Masak hingga semua bumbu meresap dan kuah mendidih. Koreksi rasa dengan garam dan gula sesuai selera. 4. Tata soun, kol, tomat, telur rebus, dan kentang goreng di dalam mangkuk.Siram dengan kuah soto dan suwiran ayam.Taburi bawang goreng dan sajikan dengan jeruk nipis, sambal, kecap manis, dan emping.',
      image: 'assets/sotoayam.jpg'),
  resep(
      name: 'Nasi Goreng',
      htm: '25K',
      tutorial:
          '1. Panaskan minyak goreng dalam wajan besar atau penggorengan 2. Tumis bawang putih dan bawang merah hingga harum dan berwarna kecokelatan 3. Tambahkan telur yang sudah dikocok lepas, orak-arik hingga matang dan tercampur rata dengan bawang 4. Jika menggunakan daging ayam, udang, sosis, atau bakso, masukkan dan tumis hingga matang 5. Tambahkan nasi putih dingin ke dalam wajan. Aduk rata dengan bumbu dan bahan lainnya 6. Tambahkan kecap manis, saus tiram, kecap asin, garam, dan merica. Aduk rata hingga semua bumbu tercampur dengan nasi 7. Masukkan irisan daun bawang, aduk kembali hingga merata 8. Cicipi dan sesuaikan bumbu sesuai selera, jika perlu tambahkan garam atau kecap sesuai keinginan 9. Sajikan nasi goreng di piring. Tambahkan pelengkap seperti acar, kerupuk, irisan mentimun, dan tomat.',
      image: 'assets/nasigoreng.jpg'),
  resep(
      name: 'Rawon',
      htm: '30K',
      tutorial:
          '1. Rebus daging sapi dengan 2 liter air hingga empuk. Angkat daging dan potong-potong dadu. Saring dan simpan air rebusan (kaldu). 2. Masukkan tepung dan susu bubuk yang sudah diayak, aduk dengan sendok kayu hingga rata 3. Masukkan bumbu tumis ke dalam kaldu daging yang sudah disaring, Tambahkan potongan daging ke dalam kaldu, Masak hingga bumbu meresap dan kuah menghitam. Koreksi rasa dengan garam dan gula sesuai selera 4. Sajikan rawon dalam mangkuk, taburi dengan daun bawang dan seledri iris, Hidangkan dengan nasi putih, tauge pendek, telur asin, sambal terasi, dan kerupuk udang.',
      image: 'assets/rawon.jpg'),
  resep(
      name: 'Rendang',
      htm: '20K',
      tutorial:
          '1. Haluskan semua bumbu halus menggunakan blender atau ulekan hingga benar-benar halus 2. Panaskan sedikit minyak dalam wajan besar. Tumis bumbu halus hingga harum dan matang, sekitar 10-15 menit 3. Masukkan potongan daging ke dalam bumbu yang sudah ditumis. Aduk hingga daging berubah warna dan tercampur rata dengan bumbu 4. Tuang santan ke dalam wajan, aduk rata, Masukkan daun jeruk purut, daun kunyit, serai, dan asam kandis. Aduk rata 5. Masak dengan api sedang sambil terus diaduk sesekali agar santan tidak pecah, Setelah santan mendidih, kecilkan api menjadi api kecil, Masak terus hingga santan mengental dan menyusut, bumbu meresap, dan daging empuk. Proses ini memakan waktu sekitar 2-3 jam atau lebih. Aduk sesekali untuk memastikan rendang tidak gosong di bagian bawah 6. Setelah daging empuk dan bumbu benar-benar kering, koreksi rasa dengan garam sesuai selera 7. Angkat rendang dari wajan dan sajikan dengan nasi putih hangat.',
      image: 'assets/rendang.jpg'),
  resep(
      name: 'Nasi Kuning',
      htm: '15K',
      tutorial:
          '1. Tumis bumbu halus dengan minyak goreng hingga harum dan matang. 2. Tuangkan santan ke dalam panci atau rice cooker, Tambahkan bumbu tumis, serai, daun salam, lengkuas, dan garam. Aduk rata. 3. Masukkan beras yang sudah dicuci dan tiriskan ke dalam panci atau rice cooker. Aduk hingga rata dengan santan dan bumbu. 4. Masak nasi seperti biasa, entah menggunakan panci atau rice cooker. Jika menggunakan panci, biarkan air menyusut dan nasi hampir matang sebelum ditutup rapat. Jika menggunakan rice cooker, tekan tombol "Cook" dan biarkan hingga proses memasak selesai. 5.  Jika ingin memberi warna kuning lebih kuat, tambahkan sejumput bubuk kunyit atau kunyit parut ke dalam nasi saat hampir matang. Juga bisa tambahkan sejumput kaldu bubuk untuk rasa tambahan. 6. Setelah nasi matang, aduk rata untuk meratakan warna dan aroma bumbu, Sajikan nasi kuning hangat sebagai pengiring hidangan favorit Anda.',
      image: 'assets/nasikuning.jpg'),
];
