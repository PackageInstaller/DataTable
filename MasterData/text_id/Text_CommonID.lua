__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "Akun"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "Kerusakan Tertinggi"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "Lapisan tertinggi"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Waktu Selesai"
  },
  CommonID_AchieveType0_Desc = {
    Text = "Semua Prestasi"
  },
  CommonID_AchieveType1_Desc = {
    Text = "Cerita Pertumbuhan"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Penyelidikan Cap"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Catatan Pertempuran"
  },
  CommonID_AchieveType4_Desc = {
    Text = "Karier Penjaga Rahasia"
  },
  CommonID_Add_State_Desc = {
    Text = "Tambahkan Status"
  },
  CommonID_All_Desc = {Text = "Semua"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Kondisi penyelesaian misi: Memicu salah satu node cerita"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Kondisi penyelesaian misi: Salah satu entri dalam grup terbuka"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Kondisi penyelesaian misi: Memicu salah satu acara"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Kondisi penyelesaian misi: Memperoleh salah satu Item"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Kondisi penyelesaian misi: Memicu salah satu jenis node"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Kondisi penyelesaian misi: Memperoleh salah satu Relik"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Kondisi penyelesaian misi: Menyelesaikan salah satu level dalam daftar untuk pertama kalinya"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Meningkatkan Hadiah untuk Delegasi"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Peningkatan Properti"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Kematian Pembangun"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Pemimpin Bangun"
  },
  CommonID_BN_Desc = {
    Text = "Bengali (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "Tidak dapat digunakan di medan perang"
  },
  CommonID_Battle_Desc = {
    Text = "Pertempuran"
  },
  CommonID_Blue_Desc = {Text = "Biru"},
  CommonID_Boss_Desc = {Text = "Pemimpin"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "Pengaturan Tombol"
  },
  CommonID_CN_Desc = {
    Text = "Mandarin Sederhana"
  },
  CommonID_CardBorder_Desc = {
    Text = "Tampilan Kartu"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Slot Peningkatan"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "Imageri Lanjutan"
  },
  CommonID_Card_AttachPost_Desc = {Text = "Pengejaran"},
  CommonID_Card_Awake_Desc = {Text = "Rouse"},
  CommonID_Card_Curse_Desc = {
    Text = "Kartu gejala"
  },
  CommonID_Card_Defend_Desc = {
    Text = "Kartu Pertahanan"
  },
  CommonID_Card_Developing_Desc = {
    Text = "Dalam pengembangan"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Kartu Turunan"
  },
  CommonID_Card_Fraud_Desc = {Text = "Penipuan"},
  CommonID_Card_Imagery_Desc = {Text = "Bayangan"},
  CommonID_Card_KeeperSkill_Desc = {Text = "Kartu Geng"},
  CommonID_Card_Potion_Desc = {
    Text = "Kartu Ramuan"
  },
  CommonID_Card_Skill_Desc = {
    Text = "Kartu keterampilan"
  },
  CommonID_Card_State_Desc = {
    Text = "Kartu negara"
  },
  CommonID_Card_Strike_Desc = {
    Text = "Kartu Pukulan"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Kartu Roda Takdir"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Level Keterampilan Sihir"
  },
  CommonID_Challenge_Desc = {
    Text = "Penyelidikan"
  },
  CommonID_Change_Skill_Desc = {
    Text = "Ganti Keterampilan"
  },
  CommonID_Chinese_Desc = {
    Text = "Bahasa Mandarin"
  },
  CommonID_ChooseHandCard_Desc = {
    Text = "Pilih kartu di tangan"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Klik untuk keluar"
  },
  CommonID_ClickToView_Desc = {
    Text = "Lihat lebih detail"
  },
  CommonID_Click_Desc = {
    Text = "Klik untuk melanjutkan"
  },
  CommonID_Close_Desc = {Text = "Tutup"},
  CommonID_ComingSoon_Desc = {
    Text = "Mohon ditunggu dengan sabar"
  },
  CommonID_CommonAttr_Desc = {
    Text = "Bonus Atribut Umum"
  },
  CommonID_Common_Desc = {Text = "Umum"},
  CommonID_ContinuousSound_Desc = {
    Text = "Putar terus-menerus"
  },
  CommonID_CopperAchieve_Desc = {Text = "Tembaga"},
  CommonID_CountingStart_Desc = {
    Text = "Waktu hitung mundur di giliran kami dimulai"
  },
  CommonID_Custom_Desc = {Text = "Kustom"},
  CommonID_DE_Desc = {
    Text = "Jerman (alpha)"
  },
  CommonID_DPS_Desc = {Text = "Assault"},
  CommonID_DepressionHit_Desc = {
    Text = "Depresi setelah terkena pukulan"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Nonaktifkan keterampilan karakter utama"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Nonaktifkan Masyarakat"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Nonaktifkan Roda Takdir"
  },
  CommonID_Display_Desc = {Text = "Tampilan"},
  CommonID_DropdownList_Desc = {
    Text = "Daftar tarik-turun"
  },
  CommonID_EN_Desc = {
    Text = "Bahasa Inggris (GPT beta)"
  },
  CommonID_ES_Desc = {
    Text = "Spanyol (alpha)"
  },
  CommonID_Elite_Desc = {Text = "Elite"},
  CommonID_EmojiType_10_Desc = {
    Text = "Si Kecil Mythag"
  },
  CommonID_EmojiType_11_Desc = {Text = "Giliranku"},
  CommonID_EmojiType_12_Desc = {
    Text = "Kehidupan Sehari-hari Mythag"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "Mythag yang Bahagia"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "Tidak senang dengan Mythag"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "Kehidupan Sekolah"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "Hari yang damai"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "Bab Waktu Senggang"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "Perbandingan Hati Mythag"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "Liburan Mythag"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Mythag yang lembut"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Dongzhe Mythag"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Pesta Kue Jahe"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Berita Menarik di Kampus"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Penyelidik Mythag"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Teater Antara Mythag"
  },
  CommonID_EmojiType_25_Desc = {Text = "Lagu Saya"},
  CommonID_EmojiType_2_Desc = {
    Text = "Malam Sebelumnya yang Terlupakan"
  },
  CommonID_EmojiType_3_Desc = {
    Text = "Seratus Rupa Dunia"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Malam Melupakan Q"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Komunikasi Fase"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Mythag yang Bercahaya"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "Mythag Gila"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "Mudah Mythag"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Mythag Bijaksana"
  },
  CommonID_Enchant_Desc = {Text = "Orison"},
  CommonID_Entrance_Desc = {
    Text = "Pintu masuk pop-up"
  },
  CommonID_FALSE_Desc = {Text = "Tidak"},
  CommonID_FR_Desc = {
    Text = "Bahasa Prancis (alpha)"
  },
  CommonID_Forged_Desc = {Text = "Memperkuat"},
  CommonID_FreeBattlePos_Desc = {
    Text = "Bebas untuk maju"
  },
  CommonID_FullScreen_Desc = {
    Text = "Layar Penuh"
  },
  CommonID_Gender_Boy_Desc = {Text = "Pria"},
  CommonID_Gender_Girl_Desc = {Text = "Wanita"},
  CommonID_GetLikeLevel_Desc = {Text = "Fungsi"},
  CommonID_GmaeVoice_Desc = {
    Text = "Suara dalam game"
  },
  CommonID_GoldAchieve_Desc = {Text = "Emas"},
  CommonID_Hall_Desc = {Text = "Aula"},
  CommonID_HarvestAdd_Desc = {
    Text = "Hadiah tambahan untuk markas"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Kondisi penyelesaian misi: Memiliki salah satu Pembangun dari daftar"
  },
  CommonID_HeadType_1_Desc = {
    Text = "Atas Nama Kunci Perak"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Dokumen kosong"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Kemarin yang tidak pernah pudar"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Koleksi perangko"
  },
  CommonID_High_Desc = {Text = "Tinggi"},
  CommonID_Holy_Desc = {
    Text = "Sanctifikasi"
  },
  CommonID_ID_Desc = {
    Text = "Bahasa Indonesia (alpha)"
  },
  CommonID_IT_Desc = {
    Text = "Italia (alpha)"
  },
  CommonID_Image_Desc = {Text = "Gambar"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "Monster berniat menyerang dan memperkuat."
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "Monster berniat melakukan serangan dan melemahkan."
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "Monster berniat melakukan serangan dan melemahkan."
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Niat monster untuk menyerang dan bertahan"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "Monster memiliki niat untuk menyerang"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "Niat Monster untuk Memperkuat"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Niat monster Aliemus bukan serangan."
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Niat monster sangat Aliemus"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "Monster memiliki niat untuk melepaskan serangan terakhir."
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Niat Monster untuk Aliemus"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "Niat Monster untuk Memperkuat"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "Niat Monster untuk Memperkuat"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "Niat monster melemah"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "Niat monster untuk bertahan dan memperkuat"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Monster berniat melakukan pertahanan dan melemahkan."
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Monster berniat Pertahanan"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Monster berniat membuat pusing"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "Monster berniat melakukan serangan berat"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "Monster berniat melakukan serangan berat"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "Niat monster untuk memperkuat dengan kekuatan tinggi"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "Niat monster sangat melemah."
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "Niat monster tidak jelas"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "Niat monster tidak jelas"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "Niat monster tidak jelas"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "Niat monster tidak jelas"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "Niat monster tidak jelas"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "Niat monster tidak jelas"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "Niat monster tidak jelas"
  },
  CommonID_ItemManagement_Desc = {Text = "Item"},
  CommonID_JP_Desc = {
    Text = "Bahasa Jepang (alpha)"
  },
  CommonID_KR_Desc = {
    Text = "Bahasa Korea (alpha)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Keterampilan Karakter Utama"
  },
  CommonID_KeyType_1_Desc = {
    Text = "Bab Lupakan"
  },
  CommonID_KeyType_2_Desc = {
    Text = "Kekacauan realm"
  },
  CommonID_KeyType_3_Desc = {
    Text = "Alam laut dalam"
  },
  CommonID_KeyType_4_Desc = {
    Text = "Domain Caro"
  },
  CommonID_KeyType_5_Desc = {Text = "Alam ultra"},
  CommonID_Key_Desc = {Text = "Tombol"},
  CommonID_Language_Desc = {Text = "Bahasa"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "Batas level maksimum ditingkatkan"
  },
  CommonID_Low_Desc = {Text = "Rendah"},
  CommonID_Management_Desc = {
    Text = "Pergi ke Pengaturan"
  },
  CommonID_ManiaHit_Desc = {
    Text = "Serangan Mengamuk"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Kontrol Keseluruhan"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Kembalikan sumber daya yang lelah"
  },
  CommonID_MessagePush_Desc = {Text = "Notifikasi"},
  CommonID_Middle_Desc = {Text = "Cina"},
  CommonID_Modify_Desc = {
    Text = "Ketuk untuk mengubah"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "Satu gelombang kecil monster"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Musuh kecil tingkat dua"
  },
  CommonID_MotherTreeMonster_Desc = {Text = "Pohon ibu"},
  CommonID_MultiplierXP_Desc = {
    Text = "Penguatan pengalaman berlipat"
  },
  CommonID_Mute_Desc = {Text = "Bisukan"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "Pemimpin Non-Bangun"
  },
  CommonID_Open_Desc = {Text = "Buka"},
  CommonID_OperationImpossible_Desc = {
    Text = "Pemain tidak berhasil beroperasi karena berbagai alasan (kekurangan aritmetika, bukan giliran sendiri, disegel atau terolid dll.) (mengeluarkan kartu, meledak Aliemus)"
  },
  CommonID_OperationStop_Desc = {
    Text = "Waktu berpikir di giliran kami telah mencapai nilai maksimum (dikonfigurasi dalam tabel konstan)"
  },
  CommonID_Orange_Desc = {Text = "Emas"},
  CommonID_PT_Desc = {
    Text = "Bahasa Portugis (alpha)"
  },
  CommonID_PVP_Desc = {Text = "Traphase"},
  CommonID_PassiveSkill_Desc = {
    Text = "Keterampilan Pasif"
  },
  CommonID_PersonalProfile_Desc = {
    Text = "Profil Pribadi"
  },
  CommonID_PlayerEnter_Desc = {
    Text = "Permainan dimulai, pemain setelah memilih kartu"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Berkas Penjaga"
  },
  CommonID_Potency_Desc = {
    Text = "Mencerahkan"
  },
  CommonID_Privacy_Desc = {Text = "Privasi"},
  CommonID_Purple_Desc = {
    Text = "Pendulum waktu"
  },
  CommonID_RU_Desc = {
    Text = "Bahasa Rusia (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Efek cahaya merah"
  },
  CommonID_Red_Desc = {Text = "kutukan"},
  CommonID_Redeem_Desc = {Text = "Tukar"},
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Dialog terkait antara Pembangun di pihak lawan dan Pembangun di pihak kita"
  },
  CommonID_Relic_Desc = {Text = "Relic"},
  CommonID_Repair_Desc = {
    Text = "Pergi untuk memperbaiki"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Sumber daya yang diperlukan berkurang"
  },
  CommonID_SUP_Desc = {Text = "Chorus"},
  CommonID_SellCard_Desc = {
    Text = "Menjual kartu"
  },
  CommonID_ShortcutKey_Desc = {
    Text = "Tombol Pintasan"
  },
  CommonID_SilverAchieve_Desc = {Text = "Perak"},
  CommonID_Sin_Desc = {Text = "Dosa Asli"},
  CommonID_SkillReady_Desc = {
    Text = "Ketika tangki Aliemus penuh dan dapat diklik untuk meledak"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Tingkatkan Keterampilan"
  },
  CommonID_Slider_Desc = {
    Text = "Penggeser Nilai"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "Level Slot Awal"
  },
  CommonID_SoundBalance_Desc = {
    Text = "Keseimbangan Suara"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Kondisi penyelesaian misi: Percakapan komunikator yang ditentukan telah dipicu"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Salinan meningkatkan hasil produksi"
  },
  CommonID_Switch_Desc = {Text = "Sakelar"},
  CommonID_System_Desc = {Text = "Sistem"},
  CommonID_TH_Desc = {
    Text = "Bahasa Thai (alpha)"
  },
  CommonID_TRUE_Desc = {Text = "Ya"},
  CommonID_TR_Desc = {
    Text = "Turki (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "Mandarin Tradisional"
  },
  CommonID_T_Desc = {Text = "Warden"},
  CommonID_TaskCount_Desc = {Text = "Menghitung"},
  CommonID_TaskInProgress_Desc = {
    Text = "Sedang berlangsung"
  },
  CommonID_TaweiMonster_Desc = {
    Text = "Menara Tawil"
  },
  CommonID_Through1_Desc = {
    Text = "Keterampilan Pasif 1"
  },
  CommonID_Through2_Desc = {
    Text = "Keterampilan Pasif 2"
  },
  CommonID_Tips_Desc = {Text = "Petunjuk"},
  CommonID_TranslationLabel_Desc = {
    Text = "Label terjemahan resmi"
  },
  CommonID_Ulti_Skill_Desc = {Text = "Exalt"},
  CommonID_UtlSkill_Promote_Desc = {
    Text = "Muliakan Ekstrem"
  },
  CommonID_VN_Desc = {
    Text = "Bahasa Vietnam (alpha)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "Sangat tinggi"
  },
  CommonID_VeryLow_Desc = {
    Text = "Sangat rendah"
  },
  CommonID_View_Desc = {
    Text = "Lihat lebih lanjut"
  },
  CommonID_Voice_Desc = {Text = "Suara"},
  CommonID_Web_Desc = {
    Text = "Redirect halaman web"
  },
  CommonID_White_Desc = {
    Text = "Perak Putih"
  },
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Efek suara saat jendela tidak dalam fokus"
  },
  CommonID_Window_Desc = {Text = "Jendela"},
  CommonID_YellowGlow_Desc = {
    Text = "Efek cahaya kuning"
  }
})
return Text_CommonID
