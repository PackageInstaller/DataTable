__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "Perintah tidak tersedia"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "Acara telah berakhir"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Jumlah hari login tidak mencukupi, hadiah tidak dapat diklaim."
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Mengikuti acara, syarat tidak terpenuhi"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "Kegiatan ini tidak tersedia"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "Acara belum dibuka"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "Acara belum dimulai"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Misi aktivitas belum selesai"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Event percobaan, hadiah tidak dapat diklaim jika level belum selesai."
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Pada sesi uji coba, level ini tidak ditemukan."
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "Penjaga telah memberikan bantuan sekali dalam aktivitas ini untukmu."
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "Event ini memerlukan Penjaga yang saling memperhatikan untuk memberikan bantuan."
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "Bantu penjaga yang sering digunakan telah mencapai batas, silakan sesuaikan daftar bantu yang sering digunakan"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "Peningkatan Keterampilan belum mencapai kondisi yang ditetapkan"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Level Pembangun tidak mencukupi untuk Mendidik"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "Pembangun belum mencapai waktu pembukaan."
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "Pembangun telah digunakan sebelumnya"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "Tidak dapat diblokir kembali"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "Kau telah dimasukkan ke dalam daftar hitam oleh pihak lain dan tidak bisa beroperasi"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "Kamu telah dimasukkan ke dalam daftar hitam oleh pihak lain, sehingga tidak dapat mengikuti atau memberi like."
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "Kamu telah memasukkan pihak lain ke dalam daftar hitam, sehingga tidak dapat memberikan like atau mengikuti."
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Jumlah orang yang diblokir telah mencapai batas maksimum"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "Pembuatan pertempuran gagal"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Koin yang dibutuhkan untuk membeli level tiket melewati tidak mencukupi"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Operasi gagal"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "Lewati belum dikonfigurasi dengan harga istimewa untuk pembelian."
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "Level hak istimewa Lewati telah penuh, tidak dapat dibeli kembali."
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Level hak istimewa tidak mencukupi, tidak dapat diklaim."
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "Hadiah tidak tersedia"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Hadiah sudah diklaim"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Kekurangan Perak utama"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Jumlah pembelian sertifikat tidak mencukupi"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Relik tidak mendukung memperkuat"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "Kartu ini telah mencapai level maksimum, tidak dapat dimemperkuat."
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "Kartu ini tidak dapat diperkuat"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Termasuk kata-kata yang diblokir"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "Ulangi komentar"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "Hapus ulang"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "Ulangi suka"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Ulangi batalkan suka"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Panjang melebihi batas"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "Komentar suka telah dihapus"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Komentar telah kedaluwarsa"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Peningkatan kartu eksklusif, tanpa batasan jumlah"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "Tidak ditemukan alur cerita untuk tantangan instance dungeon"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "Misi alur cerita untuk tantangan dungeon tidak ditemukan"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Data level Terjunan Gaib sedang diperbarui, silakan coba lagi nanti."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Tantangan misi telah selesai, hadiah tidak dapat diambil lagi."
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Tantangan misi belum selesai, hadiah tidak dapat diambil."
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "Hadiah bab belum mencapai jumlah poin yang ditentukan."
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Hadiah bab telah diklaim"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Pilihan node saat ini tidak ditemukan"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Nama karakter terduplikasi"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "Data yang dikirim oleh klien salah"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Node saat ini tidak ditemukan"
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Kesalahan tabel konfigurasi"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Hadiah tidak bisa diterima"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Hadiah belum mencapai kondisi untuk diklaim"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "Level tidak memiliki data nilai topik"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "Tidak ada poin misi untuk instance ini."
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Topik tidak ditemukan dalam modul"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "Misi belum ditemukan"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "Data unit pelajaran tidak ditemukan"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "Unit telah dikirimkan, tidak perlu mengirimkan ulang."
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "Sub-tugas dalam misi belum selesai"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Misi telah selesai"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "Tugas di bawah unit belum sepenuhnya selesai, sehingga tidak dapat diserahkan."
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "Pendaftaran Penjaga baru saat ini telah ditangguhkan"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "Tidak ada karakter, perlu dibuat."
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "Jumlah penggunaan instruksi kustom telah mencapai batas maksimum."
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "Relik telah diperkuat"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Menofin sudah cukup, tidak perlu ditambahkan."
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "Saat ini tidak dapat melakukan ritual penyembahan."
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "Aksesori tidak tersedia"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Kesalahan area acara"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "Kartu pilihan Acara tidak ada"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Jumlah kartu acara terlalu banyak"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "Acara pemilihan Relik tidak tersedia"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Jumlah Relik dalam Acara terlalu banyak"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "Terdapat kesalahan dalam pengisian jenis pada tabel konfigurasi Acara instance"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Data acara salah"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "Tidak ada batasan jumlah untuk memperbarui kartu yang dijatuhkan dalam pertempuran."
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "Pertempuran tidak memiliki batasan jumlah refresh Relik."
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Acara di salinan telah selesai"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "Acara tidak tersedia"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Tidak cukup perak rahasia untuk melakukan pembelian."
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Acara tidak ditemukan pada node ini"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "Kolam acak Acara tidak memiliki data"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "Fungsi Persimpangan terkunci"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "Fungsi di area perkemahan telah dipilih dan tidak dapat dipilih kembali."
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "Fungsi perkemahan sudah tidak memiliki jumlah penggunaan tersisa."
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Toko Acara tidak memiliki batasan jumlah pembaruan."
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "Jumlah penghapusan kartu di toko acara telah habis"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Jumlah Kartu Acara tidak mencukupi"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Jumlah Relik Acara tidak mencukupi"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "Informasi kartu eksklusif yang dimaksud tidak ditemukan"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "Rute peningkatan tidak memiliki konfigurasi ID karakter."
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Kartu eksklusif yang ditentukan belum terbuka"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "Kartu eksklusif tidak mengalami perubahan, sehingga tidak dapat beralih."
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Gagal mengganti kartu eksklusif"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "Kartu eksklusif tidak dapat di-upgrade, sehingga tidak bisa beralih."
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "UUID kartu eksklusif tidak ditemukan"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "Wakil membantu Pembangun telah kadaluarsa, harap segarkan daftar wakil dan pilih kembali Pembangun."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Item sintesis belum terkunci"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "Tidak cukup mata uang untuk mensintesis item"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Item yang diperlukan untuk sintesis tidak mencukupi"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "Bangunan sudah ada dan tidak dapat dibangun lagi."
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "Posisi sudah ada Pembangun, tidak dapat dimasuki."
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "Bangunan telah mencapai level maksimum."
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "Bangunan tidak tersedia"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Kondisi untuk meningkatkan/membangun bangunan tidak mencukupi"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Item yang diperlukan untuk peningkatan/pembangunan tidak cukup"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "Tidak ada hadiah yang tersedia untuk diklaim di node saat ini."
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "Tidak ada kesempatan untuk menantang"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "Stamina saat ini terlalu rendah, kamu sudah berada dalam Negara Kelemahan."
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Level eksplorasi instance mencapai Level 2 untuk membuka kunci"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "Setelah berhasil menyelesaikan satu eksplorasi, pemain dapat langsung melakukan eksplorasi instan."
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Kesalahan Instans"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "Tidak ditemukan salinan"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Node belum terbuka"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Node telah selesai."
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Node belum selesai"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "Node tidak berdekatan"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Jumlah pembaruan toko tidak mencukupi"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Level pemain tidak mencukupi"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "Deskripsi mengandung karakter ilegal, silakan masukkan kembali."
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "Pihak lain sedang melakukan Penyelidikan atau terlibat dalam permainan lain."
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Nilai indeks yang salah"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "Anda sekarang adalah undangan pihak lain"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "Telah ada pengundang"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Kesalahan negara instance, silakan login kembali"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Tas sudah penuh"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "Jumlah pembelian hari ini telah mencapai batas maksimum."
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "Item telah dilengkapi."
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "Item telah terkunci"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "Item tidak terkunci"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "Item telah mencapai tingkat maksimum."
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Jumlah item tidak mencukupi"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Item tidak ditemukan"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Item tidak sesuai"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "Item tidak dapat digunakan"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Item duplikat"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "Roda Takdir atau Geng belum mencapai waktu pembukaan."
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Jumlah penggunaan item tidak valid"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Item tidak dapat digunakan"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Node pemicu sebelumnya tidak ditemukan"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "Energi yang terkumpul saat ini tidak cukup untuk mengaktifkan portal. Diperlukan {s1} poin energi untuk mengaktifkan portal."
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Level maksimum telah tercapai"
  },
  ErrCode_ERR_LOCKED_Desc = {
    Text = "Belum terkunci"
  },
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "Dungeon area belum terbuka"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Garis cerita belum terbuka untuk penyapuan."
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "Salinan yang dipilih belum dibuka kuncinya"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "Jalur cerita yang dipilih belum dibuka"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Kesalahan saat login ke server"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Lampiran telah diklaim"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "Email tidak ditemukan"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Pencocokan gagal"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "Jumlah pemanggilan maksimum telah tercapai!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Tidak dapat menantang karena kekurangan koin-"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Silakan pilih Pembangun yang akan diturunkan"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Emas yang ditentukan belum terbuka - Silakan selesaikan Penyelidikan yang ditentukan"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "Waktu untuk mengganti nama belum tiba, harap Menunggu"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "Nama mengandung karakter ilegal, harap masukkan kembali"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "Panjang nama tidak valid, harus 2-4 karakter"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "Input karakter terlalu panjang"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "Karakter yang dimasukkan terlalu pendek"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "Tidak cukup poin"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "Anda tidak memiliki item ini"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "Tidak bisa dipindahkan"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Fitur belum tersedia"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Hadiah tidak memenuhi persyaratan, tidak dapat diambil."
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Pembaruan profil sedang berlangsung, harap tunggu sebentar."
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "Saat ini tidak ada pertandingan persahabatan yang sedang berlangsung."
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "Saat ini tidak ada Perjanjian yang tersedia."
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "Data NPC salah"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "NPC telah terpicu"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC tidak tersedia"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "Pihak lain saat ini sedang offline"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Level pemain tidak mencukupi"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Garis cerita tidak memiliki cukup bintang untuk melakukan penyapuan."
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "Acara dialog alur cerita tidak ditemukan"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Jumlah pembelian untuk tantangan alur cerita tidak mencukupi."
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Hadiah sudah diklaim"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "Tidak ada hadiah tersebut"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Gagal memasukkan rune"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "Koleksi PVP belum diperoleh"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "Tim Traphase tidak memiliki cukup Geng untuk bertanding."
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "Tim Traphase tidak memiliki cukup Roda takdir untuk diturunkan."
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Belum mencapai syarat untuk membuka mode pilihan"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Tantangan sedang dalam pendinginan"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "Tidak ada kesempatan untuk menantang"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "Tidak ada lawan untuk ditantang"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Silakan pilih Pembangun yang akan diturunkan"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "Salah satu pihak telah mencapai dua kemenangan, sehingga tidak dapat melanjutkan ke pertandingan berikutnya."
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "Lawan telah keluar"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "Pertarungan kata sandi tidak ada atau telah kedaluwarsa"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "Saat ini tidak mendukung melihat informasi peringkat di luar 2000 besar."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "Konfigurasi ini tidak tersedia di tabel konfigurasi isi ulang."
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "Jika sudah melakukan isi ulang gratis, tidak dapat melakukan isi ulang lagi."
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "Jumlah pembaruan barang telah mencapai batas maksimum"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "Tidak dalam keadaan saling mengikuti"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Relik telah penuh"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "Permintaan terlalu sering, silakan coba lagi nanti."
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Jumlah material yang diperlukan untuk elitisasi tidak mencukupi"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Pembangun tidak memiliki cukup mata uang untuk konsumsi peningkatan"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Data karakter bermasalah"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "Tingkat Kedatangan Pembangun telah penuh, tidak dapat ditingkatkan lebih lanjut."
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Level Bangun tidak cukup"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "Pembangun telah mencapai level tertinggi dan tidak dapat ditingkatkan."
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Kekurangan mata uang"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "Pembangun telah dimendidik ke tingkat tertinggi."
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "Belum mencapai level tertinggi, tidak dapat melakukan promosi."
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "Data Pembangun tidak ditemukan"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "Pembangun tidak memiliki Keterampilan"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "Tidak ada informasi slot"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "Potensi Bangun telah mencapai level tertinggi."
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Item peningkatan potensi Pembangun tidak cukup"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Pembangun belum membuka keterampilan"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "Keterampilan telah mencapai level maksimum"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "Item untuk peningkatan Keterampilan tidak cukup"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Mata uang untuk peningkatan keterampilan tidak mencukupi"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Level maksimum telah tercapai"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Tidak ada slot peningkatan manual tersisa."
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Sudah diperkuat, tidak dapat diperkuat lagi."
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Item yang diperlukan untuk upgrade Pembangun tidak cukup"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Pembangun tidak memiliki cukup mata uang untuk konsumsi peningkatan"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "Alam tidak memenuhi persyaratan"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "Pembangun yang bertarung di Menara Alam tidak memenuhi persyaratan Alam."
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "Level yang dimasuki tidak termasuk dalam level yang sedang dibuka saat ini."
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "Menara Alam tidak dapat membawa Pembangun yang sama untuk bertarung."
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Perak tidak mencukupi"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Kampus sedang dalam pemeliharaan, harap tunggu hingga perbaikan selesai."
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Layanan belum diaktifkan"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Barang telah dibeli"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "Saat ini tidak dapat melakukan deteksi."
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "Barang telah kedaluwarsa, tidak dapat ditukarkan."
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "Barang yang dijual sudah habis stoknya."
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "Tidak ada data toko"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "Tidak ada toko tipe ini"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "Barang ini tidak dijual."
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "Toko tidak menjual barang ini."
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Tidak ada batas pembaruan"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "Barang ini tidak tersedia di toko."
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Saat ini bukan node toko, sehingga tidak dapat diperbarui."
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "Pemain tersebut tidak ditemukan"
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "Semua wujud dari Pandangan Awal telah berhasil dikalahkan"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "Jumlah tantangan harian tipe level telah mencapai batas maksimum"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Klik terlalu sering, silakan coba lagi nanti."
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Fungsi Bangun tidak diaktifkan"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Syarat aktivasi tidak terpenuhi"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Resonansi telah diaktifkan, tidak perlu mengaktifkannya lagi."
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "Status awal Resonansi tidak dapat diatur ulang"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Bahan Resonansi tidak mencukupi."
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "Resonansi telah mencapai level maksimum"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "Resonansi tidak ditemukan di dalam instance"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "Tidak ditemukan data Resonansi"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "Data terkait level Resonansi tidak ditemukan"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "Tidak ada jumlah reset"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Efek produksi Pembangun telah dibuka, tidak perlu dibuka lagi."
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Hadiah sudah diklaim"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "Misi delegasi telah selesai dan tidak dapat ditarik kembali."
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Persyaratan delegasi tidak terpenuhi"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Misi telah selesai"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Tugas tidak ditemukan"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Misi belum selesai, hadiah tidak dapat diterima."
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "Nama tim tidak boleh mengandung karakter selain dari Tionghoa atau Inggris"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "Nama tim tidak boleh lebih dari 8 karakter"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "Jumlah Pembangun dalam tim harus mencapai empat agar dapat memasuki level."
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Konfigurasi tim tidak ditemukan"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "Tim Pembangun belum menetapkan Roda Takdir"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "Kesalahan penyesuaian tim Alam dalam Penyelidikan"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "Roda takdir tidak ada"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Kredensial tidak mencukupi"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Token masuk salah"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Node pemicu saat ini tidak ditemukan"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Aksesori tidak tercatat, tidak dapat mengganti atribut"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Unfollow terlebih dahulu sebelum memblokir."
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Pembangun, Roda takdir, atau Geng telah digunakan dalam mode permainan ini hari ini."
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "Membuka cabang gagal: Cabang tersedia"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Membuka cabang gagal: Cabang belum diaktifkan"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Membuka cabang gagal: Tidak ada item yang perlu dibuka."
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "Membuka cabang gagal: Cabang sudah terbuka"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Nomor versi tidak sesuai, harap perbarui klien terbaru; jika sudah diperbarui, harap tunggu hingga pemeliharaan kampus selesai."
  },
  ErrCode_FAILED_Desc = {Text = "Gagal"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "Karakter yang sudah ada tidak perlu dibuat ulang."
  },
  ErrCode_SUCCESS_Desc = {
    Text = "Operasi berhasil"
  }
})
return Text_ErrCode
