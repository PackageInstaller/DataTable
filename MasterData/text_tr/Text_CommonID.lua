__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "Hesap"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "Maksimum Hasar"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "Maksimum Kat"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Tamamlama Süresi"
  },
  CommonID_AchieveType0_Desc = {
    Text = "Tüm Başarımlar"
  },
  CommonID_AchieveType1_Desc = {
    Text = "Büyüme Hikâyesi"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Soruşturma İşareti"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Muharebe Kaydı"
  },
  CommonID_AchieveType4_Desc = {
    Text = "Koruyucunun Canı"
  },
  CommonID_Add_State_Desc = {Text = "Durum Ekle"},
  CommonID_All_Desc = {Text = "Tümü"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Görev Tamamlanma Koşulu: Herhangi Bir Hikâyeyi Tetikle"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Görev Tamamlanma Koşulu: Herhangi Bir Girdinin Kilidini Aç"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Görev Tamamlanma Koşulu: Herhangi Bir Etkinliği Tetikle"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Görev Tamamlanma Koşulu: Herhangi Bir Eşya Elde Et"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Görev Tamamlanma Koşulu: Herhangi Bir Düğümü Tetikle"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Görev Tamamlanma Koşulu: Herhangi Bir Kalıntı Elde Et"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Görev Tamamlanma Koşulu: Herhangi Bir Seviyeyi·Tamamlandı"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Ödülleri Artırmak İçin Ata"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Özellik Güçlendirme"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Uyandıranın Ölümü"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Uyandıran Reis"
  },
  CommonID_BN_Desc = {
    Text = "Bengalce (alfa)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "Konuşlandırılamaz"
  },
  CommonID_Battle_Desc = {Text = "Savaş"},
  CommonID_Blue_Desc = {Text = "Mavi"},
  CommonID_Boss_Desc = {Text = "Reis"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "Tuş Bağlama"
  },
  CommonID_CN_Desc = {
    Text = "Basitleştirilmiş Çince"
  },
  CommonID_CardBorder_Desc = {
    Text = "Kart Görseli"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Yuvası Yükseltme"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "İleri İmgelem"
  },
  CommonID_Card_AttachPost_Desc = {Text = "Takip"},
  CommonID_Card_Awake_Desc = {Text = "Uyanış"},
  CommonID_Card_Curse_Desc = {Text = "Semptom"},
  CommonID_Card_Defend_Desc = {
    Text = "Savunma Kartı"
  },
  CommonID_Card_Developing_Desc = {
    Text = "Geliştirme Aşamasında"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Türetilmiş Kart"
  },
  CommonID_Card_Fraud_Desc = {
    Text = "Dolandırıcılık"
  },
  CommonID_Card_Imagery_Desc = {Text = "İmgeleme"},
  CommonID_Card_KeeperSkill_Desc = {
    Text = "Çete Kartı"
  },
  CommonID_Card_Potion_Desc = {
    Text = "İksir Kartı"
  },
  CommonID_Card_Skill_Desc = {
    Text = "Beceri Kartı"
  },
  CommonID_Card_State_Desc = {
    Text = "Durum Kartı"
  },
  CommonID_Card_Strike_Desc = {
    Text = "Darbe Kartı"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Kader Çarkı"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Beceri Kullanım Seviyesi"
  },
  CommonID_Challenge_Desc = {
    Text = "Soruşturma"
  },
  CommonID_Change_Skill_Desc = {
    Text = "Beceri Değiştir"
  },
  CommonID_Chinese_Desc = {Text = "Çince"},
  CommonID_ChooseHandCard_Desc = {
    Text = "Bir El Kartı Seç"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Çıkmak için Tıkla"
  },
  CommonID_ClickToView_Desc = {
    Text = "Görüntülemek için Tıkla"
  },
  CommonID_Click_Desc = {
    Text = "Atlamak için Tıkla"
  },
  CommonID_Close_Desc = {Text = "Kapat"},
  CommonID_ComingSoon_Desc = {
    Text = "Takipte kalın"
  },
  CommonID_CommonAttr_Desc = {
    Text = "Genel İstatistik Bonusu"
  },
  CommonID_Common_Desc = {Text = "Normal"},
  CommonID_ContinuousSound_Desc = {
    Text = "Oynamaya Devam Et"
  },
  CommonID_CopperAchieve_Desc = {Text = "Bakır"},
  CommonID_CountingStart_Desc = {
    Text = "Geri sayım bizim turumuzda başlar"
  },
  CommonID_Custom_Desc = {Text = "Özel"},
  CommonID_DE_Desc = {
    Text = "Almanca (alpha)"
  },
  CommonID_DPS_Desc = {Text = "Hücum"},
  CommonID_DepressionHit_Desc = {
    Text = "Vuruşta Bunalım"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Başkahraman Becerilerini Devre Dışı Bırak"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Ahiti Devre Dışı Bırak"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Kader Çarkını Devre Dışı Bırak"
  },
  CommonID_Display_Desc = {Text = "Görsel"},
  CommonID_DropdownList_Desc = {
    Text = "Açılır Liste"
  },
  CommonID_EN_Desc = {
    Text = "İngilizce (beta)"
  },
  CommonID_ES_Desc = {
    Text = "İspanyolca (alpha)"
  },
  CommonID_Elite_Desc = {Text = "Elit"},
  CommonID_EmojiType_10_Desc = {
    Text = "Küçük Mythag"
  },
  CommonID_EmojiType_11_Desc = {Text = "Sıram"},
  CommonID_EmojiType_12_Desc = {
    Text = "Mythag Günlüğü"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "Mutlu Mythag"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "Mutsuz Mythag"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "Okul Hayatı Bölümü"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "Huzurlu Bir Gün"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "Okul Sonrası"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "Kalp Atan Misag"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "Mythag Tatili"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Tombul Misag"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Noel Mythag"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Zencefilli Kurabiye Partisi"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Kampüs Söylenceleri"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Mythag Müfettişi"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Mythag Perde Arası"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "Saya'nın Şarkısı"
  },
  CommonID_EmojiType_2_Desc = {Text = "Mori Mori"},
  CommonID_EmojiType_3_Desc = {
    Text = "Dünyevi Harikalar"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Mori-Chibiler"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Traphase İletişimi"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Parlayan Misag"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "Çılgın Misag"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "Rahat Misag"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Bilgelik Misag"
  },
  CommonID_Enchant_Desc = {Text = "Yakarış"},
  CommonID_Entrance_Desc = {
    Text = "Açılır Giriş"
  },
  CommonID_FALSE_Desc = {Text = "Hayır"},
  CommonID_FR_Desc = {
    Text = "Fransızca (alpha)"
  },
  CommonID_Forged_Desc = {Text = "Geliştir"},
  CommonID_FreeBattlePos_Desc = {
    Text = "Ücretsiz Konuşlandırma"
  },
  CommonID_FullScreen_Desc = {Text = "Tam Ekran"},
  CommonID_Gender_Boy_Desc = {Text = "Erkek"},
  CommonID_Gender_Girl_Desc = {Text = "Kadın"},
  CommonID_GetLikeLevel_Desc = {Text = "İşlev"},
  CommonID_GmaeVoice_Desc = {Text = "Oyun Sesi"},
  CommonID_GoldAchieve_Desc = {Text = "Altın"},
  CommonID_Hall_Desc = {Text = "Lobi"},
  CommonID_HarvestAdd_Desc = {
    Text = "Artırılmış Yurt Ödülleri"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Görev Tamamlanma Koşulu: Herhangi Bir Uyandırıcıya Sahip Ol"
  },
  CommonID_HeadType_1_Desc = {
    Text = "Gümüş Anahtar Adına"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Chibi Vesikalık Fotoğraf"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Solmayan Dün"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Koleksiyon Pulu"
  },
  CommonID_High_Desc = {Text = "Yüksek"},
  CommonID_Holy_Desc = {
    Text = "Kutsallaştırma"
  },
  CommonID_ID_Desc = {
    Text = "Endonezce (alpha)"
  },
  CommonID_IT_Desc = {
    Text = "İtalyanca (alfa)"
  },
  CommonID_Image_Desc = {Text = "Görüntü"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "Canavar Niyeti: Saldırı & Güçlendirme"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "Canavar Niyeti: Saldırı & Zayıflatma"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "Canavar Niyeti: Saldırı & Zayıflatma"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Canavar Niyeti: Saldırı & Savunma"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "Canavar Niyeti: Saldırı"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "Canavar Niyeti: Güçlendirme"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Canavar Niyeti: Aliemus (Saldırı Dışı)"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Canavar Niyeti: Süper Aliemus"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "Canavar Niyeti: Serbest Bırak Sonu"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Canavar Niyeti: Aliemus"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "Canavar Niyeti: Güçlendirme"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "Canavar Niyeti: Güçlendirme"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "Canavar Niyeti: Zayıflatma"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "Canavar Niyeti: Savunma & Güçlendirme"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Canavar Niyeti: Savunma & Zayıflatma"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Canavar Niyeti: Savunma"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Canavar Niyeti: Sersemletme"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "Canavar Niyeti: Ağır Saldırı"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "Canavar Niyeti: Ağır Saldırı"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "Canavar Niyeti: Büyük Güçlendirme"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "Canavar Niyeti: Büyük Zayıflatma"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "Canavar Niyeti: Bilinmeyen Yaratık"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "Canavar Niyeti: Bilinmeyen Yaratık"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "Canavar Niyeti: Bilinmeyen Yaratık"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "Canavar Niyeti: Bilinmeyen Yaratık"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "Canavar Niyeti: Bilinmeyen Yaratık"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "Canavar Niyeti: Bilinmeyen Yaratık"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "Canavar Niyeti: Bilinmeyen Yaratık"
  },
  CommonID_ItemManagement_Desc = {Text = "Eşya"},
  CommonID_JP_Desc = {
    Text = "Japonca (alpha)"
  },
  CommonID_KR_Desc = {
    Text = "Korece (alpha)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Koruyucu Becerisi"
  },
  CommonID_KeyType_1_Desc = {
    Text = "Unutuş Destanı"
  },
  CommonID_KeyType_2_Desc = {Text = "Kaos"},
  CommonID_KeyType_3_Desc = {Text = "Aequor"},
  CommonID_KeyType_4_Desc = {Text = "Caro"},
  CommonID_KeyType_5_Desc = {Text = "Ultra"},
  CommonID_Key_Desc = {Text = "Düğme"},
  CommonID_Language_Desc = {Text = "Dil"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "Seviye Üst Sınırı Artışı"
  },
  CommonID_Low_Desc = {Text = "Düşük"},
  CommonID_Management_Desc = {
    Text = "Yönetim’e Git"
  },
  CommonID_ManiaHit_Desc = {
    Text = "Vuruşta Mani"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Genel Kontrol"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Tüketilen Kaynakları İade Et"
  },
  CommonID_MessagePush_Desc = {
    Text = "Bildirim Gönderimi"
  },
  CommonID_Middle_Desc = {Text = "Orta"},
  CommonID_Modify_Desc = {
    Text = "Değiştirmek için tıklayın"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "Seviye 1 Piyon"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Seviye 2 Piyon"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "\"Bereket Ana Ağacı\""
  },
  CommonID_MultiplierXP_Desc = {
    Text = "Çoklu DEN Artışı"
  },
  CommonID_Mute_Desc = {Text = "Sessizlik"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "Uyanmamış Reis"
  },
  CommonID_Open_Desc = {Text = "Aç"},
  CommonID_OperationImpossible_Desc = {
    Text = "Oyuncu çeşitli sebeplerle (yetersiz Arithmetica, oyuncu turunda olmama, Mühürlenmiş, Taşlaşmış olma vb.) eylem gerçekleştiremez (kart oynama, Yüceltme)."
  },
  CommonID_OperationStop_Desc = {
    Text = "Turumuzun biriken düşünme süresi, (sabitler tablosunda yapılandırılan) azami değere ulaşır"
  },
  CommonID_Orange_Desc = {Text = "Altın"},
  CommonID_PT_Desc = {
    Text = "Portekizce (alpha)"
  },
  CommonID_PVP_Desc = {Text = "Traphase"},
  CommonID_PassiveSkill_Desc = {
    Text = "Pasif Beceri"
  },
  CommonID_PersonalProfile_Desc = {Text = "Profil"},
  CommonID_PlayerEnter_Desc = {
    Text = "Kartlarını seçtikten sonra Oyun Başlar"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Koruyucu Profili"
  },
  CommonID_Potency_Desc = {
    Text = "Aydınlanma"
  },
  CommonID_Privacy_Desc = {Text = "Gizlilik"},
  CommonID_Purple_Desc = {
    Text = "Krono Sarkaç"
  },
  CommonID_RU_Desc = {
    Text = "Rusça (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Kırmızı Işık Etkisi"
  },
  CommonID_Red_Desc = {Text = "Lanet"},
  CommonID_Redeem_Desc = {
    Text = "Kullanmak için Git"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Düşman Uyanan ile müttefik Uyanan arasındaki diyalog"
  },
  CommonID_Relic_Desc = {Text = "Kalıntı"},
  CommonID_Repair_Desc = {
    Text = "Onarıma Git"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Kaynak Maliyeti Azaltıldı"
  },
  CommonID_SUP_Desc = {Text = "Koro"},
  CommonID_SellCard_Desc = {Text = "Kart Sat"},
  CommonID_ShortcutKey_Desc = {
    Text = "Kısayol Tuşu"
  },
  CommonID_SilverAchieve_Desc = {Text = "Gümüş"},
  CommonID_Sin_Desc = {
    Text = "İlk Günah"
  },
  CommonID_SkillReady_Desc = {
    Text = "Aliemus göstergesi dolup tıklandığında Yüceltme’yi serbest bırakabildiği an"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Beceri Yükseltme"
  },
  CommonID_Slider_Desc = {
    Text = "Değer Kaydırıcısı"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "Varsayılan Yuva Seviyesi"
  },
  CommonID_SoundBalance_Desc = {
    Text = "Ses Dengesi"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Görev Tamamlanma Koşulu: Belirlenmiş Diyaloğu Tetikle"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Artırılmış Zindan Çıktısı"
  },
  CommonID_Switch_Desc = {Text = "Değiştir"},
  CommonID_System_Desc = {Text = "Sistem"},
  CommonID_TH_Desc = {
    Text = "Tayca (alpha)"
  },
  CommonID_TRUE_Desc = {Text = "Evet"},
  CommonID_TR_Desc = {
    Text = "Türkçe (alfa)"
  },
  CommonID_TW_Desc = {
    Text = "Geleneksel Çince"
  },
  CommonID_T_Desc = {Text = "Muhafız"},
  CommonID_TaskCount_Desc = {Text = "Sayı"},
  CommonID_TaskInProgress_Desc = {
    Text = "Devam Ediyor"
  },
  CommonID_TaweiMonster_Desc = {
    Text = "Karanlık Tawil"
  },
  CommonID_Through1_Desc = {
    Text = "Pasif Beceri 1"
  },
  CommonID_Through2_Desc = {
    Text = "Pasif Beceri 2"
  },
  CommonID_Tips_Desc = {
    Text = "Soruşturma Devam Ediyor"
  },
  CommonID_TranslationLabel_Desc = {
    Text = "Resmi Çeviri Etiketi"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "Taşkınlık"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "Aşırı Taşkınlık"
  },
  CommonID_VN_Desc = {
    Text = "Vietnamca (alpha)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "Aşırı Yüksek"
  },
  CommonID_VeryLow_Desc = {
    Text = "Aşırı Düşük"
  },
  CommonID_View_Desc = {
    Text = "Kontrol Etmeye Git"
  },
  CommonID_Voice_Desc = {Text = "Ses."},
  CommonID_Web_Desc = {
    Text = "Sayfa Yönlendirme"
  },
  CommonID_White_Desc = {Text = "Gümüş"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Odak Dışıyken Ses Efekti"
  },
  CommonID_Window_Desc = {Text = "Pencere"},
  CommonID_YellowGlow_Desc = {
    Text = "Sarı Işık Etkisi"
  }
})
return Text_CommonID
