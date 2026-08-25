__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_PanelText = readonly({
  PanelText_Battle_UltiSkill_Painting_EX_Text_C_UltiSkill_Content = {
    Text = "Aşırı Yüceliş"
  },
  PanelText_Btn_Block_Window_Text_C_Display_Content = {
    Text = "Kartı Göster"
  },
  PanelText_Btn_Block_Window_Text_C_Hide_Content = {
    Text = "Kartları Sakla"
  },
  PanelText_Btn_Get_Text_Name_Content = {Text = "Al"},
  PanelText_Com_RedDot_Text_C_GroupNew_Content = {Text = "YENİ"},
  PanelText_Com_RedDot_Text_C_New_Content = {Text = "YENİ"},
  PanelText_Com_Text_New_Text_C_New_Content = {Text = "YENİ"},
  ["PanelText_GmPanel_Text_C_Battle_Test (1)_Content"] = {Text = "Savaş 2.0"},
  PanelText_GmPanel_Text_C_Battle_Test2_Content = {
    Text = "PvP Savaşı"
  },
  PanelText_GmPanel_Text_C_Battle_Test_Content = {
    Text = "PvP Eşleştirme"
  },
  PanelText_GmPanel_Text_C_Gb_Content = {Text = "Kapat"},
  PanelText_GmPanel_Text_C_Hm_Content = {
    Text = "Grafik Kalitesi: Yüksek/Düşük"
  },
  PanelText_GmPanel_Text_C_Placeholder_Content = {Text = "Ara"},
  PanelText_GmPanel_Text_C_Xy_Content = {
    Text = "Test Protokolü"
  },
  PanelText_GmPanel_Text_C_Yc_Content = {
    Text = "GM Panelini Gizle"
  },
  PanelText_GmParamEquipPanel_Text_C_Fs_Content = {Text = "Gönder"},
  PanelText_GmParamEquipPanel_Text_C_Tc_Content = {Text = "Çıkış"},
  PanelText_GmParamPanel_Text_C_Fs_Content = {Text = "Gönder"},
  PanelText_GmParamPanel_Text_C_Param_Content = {Text = "Ayarlar"},
  PanelText_GmParamPanel_Text_C_Tc_Content = {Text = "Çıkış"},
  PanelText_Icon_Common_Text_C_New_Content = {Text = "YENİ"},
  PanelText_Icon_Common_Text_C_NoEquip_Content = {
    Text = "Kuşanılamaz"
  },
  PanelText_Item_Battle_AwakerSkill_1_Text_C_CD_Content = {
    Text = "Bekleme Süresinde..."
  },
  PanelText_Item_Battle_AwakerSkill_1_Text_C_Ready_Content = {
    Text = "Taşkınlık"
  },
  PanelText_Panel_Announcement_Text_C_Panel_Title_Content = {Text = "Duyuru"},
  PanelText_Panel_Battle_Monster_Information_Text_C_Monster_Content = {
    Text = "Canavarın Niyeti"
  },
  PanelText_Panel_Battle_Monster_Information_Text_C_Story_Content = {
    Text = "Canavarın Hikâyesi"
  },
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Canel_Content = {Text = "İptal"},
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Confirm_Content = {Text = "Onayla"},
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Canel_Content = {Text = "İptal"},
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Enter_Content = {
    Text = "Meydan Okuma"
  },
  PanelText_Panel_Gm_PVP_Text_C_Canel_Content = {Text = "İptal"},
  PanelText_Panel_Gm_PVP_Text_C_Confirm_Content = {Text = "Onayla"},
  PanelText_Panel_Loading_Text_C_Repair_Content = {Text = "Düzelt"},
  PanelText_Popup_Gm_Effect_Side_Text_Content = {
    Text = "Etkiyi Düzenle"
  },
  PanelText_Popup_Gm_Effect_Text_Cancel_Content = {Text = "Kapat"},
  PanelText_Popup_Gm_Effect_Text_Confirm_Content = {Text = "Onayla"},
  PanelText_RedPoint_New_Text_C_New_Content = {Text = "YENİ"},
  PanelText_Simple_List_Panel_Text_Content = {Text = "Kapat"},
  PanelText_Text_C_Activate_Text_C_Activate_Content = {
    Text = "Uyarıcı Malzemeler"
  },
  PanelText_UI_Address_Panel_Main_Text_C_NoTask1_Content = {Text = "Kişi Seç"},
  PanelText_UI_Address_Panel_Main_Text_C_Title_Content = {
    Text = "İletişimci"
  },
  PanelText_UI_Address_Panel_Main_Text_Time_Content = {
    Text = "Seçim yapmak için listeye tıkla"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_C_NoTask_Content = {
    Text = "Yeni mesaj yok"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Title_Content = {
    Text = "İletişimci"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Achievement_Content = {
    Text = "Ahitleri Sökme"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Alchemy_Content = {
    Text = "Malzeme Sentezi"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Permute_Content = {
    Text = "Malzeme Dönüşümü"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Recast_Content = {
    Text = "Ahit Yeniden Basımı"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveItem_Content = {
    Text = "Malzeme Çöküşü"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveWeapon_Content = {
    Text = "Çark Sökme"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_Title_Content = {Text = "Simya"},
  PanelText_UI_Alchemy_Popup_Break_Down_Placeholder_Content = {
    Text = "Cevabı girmek için tıkla"
  },
  PanelText_UI_Alchemy_Popup_MyTeam_Awaker_List_Optimize_Text_Btn_Save_Content = {Text = "Kaydet"},
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Name_Content = {Text = "İkame"},
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Possess_Tips_Content = {
    Text = "Değiştirilmek Üzere"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Tips_Content = {
    Text = "Söküm için alınabilir eşya yok"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Title_Content = {
    Text = "İkame İçin Gerekli Malzemeler"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Whole_Content = {
    Text = "Tümünü Seç"
  },
  PanelText_UI_Alchemy_Popup_Recast_Text_C_Name_Content = {
    Text = "Yeniden Baskı"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_All_Content = {
    Text = "Tümünü Seç"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Cap_Content = {
    Text = "Seviye Maksimumda"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNum_Content = {Text = "Miktar"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Mail_Content = {Text = "Kurallar"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_MaterialsNull_Content = {
    Text = "İlgili Ahit yok"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "Düz Konum sınırına ulaşıldı"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Null_Content = {
    Text = "Lütfen sökülecek eşyayı seçin"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Resolve_Content = {
    Text = "Elde etmek için parçala"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Sel_Content = {Text = "Seçildi"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Screen_Content = {Text = "Filtre"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips1_Content = {Text = "I"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips2_Content = {Text = "II"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips3_Content = {Text = "III"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips4_Content = {Text = "IV"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips5_Content = {Text = "V"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips6_Content = {Text = "VI"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Confirm_Content = {Text = "Onayla"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Reset_Content = {Text = "Sıfırla"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle1_Content = {Text = "Set"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle2_Content = {Text = "Konum"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle3_Content = {
    Text = "Ana Özellik"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle4_Content = {
    Text = "Alt Özellik"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_SiftTitle_Text_C_Tips_Content = {Text = "Seç"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_All_Content = {
    Text = "Tümünü Seç"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Cap_Content = {
    Text = "Seviye Maksimumda"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNum_Content = {Text = "Miktar"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_MaterialsNull_Content = {
    Text = "İlgili Ahit yok"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_NormotopiaCap_Content = {
    Text = "Yükseliş Maksimumda"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Null_Content = {
    Text = "Lütfen sökülecek eşyayı seçin"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Resolve_Content = {
    Text = "Elde etmek için parçala"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Sel_Content = {Text = "Seçildi"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_All_Content = {
    Text = "Tümünü Seç"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Cap_Content = {
    Text = "Seviye Maksimumda"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNum_Content = {Text = "Miktar"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Mail_Content = {Text = "Kurallar"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "Düz Konum sınırına ulaşıldı"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Null_Content = {
    Text = "Lütfen sökülecek eşyayı seçin"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Resolve_Content = {
    Text = "Elde etmek için parçala"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Sel_Content = {Text = "Seçildi"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_WeaponNull_Content = {
    Text = "İlgili Kader Çarkı yok"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_All_Content = {
    Text = "Tümünü Seç"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Cap_Content = {
    Text = "Seviye Maksimumda"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNum_Content = {Text = "Miktar"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_NormotopiaCap_Content = {
    Text = "Yükseliş Maksimumda"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Null_Content = {
    Text = "Lütfen sökülecek eşyayı seçin"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Resolve_Content = {
    Text = "Elde etmek için parçala"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Sel_Content = {Text = "Seçildi"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_WeaponNull_Content = {
    Text = "İlgili Kader Çarkı yok"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Name_Content = {Text = "Sök"},
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Whole_Content = {
    Text = "Tümünü Seç"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_None_Tips_Content = {
    Text = "Soldan sökülecek eşyaları seç."
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Possess_Tips_Content = {
    Text = "Sökme Üzeresin"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Slider_Tips_Content = {
    Text = "Sökme Sayısı"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Tips_Content = {
    Text = "Sökülecek malzeme yok"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Title_Content = {
    Text = "Sökmeden elde edilen malzemeler"
  },
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Have_Content = {Text = "EVET"},
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Not_Content = {Text = "Boş"},
  PanelText_UI_Announcement_Item_Title_Text_New_Info_Content = {Text = "YENİ"},
  PanelText_UI_Awaker_Button_Addition_Text_C_Tips_Content = {Text = "Bonus"},
  PanelText_UI_Awaker_Item_Info_Text_C_Attribute_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Attributes_Title_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Configuration_Content = {Text = "Dizilim"},
  PanelText_UI_Awaker_Item_Info_Text_C_Grade_Content = {
    Text = "Koruyucu TP"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_High_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Item_Info_Text_C_Level_Content = {Text = "Sv."},
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Content = {Text = "Yakınlık"},
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Title_Content = {Text = "Yakınlık"},
  PanelText_UI_Awaker_Item_Info_Text_C_Name1_Content = {Text = "İsim"},
  PanelText_UI_Awaker_Item_Info_Text_C_Name2_Content = {Text = "Stil ."},
  PanelText_UI_Awaker_Item_Info_Text_C_No_Content = {
    Text = "Elde Edilmedi"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Normal_Content = {Text = "Seviye 60"},
  PanelText_UI_Awaker_Item_Info_Text_C_Potential_Content = {
    Text = "Gnostik İlerleme"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Score_Content = {Text = "Skor ."},
  PanelText_UI_Awaker_Item_Info_Text_C_Score_Force_Content = {
    Text = "Dövüş Gücü"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Title_Content = {Text = "Diyar"},
  PanelText_UI_Awaker_Item_Info_Text_C_Xx_Content = {
    Text = "Ayrıntılar"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Full_Content = {
    Text = "Aydınlanma dolu"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Got_Content = {Text = "Uyanış"},
  PanelText_UI_Awaker_Item_List_Text_C_Already_Content = {
    Text = "Zaten Sahip"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Disable_Content = {
    Text = "Değiştirilemez"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Full_Content = {
    Text = "Tamamen Aydınlanmış"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Click_Content = {Text = "Sıfırla"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Content = {Text = "Sıfırla"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Click_Content = {
    Text = "Aydınlanma"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Content = {
    Text = "Aydınlanma"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Click_Content = {Text = "Arşiv"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Content = {Text = "Arşiv"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Click_Content = {Text = "Ahit"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Content = {Text = "Ahit"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Click_Content = {Text = "Yetenek"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Content = {Text = "Yetenek"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Click_Content = {Text = "Durum"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Content = {Text = "Durum"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_TalentSelected_Content = {Text = "Yetenek"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Talent_Content = {Text = "Yetenek"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Click_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Consume_Content = {
    Text = "Köken Formunu açmak için aşağıdaki eşyalar tüketilecek. Emin misin?"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_1_Content = {Text = "İptal"},
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_2_Content = {Text = "Onayla"},
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Title_Content = {
    Text = "Köken Kilidi Açma Onayı"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Click_Content = {Text = "Evrensel"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Content = {Text = "Evrensel"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Click_Content = {
    Text = "Meydan Okuma Modu"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Content = {
    Text = "Meydan Okuma Modu"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Current_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Lower_Content = {
    Text = "Sonraki Seviye"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Lv_Content = {Text = "Sv."},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Mad_Content = {
    Text = "Aşırı Yüceltme Kilidi Açıldı"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Solved_Content = {
    Text = "Kilidi Açıldı"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Unsolved_Content = {Text = "Kilitli"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_WillSolved_Content = {Text = "Açılacak"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Originally_Lv_Content = {Text = "Sv."},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Ranking_Content = {Text = "Önizleme"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Skill_Story_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Solved_Content = {
    Text = "Kilidi Açıldı"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Click_Content = {
    Text = "Soruşturma Modu"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Content = {
    Text = "Soruşturma Modu"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Unsolved_Content = {Text = "Kilitli"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_CN_Content = {Text = "Etkin"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_EN_Content = {Text = "Gereklilik"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_ZN_Content = {Text = "Gereklilik"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_WillSolved_Content = {Text = "Açılacak"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Solved_Content = {
    Text = "Kilidi Açıldı"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Unsolved_Content = {Text = "Kilitli"},
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_1_Content = {
    Text = "Yaratılış Dönüşü"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_2_Content = {
    Text = "Gelişim Sıfırlama"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_1_Content = {
    Text = "Sıfırlama Önizlemesi"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_2_Content = {
    Text = "Sıfırlama Önizlemesi"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_3_Content = {
    Text = "Sıfırlama Önizlemesi"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_TipDesc_Content = {
    Text = "'Gelişim Sıfırlama' veya 'Aydınlanma Sıfırlama'dan sonra artık 'Yaratılış Dönüşü' gerçekleştiremezsin."
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Introduce_Content = {Text = "Gereklilik"},
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Click_Content = {
    Text = "Meydan Okuma Modu"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Content = {
    Text = "Meydan Okuma Modu"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Click_Content = {Text = "Özel"},
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Content = {Text = "Özel"},
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Click_Content = {
    Text = "Soruşturma Modu"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Content = {
    Text = "Soruşturma Modu"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Warning_CN_Content = {Text = "Etkin"},
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Warning_ZN_Content = {Text = "Gereklilik"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Attribute_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Full_Content = {
    Text = "Maksimum Seviyeye Ulaşıldı"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_High_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Insufficient_Content = {
    Text = "Uyandıran’ın Yüceltme seviyesi yetersiz"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Lv_1_Content = {Text = "Sv."},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Lv_Content = {Text = "Sv."},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Maniac_Content = {
    Text = "Taşkınlık"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Material_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_1_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_2_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_3_Content = {
    Text = "Sonraki Seviye"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_4_Content = {
    Text = "Sonraki Seviye"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Normal_Content = {Text = "Azami Sv."},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_PressTip_Content = {
    Text = "Ayrıntılar için her karta uzun basarak yakınlaştır."
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Skill_Tag_Content = {
    Text = "Taşkınlık"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Tale_Content = {
    Text = "Bir Hikâye..."
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Text_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Attribute_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Maniac_Content = {
    Text = "Taşkınlık"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Material_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_1_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_2_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_3_Content = {
    Text = "Sonraki Seviye"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_4_Content = {
    Text = "Sonraki Seviye"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Tale_Content = {
    Text = "Bir Hikâye..."
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Text_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Item_Story_Text_1_Content = {Text = "Giriş"},
  PanelText_UI_Awaker_Item_Story_Text_C_Bg_Content = {Text = "Bilgi"},
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Material_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Tips_Content = {
    Text = "Otomatik Yerleştir"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_Confirm_Content = {Text = "Yükseltme"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_2_Content = {
    Text = "İkinci Seçenek"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_3_Content = {
    Text = "Üçüncü Seçenek"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_Content = {
    Text = "Önkoşullar"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Material_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_New_Content = {
    Text = "Yeni Beceri Etkinleştirilebilir"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Title_Content = {
    Text = "Önkoşullar <WordSize20:(Birini Seç)>"
  },
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Prop_Title_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Tips_Content = {
    Text = "Ayrıntılar"
  },
  PanelText_UI_Awaker_Item_Trinket_Detail_Text_C_Empty_Content = {
    Text = "Ahitleri Seç"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Deplete_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Fast_Content = {
    Text = "Hızlı Yerleştir"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_1_Content = {Text = "Yükseltme"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_2_Content = {
    Text = "Transkripsiyon"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_3_Content = {Text = "Yükseltme"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Refinement_Content = {
    Text = "Ahit Ayrıntıları"
  },
  PanelText_UI_Awaker_Item_Trinket_Show_Text_C_Accessories_Content = {Text = "Ahitler"},
  PanelText_UI_Awaker_Item_Trinket_Show_Text_C_Covenant_Content = {Text = "Ahitler"},
  PanelText_UI_Awaker_Item_Voice_Text_1_Content = {Text = "Giriş"},
  ["PanelText_UI_Awaker_Item_Voice_Text_C_ Voice_Content"] = {
    Text = "Seslendirme Sanatçısı"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Normal_Content = {Text = "Savaş"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Select_Content = {Text = "Savaş"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Normal_Content = {Text = "Günlük"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Select_Content = {Text = "Günlük"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Information_Content = {Text = "Bilgi"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Normal_Content = {Text = "Traphase"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Select_Content = {Text = "Traphase"},
  PanelText_UI_Awaker_Item_Weapon_Refine_Text_C_Coin_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Blackpool_Content = {
    Text = "Önizlemeye Dön"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_3_Content = {
    Text = "Yaratılış Dönüşü"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_4_Content = {
    Text = "Yığın İz Sürme"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Cost_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Current_Content = {
    Text = "Mevcut Etki"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Expend_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Fast_Content = {
    Text = "Hızlı Yerleştir"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Full_Content = {
    Text = "Maksimum Seviye"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_1_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_2_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_3_Content = {
    Text = "Yığılmış"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_4_Content = {
    Text = "Yığılmış"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_5_Content = {Text = "Sonraki"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_6_Content = {Text = "Sonraki"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Next_Content = {
    Text = "<Blue:Sonraki Aşama Etkisi>"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Overlay_Content = {
    Text = "Önizlemeye Dön"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Level_Content = {
    Text = "WoD Yükseliş Rütbesi"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Name_Content = {Text = "Yükseliş"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Title_Content = {
    Text = "Malzeme Seç"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Warning_Content = {
    Text = "Yükseliş Seviye Sınırına Ulaşıldı"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_BackTraceTip_Content = {
    Text = "\"Yükseliş Sıfırlama\"yı kullandıktan sonra \"Yaratılış Dönüşü\" artık gerçekleştirilemez."
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_Title_Content = {
    Text = "WoD Ayrıntıları"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Click_Content = {Text = "Sıfırla"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Content = {Text = "Sıfırla"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Breakthrough_Content = {Text = "Yüceltme"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Enhance_Content = {Text = "Geliştir"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Equip_Content = {
    Text = "Kuşanılmış"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Fast_Content = {
    Text = "Hızlı Yerleştir"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_1_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Refine_Content = {Text = "Yükseliş"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Click_Content = {Text = "Yükseliş"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Content = {Text = "Yükseliş"},
  ["PanelText_UI_Awaker_PanelStory_Main_Text_C_ Describe_Content"] = {Text = "Açıklama"},
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Message_Content = {
    Text = "Uyandıran Bilgisi"
  },
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Story_Content = {
    Text = "Bir Hikâye..."
  },
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Title_Content = {
    Text = "Temel Bilgiler"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_1_Content = {
    Text = "Normal Form"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_2_Content = {
    Text = "Normal Form"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_3_Content = {
    Text = "Normal Form"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_1_Content = {
    Text = "Köken Formu"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_2_Content = {
    Text = "Köken Formu"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_3_Content = {
    Text = "Köken Formu"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Null_Content = {
    Text = "Bu parça için alınabilir Ahit yok"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Strengthen_Content = {Text = "Geliştir"},
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Title_Content = {
    Text = "Ahit Bağlama"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_UnBindAll_Content = {
    Text = "Tümünün Bağını Çöz"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Contrast_Content = {
    Text = "Karşılaştır"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info1_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info2_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info3_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info4_Content = {Text = "Hiza"},
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty1_Content = {
    Text = "Soldan bir WoD seç"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty_Content = {
    Text = "Soldan bir WoD seç"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Unlock_Content = {
    Text = "İkinci WoD’u Açmak için\nUyandıran’ı Yücelt"
  },
  PanelText_UI_Awaker_Popup_Attribute_Detail_Text_C_Title_Content = {
    Text = "Özellik Ayrıntıları"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_1_Content = {
    Text = "Ayrıntıları Görüntüle"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_2_Content = {Text = "Onayla"},
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_NoTask_Content = {
    Text = "Sıfırlama için alınabilir eşya yok"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Title_Content = {
    Text = "Bir Eşya Seç"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_1_Content = {
    Text = "Standart Uyandırıcı"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_2_Content = {
    Text = "Sınırlı Uyandıran"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_3_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_BindTip_Content = {
    Text = "Diğer Uyandırıcılar tarafından kuşanılan veya kadro/plan/destek içinde bulunan Ahitler otomatik olarak kaldırıldı"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Tip_Content = {
    Text = "Aşağıdaki Ahit bağlansın mı?"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Title_Content = {
    Text = "Bağlamayı Değiştirme Onayı"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Cancel_Name_Content = {Text = "İptal"},
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Confirm_Name_Content = {Text = "Onayla"},
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Tip_Content = {
    Text = "Gerekli malzemeler yetersiz.\nBunun yerine aşağıdaki malzemeleri tüketmek ister misiniz?"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Title_Content = {Text = "İpucu"},
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Expired_Content = {
    Text = "Aşağıdaki eşyaların süresi doldu ve artık kullanılamaz."
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Title_Content = {
    Text = "Eşyaların Süresi Doldu"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_No_Trinket_Content = {
    Text = "Alınabilir malzeme yok"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_Title_Content = {Text = "Ahit Seç"},
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Content_Content = {
    Text = "Seviye Maksimum"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Title_Content = {
    Text = "Seviye Atla"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Xuyao_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Popup_MyTeam_List_Text_C_William_Content = {
    Text = "Alınabilir yükseltme malzemesi yok"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Coin_Count_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Material_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Popup_Potential_Text_C_Name_Content = {
    Text = "Gnostik İlerleme"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Title_Content = {
    Text = "Seviye Üst Sınırı Artışı"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Preview_Content = {
    Text = "Sıfırlamadan sonra aşağıdaki malzemeleri elde edebilirsin."
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Title_Content = {
    Text = "Sıfırlama Önizlemesi"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Content_Content = {
    Text = "Seviye Sınırı"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Title_Content = {
    Text = "Yetenek Yükseltme"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Xuyao_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Condition_Content = {
    Text = "Açılma Koşulları"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Current_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_High_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Lower_Content = {
    Text = "Sonraki Seviye"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Lv_Content = {Text = "Sv."},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Normal_Content = {Text = "Azami Sv."},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Warning_EN_Content = {
    Text = "Önkoşullar"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_Require_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Popup_Tip_Preview_Text_C_Title_Content = {
    Text = "Malzeme Önizlemesi"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Info_Content = {
    Text = "Kapatmak için boş bir alana tıkla."
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_New_Content = {
    Text = "Yeni Beceri Etkinleştirilebilir"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Succeed_Content = {
    Text = "Başarıyla Yüceltildi"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Breakthrough_Content = {
    Text = "Senkronizasyon Gereksinimi"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Now_Content = {Text = "Mevcut"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Reward_Content = {
    Text = "Seviye Ödülleri"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Screening_Content = {
    Text = "Ödül Alındı"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Tips_Content = {
    Text = "Görüntüle"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Title_Content = {Text = "Yakınlık"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Unlock_Content = {
    Text = "Arşiv Kilidi Açıldı"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_illustrate_Content = {Text = "Kurallar"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_Name_Content = {Text = "Al"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Activation_Content = {Text = "Etkin"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Lv_Content = {
    Text = "Seviye Üst Sınırı Artışı"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Content = {
    Text = "Seviye Üst Sınırı Artışı"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Name_Content = {
    Text = "Aşırı Yüceliş"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Activation_Content = {Text = "Etkin"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Name_Content = {
    Text = "Mutlak Aksiyom"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_Activation_Content = {
    Text = "Etkin Değil"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_MaxMad_Activation_Content = {
    Text = "Etkin Değil"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Solved_Content = {
    Text = "Kilidi Açıldı"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Title_Content = {
    Text = "Kişilik Derinleşmesi"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unlock_Content = {
    Text = "Özellik Güçlendirme"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unsolved_Content = {Text = "Kilitli"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_WillSolved_Content = {Text = "Açılacak"},
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Material_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Reward_Content = {Text = "Ödül"},
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Title_Content = {Text = "Önizleme"},
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_Screening_Content = {
    Text = "Ödül Alındı"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_BindTip_Content = {
    Text = "Bağlandıktan sonra, Ahit'in ana niteliği ek olarak 50% artırılır!"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Bind_Content = {
    Text = "Ahit Bağlama"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Empty_Suit_Content = {
    Text = "Etkin bir set etkisi yok"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Foundation_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Rule_Content = {Text = "Kurallar"},
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Suit_Content = {Text = "Set Etkisi"},
  PanelText_UI_Awaker_Popup_Trinket_Change_Text_C_Equipped_Content = {
    Text = "Kuşanılmış"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_AutoRefinement_Content = {
    Text = "Otomatik Transkripsiyon"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Empty_Content = {
    Text = "Yeni Alt Özellikler atamak için Yazıya Dök"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Exchange_Content = {Text = "Ayarlar"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Foundation_Content = {
    Text = "Orijinal Alt Özellikler"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Hoist_Content = {
    Text = "Yeni Alt Özellikler"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_1_Content = {
    Text = "Transkripsiyon"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_2_Content = {Text = "Değiştir"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_No_Entries_Content = {
    Text = "Özellik yok"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Skip_Content = {
    Text = "Animasyonu Atla"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Text_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_illustrate_Content = {
    Text = "Transkripsiyon Talimatları"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Filtrate_Content = {
    Text = "SSR ve Altı Malzemeler"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Shortcut_Content = {
    Text = "Hızlı Yerleştir"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Upper_Limit_Content = {
    Text = "Maksimum Seviyeye Ulaşıldı"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_List_Text_C_None_Content = {
    Text = "Kuşanılmamış Kader Çarkı yok"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_1_Content = {
    Text = "Ahitleri Seç"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_2_Content = {
    Text = "Etkin bir set etkisi yok"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Foundation_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Suit_Content = {Text = "Set Etkisi"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_1_Normal_Content = {Text = "I"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_1_Select_Content = {Text = "I"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_2_Normal_Content = {Text = "II"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_2_Select_Content = {Text = "II"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_3_Normal_Content = {Text = "III"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_3_Select_Content = {Text = "III"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_4_Normal_Content = {Text = "IV"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_4_Select_Content = {Text = "IV"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_5_Normal_Content = {Text = "V"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_5_Select_Content = {Text = "V"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_6_Normal_Content = {Text = "VI"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_6_Select_Content = {Text = "VI"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Contrast_Content = {
    Text = "Karşılaştır"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Empty_Content = {
    Text = "Ahitleri Seç"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_None_Content = {
    Text = "Bu parça için alınabilir Ahit yok"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Notselected_Content = {
    Text = "Ahitleri Seç"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Suit_Content = {Text = "Set Etkisi"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_1_Normal_Content = {Text = "I"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_1_Select_Content = {Text = "I"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_2_Normal_Content = {Text = "II"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_2_Select_Content = {Text = "II"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_3_Normal_Content = {Text = "III"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_3_Select_Content = {Text = "III"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_4_Normal_Content = {Text = "IV"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_4_Select_Content = {Text = "IV"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_5_Normal_Content = {Text = "V"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_5_Select_Content = {Text = "V"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_6_Normal_Content = {Text = "VI"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_6_Select_Content = {Text = "VI"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_None_Content = {
    Text = "Kullanılmamış Ahit yok"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Consume_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Deplete_Content = {Text = "Malzemeler"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Exchange_Content = {Text = "Ayarlar"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Content = {
    Text = "Hızlı Yerleştir"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_High_Content = {Text = "Seviye +1"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Normal_Content = {Text = "Seviye +1"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_MaxLevel_Content = {Text = "Geliştir"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_High_Content = {
    Text = "Seviyeyi En Yükseğe Çıkar"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_Normal_Content = {
    Text = "Seviyeyi En Yükseğe Çıkar"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Name_3_Content = {Text = "Yükseltme"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Title_Content = {
    Text = "Koruyucu TP"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_AutoSelect_Content = {
    Text = "Otomatik Seçim"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Cancel_Content = {Text = "İptal"},
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Confirm_Content = {
    Text = "Ahit'in Bağını Çöz"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_NeedTrinket_Content = {
    Text = "Ahit Gerekli"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Title_Content = {
    Text = "Ahit'in Bağını Çöz"
  },
  PanelText_UI_Awaker_Popup_Whole_Body_Text_C_Reveal_Content = {Text = "Gizli"},
  PanelText_UI_Awaker_Popup_illustrate_Tips_Text_C_Title_Content = {
    Text = "Ek Açıklaması"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Tips_Content = {
    Text = "Genel Bakış"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Title_Content = {
    Text = "Uyandırıcı Yetenek"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Type_Content = {Text = "Tür"},
  PanelText_UI_Awaker_Weapon_Enhance_Success_Text_C_Succeed_Content = {
    Text = "Geliştirilmiş"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Info_Content = {
    Text = "Kapatmak için boş bir alana tıkla."
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Succeed_Content = {
    Text = "Yükseltildi"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Attribute_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Choose_Content = {
    Text = "Uyandıran Seç"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Helicopter_Content = {
    Text = "Yükseltme Önizlemesi"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Skill_Content = {Text = "Yetenek"},
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Title_Content = {
    Text = "Uyandıran Güçlendirmesi"
  },
  PanelText_UI_Bag_Item_Appearance_Text_C_Got_Content = {Text = "Edinildi"},
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_AavtarName_Content = {
    Text = "Avatar ve İfade"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Avatar_Info_Content = {
    Text = "Ayrıntı Önizlemesi"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Source_Content = {Text = "Kaynak"},
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Time_Content = {
    Text = "Kalan Geçerlilik Süresi:"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_AavtarName_Content = {
    Text = "Avatar ve İfade"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "Ayrıntı Önizlemesi"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "Müfreze Etkisi:"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Source_Content = {Text = "Kaynak Al"},
  PanelText_UI_Bag_Item_Detail_Text_C_Time_Content = {
    Text = "Kalan Geçerlilik Süresi"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Attack_Content = {Text = "Temel SLD"},
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Defense_Content = {Text = "Temel SAV"},
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Physique_Content = {Text = "Temel KON"},
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Full_Content = {
    Text = "Aydınlanma dolu"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Title_Content = {
    Text = "Uyandıran Kırık Parça Seç"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Yes_Content = {
    Text = "Zaten Sahip"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Cancel_Name_Content = {
    Text = "Ayrıntıları Görüntüle"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Confirm_Name_Content = {Text = "Onayla"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_BtnName_Content = {Text = "Al"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Emoji_Content = {Text = "İfade"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_NoTask_Content = {
    Text = "Tüm Kostümler elde edildi"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_RatePreview_Content = {
    Text = "Olasılık Önizlemesi"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Title_Content = {
    Text = "Görünüm Önizlemesi"
  },
  PanelText_UI_Bag_Panel_Main_Text_AmountName_Content = {Text = "Miktar"},
  PanelText_UI_Bag_Panel_Main_Text_C_2_Select_Content = {Text = "Düzen"},
  PanelText_UI_Bag_Panel_Main_Text_C_Cap_Content = {
    Text = "Seviye Maksimumda"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_None2_Content = {Text = "Eşya Yok"},
  PanelText_UI_Bag_Panel_Main_Text_C_NormotopiaCap_Content = {
    Text = "Yükseliş Maksimumda"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Replacement_Content = {Text = "İkame"},
  PanelText_UI_Bag_Panel_Main_Text_C_Resolve_Content = {Text = "Sök"},
  PanelText_UI_Bag_Panel_Main_Text_C_Synthesis_Content = {Text = "Sentezle"},
  PanelText_UI_Bag_Panel_Main_Text_C_recast_Content = {
    Text = "Yeniden döv"
  },
  PanelText_UI_Bag_Panel_Main_Text_Intensify_Content = {Text = "Geliştir"},
  PanelText_UI_Bag_Panel_Main_Text_Normotopia_Content = {Text = "Yükseliş"},
  PanelText_UI_Bag_Panel_Main_Text_Title_Content = {Text = "Envanter"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_BtnName_Content = {Text = "Al"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Emoji_Content = {Text = "İfade"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_NoTask_Content = {Text = "Veri yok"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Title_Content = {
    Text = "Görünüm Önizlemesi"
  },
  PanelText_UI_Battle_Item_CounterAwaker_Text_C_CounterAwaker_Content = {
    Text = "Saldırı Bonusu Uyananlar"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Disabled_CN_Content = {Text = "Onayla"},
  PanelText_UI_Battle_Panel_CardStack_Text_C_Display_Content = {
    Text = "Kartı Göster"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Hide_Content = {
    Text = "Kartları Sakla"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_High_CN_Content = {Text = "Onayla"},
  PanelText_UI_Battle_Panel_CardStack_Text_C_Normal_CN_Content = {Text = "Onayla"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Auto_Content = {Text = "OTOMATİK"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Auto_Dis_Content = {Text = "OTOMATİK"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Auto_Nor_Content = {Text = "OTOMATİK"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Count_Content = {Text = "D-Gelgiti"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_End_EN_No_Content = {Text = "Son"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Insufficient_Content = {
    Text = "Yetersiz Alan"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Name_Content = {Text = "Son"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Setting_Content = {Text = "Ayarlar"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Unclickable_Content = {Text = "Son"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Zongshanghai_Content = {
    Text = "Toplam Hasar"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_insufficient_Content = {
    Text = "Yetersiz Alan"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_CD_Content = {
    Text = "Bekleme Süresinde..."
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Cooling_Content = {
    Text = "Bekleme süresinde, bir sonraki turda yeniden kullanılabilir"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Title_Content = {
    Text = "Aşırı Yüceliş"
  },
  PanelText_UI_Battle_Popup_Anger_Text_C_CD_Content = {
    Text = "Bekleme Süresinde..."
  },
  PanelText_UI_Battle_Popup_Anger_Text_C_Cooling_Content = {
    Text = "Bekleme süresinde, bir sonraki turda yeniden kullanılabilir"
  },
  PanelText_UI_Battle_Popup_Anger_Text_Title_Content = {
    Text = "Taşkınlık"
  },
  PanelText_UI_Battle_Popup_AttachPost_Text_C_AttachPost_Content = {Text = "Takip"},
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Confirm_Content = {Text = "Onayla"},
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Title_Content = {
    Text = "Bir Kart Seti Seçin"
  },
  PanelText_UI_Battle_Popup_Elite_Text_C_Failure_Content = {
    Text = "Geri Çekil"
  },
  PanelText_UI_Battle_Popup_Elite_Text_C_Victory_Content = {
    Text = "Tehlike Alarmı"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Hang_Content = {
    Text = "Savaş Başla"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Title_Content = {
    Text = "En Yüksek Alarm"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Continue_Content = {
    Text = "Devam etmek için tıkla"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Failure_Content = {
    Text = "Başarısızlık"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Victory_Content = {
    Text = "Savaş Başarısız"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_1_Content = {Text = "İptal"},
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_2_Content = {Text = "Onayla"},
  PanelText_UI_Battle_Popup_Furnace_Text_C_Title_Content = {
    Text = "Kızıl Ocak"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Awaker_School_Content = {Text = "Koruyucu"},
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Nature_Content = {
    Text = "Takım Bilgisi"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Property_Content = {
    Text = "Acil Durum Envanteri"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill2_Content = {Text = "Keyflare"},
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill_Tag_Content = {Text = "Müfreze"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeeperSkill_Content = {
    Text = "Serbest Bırak"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenAwaken_Content = {
    Text = "Serbest Bırak"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenNewChaos_Content = {
    Text = "Serbest Bırak"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_Title_Content = {
    Text = "Bir Komut Seç"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_AwakenTitle_Content = {
    Text = "Keyflare Uyanışı"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_NewChaosTitle_Content = {
    Text = "Bileşik Müfreze"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Hang_Content = {
    Text = "Savaş Başla"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Title_Content = {
    Text = "Savaş Başlangıcı"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips2_Content = {
    Text = "Kullanılsın mı?"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips_Content = {
    Text = "Acil Gnosis Birimi tükendi. Aşağıdaki eşyayı kullan"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Cost_Content = {Text = "Tüketme"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Tips_Content = {
    Text = "(Kullanım, onu doğrudan tüketip bir Diriliş tetikler; geri çekilirsen Acil Gnosis Birimi iade edilir)"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Cancel_Name_Content = {Text = "İptal"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_Confirm_Name_Content = {Text = "Onayla"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_Title_Content = {
    Text = "Şimdi Canlandır?"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_AffixInfo_Content = {
    Text = "Ek Açıklaması"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Arousal_Content = {Text = "Uyanış"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Deepen_Tag_Content = {
    Text = "Kişilik Derinleşmesi"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Destiny_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Gnosisi_Content = {Text = "Uyanış"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Maniac_Content = {
    Text = "Aliemus Değeri"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Property_Content = {
    Text = "Özellik Ayrıntıları"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Secret_Content = {Text = "Ahit"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Skill_Tag_Content = {
    Text = "Taşkınlık"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Talent_Content = {Text = "Yetenek"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Awakening_Content = {Text = "Uyanış"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Trinket_Content = {Text = "Ahit"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Weapon_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Battle_Popup_Round_Enemy_Text_C_Our_Content = {
    Text = "Düşman Sırası"
  },
  PanelText_UI_Battle_Popup_Round_Mine_Text_C_Our_Content = {
    Text = "Sıra Sende"
  },
  PanelText_UI_Battle_Popup_SelectAwaker_Text_C_Title_Content = {
    Text = "Bir Uyandırıcı Seç"
  },
  PanelText_UI_Battle_Popup_Settle_Text_C_Pendants_Content = {Text = "Zafer"},
  PanelText_UI_Battle_Popup_Settle_Text_C_Succeed_Content = {Text = "Zafer!"},
  PanelText_UI_Battle_Popup_Settle_Text_C_Victory_Content = {Text = "Zafer"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Activate_Content = {
    Text = "Geçerli Komut"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Defense_Content = {Text = "Savunma"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_1_Content = {Text = "Seçilemez"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_2_Content = {Text = "Seçilemez"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Frantic_Content = {Text = "Delilik"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Name_Content = {Text = "Savaş"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Title_Content = {
    Text = "Bir Dokunaç Duruşu Seç"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Cancel_Content = {Text = "İptal"},
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Lock_Content = {
    Text = "Zaman Tersine Çevirme: Savaşı önceki bir tura geri sarın"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Sure_Content = {Text = "Onayla"},
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Title_Content = {
    Text = "Zaman Akışı Tersine Dönüş"
  },
  PanelText_UI_Battle_Tip_CounterAwaker_Text_C_Title_Content = {
    Text = "Düşman Özellikleri"
  },
  PanelText_UI_Card_Panel_Discard_Text_C_Title_Content = {Text = "El"},
  PanelText_UI_Chaper_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_Content = {
    Text = "Kümülatif Ödüller"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_En_Content = {
    Text = "Düşen Eşyalar"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Cancel_Content = {Text = "Çıkış"},
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Confirm_Content = {
    Text = "Yine de Devam Et"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Joinin_Content = {
    Text = "Önce aşağıdaki aşamaları tamamlaman önerilir"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Screening_Content = {
    Text = "Bugün artık hatırlatma yok"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Bright_Content = {Text = "Yakarış"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Content = {Text = "Yakarış"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Begone_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Creation_Content = {Text = "Kalıntı"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkactivity_Content = {Text = "Yakarış"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkgame_Content = {Text = "Kalıntı"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Demon_Content = {
    Text = "Alınabilir Yakarış yok"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Bright_Content = {Text = "Kalıntı"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Content = {Text = "Kalıntı"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Mail_Content = {
    Text = "Hiçbir Kalıntı Yok"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_No_Content = {
    Text = "Oymalı İşaret Yok"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Not_Content = {
    Text = "Alınabilir Kalıntı yok"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Walk_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_mail_Content = {
    Text = "Gelen Kutusu Boş"
  },
  PanelText_UI_Chaper_Popup_Level_Success_Text_C_Title_Content = {
    Text = "Sahne Başarımı"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Achievement_Content = {
    Text = "Düşman Önizlemesi"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Cost_Tips_Content = {
    Text = "Gereksinimler:"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Grade_Content = {
    Text = "Önerilen Seviye"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Monster_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Recommend_Content = {
    Text = "Diyar Önerisi"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Reward_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Suppress_Content = {Text = "D-Gelgiti"},
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Title_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Monster_Content = {Text = "Canavar"},
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Title_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Chaper_Popup_Particulars_View_Text_C_Replay_Content = {Text = "Kayıt"},
  PanelText_UI_Chaper_Popup_StageAchieve_View_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Difficulty_Content = {Text = "Zor"},
  PanelText_UI_Chapter_Dream_View_Text_C_Nightmare_Content = {Text = "Delilik"},
  PanelText_UI_Chapter_Dream_View_Text_C_Remember_Content = {Text = "Hikâye"},
  PanelText_UI_Chapter_Dream_View_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Difficulty_Content = {Text = "Zor"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Nightmare_Content = {Text = "Karabasan"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Remember_Content = {Text = "Hikâye"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Simple_Content = {Text = "Kolay"},
  PanelText_UI_Chapter_Item_Achievement_List_Text_C_Lost_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Chapter_Item_Achievement_List_Text_Lost_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Expect_Content = {
    Text = "Takipte kalın"
  },
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Tips_Content = {
    Text = "Tamamlandı"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect1_Content = {
    Text = "Henüz kilitli değil"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect2_Content = {
    Text = "Henüz kilitli değil"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect_Content = {
    Text = "Takipte kalın"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Tips_Content = {
    Text = "Tamamlandı"
  },
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Chaoter_Content = {
    Text = "Rüya Görünümü"
  },
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Item_Dream_02_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Item_Dream_03_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Item_Dream_04_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Chaoter_Content = {
    Text = "Rüya Görünümü"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Item_Skill_Text_C_Level_Content = {Text = "Durum"},
  PanelText_UI_Chapter_Item_Special_01_Text_C_Chaoter_Content = {
    Text = "Rüya Görünümü"
  },
  PanelText_UI_Chapter_Item_Special_01_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Item_Special_02_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Item_Special_03_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Item_StageAchieve_Text_C_Lost_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Chapter_Item_Success_List_Text_Lost_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Award_Content = {
    Text = "Tüm ödül koşulları yerine getirildi."
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Award_Content = {
    Text = "Tamamlandı"
  },
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Difficulty_Content = {Text = "Zor"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_Nightmare_Content = {Text = "Delilik"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_NoTask_Content = {
    Text = "Alınabilir Özel Görev Kaydı Yok"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_Time_Content = {
    Text = "21.12.2023 05:00 Yeni gelenler, takipte kalın"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Title_Content = {
    Text = "Soruşturma"
  },
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_2_Content = {
    Text = "Sahne Başarımı"
  },
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_Content = {
    Text = "Seviye Skoru"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_01_Content = {Text = "Zor"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Content = {Text = "Zor"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Now_Content = {Text = "Zor"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_01_Content = {Text = "Delilik"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Content = {Text = "Delilik"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Now_Content = {Text = "Delilik"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Progress_Content = {
    Text = "Soruşturma İlerlemesi"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_01_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Now_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tab_Special_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tishi_Content = {
    Text = "Sahne Başarımı"
  },
  PanelText_UI_Chapter_Popup_Achievement_Text_C_Title_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Chapter_Popup_Chapter_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Chapter_Popup_Monster_Details_Text_C_Title_Content = {
    Text = "Düşman Ayrıntıları"
  },
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Effect_Content = {Text = "Etki"},
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Story_Content = {
    Text = "Bir Hikâye..."
  },
  PanelText_UI_Chapter_Popup_Yuanxing_Text_Title_Content = {
    Text = "Değerlendirme"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Difficulty_Content = {Text = "Zor"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Nightmare_Content = {Text = "Delilik"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Progress_Content = {Text = "İlerleme"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Remember_Content = {Text = "Hikâye"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Tab_Special_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Difficulty_Content = {Text = "Zor"},
  PanelText_UI_Chapter_Spur_View_Text_C_Nightmare_Content = {Text = "Delilik"},
  PanelText_UI_Chapter_Spur_View_Text_C_Progress_Content = {Text = "İlerleme"},
  PanelText_UI_Chapter_Spur_View_Text_C_Remember_Content = {Text = "Hikâye"},
  PanelText_UI_Chapter_Spur_View_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Chapter_Spur_View_Text_C_Review_Content = {Text = "Prolog"},
  PanelText_UI_Chapter_Spur_View_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Spur_View_Text_C_Tab_Special_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Condition_Content = {
    Text = "Kilitli Değil"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Name_Content = {
    Text = "Hikâye Moduna Gir"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_NoTask_Content = {
    Text = "Üreme Çılgınlığı henüz kilitli"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_StoryDesc_Content = {
    Text = "\"Şehvetli Arzular\"ın esrarengiz etkisi sürdükçe, Uyandırma Yapanlar \"Üreme Çılgınlığı\" na kapıldı... Lütfen dikkatli olun, Koruyucular!"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Tip_Content = {
    Text = "\"Şehvani Arzular\" sırasında, Çılgınlık Hikâyeleri artık Afinite gerektirmez ve yalnızca \"Gerçeklik Sınırı\"*1’e mal olur!"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Title_Content = {
    Text = "Parti Daveti"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Collection_Btn_Position_Text_C_Upgrade_Content = {Text = "Karakter"},
  PanelText_UI_Collection_History_Details_Text_C_Lock_Content = {
    Text = "Görsel materyaller henüz edinilmedi."
  },
  PanelText_UI_Collection_History_Details_Text_Title_Content = {Text = "Kayıt"},
  PanelText_UI_Collection_Item_Comprehensive_Text_C_Placeholder_Content = {
    Text = "Bir terim ara..."
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_High_Content = {
    Text = "Müziği Sıfırla"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Label_Content = {Text = "Gramofon"},
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Mail_Content = {Text = "İlerleme"},
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Normal_Content = {Text = "BGM Ayarla"},
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Title_Content = {
    Text = "Kütüphane"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Label_Content = {Text = "Gramofon"},
  PanelText_UI_Collection_Item_Music_Text_C_Mail_Content = {Text = "İlerleme"},
  PanelText_UI_Collection_Item_Music_Text_C_Title_Content = {
    Text = "Kütüphane"
  },
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_UnLock_Content = {Text = "Kilidi Aç"},
  PanelText_UI_Collection_Item_Video_Text_C_UnLock_Content = {Text = "Kilidi Aç"},
  PanelText_UI_Collection_Panel_EquipDetail_Text_C_Title_Content = {
    Text = "Bir Hikâye..."
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_None2_Content = {
    Text = "Henüz malzeme yok"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_None_Content = {
    Text = "Henüz ilgili koleksiyon yok"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Collection_Panel_Event_Text_C_Placeholder_Content = {
    Text = "Bir terim ara..."
  },
  PanelText_UI_Collection_Panel_History_Text_C_Label_Content = {
    Text = "Vakanüvis Kayıtları"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Mail_Content = {Text = "İlerleme"},
  PanelText_UI_Collection_Panel_History_Text_C_Title_Content = {
    Text = "Kütüphane"
  },
  PanelText_UI_Collection_Panel_LoginPV_Text_Title_Content = {
    Text = "Giriş Arka Planını Değiştir"
  },
  PanelText_UI_Collection_Panel_LoginPV_Text_Title_En_Content = {
    Text = "Giriş Arka Planını Değiştir"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Creation_Content = {Text = "Kalıntı"},
  PanelText_UI_Collection_Panel_Main_Text_C_Event_Content = {Text = "Etkinlik"},
  PanelText_UI_Collection_Panel_Main_Text_C_Image_Content = {Text = "Görüntü"},
  PanelText_UI_Collection_Panel_Main_Text_C_Music_Content = {Text = "Gramofon"},
  PanelText_UI_Collection_Panel_Main_Text_C_Progress_Content = {Text = "İlerleme"},
  PanelText_UI_Collection_Panel_Main_Text_C_Role_Content = {Text = "Karakter"},
  PanelText_UI_Collection_Panel_Main_Text_C_Title_Content = {
    Text = "Kütüphane"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Trinket_Content = {Text = "Ahit"},
  PanelText_UI_Collection_Panel_Main_Text_C_Weapon_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_World_Content = {
    Text = "Dünya İnşası"
  },
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Mail_Content = {Text = "İlerleme"},
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Title_Content = {
    Text = "Kütüphane"
  },
  PanelText_UI_Collection_Panel_Organize_Text_C_Mail_Content = {Text = "İlerleme"},
  PanelText_UI_Collection_Panel_Organize_Text_Title_Content = {
    Text = "Kütüphane"
  },
  PanelText_UI_Collection_Panel_Relic_Text_C_Mail_Content = {Text = "İlerleme"},
  PanelText_UI_Collection_Panel_Relic_Text_C_Title_Content = {
    Text = "Bir Hikâye..."
  },
  PanelText_UI_Collection_Panel_Relic_Text_Title_Content = {
    Text = "Kütüphane"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Cancel_Content = {Text = "İptal"},
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Display_Content = {
    Text = "Uyandıranı Göster"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_DownLoadCG_Content = {
    Text = "Orijinal Görseli İndir"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_HideAwaker_Content = {
    Text = "Bu görüntüyü yatakhane arka planı olarak ayarladıktan sonra, ziyaretçi karakterin illüstrasyonu gizlenecektir."
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Hide_Content = {
    Text = "Gizli Uyandıran"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_High_Content = {
    Text = "Arka Planı Sıfırla"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Normal_Content = {
    Text = "Yurt Arka Planı Olarak Ayarla"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Save_Content = {Text = "Kaydet"},
  PanelText_UI_Collection_Panel_Unlock_Text_C_Cost_Content = {Text = "Tüketme"},
  PanelText_UI_Collection_Panel_World_Text_C_Chronicle_Content = {
    Text = "Vakanüvis Kayıtları"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Comprehensive_Content = {
    Text = "Ansiklopedi"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Label_Content = {
    Text = "Dünya İnşası"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Organize_Content = {
    Text = "Fraksiyonlar"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Title_Content = {
    Text = "Kütüphane"
  },
  PanelText_UI_Collection_Panel_World_Text_Progress_Content = {Text = "İlerleme"},
  PanelText_UI_Common_Awaker_Favor_Text_C_Sync_Content = {
    Text = "Uyandıran Afinite Artışı"
  },
  PanelText_UI_Common_Btn_Back1_Text_C_Name_Content = {Text = "Çıkış"},
  PanelText_UI_Common_Btn_Back2_Text_C_Name_Content = {Text = "Çıkış"},
  PanelText_UI_Common_Btn_Back3_Text_C_Name_Content = {Text = "Çıkış"},
  PanelText_UI_Common_Btn_Level1_Special_Text_C_Upgrade_Content = {
    Text = "Aydınlanma"
  },
  PanelText_UI_Common_Btn_Receive_Small_Text_C_Name_Content = {Text = "Al"},
  PanelText_UI_Common_Btn_Share_Text_C_Across_Content = {
    Text = "İlk Paylaşım Ödülü"
  },
  PanelText_UI_Common_Btn_Share_Text_C_Share_Content = {
    Text = "İlk Paylaşım Ödülü"
  },
  PanelText_UI_Common_Btn_Small_240x90_Text_Name_Content = {
    Text = "Yetenek Etkinleştir"
  },
  PanelText_UI_Common_Group_Coin_Text_C_Text_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Common_Item_Btn_Back_1_Text_C_Name_Content = {Text = "Çıkış"},
  PanelText_UI_Common_Item_Detail_Text_C_AavtarName_Content = {
    Text = "Avatar ve İfade"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "Ayrıntı Önizlemesi"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Close_Content = {Text = "Çöküş"},
  PanelText_UI_Common_Item_Detail_Text_C_Equipped_Content = {
    Text = "Kuşanılmış"
  },
  PanelText_UI_Common_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "Müfreze Etkisi:"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Source_Content = {Text = "Kaynak Al"},
  PanelText_UI_Common_Item_Hint_Text_C_Recommend_Content = {Text = "SICAK"},
  PanelText_UI_Common_Item_Potency_Text_C_Max_Content = {Text = "MAKS"},
  PanelText_UI_Common_Item_Tip_Bg_Text_C_Label_Content = {Text = "Sırala."},
  PanelText_UI_Common_Item_Tip_Bg_Text_C_Name_Content = {Text = "Sırala"},
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Dispatch_Content = {Text = "Görevler"},
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Expired_Content = {
    Text = "Süresi Doldu"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NoEquip_Content = {
    Text = "Kuşanılamaz"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NotActive_Content = {
    Text = "Etkin Değil"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_UpperLimit_Content = {
    Text = "Üst limite ulaşıldı"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Using_Content = {
    Text = "Kullanımda"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Full_Content = {
    Text = "Tam Yükseltilmiş"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Double_Content = {Text = "Çift"},
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Nor_Content = {Text = "Fazladan"},
  PanelText_UI_Common_Melt_Disaster_Text_C_Suppress_Content = {Text = "D-Gelgiti"},
  PanelText_UI_Common_Popup_Card_List_Text_C_AbandonCard_Content = {
    Text = "Atılmış Kart Destesi"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_DrawCard_Content = {
    Text = "Çekme Destesi"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_Empty_Content = {
    Text = "Mevcut Çekme Destesi boş"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_NoTask_Content = {
    Text = "Kullanılabilir kart yok"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Cancel_Content = {Text = "İptal"},
  PanelText_UI_Common_Popup_Consume_Text_C_Confirm_Content = {Text = "Onayla"},
  PanelText_UI_Common_Popup_Consume_Text_C_Title_Content = {
    Text = "Eşya Kullanım Onayı"
  },
  PanelText_UI_Common_Popup_Tip_01_Text_C_Screening_Content = {
    Text = "Bugün tekrar gösterme"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_Screening_Content = {
    Text = "Bugün tekrar gösterme"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_ShopNeed_Content = {
    Text = "Mevcut Kupon Sayısı"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_Screening_Content = {
    Text = "Bugün tekrar gösterme"
  },
  PanelText_UI_Common_Popup_Tip_4_Text_C_Info_Content = {
    Text = "<WhiteQuality:Kapatmak için tıkla>"
  },
  PanelText_UI_Common_Popup_Tip_4_Text_C_Level1_Content = {Text = "Sv."},
  PanelText_UI_Common_Popup_Tip_4_Text_C_Level2_Content = {Text = "Sv."},
  PanelText_UI_Common_Popup_Tip_4_Text_C_Lv1_Content = {Text = "Sv."},
  PanelText_UI_Common_Popup_Tip_4_Text_C_Lv2_Content = {Text = "Sv."},
  PanelText_UI_Common_Popup_Tip_5_Text_C_Info_Content = {
    Text = "Kapatmak için boş bir alana tıkla."
  },
  PanelText_UI_Common_Popup_Tip_6_Text_C_Tips_Content = {
    Text = "İsminizi değiştirdikten sonra 72 saat boyunca yeniden değiştiremezsiniz."
  },
  PanelText_UI_Common_Popup_Tip_6_Text_NameCancel_Content = {Text = "İptal"},
  PanelText_UI_Common_Popup_Tip_6_Text_NameConfirm_Content = {Text = "Onayla"},
  PanelText_UI_Common_Popup_Tip_6_Text_Placeholder_Content = {
    Text = "Lütfen adınızı girin"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_Title_Content = {
    Text = "İsim Değiştir"
  },
  PanelText_UI_Common_Popup_Tips_6_Text_null_Content = {
    Text = "(Hasar Görmüş)"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Material_Content = {Text = "Malzemeler"},
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Reward_Content = {Text = "Ödül"},
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Title_Content = {Text = "Önizleme"},
  PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Day_Content = {Text = "g"},
  PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Month_Content = {Text = "Ay"},
  PanelText_UI_Common_Popup_Tips_Confirm_S_Text_Title_En_Content = {Text = "Duyuru"},
  PanelText_UI_Common_Popup_Tips_Small_Text_C_Scroll_Tips_Content = {
    Text = "Daha fazla ödülü görmek için yukarı ve aşağı savur"
  },
  PanelText_UI_Community_Acclaim_Tips_Text_C_Name_1_Content = {
    Text = "Değerlendirmeye Geç"
  },
  PanelText_UI_Community_Steer_Tips_Text_Thanks_Name_Content = {
    Text = "Özel Teşekkür"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_LetterTitle_Content = {
    Text = "Sevgili Yerelleştirme Gönüllüleri:"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Name_Content = {
    Text = "Yerelleştirme Gönüllüsü"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Signature_Content = {
    Text = "Mythag Üniversitesi Komitesi"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Sincerely_Content = {
    Text = "İçten Şükranla"
  },
  PanelText_UI_Community_ThanksLetter_Text_Prefix_Content = {
    Text = "Keskin dil duygunuz ve oyun tutkunuzla, katı makine çevirisi metinlerini canlı bir dile dönüştürüyorsunuz. Dünyanın dört bir yanındaki Koruyucuların Morimens'in özgün deneyiminin tadını çıkarmasını sağlayan tam da bu özverili tutkunuzdur. \nMythag Üniversitesi, olağanüstü katkılarından dolayı aşağıdaki Koruyuculara içtenlikle teşekkür eder:"
  },
  PanelText_UI_Community_ThanksLetter_Text_Suffix_Content = {
    Text = "Gümüş Anahtar Bize Yol Göstersin."
  },
  PanelText_UI_Community_ThanksLetter_Text_Title_Content = {
    Text = "Özel Teşekkür"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Award_Content = {
    Text = "Arşivlendi"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Free_Unlock_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Lock_Content = {
    Text = "Henüz kilitli değil"
  },
  PanelText_UI_Copy_Story_View_Text_C_ReadTip_Content = {
    Text = "Önerilen sıra yalnızca tavsiye edilen okuma sırasını temsil eder, kesin zaman sırasını temsil etmez."
  },
  PanelText_UI_Course_Panel_Main_Text_C_NoTask_Content = {
    Text = "Şu anda bu türde herhangi bir eğitim bölümü alınabilir değil."
  },
  PanelText_UI_Course_Panel_Main_Text_C_Placeholder_Content = {
    Text = "Öğretici aranıyor..."
  },
  PanelText_UI_Course_Panel_Text_Title_Content = {Text = "Öğretici"},
  PanelText_UI_Dbgcopy_Item_Select_Goods_Text_C_Sellout_Content = {Text = "Tükendi"},
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Achievement_Content = {
    Text = "Sahne Başarımı"
  },
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Star_Content = {Text = "Derece"},
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Arousal_Sellout_Content = {Text = "Tükendi"},
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Curse_Content = {
    Text = "Lanetler Arasında"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Sell_Sellout_Content = {Text = "Tükendi"},
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Spend_Content = {Text = "Maliyet"},
  PanelText_UI_Dbgcopy_Panel_Main_New_Text_C_Count_Content = {Text = "D-Gelgiti"},
  PanelText_UI_Dbgcopy_Panel_RelicPreview_Text_Name_Content = {Text = "Dönüş"},
  PanelText_UI_Dbgcopy_Panel_RelicStrength_Text_C_Title_Content = {
    Text = "Kalıntıyı Geliştir"
  },
  PanelText_UI_Dbgcopy_Panel_Select_Arousal_Text_C_Name_Content = {Text = "Seç"},
  PanelText_UI_Dbgcopy_Panel_Select_Arousal_Text_C_Precautions_Content = {Text = "Duyuru"},
  PanelText_UI_Dbgcopy_Panel_Select_Awaken_Text_C_Precautions_Content = {Text = "Duyuru"},
  PanelText_UI_Dbgcopy_Panel_Select_Curse_Text_C_Precautions_Content = {Text = "Duyuru"},
  PanelText_UI_Dbgcopy_Panel_Select_Extra_Text_C_Name_Content = {Text = "Vazgeç"},
  PanelText_UI_Dbgcopy_Panel_Select_Extra_Text_C_Precautions_Content = {Text = "Duyuru"},
  PanelText_UI_Dbgcopy_Panel_Store_Text_C_exit_Content = {Text = "Çıkış"},
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Display_Content = {
    Text = "Etkinliği Göster"
  },
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Hide_Content = {
    Text = "Etkinliği Sakla"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Monster_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Tip_Content = {
    Text = "Lütfen farklı bölümlerin farklı çevresel özellikler ve farklı başlangıç Kalıntıları getireceğinin farkında olun."
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Title_Content = {
    Text = "Aşama Etki Açıklaması"
  },
  PanelText_UI_Dbgcopy_Popup_Remove_Enchantment_Text_C_Precautions_Content = {Text = "Duyuru"},
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Confirm_Content = {Text = "Onayla"},
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Replace_Content = {Text = "Değiştir"},
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_TeamAwaker_Content = {
    Text = "Mevcut Kadro"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Title_Content = {
    Text = "Karakter Değiştir"
  },
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Suppress_Content = {Text = "Dölleme"},
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Title_Content = {
    Text = "D-Gelgiti Etki Açıklaması"
  },
  PanelText_UI_Dbgcopy_Popup_ydbj_yty_01_Text_C_Dcks_Content = {
    Text = "Soruşturma Başlıyor"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_BtnName_Content = {
    Text = "Eğitime Başla"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_C_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Dungeons_Item_Common_Element_Text_C_Award_Content = {
    Text = "Ödül +%100"
  },
  PanelText_UI_Dungeons_Item_Common_Tier2_Text_C_Current_Content = {
    Text = "Tamamlandı"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Extra_Content = {
    Text = "Ekstra Tamamlama"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Content = {Text = "Sıfırla"},
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Extra_Content = {Text = "Sıfırla"},
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Undone_Content = {
    Text = "Tamamlanmamış Meydan Okuma"
  },
  PanelText_UI_Dungeons_Item_RailWayRank_Text_C_Null_Content = {
    Text = "Hiçbir kadro alınabilir değil"
  },
  PanelText_UI_Dungeons_Material_View_Text_C_ActivityAchievement_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_All_Content = {Text = "Tümü"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Awaker_Content = {Text = "Savaş"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_BattleStatistics_Content = {
    Text = "Savaş İstatistikleri"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Damage_Content = {
    Text = "Verilen Hasar"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Heal_Content = {
    Text = "Yapılan İyileştirme"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_BattleStatistics_Content = {Text = "Veri yok"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_RoundStatistics_Content = {Text = "Veri yok"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_RoundStatistics_Content = {
    Text = "Tur İstatistikleri"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Shield_Content = {
    Text = "Üretilen Karakter Kalkanı"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_BattleStatistics_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_RoundStatistics_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Experience_Content = {
    Text = "Dalış Seviyesi"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Highest_Content = {
    Text = "Haftalık En Yüksek Puan"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Rank_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Record_Content = {
    Text = "Haftalık Performans"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Store_Content = {
    Text = "Borsa Mağazası"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Title_Content = {
    Text = "Soruşturma Unvanı"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Diving_Record_Content = {
    Text = "Derin Dalış Kayıtları"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Main_Title_Content = {
    Text = "Hayali Dalış"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Highest_Content = {
    Text = "Haftalık En Yüksek Puan"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record2_Content = {
    Text = "Haftalık Performans"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record_Content = {
    Text = "Haftalık Performans"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Reward2_Content = {
    Text = "Derin Dalış Kayıtları"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Store_Content = {
    Text = "Borsa Mağazası"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Title_Content = {
    Text = "Soruşturma Unvanı"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_illustrate_Content = {
    Text = "Oynanış Kuralları"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_list_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Appraise_Content = {
    Text = "Skor İstatistikleri"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Finish_Content = {
    Text = "Soruşturma Başarılı"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_High_Content = {
    Text = "Yeni Rekor!"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Remind_Content = {
    Text = "Güçlü düşmanlarla yüzleşmeden önce Uyandırıcıların Yeteneklerini güçlendirin!"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Score_Content = {
    Text = "Toplam Skor"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Synthesis_Content = {
    Text = "(=toplam ×3)"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Award_Content = {
    Text = "Tamamlama Ödülü"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Highest_Content = {
    Text = "En Yüksek Kayıt"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Record_Content = {
    Text = "Bugünkü Başarılar"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Reward_Content = {Text = "Sınavlar"},
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Score_Content = {
    Text = "Haftalık Kümülatif Skor"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Store_Content = {
    Text = "Borsa Mağazası"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Title_Content = {
    Text = "Sıralama Unvanı"
  },
  PanelText_UI_Dungeons_Panel_Material_Text_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Appraise_Content = {
    Text = "Skor İstatistikleri"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_BattleData_Content = {
    Text = "Genel Bakış"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Finish_Content = {
    Text = "Soruşturma Tamamlandı"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_High_Content = {
    Text = "Yeni Rekor!"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "Ödül Yerleşimi"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Integral_Content = {
    Text = "Değerlendirme"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Limit_Content = {
    Text = "※Eşya sınırına ulaşıldı"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Score_Content = {
    Text = "Toplam Skor"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Statistics_Content = {
    Text = "Savaş İstatistikleri"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Sync_Content = {
    Text = "Uyandıran Afinite Artışı"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Synthesis_Content = {
    Text = "(=toplam ×3)"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_TeamInfo_Content = {
    Text = "Takım Bilgisi"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval1_Content = {Text = "Aralık"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval2_Content = {
    Text = "Dönüşüm Aralığı"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_1_Content = {
    Text = "Kaos Diyarı"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_2_Content = {
    Text = "Kan Ayı Kulesi"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_3_Content = {
    Text = "Aequor Uçurumu"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_4_Content = {
    Text = "Ultra Yolculuğu"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_1_Content = {Text = "Kilitli"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_2_Content = {Text = "Kilitli"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_3_Content = {Text = "Kilitli"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_4_Content = {Text = "Kilitli"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Tips_Content = {Text = "Işıksız"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_illustrate_Content = {
    Text = "Oynanış Kuralları"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card2_Content = {
    Text = "(Yakarış ile)"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card_Content = {Text = "Kartlar"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_KeyToken_Content = {Text = "Müfreze"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_NoTask_Content = {Text = "Kayıt yok"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Null_Content = {
    Text = "Kullanılabilir Kalıntı Yok"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_PlayerLevel_Content = {
    Text = "Koruyucu Seviyesi"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Relic_Content = {Text = "Kalıntı"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Reset_Content = {Text = "Sıfırla"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamData_Content = {
    Text = "Parti Verileri"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamProperty_Content = {
    Text = "Takım Özellikleri"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Team_Content = {
    Text = "Soruşturma Ekibi"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Uid_Content = {
    Text = "Koruyucu Kimliği:"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Dungeons_Panel_Trinket_Text_C_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Activity_Awaker_Content = {
    Text = "Sınırlı: Unutuş Destanı"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Award_Content = {
    Text = "Tamamlama Ödülleri"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Emoji_Content = {Text = "İfade"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Introduce_Content = {
    Text = "Yetenek Tanıtımı"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_1_Content = {Text = "Al"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_Content = {
    Text = "Denemeyi Başlat"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Normal_Awaker_Content = {Text = "Kalıcı"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Star_Awaker_Content = {
    Text = "Sınırlı: Yıldız Bölümü"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Undone_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Wake_Content = {
    Text = "Uyanışa Git"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_ActivityAchievement_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_AwardText_Content = {
    Text = "Haftalık Ödüller"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_AwardText_Content = {
    Text = "Haftalık Ödüller"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Info_Content = {
    Text = "Koruyucu Bilgisi"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_More_Content = {
    Text = "Ayrıntıları Görüntüle"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_NoTask_Content = {Text = "Kayıt yok"},
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Rank_Content = {Text = "Rütbe"},
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Replay_Content = {
    Text = "Tekrar Oynat"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Value_Content = {
    Text = "Eğitim Puanları"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_Title_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeons_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Dungeons_Popup_Award_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Awaker_Content = {Text = "Savaş"},
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Damage_Content = {
    Text = "Verilen Hasar"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Heal_Content = {
    Text = "Yapılan İyileştirme"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Shield_Content = {
    Text = "Üretilen Karakter Kalkanı"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Title_Content = {
    Text = "Savaş İstatistikleri"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_FilterAwaker_Content = {Text = "Filtre"},
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_No_Records_Content = {
    Text = "Henüz Kayıt Yok"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Refresh_Content = {Text = "Yenileme"},
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Title_Content = {
    Text = "Kayıtlı Tamamlamayı Sil"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_Fliter_Type_Content = {
    Text = "Toplam Tur Sayısı"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Award_Content = {
    Text = "Yüksek Skor Sıralamaları"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Big_Content = {
    Text = "Rütbe Aralığı"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Current_Content = {
    Text = "Mevcut Ödüller"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Empty_Content = {Text = "Kayıt yok"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_FilterAwaker_Content = {Text = "Filtre"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Grade_Content = {
    Text = "Sıralama Unvanı"
  },
  ["PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Haven't_Content"] = {
    Text = "Alınabilir ödül yok"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Highest_Content = {
    Text = "En Yüksek Kayıt"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_1_Content = {
    Text = "Koruyucu Bilgisi"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_2_Content = {
    Text = "Sıralama Unvanı"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_3_Content = {
    Text = "En Yüksek Kayıt"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_4_Content = {Text = "Rütbe"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_5_Content = {Text = "Dizilim"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_6_Content = {Text = "Kayıt"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Me_Content = {Text = "Sıralamam"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_NoTask_Content = {Text = "Kayıt yok"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Prompt_Content = {
    Text = "Ödüller, soruşturma unvanlarına göre belirlenir ve her Pazartesi saat 09:00'da postanıza gönderilir."
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward1_Content = {Text = "Ödüller"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward2_Content = {Text = "Ödüller"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Ranking_Content = {Text = "Rütbe"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Reward_Content = {Text = "Ödüller"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season1_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season2_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Small_Content = {
    Text = "Küçük veya eşittir"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking1_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking2_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Title_Content = {Text = "Sıralama"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_illustrate_Content = {Text = "Ödüller"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Big_Content = {
    Text = "Rütbe Aralığı"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_DivingTitle_Content = {
    Text = "Sıralama Unvanı"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Exp_Content = {
    Text = "En Yüksek Puan"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Grade_Content = {
    Text = "Sıralama Unvanı"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Info_Content = {
    Text = "Koruyucu Bilgisi"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_NoTask_Content = {Text = "Kayıt yok"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Nor_Content = {Text = "Ödüller"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Sel_Content = {Text = "Ödüller"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Content = {Text = "Rütbe"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Nor_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Sel_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Replay_Content = {Text = "Kayıt"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Reward_Content = {Text = "Ödüller"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Round_Content = {Text = "Raundlar"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Team_Content = {Text = "Dizilim"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Title_Content = {
    Text = "VIP Listesi"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Big_Content = {
    Text = "Büyüktür"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Reward_Content = {Text = "Ödüller"},
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Small_Content = {
    Text = "Küçük veya eşittir"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Title_Content = {Text = "Ödüller"},
  PanelText_UI_Dungeons_Popup_Rules_Tip_Text_C_Title_Content = {
    Text = "Etkinlik Kuralları"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Award_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_2_Content = {Text = "Rezonans"},
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Title_Content = {
    Text = "Kule Roguelike"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Award_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Challenge_Content = {
    Text = "Standart Mod"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Daily_Content = {
    Text = "Günlük Meydan Okuma"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Name_Content = {
    Text = "Kule Roguelike"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_NoTask_Content = {Text = "Boş"},
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_EnergyCost_Content = {
    Text = "Arithmetica"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Extra_Content = {
    Text = "Ekstra Bonus"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_KeeperSkill_Content = {Text = "Keyflare"},
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Manual_Content = {
    Text = "Manuel Savaş"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UltiEnergy_Content = {Text = "Aliemus"},
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UseCard_Content = {Text = "Kart oyna"},
  PanelText_UI_Dungeons_Trinket_View_Text_C_ActivityAchievement_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Lost_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title2_Content = {
    Text = "Toplam Skor"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title_Content = {
    Text = "Toplam Yıldızlar"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Lost_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Title_Content = {
    Text = "Toplam Yıldız Sayısı:"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Null_Content = {
    Text = "Hiçbir kadro alınabilir değil"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Underway_Content = {
    Text = "Savaş verisi iletimi sürüyor"
  },
  PanelText_UI_Dungeous_Item_Reward_Text_C_Present_Content = {Text = "Mevcut"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Additional_Content = {
    Text = "Bugün Ödül +%50"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardNum_Content = {
    Text = "Bugün 2x Ödül Denemesi"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardText_Content = {
    Text = "Haftalık Ödüller"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Boundaries_Tips_Content = {
    Text = "Önerilen Diyar"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Name_Content = {
    Text = "Yeniden Canlandırma"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Recommend_Content = {
    Text = "Önerilen Diyar"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_1_Content = {Text = "Kaos"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_2_Content = {Text = "Ultra"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_3_Content = {Text = "Caro"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_4_Content = {Text = "Aequor"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Special_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_AwardText_Content = {
    Text = "Haftalık Ödüller"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Award_Content = {
    Text = "Düşman Ayrıntıları"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Boundaries_Tips_Content = {
    Text = "Önerilen Diyar"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Reward_Content = {
    Text = "Tamamlama Ödülü"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Special_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_Title_Content = {
    Text = "Gizemli Hakimiyet"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Award_Content = {
    Text = "Bölüm Önizlemesi"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Boundaries_Tips_Content = {
    Text = "Önerilen Diyar"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Difficulty_Content = {
    Text = "İniş Derinliği"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Reward_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Score_Content = {
    Text = "Haftalık En Yüksek Puan"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Special_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_RewardShow_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_StrongAwakers_Content = {
    Text = "Geliştirilmiş Uyanışçı"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Suppress_Content = {Text = "D-Gelgiti"},
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Remuneration_Content = {
    Text = "Karakter Ödülleri"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Special_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Hint_Content = {
    Text = "*Bölgesel D-Etkisi Yasak Bölgeleri’nde görevlendirilen Uyandırıcılar ve Kader Çarkları başka bölgelerde görevlendirilemez."
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Rank_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Title_Content = {
    Text = "D-Etkisi Yasak Bölgesi"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Train_Content = {
    Text = "Mevcut Puanlar"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly_Content = {
    Text = "Özel Eğitim Ödülleri"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Hint_Content = {
    Text = "Bu savaşta kullanılan Uyandırıcılar, Kader Çarkları ve Müfreze diğer Bölgesel D-Etkisi Yasak Bölgeleri’nde görevlendirilemez."
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Title_Content = {
    Text = "D-Etkisi Yasak Bölgesi"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Train_Content = {
    Text = "Mevcut Puanlar"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Weekly_Content = {
    Text = "Özel Eğitim Ödülleri"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Extra_Content = {
    Text = "Ekstra Temizleme Takım Dizilişi"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Integral_Content = {
    Text = "Tamamlama Puanı"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_LineUp_Content = {
    Text = "Dizilimi Temizle"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Monster_Content = {
    Text = "Canavar Önizlemesi"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Content = {Text = "Sıfırla"},
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Extra_Content = {Text = "Sıfırla"},
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_None_Content = {
    Text = "Hiçbir kadro alınabilir değil"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Replay_Content = {Text = "Kayıt"},
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Special_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_Extra_None_Content = {
    Text = "Meydan okuma henüz tamamlanmadı"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Integral_Content = {
    Text = "Eğitim Puanları"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_LineUp_Content = {Text = "Dizilim"},
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Monster_Content = {
    Text = "Canavar Önizlemesi"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Name_Content = {Text = "Sıfırla"},
  PanelText_UI_Dungeous_Panel_Molten_Text_C_None_Content = {
    Text = "Meydan okuma henüz tamamlanmadı"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Special_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Suppress_Content = {Text = "D-Gelgiti"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Challenge_Content = {
    Text = "Meydan Okuma"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Choose_Content = {
    Text = "Zorluk Seç"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Experience_Content = {
    Text = "Tren Yükseltmeleri"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Hard_Content = {Text = "Zor"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Madness_Content = {Text = "Delilik"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Normal_Content = {Text = "Normal"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Rank_Content = {
    Text = "VIP Listesi"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Record_Content = {
    Text = "Yolculuk Çerçeveleri"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "Küçük N'in Yardımı"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Title_Content = {
    Text = "Çılgın Gökyüzü Rayı"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award2_Content = {
    Text = "Gizli Diyar Yasaları"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award_Content = {
    Text = "Düşman Ayrıntıları"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Boundaries_Tips_Content = {
    Text = "Önerilen Diyar"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Cost_Tips_Content = {
    Text = "Gereksinimler:"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Replay_Content = {Text = "Kayıt"},
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Reward_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Special_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Tishi_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award2_Content = {
    Text = "Gizli Diyar Kuralları"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award_Content = {
    Text = "Düşman Ayrıntıları"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Boundaries_Tips_Content = {
    Text = "Önerilen Diyar"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Cost_Tips_Content = {
    Text = "Grup Gereksinimleri"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Reward_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Special_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Tishi_Content = {
    Text = "Yıldız İlerlemesi"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Additional_Content = {
    Text = "Bugün Ödül +%50"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_AwardNum_Content = {
    Text = "Bugün 2x Ödül Denemesi"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Boundaries_Tips_Content = {
    Text = "Önerilen Diyar"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Cw_Content = {Text = "Ultra"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Hd_Content = {Text = "Kaos"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Recommend_Content = {
    Text = "Önerilen Diyar"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Sh_Content = {Text = "Aequor"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Special_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Xr_Content = {Text = "Caro"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_Name_Content = {
    Text = "Yeniden Canlandırma"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_1_Content = {
    Text = "Seçili Kader Çarkı yok"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_2_Content = {
    Text = "Seçim yapmak için sol tarafa tıkla"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_Content = {
    Text = "*Bir Uyanan yalnızca bir SSR Kader Çarkı kuşanabilir."
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "Kader Çarkı Seç"
  },
  PanelText_UI_Dungeous_Popup_FailTip_Text_C_Title_Content = {
    Text = "Güçlendirme İpuçları"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "Yıldız Ödülü Önizlemesi"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_En_Content = {
    Text = "Düşen Eşyalar"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Title_Content = {
    Text = "Skor İstatistikleri"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Total_Content = {
    Text = "Mevcut Toplam Puan"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Coin_Content = {
    Text = "Yetersiz Para Birimi"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Explain_Content = {Text = "Kurallar"},
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_RewardPreview_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Swept_Content = {
    Text = "Yeniden Canlandırma Sayısı"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Text_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Tips_Content = {
    Text = "Üç yıldızlı soruşturma derecesi elde edildiğinde açılır."
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_Title_Content = {
    Text = "Şimdi Yeniden Canlandırılsın mı?"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Deplete_Content = {
    Text = "Yeniden Canlandırma Bedeli"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Swept_Content = {
    Text = "Yeniden Canlandırma Sayısı"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Team_Content = {
    Text = "Soruşturma Ekibi"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Title_Content = {
    Text = "Şimdi Yeniden Canlandırılsın mı?"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Difficulty_Content = {Text = "Sıfırla"},
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_NoTask_Content = {Text = "Kayıt yok"},
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Prohibit_Content = {
    Text = "Bu seviye için Müfreze devre dışı"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Skill_Content = {
    Text = "Koruyucu Becerileri"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Title_Content = {
    Text = "Mücadele Takımı"
  },
  PanelText_UI_Dungeous_Popup_Tips_New_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity2_Content = {
    Text = "İlk Tamamlama Ödülü"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity_Content = {
    Text = "İlk Tamamlama Ödülü"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game2_Content = {
    Text = "Kümülatif Ödüller"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game_Content = {
    Text = "Kümülatif Ödüller"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Again_Content = {
    Text = "Meydan Okumayı Sıfırla"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Boundaries_Tips_Content = {
    Text = "Önerilen Diyar"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Cw_Content = {Text = "Ultra"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Hd_Content = {Text = "Kaos"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Monster_Content = {
    Text = "Canavar Önizlemesi"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Sh_Content = {Text = "Aequor"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Title_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Xr_Content = {Text = "Caro"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_illustrate_Content = {
    Text = "Oynanış Kuralları"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Again_Content = {
    Text = "Meydan Okumayı Sıfırla"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Tips_Content = {
    Text = "Ödül Ayrıntıları"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Title_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_illustrate_Content = {
    Text = "Oynanış Kuralları"
  },
  PanelText_UI_Dungeous_illustrate_Tip_Text_C_Title_Content = {
    Text = "Işıksız Diyar"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Finish_Content = {
    Text = "Etkinlik sona erdi, edinim durduruldu."
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Full_Content = {
    Text = "Mevcut Depolama Sınırına Ulaşıldı"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Event_Activity_Castor_Text_C_Reward_Content = {
    Text = "Malzeme Edin"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_SpeedTitle_Content = {
    Text = "Depolama Hızı:"
  },
  PanelText_UI_Event_Activity_Castor_Text_None_Content = {
    Text = "Envanter yok"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Finish_Content = {
    Text = "Etkinlik sona erdi."
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Full_Content = {
    Text = "Envanter sınırına ulaşıldı"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Event_Activity_DonationBox_Text_C_None_Content = {
    Text = "Bağışlanan envanter yok"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Reward_Content = {Text = "Envanter"},
  PanelText_UI_Event_Activity_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "Edinim Hızı:"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Finish_Content = {
    Text = "Etkinlik sona erdi."
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Full_Content = {
    Text = "Depolama sınırına ulaşıldı."
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Event_Activity_Horla_Text_C_Reward_Content = {
    Text = "Mağaza Bilgisi"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_SpeedTitle_Content = {
    Text = "Depolama Hızı"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Finish_Content = {
    Text = "Etkinlik sona erdi, edinim durduruldu."
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Full_Content = {
    Text = "Mevcut Depolama Sınırına Ulaşıldı"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Reward_Content = {
    Text = "Malzeme Edin"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_SpeedTitle_Content = {
    Text = "Depolama Hızı:"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_None_Content = {
    Text = "Envanter yok"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Label_Content = {
    Text = "Bayan Gray'in Dükkânı"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Mail_Content = {Text = "Kurallar"},
  PanelText_UI_Event_Activity_Main_Text_C_Normal_1_Content = {Text = "I"},
  PanelText_UI_Event_Activity_Main_Text_C_Normal_2_Content = {Text = "II"},
  PanelText_UI_Event_Activity_Main_Text_C_Normal_3_Content = {Text = "III"},
  PanelText_UI_Event_Activity_Main_Text_C_Select_1_Content = {Text = "I"},
  PanelText_UI_Event_Activity_Main_Text_C_Select_2_Content = {Text = "II"},
  PanelText_UI_Event_Activity_Main_Text_C_Select_3_Content = {Text = "III"},
  PanelText_UI_Event_Activity_Main_Text_C_Title_Content = {
    Text = "Kilise Hayır Pazarı"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Finish_Content = {
    Text = "Etkinlik sona erdi, edinim durduruldu."
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Full_Content = {
    Text = "Mevcut Depolama Sınırına Ulaşıldı"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Event_Activity_Miriam_Text_C_Reward_Content = {
    Text = "Malzeme Edin"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_SpeedTitle_Content = {
    Text = "Edinim Hızı"
  },
  PanelText_UI_Event_Activity_Miriam_Text_None_Content = {
    Text = "Envanter yok"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Finish_Content = {
    Text = "Etkinlik sona erdi, edinim durduruldu."
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Full_Content = {
    Text = "Mevcut Depolama Sınırına Ulaşıldı"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Reward_Content = {
    Text = "Malzeme Edin"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_SpeedTitle_Content = {
    Text = "Depolama Hızı:"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_None_Content = {
    Text = "Envanter yok"
  },
  PanelText_UI_Event_Activity_Pollux_Text_None_Content = {
    Text = "Envanter yok"
  },
  PanelText_UI_Event_Activity_RewardList_Text_C_Reward_Content = {
    Text = "Yardım Satışı Listesi"
  },
  PanelText_UI_Event_Activity_RewardPool_Text_C_Name_Content = {Text = "Sıfırla"},
  PanelText_UI_Event_Activity_RewardPool_Text_Name_Content = {
    Text = "Tümünü Borsa’ya Ver"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Close_Content = {
    Text = "Dönmek için boş alana tıkla"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_CoreReward_Content = {
    Text = "Özel Tohum"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Result_Content = {
    Text = "Borsa Sonuçları"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_C_Desc_Content = {
    Text = "Efendi bugün de Karen’a temizlikte yardım etmeye mi geldi? Ne harika; bu da Karen’ın küçük bir minnettarlık nişanesi, lütfen mutlaka kabul edin!"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_1_Content = {Text = "Alındı"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_2_Content = {Text = "Alındı"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_3_Content = {Text = "Alındı"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_4_Content = {Text = "Alındı"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_5_Content = {Text = "Alındı"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_6_Content = {Text = "Alındı"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_7_Content = {Text = "Alındı"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Title_Content = {
    Text = "Karen'ın Şükranı"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_C_Desc_Content = {
    Text = "Güneş ışığı, kum, dalgalar ve sayısız gülümseyen yüz— bu yaz düşünde, enerjik bir voleybol maçı yapalım!"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_Title_Content = {
    Text = "Yaz Şenliği"
  },
  PanelText_UI_Event_Activity_SummonBenefits_Text_C_Summon_Content = {
    Text = "Ücretsiz Uyanış"
  },
  PanelText_UI_Event_Activity_Thing_Item_Text_C_Sold_Out_Content = {Text = "Tükendi"},
  PanelText_UI_Event_Activity_Thing_Item_Text_C_Special_Tips_Content = {Text = "Özel"},
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Finish_Content = {
    Text = "Etkinlik sona erdi ve depolama durduruldu."
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Full_Content = {
    Text = "Depolama kapasitesi sınırına ulaşıldı"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Reward_Content = {
    Text = "Depolanmış Madde"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_SpeedTitle_Content = {
    Text = "Depolama Hızı:"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "Manik Birikim"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_Name_Content = {Text = "Al"},
  PanelText_UI_Event_Activity_TwentyFour_Text_None_Content = {
    Text = "Envanter yok"
  },
  PanelText_UI_Event_Activity_XiaomaoGift_Text_C_Receive_Content = {
    Text = "Kalan Uyanışlar:"
  },
  PanelText_UI_Event_Challenge_Item_Text_C_Finish_Content = {Text = "Son Kez"},
  PanelText_UI_Event_Item_Return_Text_C_Close_Content = {
    Text = "Kapatmak için ekrana dokun"
  },
  PanelText_UI_Event_Item_Return_Text_C_Finish_Content = {Text = "Alındı"},
  PanelText_UI_Event_Item_SignDay_Text_C_CanReceive_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Event_Item_SignDay_Text_C_Got_Content = {Text = "Alındı"},
  PanelText_UI_Event_Item_SignDay_Text_C_Nor_Content = {
    Text = "Ödüller Hazır"
  },
  PanelText_UI_Event_Item_WeaponOptional_Text_C_Got_Content = {
    Text = "Zaten Sahip"
  },
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Title_Content = {
    Text = "Kilise Bölgesi"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Introduction_Content = {
    Text = "Şşşt... derin bir nefes al, dokunaçlarını gevşet. Şimdi “24”ün bilincinin derinliklerine inecek, gizli Anıları keşfedeceksin..."
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "Hafıza Kodu"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Awaker_Content = {
    Text = "Deneme Uyanışçı"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_FristCreation_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Leader_Content = {
    Text = "Bölüm Önizlemesi"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Record_Content = {
    Text = "Meydan Okuma"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_StarTitle_Content = {
    Text = "Yıldız Hedefleri"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Title_Content = {
    Text = "Kurgulanmış Gizem"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Creation_Content = {
    Text = "Aşama Kalıntısı"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Double_Content = {
    Text = "Çifte Meydan Okuma"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_FristCreation_Content = {
    Text = "Başlangıç Kalıntısı"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Leader_Content = {
    Text = "Boss Önizlemesi<WordSize20:>"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_MeltErosion_Content = {Text = "D-Gelgiti"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Monster_Content = {
    Text = "Canavar Önizlemesi"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Record_Content = {
    Text = "Meydan Okuma"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_RemainNum_Content = {
    Text = "Kalan Klon Sayısı"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Replay_Content = {Text = "Kayıt"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Event_Panel_Challenge_Text_C_RewardTitle_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_SweepName_Content = {Text = "Süpürme"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Title_Content = {
    Text = "Kurgulanmış Gizem"
  },
  PanelText_UI_Event_Panel_Challenge_Text_Career_Content = {
    Text = "Gereklilik: Diyar 1"
  },
  PanelText_UI_Event_RewardGroup_Text_C_Reset_Content = {
    Text = "Kalan Sıfırlamalar:"
  },
  PanelText_UI_Event_Reward_Item_Text_C_Not_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Event_Reward_Item_Text_C_Receive_Content = {Text = "Al"},
  PanelText_UI_Event_Task_Item_Text_C_Not_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Event_Task_Item_Text_C_Receive_Content = {Text = "Al"},
  PanelText_UI_Event_WeaponOptional_Text_C_Receive_Content = {
    Text = "Kalan Uyanışlar:"
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Introduction_Content = {
    Text = "Gel! Notaları delilik, kıyım ve ıstırap olan bu ağıdı, yıldızların arasında titreşen bir ilahiye dönüştürelim!\nO Kör Ahmak Tanrı, Budalalık ve Kaos’un Yüce Varlığı, ne şimdi ne de gelecekte uyanmamalı."
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Title_Content = {
    Text = "Yıldız Ağıtı"
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Introduction_Content = {
    Text = "Rabbimizin vaat ettiği yakındır.\nBin yıllık bekleyiş mutlu bir sona kavuşacak ve vaat edilen topraklar denizden yükselecek.\nO, İlahi Ana'nın göğsünden yeniden doğacak; yedinci gün sona erdiğinde, yeni bir dünya inecek."
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Title_Content = {
    Text = "Teofani Haftası"
  },
  PanelText_UI_Events_Item_Castor_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Castor_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_Free_Content = {Text = "Ücretsiz"},
  PanelText_UI_Events_Item_GiftBag_Text_C_High_Content = {Text = "Ücretsiz"},
  PanelText_UI_Events_Item_GiftBag_Text_C_Noraml_Content = {Text = "Al"},
  PanelText_UI_Events_Item_GiftBag_Text_C_Soldout_Content = {Text = "Alındı"},
  PanelText_UI_Events_Item_Hamline_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Hamline_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Killed_Content = {
    Text = "Öldürüldü!"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Progress_Content = {
    Text = "Meydan Okunabilir"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Full_Content = {
    Text = "Tam Yükseltilmiş"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Have_Content = {
    Text = "Zaten Sahip"
  },
  PanelText_UI_Events_Item_OriDoll_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_OriDoll_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_PreOrderGift_Text_C_Lock_Content = {
    Text = "Talep Etmek İçin Satın Al"
  },
  PanelText_UI_Events_Item_RAIDProgressGroup_Text_C_Kill_Content = {
    Text = "Toplam Yakalamalar"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Career_Content = {
    Text = "Grup Gereksinimleri"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Finish_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Item_RAID_Text_C_Kill_Content = {Text = "Yakalandı"},
  PanelText_UI_Events_Item_RAID_Text_CareerLimit_Content = {
    Text = "Sınırsız"
  },
  PanelText_UI_Events_Item_RAID_Text_Lock_Content = {
    Text = "Henüz Mevcut Değil"
  },
  PanelText_UI_Events_Item_Rome_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Rome_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_SignDiamond_Text_C_Receive_Content = {Text = "Alındı"},
  PanelText_UI_Events_Item_Sorel_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Sorel_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Stage_Text_C_Undone_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_NormalTip_Content = {
    Text = "Normal Zorluk Tamamlanmayı Bekliyor"
  },
  PanelText_UI_Events_Item_SurveyDiary_Text_Name_Content = {Text = "Al"},
  PanelText_UI_Events_Item_Tab_Text_C_Return_Content = {
    Text = "Eve Dönüş Etkinliği"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Career_Content = {
    Text = "Grup Gereksinimleri"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Finish_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Item_TeamSchool_Text_CareerLimit_Content = {
    Text = "Sınırsız"
  },
  PanelText_UI_Events_Item_Tulu_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Tulu_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_LockTips_Content = {
    Text = "Görev Gücü Kayıtları’nı açmak için önkoşul seviyeleri tamamla."
  },
  PanelText_UI_Events_Item_Wanda_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Killed_Content = {
    Text = "Ortadan Kaldırıldı!"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Progress_Content = {
    Text = "Kalan Klon Sayısı"
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "Bedenini terk et, aklını terk et ve saf iradeden oluşan bu dünyada Onun varlığını hisset.\nO senin tek olanındır. O aynı zamanda her şeyindir."
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Title_Content = {
    Text = "Kasvetli Gelgit"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Introduction_Content = {
    Text = "\nAğzını sonuna kadar aç ve var gücünle ısır.\nYut ya da yutul—işte Savaş’ın kuralı, işte bir canavarın yazgısı budur."
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Title_Content = {
    Text = "Vahşi Hırs"
  },
  PanelText_UI_Events_OriHelot_Text_C_Fall_Content = {
    Text = "Düşen Ögeler Önizlemesi"
  },
  PanelText_UI_Events_OriHelot_Text_C_LockTips_Content = {
    Text = "Aşama Kilit Açma Bildirimi"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_Challenge_Content = {
    Text = "Yıldız Ağıtı"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_ProgressTitle_Content = {
    Text = "Küresel İlerleme"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Ordinary_Content = {
    Text = "Standart Arşivler"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_PassportUp_Content = {Text = "Yükseltme"},
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Senior_Content = {
    Text = "Gelişmiş Seyahat Kayıtları"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_illustrate_Content = {
    Text = "Etkinlik Açıklaması"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_PayTip_Content = {
    Text = "Gösterilen fiyat yalnızca referans içindir. Gerçek ödemeler, geçerli para birimi üzerinden güncel kurla işlenecektir."
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Introduction_Content = {
    Text = "Işıklar parlıyor. Alkışlar diniyor. Seyirciler heyecanla bekliyor.\nSahneye çıkma zamanı, sevgili çocuklarım. İlerleyin—performans sergileyin, ruhlarınızı yırtıp açın ve en derin sırlarınızı satın. En yıkıcı yaralarınızı alın ve seyircinin zevki için şekerleme yapın. Sadece sizin için yakılan o tek ışık huzmesinde açgözlüce güneşlenin, ta ki perde hem sizi hem de seyircinizi birlikte gömmek için kapanana dek.\n\nBu sizin için yazılmış sahne—çıkın! Korkmayın; sahne korkusuna gerek yok."
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Title_Content = {
    Text = "Kuklanın Sahnesi"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Challenge_Content = {
    Text = "Kuklanın Sahnesi"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Shop_Content = {
    Text = "Tiyatro Hediyelikleri"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Topic_Content = {
    Text = "Bağlı Dokumacı"
  },
  PanelText_UI_Events_Panel_Attendance_Text_C_GiftTitle_Content = {
    Text = "Bir Kostüm Kuponu talep et!"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_1_Content = {
    Text = "Hayali Dalış"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_2_Content = {Text = "Traphase"},
  PanelText_UI_Events_Panel_Award_Text_C_Award_Content = {
    Text = "Hayali Dalış"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Over_Content = {
    Text = "Bugünkü Koruyucu DEN’i"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Title_Content = {
    Text = "Bugünkü Koruyucu DEN’i"
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Not_Unlocked_Content = {
    Text = "Kilitli Değil"
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Shop_Content = {
    Text = "Okula Dönüş Mağazası"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Challenge_Content = {Text = "Kutsal Yol"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Fill_Up_Content = {
    Text = "(Depolama Sınırına Kalan:"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Finish_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Fundraising_Content = {
    Text = "Vatandaşların İyi Niyeti"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Not_unlocked_Content = {
    Text = "<Gray:Kilit Açıldı>"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Pv_Content = {Text = "Hikâye"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Record_Content = {
    Text = "Kanın Rengi"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Resonance_Content = {
    Text = "Rezonans: Ruhun Çatalı"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Shop_Content = {
    Text = "Kilise Hayır Pazarı"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Topic_Content = {
    Text = "Ruh Çobanı: Tekrar"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Award_Content = {
    Text = "Sınırlı Süreli Ödüller"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Limit_Content = {
    Text = "Soruşturma Ödülü"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Over_Content = {
    Text = "Tüm ödüller alındı"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Pass_Content = {
    Text = "Tamamlama Ödülü"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Title_Content = {
    Text = "Ödül Önizlemesi"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Introduction_Content = {
    Text = "♪~~♫~~♪~~♫~~♪~~♫~~\nKar dağının eteğinde, her rehber onu hatırlar ve her çocuk hâlâ onu söyler. O, yüce dağın ete kemiğe bürünmüş iradesidir; merhametli tanrıça Umapati'dir. İlahi gücü fani dünyaya saçılmıştır; hazineleri bulunamaz. Dokunulacak kadar yakındırlar; hiçbir iz bırakmazlar. \nBir şeyden vazgeç. Bir şeye tutun. Tanrıçanın gerçek özüne karşı kalbi sahte olanlar, ölen dağın yanı sıra kar dağında sonsuza dek gömülecektir."
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Title_Content = {
    Text = "Umapati'nin Hazineleri"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Challenge_Content = {
    Text = "Umapati'nin Hazineleri"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Shop_Content = {
    Text = "Peri'nin Ritüelleri"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Topic_Content = {
    Text = "Yeni Ay ve Derin Kar"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Introduction_Content = {
    Text = "Bir kuşun yaşamı, özgürlüğe yazgılı bir yaşamdır. Yumurtadan çıktığı o anı görmeliydin; yaşamın özgürlüğünü, ölümün elinden söküp alışını. Uçmayı ilk öğrendiği anı görmeliydin; sıcak yuvanın konforundan kopup, hayatta kalmanın özgürlüğünü söküp alışını. Şimdi, özgürlüğün Anahtarı ölümün uçurumuna atılsa, tereddüt etmeden atlar—dar bir yaşam yerine ölümün azgın fırtınasıyla yüzleşmeyi seçer, onun yerine sonsuz özgürlüğü kucaklar."
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Title_Content = {
    Text = "Gökyüzüne Yükselen Ruh"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Challenge_Content = {
    Text = "Gökyüzüne Yükselen Ruh"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Castor_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Castor_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Castor_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Record_Content = {
    Text = "Düş Diyarı"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Shop_Content = {
    Text = "Bilgi Arzusu"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Topic_Content = {
    Text = "Yansımanın Tutsağı"
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Introduction_Content = {
    Text = "O günden beri, tek bir gözyaşı bile dökmedi.\nYalnız başına dolaşıyor, dışlanmışlarla dolu bir dünyada sürükleniyor.\nGörkemli bir plan başlamak üzere, onun son vedası olarak.\nO, en başarılı psikolog; bu ise onun en başarılı tedavisi."
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Title_Content = {
    Text = "Korku Terapisi"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Challenge_Content = {
    Text = "Korku Terapisi"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Clementine_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Clementine_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Clementine_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Record_Content = {
    Text = "Psişe Derin Dalışı"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Resonance_Content = {
    Text = "Rezonans: Yokluk"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Shop_Content = {
    Text = "Nöroterapi odası"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Topic_Content = {
    Text = "Hafızanın Altına Gömülü"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Empty_Content = {
    Text = "Tüm ödüller alındı"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Lottery_Content = {
    Text = "1× Çekiliş"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Rate_Content = {
    Text = "Olasılık Açıklaması"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Tip_Content = {
    Text = "<color=#e3c96e>Premium Kostüm</color>, <color=#e3c96e>5</color>. çekilişten itibaren düşebilir"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Topic_Content = {
    Text = "Ruh Çobanı"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_Free_Content = {Text = "Ücretsiz"},
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Introduction_Content = {
    Text = "Bu sahil kasabasında, cıvıl cıvıl bir ticaret caddesi vardır. Deniz ticareti buraya sayısız moda ürünü taşımıştır; yeterince Leonian Florin ödediğin sürece, daima tatmin edici bir şeyler bulursun.\nTek istisna, köşedeki küçük bir dükkândır; büyülü antikalarla dolu, eski usul bir yer. Pipo dumanının kıvrıla kıvrıla yükseldiği havada, geniş siperli şapkasını takmış dükkâncı sana yavaşça bir gülümseme sunar.\n\"Hoş Geldin Kaygısız Dükkân’a; tüm ihtiyaçların karşılanır, yeter ki bedelini ödeyesin...\"\n\"Elbette, elbette, fiyatlarımız makuldür ve biz Everyone karşı dürüstüz.\""
  },
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Title_Content = {
    Text = "Cadının Dükkânı"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Challenge_Content = {
    Text = "Cadının Dükkânı"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Shop_Content = {
    Text = "Cadının Hazinesi"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Topic_Content = {
    Text = "Yağmur Kasabasının Hayaleti"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Introduction_Content = {
    Text = "Orkestra doruk noktasına ulaştı ve on üçüncü çan çaldı.\nBu gece, şairin bıçağı dizelerini oyacak.\nBu gece, ananın boğazı bizi bütünüyle yutacak."
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Title_Content = {
    Text = "Ruh Bayramı"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Challenge_Content = {
    Text = "Ruh Bayramı"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Doresain_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Doresain_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Doresain_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Record_Content = {
    Text = "Görevler Kaydı"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Shop_Content = {
    Text = "Kemik Sarayı Ziyafet Salonu"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Topic_Content = {
    Text = "Ölümsüzlerin Estetiği"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Ordinary_Content = {
    Text = "Standart Arşivler"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_PassportUp_Content = {Text = "Yükseltme"},
  PanelText_UI_Events_Panel_GamePassport_Text_C_Senior_Content = {
    Text = "Gelişmiş Seyahat Kayıtları"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_illustrate_Content = {
    Text = "Etkinlik Açıklaması"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Introduction_Content = {
    Text = "Mızrağının ucunda çalınan Gümbürdeyen Makineler.\nUzun Rüya’ya Nüfuz Etmiş, Yıkım’ın Son Bölümüne dek."
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Title_Content = {
    Text = "Gümbürdeyen Makineler"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Challenge_Content = {
    Text = "Gümbürdeyen Makineler"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Hamline_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Hamline_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Hamline_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Resonance_Content = {
    Text = "Rezonans: Yokluk"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Shop_Content = {
    Text = "Uyku Kalesi"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Topic_Content = {
    Text = "Görünmez Senfoni"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Introduction_Content = {
    Text = "Harap olmuş serada, yalnız bir gül tutsak tutuluyor."
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Title_Content = {
    Text = "Bahçe Hatıraları"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Challenge_Content = {
    Text = "Bahçe Hatıraları"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Horla_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Horla_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Horla_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Resonance_Content = {
    Text = "Rezonans: Bahçe Ağıdı"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Shop_Content = {
    Text = "Colette'in Çiçek Evi"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Topic_Content = {
    Text = "Bahar Solmadan Önce"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Reward_Content = {
    Text = "Toz Alma Ödeneği"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Sign_Content = {
    Text = "Karen'ın Şükranı"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Task_Content = {
    Text = "Temizlik İlerlemesi"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Topic_Content = {
    Text = "Süpürge ve Harika"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Introduction_Content = {
    Text = "Bir kez daha Toprak'ın üzerinde duruyor ve her şeyi tüketen intikam söz verildiği gibi geliyor.\n\nBu bitmek bilmeyen bir Av, bu Yaşayan Alev'in yakıcı ateşi.\n\nHer köşeyi dolaşacak, Ölüm ile Sözleşme imzalamış herkesi avlayacak.\n\nKoş, koş, daha derin Karanlığa kaç, bulunmayacağını düşündüğün bir yere kaç.\n\nGerçi bunun bir anlamı yok, çünkü O her dünyayı çiğneyerek geçecek.\n\nHer şeyi avlayacak, ta ki her şey küle dönene dek."
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Title_Content = {Text = "Kül Avı"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Challenge_Content = {Text = "Kül Avı"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Fill_Up_Content = {
    Text = "(Depolama Sınırına Kalan:"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Record_Content = {
    Text = "Psişe Derin Dalışı"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Shop_Content = {Text = "Gizli Üs"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Topic_Content = {
    Text = "Yere İnen Bin Güneş"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Describe_Content = {
    Text = "Tanık olduğun şey yalnızca bir ruhun seçimi değil, aynı zamanda yaşamının dalgalı yolculuğudur."
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Lake_City_Text_C_Title_Content = {Text = "Kutsal Yol"},
  PanelText_UI_Events_Panel_Lake_City_Text_C_illustrate_Content = {
    Text = "Oynanış Kuralları"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Introduction_Content = {
    Text = "Bebek’in verdiği görevler asla basit değildir.\nHerkese defalarca “eğlenin” diye hatırlatmasına rağmen, bir grup Uyanan’ı ilk kez dışarı çıkaran Koruyucu nasıl gergin olmasın?\nAma unutma, “eğlenmek” gerek, tamam mı."
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Title_Content = {
    Text = "Kurgulanmış Gizem"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Challenge_Content = {
    Text = "Kurgulanmış Gizem"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Pv_Content = {
    Text = "Video oynat"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Resonance_Content = {
    Text = "Rezonans: Direktörün Kodu"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Shop_Content = {
    Text = "Gizemli kodeks emporyumu"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Topic_Content = {
    Text = "Hikâyelerin Büyüsü·Tekrar"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Introduction_Content = {
    Text = "Güç, kuvvet, zenginlik, özgürlük... Leviathan'ın topraklarında, O sana arzuladığın her şeyi bahşedecek.\nTabii ki, ayakta kalan son kişi sen olman şartıyla."
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Title_Content = {
    Text = "Açgözlülük ve Kan Hırsı"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Challenge_Content = {
    Text = "Açgözlülük ve Kan Hırsı"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Record_Content = {
    Text = "Psişe Derin Dalışı"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Shop_Content = {
    Text = "Arena Sunağı"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Topic_Content = {
    Text = "Leviathan'ın Oyunu"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Challenge_Content = {
    Text = "Kurgulanmış Gizem"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Desc_Content = {
    Text = "Bebek’in verdiği görevler asla basit değildir.\nHerkese defalarca “eğlenin” diye hatırlatmasına rağmen, bir grup Uyanan’ı ilk kez dışarı çıkaran Koruyucu nasıl gergin olmasın?\nAma unutma, “eğlenmek” gerek, tamam mı."
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Own_Content = {
    Text = "Mevcut Sahip Olunan"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Resonance_Content = {
    Text = "Rezonans: Direktörün Kodu"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Shop_Content = {
    Text = "Gizemli kodeks emporyumu"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Topic_Content = {
    Text = "Hikâye Anlatımının Büyüsü"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentActivity_Content = {
    Text = "Atari Salonu"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentRule_Content = {
    Text = "Atari Salonu"
  },
  PanelText_UI_Events_Panel_Main_Text_C_Pv_Content = {
    Text = "Video oynat"
  },
  PanelText_UI_Events_Panel_Main_Text_C_SevenDays_Content = {
    Text = "Yedi Günlük Giriş"
  },
  PanelText_UI_Events_Panel_Main_Text_C_illustrate_Content = {
    Text = "Etkinlik Açıklaması"
  },
  PanelText_UI_Events_Panel_Main_Text_Title_Content = {Text = "Etkinlik"},
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Introduction_Content = {
    Text = "Bu çetin ve kutsal yola gir. Her şeyin sonunda, nihai Kapı senin için açılacak."
  },
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Title_Content = {
    Text = "Tanrı Diyarının Doğuşu"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Challenge_Content = {
    Text = "Tanrı Diyarının Doğuşu"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Miriam_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Miriam_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Miriam_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Record_Content = {
    Text = "Düş Diyarı"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Resonance_Content = {
    Text = "Rezonans: Derinlerin Ayini"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Shop_Content = {
    Text = "Uçurumun Yanıtı"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Topic_Content = {
    Text = "Uçurum Kurbanı"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Introduction_Content = {
    Text = "Gökyüzü~ ne parlak~ deniz~ ne sakin~\nVortice~ ve arkadaşlar~ Coalsie~ yelken açtı!\nFırtınalar mı? Korkmayız! Şimşekler mi? Korkmayız!\nVortice, arkadaşlar, Coalsie~\nÖzgürlüğümüz için! İşte! Başlıyoruz!"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Title_Content = {
    Text = "Vortice ve Deniz"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Challenge_Content = {
    Text = "Vortice ve Deniz"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Record_Content = {Text = "İhtiras"},
  PanelText_UI_Events_Panel_Mosk_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Shop_Content = {
    Text = "Vortice'nin Hazinesi"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Topic_Content = {
    Text = "Moskstraumen'in Çağrısı"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Introduction_Content = {
    Text = "Bir gün, aniden değiştiğini fark ediyorsun.\nKimse bunu keşfetmedi çünkü aynı davranışlara ve tavırlara, aynı çarpıcı görünüme sahipsin.\nAma sen çok iyi biliyorsun ki, bir zamanlar parlak kırmızı olan kalp, çoktan sisten yapılmış bir maskeyle örtülmüş.\nEğer rol yapmaya devam edebiliyorsam, hâlâ eskisi gibi aynı kişi miyim?\nTebrikler, bu soru aklında bir saniyeden fazla kalmadı; aslında, o maske kaldırılmadan önce kimse gerçek düşüncelerini bilmiyor.\nO halde, önce yola çıkalım~"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Title_Content = {
    Text = "Kayıp Benlik"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Challenge_Content = {
    Text = "Kayıp Benlik"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Record_Content = {
    Text = "Çok Boyutlu Bağlantı"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Shop_Content = {
    Text = "Mouchette'in Kulübesi"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Topic_Content = {
    Text = "Sisle Örtülü Ayin"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Introduction_Content = {
    Text = "Karanlığa Gömülmüş @2minde, O’nun Dau@2ter’ında, Büyük @4 Doğar"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Title_Content = {
    Text = "Karanlık Rahim"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Challenge_Content = {
    Text = "Karanlık Rahim"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Homology_Content = {
    Text = "Etkinlik süresince Afinite Kazancı ikiye katlanır!"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Pv_Content = {
    Text = "Video oynat"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Record_Content = {
    Text = "Güle Övgü"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Shop_Content = {
    Text = "Semavi Gebelik"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Topic_Content = {
    Text = "Yıldızlar Yerinde: Tekrar"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Challenge_Content = {
    Text = "Kasvetli Gelgit"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_GiftTitle_Content = {
    Text = "Bir Kostüm Kuponu talep et!"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_ProgressTitle_Content = {
    Text = "Kasvetli Gelgit Öldürme İlerleyişi"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Topic_Content = {
    Text = "Tanrı Diyarı Yeniden Yüzeye Çıkıyor"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Introduction_Content = {
    Text = "Dünyanın sonundaki büyük Kapı’ya bakıyor, sonra tereddüt etmeden öne adım atıyor.\nTık. Kol çevriliyor. Eşiğin ötesini gözleriyle açgözlü bir hevesle tarıyor.\nAma orada yalnızca hiçlik var. Düş’ün içine adım atmış durumda.\nBunu bilmeliydi: böylesine cömertçe sunulan armağanlar, her zaman en dik bedeli talep eder."
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Title_Content = {
    Text = "Unutuş Kapısı"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Challenge_Content = {
    Text = "Unutuş Kapısı"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_OriDoll_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_OriDoll_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_OriDoll_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Record_Content = {
    Text = "Psişe Derin Dalışı"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Resonance_Content = {
    Text = "Rezonans: Yokluk"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Shop_Content = {
    Text = "Üstadın Öğretileri"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Topic_Content = {
    Text = "Yarım Adım Ötede"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Challenge_Content = {
    Text = "Vahşi Hırs"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_OriHelot_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_OriHelot_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_OriHelot_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Shop_Content = {
    Text = "Dağ Çenesi"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Topic_Content = {
    Text = "Karlar Eridiğinde: Tekrar"
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Introduction_Content = {
    Text = "Rabbimizin vaat ettiği yakındır.\nBin yıllık bekleyiş mutlu bir sona kavuşacak ve vaat edilen topraklar denizden yükselecek.\nO, İlahi Ana'nın göğsünden yeniden doğacak; yedinci gün sona erdiğinde, yeni bir dünya inecek."
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Title_Content = {
    Text = "Teofani Haftası"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Challenge_Content = {
    Text = "Teofani Haftası"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Shop_Content = {
    Text = "Kutsal Yatak Odası"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Topic_Content = {
    Text = "Kutsal Doğumun Ayini"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_ChallengeTip_Content = {
    Text = "Süreli İş Birliği"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Challenge_Content = {Text = "Traphase"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Record_Content = {Text = "Sıram"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Shop_Content = {
    Text = "Mağaza Adı"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Topic_Content = {
    Text = "Yağmur Kasabasının Hayaleti"
  },
  PanelText_UI_Events_Panel_PermanentActivity_Text_C_Reward_Content = {
    Text = "Kalan Ödüller"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Introduction_Content = {
    Text = "Akıl sağlığı ile Çöküş arasında, tuhaf bir parşömen açılır.\nNefret ettiğin halüsinasyonlar parlak Ana Renkler çizer,\nKorktuğun kontrol kaybı, Sadakat suretine bürünür.\nBurada, Delilik sanatın içgüdüsü, dünyanın Kökenidir,\nAsla yalan söylemeyen tek hakikattir."
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Title_Content = {
    Text = "Tuhaf Eskiz"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Challenge_Content = {
    Text = "Tuhaf Eskiz"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Record_Content = {
    Text = "Psişe Derin Dalışı"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Shop_Content = {
    Text = "Pickman'ın Atölyesi"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Topic_Content = {
    Text = "Tuvalin Karanlık Yüzü"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Introduction_Content = {
    Text = "Nefret ve sevgi, sıcaklık ve acı, bir zamanlar sahip olduklarımız ve kaybettiklerimiz—artık hepsi iç içe geçmiş, çözülmesi imkânsız.\nOrtak kanımız birlikte aksın ve birleşsin, ayrılmaz kaderimizi şekillendirsin."
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Title_Content = {
    Text = "Kaynaşan Acı Kan"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Challenge_Content = {
    Text = "Kaynaşan Acı Kan"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Record_Content = {
    Text = "Göklerin Ötesinde·Bölüm II"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Shop_Content = {
    Text = "Kutsama Ayini"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Topic_Content = {
    Text = "Ebedi Gündüzün Son Gecesi"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Introduction_Content = {
    Text = "Uğursuz beyaz ışık yeniden Yüksek Ev'in pencerelerini delip geçtiğinde, o sana çoktan davetini iletmiştir.\nKucaklamak, yutmak, sarmak, sıkıştırmak… \nDerin Deniz'in derinliklerinden gelen Çağrı'ya cevap ver, bu dinmeyen Yüksek Ev Avı'na katıl; geçmişin, benliğin, hiçbir şeyin önemi kalmaz artık."
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Title_Content = {
    Text = "Yüksek Ev Avı"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Challenge_Content = {
    Text = "Yüksek Ev Avı"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Record_Content = {
    Text = "Psişe Derin Dalışı"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Shop_Content = {
    Text = "Av Alanları"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Topic_Content = {
    Text = "Ebwynnos Evermore"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Challenge_Content = {
    Text = "Kedi Gümüş Akını"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Rank_Content = {
    Text = "Yakalama Sıralamaları"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Reward_Content = {
    Text = "Kara Kedi Yakalama Günlüğü"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Topic_Content = {
    Text = "Miyavlı Teşekkürler!"
  },
  PanelText_UI_Events_Panel_RailWay_StageGroup_Text_C_Title_Content = {Text = "Trene Bin"},
  PanelText_UI_Events_Panel_RailWay_Text_C_Challenge_Content = {Text = "Trene Bin"},
  PanelText_UI_Events_Panel_RailWay_Text_C_Rank_Content = {
    Text = "VIP Listesi"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "Küçük N'in Yardımı"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Reward_Content = {
    Text = "İz Düzeni İzleri"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Topic_Content = {
    Text = "Çılgın Gökyüzü Rayı"
  },
  PanelText_UI_Events_Panel_Reward_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Events_Panel_Reward_Text_Title_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Introduction_Content = {
    Text = "Biz etoburuz, kurdun çocuklarıyız. Arzuladığımız et—zengin, kızıl ve damlayan—er ya da geç dişlerimize ve dillerimize varacaktır; tıpkı her şeyin varmak zorunda olduğu gibi."
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Title_Content = {Text = "Kutsal Av"},
  PanelText_UI_Events_Panel_Rome_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Challenge_Content = {Text = "Kutsal Av"},
  PanelText_UI_Events_Panel_Rome_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Rome_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Rome_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Rome_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Record_Content = {
    Text = "Düş Diyarı"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Shop_Content = {
    Text = "Haraç Sunma"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Topic_Content = {
    Text = "Roma! Özel Etkinlik"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Introduction_Content = {
    Text = "Evet, artık sıradan, süssüz bir Dedektif olmak hiç de revaçta değil.\nUçamıyor, kaybolup gidemiyor ve bir bilim insanı yardımcın yoksa, lütfen kariyer planını yeniden düşün."
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Title_Content = {
    Text = "Mehtap masalları"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Challenge_Content = {
    Text = "Mehtap masalları"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Homology_Content = {
    Text = "Etkinlik süresince Afinite Kazancı ikiye katlanır!"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Pv_Content = {
    Text = "Video oynat"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Record_Content = {
    Text = "İyi Avlar!"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Shop_Content = {
    Text = "Şans Kulübü"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Topic_Content = {
    Text = "Dedektif El Kitabı: Tekrar"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Introduction_Content = {
    Text = "Bilim mi? Önemi yok. Etik mi? Önemi yok. Ahlak mı? Önemi yok. \nYaşam, ölüm, umut, umutsuzluk... sonunda, bodrumdaki bir defterde, aynı ispat iki farklı el yazısıyla yazılmış. \nDiyorlar ki: <Italic:\"Bak—aşk tek ve biricik ebedi temadır.\">"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Title_Content = {
    Text = "Karanlık Oda Notları"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Challenge_Content = {
    Text = "Karanlık Oda Notları"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Record_Content = {
    Text = "Unutulmuş Aşk Tohumları"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Shop_Content = {
    Text = "Karahindiba Bahçesi"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Topic_Content = {
    Text = "Baş Aşağı Yeniden Doğuş"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Introduction_Content = {
    Text = "Yıllar sonra, bir biyografi yazarı bir akşam kapısını çaldı.\nO gün, akik taşlarından çürüyen gül konağına kadar pek çok şey konuştular...\nŞimdi yazar, bu parçalanmış sözleri bir kitapta topladı; burada bulunan hepinize adanmıştır."
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Title_Content = {
    Text = "Gülün Anıları"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Challenge_Content = {
    Text = "Gülün Anıları"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Homology_Content = {
    Text = "Etkinlik süresince Afinite Kazancı ikiye katlanır!"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Pv_Content = {
    Text = "Video oynat"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Record_Content = {
    Text = "Güle Övgü"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Shop_Content = {
    Text = "Altın Kızıl Şölen"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Topic_Content = {
    Text = "Güle Mektup"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Limit_Content = {
    Text = "Soruşturma Ödülü"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Over_Content = {
    Text = "Tüm ödül koşulları yerine getirildi."
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Pass_Content = {
    Text = "Tamamlama Ödülü"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Title_Content = {
    Text = "Ödül almak için Uyanış Deneme Görevini tamamla."
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Introduction_Content = {
    Text = "Eski Sekstant yıldızlar arasındaki açıları tayin eder, kadim deniz haritaları beklenen rotayı çizer ve yıpranmış pusula, İleriye gidilecek yönü belirler...\nSoğuk ve derin Karadeniz’in içinde bile, hâlâ sıradan bakır ve demire güvenerek Herkes için yolu gösteren Kâşifler vardır.\nTüm kılavuzlar asla yolunu kaybetmesin."
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Title_Content = {
    Text = "Derin Denizde Kayıp"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Challenge_Content = {
    Text = "Derin Denizde Kayıp"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Record_Content = {
    Text = "Son Kılavuzluk"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Shop_Content = {
    Text = "Mürettebatın Hazineleri"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Topic_Content = {
    Text = "Fırtınanın Altında Salınış"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Introduction_Content = {
    Text = "Önce dostluk, sonra rekabet—şaka tabii!\nYakıcı güneşin altında ter dökerek, şampiyonluk için çabalamak!"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Title_Content = {
    Text = "Plaj Voleybolu Turnuvası"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Challenge_Content = {
    Text = "Plaj Voleybolu Turnuvası"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Record_Content = {
    Text = "Düş Diyarı"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Shop_Content = {
    Text = "Sahil Hanı"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Sign_Content = {
    Text = "Yaz Şenliği"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Topic_Content = {
    Text = "Yaz Özel: I"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Introduction_Content = {
    Text = "Sıcak güneş ışığı altında her şey çok rahat ve mutlu hissettiriyor.\nMasmavi gökyüzüne bakıyorsun, tıpkı bir peri masalındaki gibi, ve tuvali kendi ellerinle yırtıp sahte dünyadan çıkmaya karar veriyorsun."
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Progress_Content = {
    Text = "Yıldız İlerlemesi"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Title_Content = {
    Text = "Güneş Altında Yeni Şey"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Challenge_Content = {
    Text = "Güneş Altında Yeni Şey"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Record_Content = {
    Text = "Düş Diyarı"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Shop_Content = {
    Text = "Öğrenci Konseyi Binası"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Topic_Content = {
    Text = "Her Şey Eskisi Gibiyse"
  },
  PanelText_UI_Events_Panel_SurveyDiary_Text_C_Return_Content = {
    Text = "Okula Dönüş Ödülü"
  },
  PanelText_UI_Events_Panel_Task_Text_C_OneKeyName_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Events_Panel_Task_Text_Title_Content = {
    Text = "Temizlik İlerlemesi"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Introduction_Content = {
    Text = "Son Sınırın Kapısı'nı aş ve sonsuz bilgelik diyarına ulaş.\nKirletilmiş olana yüz çevir ve \"kendin\" olmanın ne demek olduğunu idrak et.\nBu, Onlar tarafından sana bahşedilmiş Son Sınav'dır."
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Title_Content = {Text = "Son Sınav"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Challenge_Content = {Text = "Son Sınav"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Shop_Content = {Text = "Yankı"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Topic_Content = {
    Text = "Tüm Diyarların Kapısı"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Challenge_Content = {
    Text = "Kediler Karnavalı"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Tip_Content = {
    Text = "Her gün farklı Okul Kedisi seviyeleri açılır ve meydan okumaları başarıyla tamamlayarak bol ödüller kazanabilirsiniz!"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Topic_Content = {
    Text = "Uzza Kedi Yasası"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Describe_Content = {
    Text = "Zaman ileri geri akar, solmuş çiçekler yeniden açar."
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Title_Content = {
    Text = "Kaotik Arzu"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_illustrate_Content = {
    Text = "Oynanış Kuralları"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Challenge_Content = {
    Text = "Kaotik Arzu"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Homology_Content = {
    Text = "Etkinlik süresince Afinite Kazancı ikiye katlanır!"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Pv_Content = {
    Text = "Video oynat"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_RecordTip_Content = {
    Text = "Süreli Açılış"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Record_Content = {
    Text = "Üreme Çılgınlığı"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Shop_Content = {
    Text = "Şehvet Tohumu"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Topic_Content = {
    Text = "Bedensel Arzular"
  },
  PanelText_UI_Events_Panel_Try_Text_C_Fail_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Events_Panel_Try_Text_C_Summon_Content = {
    Text = "Uyanışa Git"
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Introduction_Content = {
    Text = "Dua, Adanmışlık, Kurban; insanlığın derinliği, O’nun gözünde yalnızca kakofonik bir maskaralıktır.\nYine de bu maskaralık bazen izler bırakır, Tanrı-Kral’ın bakışında… ya da kalbinde."
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Title_Content = {
    Text = "Derin Deniz Bakışı"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Challenge_Content = {
    Text = "Derin Deniz Bakışı"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Tulu_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Tulu_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Tulu_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Record_Content = {
    Text = "Taç Giyme Günü"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Resonance_Content = {
    Text = "Rezonans: Sıradağları Yutma"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Shop_Content = {
    Text = "Uçurum Aydınlanması"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Topic_Content = {
    Text = "Tanrı Kralın Dönüşü"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Challenge_Content = {
    Text = "Hafıza Kodu"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Fill_Up_Content = {
    Text = "(Depolama Sınırına Kalan:"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finish_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Not_unlocked_Content = {
    Text = "<Gray:Kilit Açıldı>"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Pv_Content = {
    Text = "Video oynat"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Record_Content = {
    Text = "Dingin Bölünme"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Resonance_Content = {
    Text = "Rezonans: Ayrışma Sendromu"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Shop_Content = {
    Text = "Ego Tahlili"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Topic_Content = {
    Text = "Çoklu Şifa: Tekrar"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Describe_Content = {
    Text = "Göldeki Şehir Isarawu’nun, Wanda’nın memleketi olduğu söylenir.\nBu kez Rüya Kapısı’ndan geçecek ve saat dilleriyle dolu kadim kulelere varacaksın..."
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Resonance_Content = {Text = "Rezonans"},
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Title_Content = {
    Text = "Göldeki Şehir"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_illustrate_Content = {
    Text = "Oynanış Kuralları"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Can_Unlockable_Content = {
    Text = "Alınabilir"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Challenge_Content = {
    Text = "Göldeki Şehir"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Fill_Up_Content = {
    Text = "Yenilenme Süresi:"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Finished_Content = {Text = "Sona Erdi"},
  PanelText_UI_Events_Panel_Wanda_Text_C_Max_Content = {Text = "Maks"},
  PanelText_UI_Events_Panel_Wanda_Text_C_Not_unlocked_Content = {Text = "Kilitli"},
  PanelText_UI_Events_Panel_Wanda_Text_C_Pv_Content = {
    Text = "Video oynat"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Receive_Content = {
    Text = "Talep Edilebilir Süre:"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Record_Content = {
    Text = "Alevlerin Şöleni"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Resonance_Content = {
    Text = "Rezonans: Gizli Vekâlet Emri"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Shop_Content = {
    Text = "Wanda'nın Hazine Mahzeni"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Topic_Content = {
    Text = "Alevlerin Şöleni"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Challenge_Content = {
    Text = "Yıldız Ağıtı"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_ProgressTitle_Content = {
    Text = "Sahne İlerlemesi"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Rank_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Record_Content = {
    Text = "Özel Görev Kayıtları"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Topic_Content = {
    Text = "Belirleyici: İlksel Gölge"
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Introduction_Content = {
    Text = "Sevgiden doğar kin; kinden, koyu ve boğucu bir nefret. Gökyüzü yakarışlarına sessiz kalır, toprak kaçış için bir mezar sunmaz. Yalnızca Gece Sisinin arasından süzülen kahkaha çağrına cevap verir—ve bunun için hiçbir bedel istemez. Ona bak. Onu takip et. Onda eri. Ona dönüş."
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Title_Content = {
    Text = "Obsidyen Anaerkil"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_ChallengeTip_Content = {
    Text = "Süreli Etkinlik"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Challenge_Content = {
    Text = "Obsidyen Anaerkil"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_RecordTip_Content = {
    Text = "Ücretsiz Kilit Açma Etkinliği"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Record_Content = {
    Text = "Psişe Derin Dalışı"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Reward_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Shop_Content = {
    Text = "Issız Sunu"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Topic_Content = {
    Text = "Huangpu Fısıltıları"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Awards_Content = {Text = "Ödüller"},
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_CurRate_Content = {
    Text = "Mevcut Olasılık"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_InitRate_Content = {
    Text = "Başlangıç Olasılığı"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Item_Content = {
    Text = "Ödül Eşyası"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Rate_Content = {Text = "Olasılık"},
  PanelText_UI_Events_Popup_GiftBag_Text_C_Desc_Content = {
    Text = "Etkinlik Açıklaması"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_InfoTitle_Content = {
    Text = "Etkinlik Özeti"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_OptionWeapon_Content = {
    Text = "Tüm İsteğe Bağlı Kader Çarklarını Görüntüle"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_Slogan_Content = {
    Text = "Sadece 24 Saat!\n1 Standart Uyanışçı seç!"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_SpecialTime_Content = {Text = "Kalan"},
  PanelText_UI_Events_Popup_GiftBag_Text_PayTip_Content = {
    Text = "Gösterilen fiyat yalnızca referans içindir. Gerçek ödemeler, geçerli para birimi üzerinden güncel kurla işlenecektir."
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_1_Content = {
    Text = "Ayrıntıları Görüntüle"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_2_Content = {Text = "Al"},
  PanelText_UI_Events_Popup_Optional_Text_C_Title_Content = {
    Text = "WoD Seçici"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistAwaker_Content = {
    Text = "Destek Uyandıran"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistCount_Content = {
    Text = "Destek Sayısı"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Assist_Content = {
    Text = "Destek Sıralaması"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Assist_Content = {Text = "Kayıt yok"},
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Kill_Content = {Text = "Kayıt yok"},
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Assist_Content = {
    Text = "Koruyucu Bilgisi"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Kill_Content = {
    Text = "Koruyucu Bilgisi"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_KillCount_Content = {
    Text = "Toplam Yakalama Sayısı"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Kill_Content = {
    Text = "Koruyucu Sıralaması"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Assist_Content = {Text = "Rütbe"},
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Kill_Content = {Text = "Rütbe"},
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Title_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Introduction_Content = {
    Text = "Siyah, siyah, siyah…\nKapkara Canavarlar çığlık atıyor, kükreyor ve çılgınca dans ediyor, bir gelgit gibi üzerinize akıyor.\n \"Pfft—\"\n\"Bunda neredeyse hiç Gümüş yokmuş. Bir dahakine daha fazla getirmeyi unutma.\""
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Title_Content = {
    Text = "Kedi Gümüş Akını"
  },
  PanelText_UI_Events_Stage_Tip_Text_C_Title_Content = {
    Text = "Soruşturma Ödülü"
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Introduction_Content = {
    Text = "Siyah, kara gelgit sonsuzca kabarıyor.\nÇılgına dönmüş kediler seni sardı, sayısız boyuttan üstüne doğru hücum ediyorlar."
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Title_Content = {
    Text = "Kediler Karnavalı"
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "En ilkel umutsuzluğunla yüzleş. En ilkel dehşetinle yüzleş.\nGörünmeden yan yana durun ve sonra Onu alt edin."
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Title_Content = {
    Text = "Yıldız Ağıtı"
  },
  PanelText_UI_Events_illustrate_Tip_Text_C_Title_Content = {
    Text = "Uyandıran Tanımı"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Full_Content = {
    Text = "Tüm Malzemelere Sahipsiniz"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Goto_Content = {Text = "İlerle"},
  PanelText_UI_GuideNote_Item_Material_Text_C_Source_Content = {Text = "Kaynak Al"},
  PanelText_UI_GuideNote_Item_Material_Text_C_Sweep_Content = {
    Text = "Yeniden Canlandırma"
  },
  PanelText_UI_GuideNote_Item_Task_Text_C_Recieve_Content = {Text = "Al"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Goto_Content = {Text = "İlerle"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Source_Content = {Text = "Kaynak Al"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Sweep_Content = {
    Text = "Yeniden Canlandırma"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Change_Content = {Text = "Değiştir"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Choose_Content = {
    Text = "Seçmek için tıklayın"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Detail_Content = {
    Text = "Ayrıntılar"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_ExcludeTalent_Content = {Text = "Yetenek"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Level_Content = {
    Text = "Koruyucu TP"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_More_Content = {
    Text = "Daha Fazla Yükseltme"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_NoTask_Content = {
    Text = "Bir Uyandırıcı Seçin"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Skill_Content = {Text = "Yetenek"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Talent_Content = {Text = "Yetenek"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Abyss_Content = {Text = "İlerle"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_DailyChallenge_Content = {Text = "İlerle"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Pvp_Content = {Text = "İlerle"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RailyWay_Content = {Text = "İlerle"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RotationMode_Content = {Text = "İlerle"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Rank_Abyss_Content = {Text = "Rütbe"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Abyss_Content = {
    Text = "Kalan Ödüller"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_DailyChallenge_Content = {Text = "Ödüller"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Pvp_Content = {Text = "Ödüller"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RailyWay_Content = {Text = "Ödüller"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RotationMode_Content = {Text = "Ödüller"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_DailyChallenge_Content = {Text = "PTS"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_Pvp_Content = {Text = "PTS"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RailyWay_Content = {
    Text = "En Yüksek Puan"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RotationMode_Content = {Text = "PTS"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Abyss_Content = {
    Text = "D-Etkisi Yasak Bölgesi"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_DailyChallenge_Content = {
    Text = "Hayali Dalış"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Pvp_Content = {
    Text = "Traphase - Serbest Seçim"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RailyWay_Content = {
    Text = "Çılgın Gökyüzü Rayı"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RotationMode_Content = {
    Text = "Traphase - Sıralı Seçim"
  },
  PanelText_UI_GuideNote_PermTrainBase_Text_C_Goto_Content = {Text = "İlerle"},
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Goto_Content = {Text = "İlerle"},
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ItemsPreview_Content = {
    Text = "Kalan Kaynaklar Önizlemesi"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Null_Content = {
    Text = "Kalan Kaynak Yok"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ProgressTitle_Content = {
    Text = "Oyun İlerlemesi"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Title_Content = {
    Text = "Soruşturma"
  },
  PanelText_UI_Guide_ChangeName_Image_Confim_Dis_Bg_Content = {Text = "Kazı"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Dis_Content = {
    Text = "İsim İmzala"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Nor_Content = {
    Text = "İsim İmzala"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Myself_Content = {Text = "Adın"},
  PanelText_UI_Guide_ChangeName_Text_C_Return_Content = {
    Text = "Cinsiyet Seçimine Dön"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Tips_Content = {
    Text = "Lütfen adınızı girin"
  },
  PanelText_UI_Guide_ChangeName_Text_Confim_Nor_Content = {Text = "Kazı"},
  PanelText_UI_Home_Panel_Main_Text_C_Title_Content = {
    Text = "Araştırma Merkezi"
  },
  PanelText_UI_Homeland_Item_Building_Text_C_Done_Content = {Text = "Tam"},
  PanelText_UI_Homeland_Panel_Main_Text_C_Tips_Content = {
    Text = "Bonus Genel Bakış"
  },
  PanelText_UI_InvitationCode_Item_Player_Text_Name_Content = {Text = "Al"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_BindingTip_Content = {
    Text = "Seni yönlendiren bir Koruyucuya bağlan.\nSayısız Gümüş Anahtarın titreştiği bir evrende,\nasla yalnız değilsin."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_High_Content = {
    Text = "Daveti Bağla"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_Nor_Content = {
    Text = "Daveti Bağla"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Clean_Content = {Text = "Tamamlama"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Condition_Content = {
    Text = "Davet edilen Koruyucular, Seviye 5/10/15/20'ye ulaştıklarında ödüller alabilir."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Copy_Content = {Text = "Kopyala"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Desc_Content = {
    Text = "Davet Kodunu kopyala.\nRuhları sonsuz evren boyunca bir Çözünme yolculuğunda rehberlik et."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InputTip_Content = {
    Text = "Talep etmek için Davet Kodunu gir:"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InviteCount_Content = {
    Text = "Davet Edilen Koruyucular"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_High_Content = {
    Text = "Mythag Kayıt Daveti"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_Nor_Content = {
    Text = "Mythag Kayıt Daveti"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InvitedCount_Content = {Text = "300!"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_MyCode_Content = {
    Text = "Davet Kodum"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Paste_Content = {
    Text = "Yapıştır"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Share_Content = {Text = "Paylaş"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Tips_Content = {Text = "Kod Gir"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Value_Content = {Text = "Parıltı"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_illustrate_Content = {
    Text = "Etkinlik Açıklaması"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_Title_Content = {
    Text = "Mythag Kayıt Daveti"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Null_Content = {
    Text = "Henüz hiçbir davet edilen Koruyucu Seviye 5'e ulaşmadı"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title2_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title_Content = {
    Text = "Davet Listesi"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Acquire_Content = {
    Text = "Yeni Müfreze Kilidi Açıldı"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Tips_Content = {
    Text = "Kapatmak için ekrana dokun"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Current_Content = {
    Text = "Kuşanılmış"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Disable_Content = {
    Text = "Kullanılamıyor"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_1_Content = {Text = "Seç"},
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_2_Content = {Text = "İptal"},
  PanelText_UI_Keeper_Skill_Panel_Text_C_NoTask_Content = {
    Text = "Alınabilir Çete Yok"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Title_Content = {Text = "Müfreze"},
  PanelText_UI_Keeper_Skill_Panel_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Login_Panel_ServerSelect_Text_Panel_Title_Content = {
    Text = "Sunucu Seçimi"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Activity_Content = {
    Text = "Etkinlik Bildirimi"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_BugFix_Content = {
    Text = "Sorun Giderme"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Game_Content = {Text = "Duyuru"},
  PanelText_UI_Login_Popup_Tips_Text_C_Title2_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title_Content = {
    Text = "Burada henüz hiçbir şey yok..."
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title_En_Content = {
    Text = "Gelen Kutusu Boş"
  },
  PanelText_UI_Login_Popup_Tips_Text_Title_Content = {Text = "Duyuru"},
  PanelText_UI_Login_Text_C_Announcement_Content = {Text = "Duyuru"},
  PanelText_UI_Login_Text_C_Build_Title_Content = {Text = "Yapı:"},
  PanelText_UI_Login_Text_C_Deal_Content = {Text = "Anlaşma"},
  PanelText_UI_Login_Text_C_Enter2_Content = {Text = "Gir"},
  PanelText_UI_Login_Text_C_Enter_Content = {
    Text = "Mythag'a Gir"
  },
  PanelText_UI_Login_Text_C_Fight_Content = {Text = "Savaş 2.0"},
  PanelText_UI_Login_Text_C_Plot_Content = {
    Text = "Ort. Hikâye Testi"
  },
  PanelText_UI_Login_Text_C_Quit_Content = {Text = "Çıkış"},
  PanelText_UI_Login_Text_C_Repair_Content = {Text = "Düzelt"},
  PanelText_UI_Login_Text_C_Service_Content = {
    Text = "Müşteri Desteği"
  },
  PanelText_UI_Login_Text_C_Set_Content = {Text = "Ayarlar"},
  PanelText_UI_Login_Text_C_Setting_Content = {Text = "Ayarlar"},
  PanelText_UI_Login_Text_C_Sweep_Content = {
    Text = "QR Kod Tara"
  },
  PanelText_UI_Login_Text_C_Title1_Content = {Text = "Morimens"},
  PanelText_UI_Login_Text_C_User_Content = {
    Text = "Kullanıcı Merkezi"
  },
  PanelText_UI_Login_Text_C_Ver_Title_Content = {Text = "Sürüm:"},
  PanelText_UI_Mail_Text_C_All_Content = {
    Text = "Tümünü Al"
  },
  PanelText_UI_Mail_Text_C_Collection_Content = {
    Text = "Kayıtlı Postalar"
  },
  PanelText_UI_Mail_Text_C_Delete01_Content = {Text = "Sil"},
  PanelText_UI_Mail_Text_C_Delete_Content = {
    Text = "Okunanları Sil"
  },
  PanelText_UI_Mail_Text_C_Empty_Content = {
    Text = "Gelen Kutusu Boş"
  },
  PanelText_UI_Mail_Text_C_Mail_Content = {
    Text = "Gelen Kutusu"
  },
  PanelText_UI_Mail_Text_C_Name_Content = {Text = "Al"},
  PanelText_UI_Mail_Text_C_NoTask1_Content = {
    Text = "Alınabilir posta yok"
  },
  PanelText_UI_Mail_Text_C_Select_Letter_Content = {Text = "Posta Seç"},
  PanelText_UI_Mail_Text_C_Time_Content = {Text = "Zaman:"},
  PanelText_UI_Mail_Text_C_Tips_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Mail_Text_C_Title_Content = {
    Text = "Posta Kutusu"
  },
  PanelText_UI_Mail_Text_Time2_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Mail_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Close_Content = {
    Text = "Kapatmak için ekrana dokun"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Daily_Content = {
    Text = "Günlük Görev"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Finish_Content = {
    Text = "Bugün tamamlanan görevler"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Receive_Content = {Text = "Alındı"},
  PanelText_UI_Main_Daily_Tips_Text_C_Reward_Content = {
    Text = "Tamamlama Ödülleri"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Skill_Tag_Content = {
    Text = "Soruşturma Yaklaşımı"
  },
  PanelText_UI_Main_Favor_Tip_Text_C_Name_Content = {Text = "Yakınlık"},
  PanelText_UI_Main_Helicopter_Tips_Text_C_Awaken_Content = {
    Text = "Uyanış Tarihi"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Favor_Content = {
    Text = "Mevcut Afinite"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Tip_Content = {
    Text = "Odanıza bir Uyanan davet edin. Zamanla Afinite kazanacaklar."
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Title_Content = {Text = "Yatakhane"},
  PanelText_UI_Main_Helicopter_Tips_Text_Name_1_Content = {Text = "Davet"},
  PanelText_UI_Main_Helicopter_Tips_Text_Name_2_Content = {Text = "İptal"},
  PanelText_UI_Main_Helicopter_Tips_Text_ResetBg_Content = {
    Text = "Varsayılan Ayar"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Not_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Proxy_Content = {
    Text = "Vekil Kullan"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Receive_Content = {Text = "Al"},
  PanelText_UI_Main_Panel_1_Text_Abyss_Content = {
    Text = "D-Etkisi Yasak Bölgesi"
  },
  PanelText_UI_Main_Panel_1_Text_C_Acclaim_Content = {
    Text = "Oyunu Değerlendir"
  },
  PanelText_UI_Main_Panel_1_Text_C_Activity_Content = {Text = "Etkinlik"},
  PanelText_UI_Main_Panel_1_Text_C_Awaker_Content = {Text = "Uyandıran"},
  PanelText_UI_Main_Panel_1_Text_C_Bag_Content = {Text = "Envanter"},
  PanelText_UI_Main_Panel_1_Text_C_Close_1_Content = {Text = "Kapanış"},
  PanelText_UI_Main_Panel_1_Text_C_Close_Content = {Text = "Kapanış"},
  PanelText_UI_Main_Panel_1_Text_C_Collection_Content = {
    Text = "Kütüphane"
  },
  PanelText_UI_Main_Panel_1_Text_C_Community_Content = {Text = "Topluluk"},
  PanelText_UI_Main_Panel_1_Text_C_Daily_Content = {
    Text = "Günlük Görev"
  },
  PanelText_UI_Main_Panel_1_Text_C_Dbg_Content = {
    Text = "Perde Arası"
  },
  PanelText_UI_Main_Panel_1_Text_C_Dengji_Content = {Text = "Sv."},
  PanelText_UI_Main_Panel_1_Text_C_DungeonNote_Content = {Text = "El Kitabı"},
  PanelText_UI_Main_Panel_1_Text_C_Formation_Content = {Text = "Dizilim"},
  PanelText_UI_Main_Panel_1_Text_C_Formation_EN_Content = {Text = "Görev"},
  PanelText_UI_Main_Panel_1_Text_C_Full_Content = {
    Text = "Tamamlandı"
  },
  PanelText_UI_Main_Panel_1_Text_C_GamePassport_Content = {Text = "Arşivler"},
  PanelText_UI_Main_Panel_1_Text_C_Lesson_Content = {Text = "Müfredat"},
  PanelText_UI_Main_Panel_1_Text_C_Main_Content = {
    Text = "Soruşturma"
  },
  PanelText_UI_Main_Panel_1_Text_C_Mission_Content = {Text = "Kılavuz"},
  PanelText_UI_Main_Panel_1_Text_C_Pvp_Content = {Text = "Traphase\n"},
  PanelText_UI_Main_Panel_1_Text_C_Recall_Content = {
    Text = "Atari Salonu"
  },
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Content = {Text = "Uyanış"},
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Nor_Content = {Text = "Uyanış"},
  PanelText_UI_Main_Panel_1_Text_C_Store_Content = {
    Text = "Mythag Mağazası"
  },
  PanelText_UI_Main_Panel_1_Text_C_Welfare_Content = {
    Text = "Çeşitli Sınırlı Süreli Ödülleri Talep Et!"
  },
  PanelText_UI_Main_Panel_1_Text_Diving_Content = {
    Text = "Hayali Dalış"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_Title_Content = {
    Text = "Eğitim Görevleri"
  },
  PanelText_UI_Michi_Popup_Strengthen_Succeed_Text_C_Info_Content = {
    Text = "Kapatmak için boş bir alana tıkla."
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Consume_Content = {Text = "Tüketme"},
  PanelText_UI_Other_Donate_Tips_Text_C_Donated_Content = {
    Text = "Toplam Bağış"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Fund_Content = {
    Text = "Mezunlar Bağış Fonu"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Least_Content = {Text = "Dak"},
  PanelText_UI_Other_Donate_Tips_Text_C_Title_Content = {
    Text = "Gümüş Çekirdek Özü Bağışı"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Utmost_Content = {Text = "Maks"},
  PanelText_UI_Other_Fund_Tips_Text_C_Describe_Content = {
    Text = "Gümüş Çekirdek Özü bağışlayarak katkı biriktir; iyiliklerin karşılıksız kalmayacak. “Toplam Katkı Değerin”, bağışladığın Gümüş Çekirdek Özünün toplamıdır."
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Donated_Content = {
    Text = "Mevcut Toplam Katkı"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Title_Content = {
    Text = "Mezunlar Bağış Fonu"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_illustrate_Content = {Text = "Kurallar"},
  PanelText_UI_Other_Physical_Tips_Text_C_All_Content = {
    Text = "Tam iyileşme:"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Auto_Content = {
    Text = "Otomatik İyileşme"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_1_Content = {Text = "İptal"},
  PanelText_UI_Other_Physical_Tips_Text_C_Name_2_Content = {Text = "Onayla"},
  PanelText_UI_Other_Physical_Tips_Text_C_Name_Content = {Text = "İptal"},
  PanelText_UI_Other_Physical_Tips_Text_C_Next_Content = {
    Text = "Sonraki iyileşme:"
  },
  PanelText_UI_Other_Physical_Tips_Text_Name_Content = {Text = "İptal"},
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Energy_Content = {
    Text = "Enerji Tüketimi:"
  },
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Info_Content = {
    Text = "Kapatmak için boş bir alana tıkla."
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Next_Content = {
    Text = "Gümüş Kristal Tüket"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Now_Content = {
    Text = "Mevcut Gümüş Kristaller"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Question_Content = {
    Text = "Anahtarı şimdi al?"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Next_Content = {
    Text = "Anahtar Tüket"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Now_Content = {
    Text = "Mevcut Anahtarlar"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Title_Content = {
    Text = "Anahtar Edinme"
  },
  PanelText_UI_Other_Popup_Trinket_LevelUp_Text_C_Success_Content = {
    Text = "Geliştirilmiş"
  },
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_HP_Content = {Text = "HP"},
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_Wait_Content = {
    Text = "Sıralı Seçim Modu Bilgisi Bekleniyor"
  },
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Attack_Content = {Text = "İlk Hamle"},
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Defend_Content = {Text = "Geç Hamle"},
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Adjust_Content = {
    Text = "Uyandırıcı konumlarını değiştirmek için tıkla"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_My_Content = {Text = "Hazır!"},
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_Other_Content = {Text = "Hazır!"},
  PanelText_UI_PVP_Panel_TeamRotation_Text_BtnName_Content = {Text = "Seç"},
  PanelText_UI_Passport_Choose_Tip_Text_C_Title_Content = {
    Text = "\"Lütfen ödülleri seçin\""
  },
  PanelText_UI_Passport_Exchange_Text_C_Buy_Title_Content = {
    Text = "Seviye Atla"
  },
  PanelText_UI_Passport_Exchange_Text_C_Cost_Tips_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Passport_Exchange_Text_C_Title_Content = {
    Text = "Konu Seviye Yükseltme"
  },
  PanelText_UI_Passport_Exchange_Text_C_Title_En_Content = {
    Text = "Seviye Atla."
  },
  PanelText_UI_Passport_Instructions_Text_C_Remainder_Content = {
    Text = "Bu Dönemin Kalan Süresi"
  },
  PanelText_UI_Passport_Instructions_Text_C_Title_Content = {Text = "Müfredat"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Additional_Content = {Text = "Hemen Al"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Condition_Content = {
    Text = "Talep Etmek İçin Yükseltme"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_1_Content = {Text = "+"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_3_Content = {Text = "Seviye"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_4_Content = {
    Text = "Konu Seviyesi"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_Content = {
    Text = "Konu Seviyesi anında <color=#5EF2FF>+<size=32>10</size></color>!"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Introduce_Content = {
    Text = "Üst Düzey Konular’ı aç ve seviye 40’a ulaşarak bir Kader Çarkı ya da Lümen Çekirdeği ×5 seç."
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Name_Content = {
    Text = "İleri Müfredat"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_1_Content = {
    Text = "Günlük Görevler\nÖdüller ×3"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_2_Content = {
    Text = "Savaş\nTur Geri Alma"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_3_Content = {
    Text = "Traphase\nTüm Kartlar"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_Content = {
    Text = "Bu Ders Kaydı Süresince Ayrıcalıkların Kilidini Açmak İçin Satın Alın:"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Prompt_Content = {
    Text = "Lütfen sorumlulukla tadını çıkarın ve harcamalarınızı akıllıca yapın."
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_1_Content = {
    Text = "Satın Alındı"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_2_Content = {
    Text = "Satın Alındı"
  },
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Senior (1)_Content"] = {Text = "İleri"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Senior_Content = {
    Text = "Üst Düzey Konular"
  },
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Super (1)_Content"] = {Text = "Üstün"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Super_Content = {
    Text = "Üst Düzey Konular"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_TempUnlock_Content = {
    Text = "Yalnızca Temel Konular İçin"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_ThisIssue_Content = {
    Text = "Talep Etmek İçin Yükseltme"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Condition_Content = {
    Text = "Konu Seviyelerinden alınabilir"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_1_Content = {Text = "+"},
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_3_Content = {Text = "Seviye"},
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_4_Content = {
    Text = "Konu Seviyesi ve elde et"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Introduce_Content = {
    Text = "İnce işçilikle, el yapımı olarak hazırlanmış, kıymetli bir Kader Çarkı içeren şeref kutusu.\nÜst Düzey Konular’ı aç ve seviye 40’a ulaşarak bir Kader Çarkı ya da Lümen Çekirdeği ×5 seç."
  },
  PanelText_UI_Passport_Money_Item_Text_C_Name_Content = {
    Text = "Müfredat Onur Kutusu"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Prompt_Content = {
    Text = "Lütfen sorumlulukla tadını çıkarın ve harcamalarınızı akıllıca yapın."
  },
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_1_Content = {
    Text = "Satın Alındı"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_2_Content = {
    Text = "Satın Alındı"
  },
  ["PanelText_UI_Passport_Money_Item_Text_C_Senior (1)_Content"] = {Text = "İleri"},
  PanelText_UI_Passport_Money_Item_Text_C_Senior_Content = {
    Text = "Üst Düzey Konular"
  },
  ["PanelText_UI_Passport_Money_Item_Text_C_Super (1)_Content"] = {Text = "Üstün"},
  PanelText_UI_Passport_Money_Item_Text_C_Super_Content = {
    Text = "Üst Düzey Konular"
  },
  PanelText_UI_Passport_Money_Item_Text_C_ThisIssue_Content = {
    Text = "Tüm Üst Düzey Konular içeriği"
  },
  PanelText_UI_Passport_Panel_Main_New_Text_C_Mail_Content = {Text = "Kurallar"},
  PanelText_UI_Passport_Panel_Main_New_Text_C_Title_Content = {Text = "Müfredat"},
  PanelText_UI_Passport_Panel_Main_Text_C_Experience_Content = {
    Text = "Görev Deneyimi"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Full_Content = {
    Text = "Seviye Maksimumda"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Instructions_Grade_Content = {
    Text = "Konu Seviyesi"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Mail_Content = {Text = "Kurallar"},
  PanelText_UI_Passport_Panel_Main_Text_C_Name_Content = {
    Text = "Seviye Atla"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Online_Content = {
    Text = "Haftalık DEN Sınırı"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Title_Content = {Text = "Müfredat"},
  PanelText_UI_Passport_Popup_Player_LevelUp_Text_C_Title_Content = {
    Text = "Konu Seviye Yükseltme"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Cancel_Name_Content = {Text = "İptal"},
  PanelText_UI_Passport_Popup_Recharge_Text_Confirm_Name_Content = {Text = "Onayla"},
  PanelText_UI_Passport_Popup_Recharge_Text_Title_Content = {
    Text = "Satın Alma Onayı"
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Content_Content = {
    Text = "İnce işçilikle, el yapımı olarak hazırlanmış, kıymetli bir Kader Çarkı içeren şeref kutusu.\nÜst Düzey Konular’ı aç ve seviye 40’a ulaşarak bir Kader Çarkı ya da Lümen Çekirdeği ×5 seç."
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Title_Content = {
    Text = "Müfredat Onur Kutusu"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Experience_Content = {
    Text = "Görev Deneyimi"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Full_Content = {
    Text = "Seviye Maksimumda"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_GainExperience_Content = {Text = "EXP Kazan"},
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_2_Content = {
    Text = "Seviye Satın Al"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Online_Content = {
    Text = "Bu Haftanın Sınırı"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Ordinary_Title_Content = {
    Text = "Temel Konular"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Content = {
    Text = "İleri Müfredat"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Title_Content = {
    Text = "Üst Düzey Konular"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Timing_Content = {Text = "Bu Sayı"},
  PanelText_UI_Passport_Reward_Item_New_Text_C_Unlock_Content = {Text = "Hemen Al"},
  PanelText_UI_Passport_Reward_Item_Text_C_Experience_Content = {
    Text = "Görev Deneyimi"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Full_Content = {
    Text = "Seviye Maksimumda"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_2_Content = {
    Text = "Seviye Satın Al"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Online_Content = {
    Text = "Bu Haftanın Sınırı"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Ordinary_Title_Content = {
    Text = "Temel Konular"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Content = {
    Text = "İleri Müfredat"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Title_Content = {
    Text = "Üst Düzey Konular"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Tab_Special_Content = {Text = "İleri"},
  PanelText_UI_Passport_Reward_Item_Text_C_Timing_Content = {
    Text = "Bu Dönemin Kalan Süresi"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Introduce_Content = {
    Text = "Üst Düzey Konular’ı aç ve seviye 40’a ulaşarak bir Kader Çarkı ya da Lümen Çekirdeği ×5 seç."
  },
  PanelText_UI_Passport_Show_Item_Text_C_Reward_Content = {
    Text = "Mevcut Hediye Kutusu Önizlemesi"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Time_1_Content = {
    Text = "Etkinlikte Kalan Süre"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Double_Content = {Text = "Çift EXP"},
  PanelText_UI_Passport_Task_Choose_Text_C_Tab_Special_Content = {Text = "Etkinlik"},
  PanelText_UI_Passport_Task_Description_Text_C_Name_Content = {Text = "Al"},
  PanelText_UI_Passport_Task_Description_Text_C_Tab_Special_Content = {Text = "Etkinlik"},
  PanelText_UI_Passport_Task_Item_Text_C_Experience_Content = {
    Text = "Görev Deneyimi"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Full_Content = {
    Text = "Seviye Maksimumda"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_3_Content = {
    Text = "Seviye Satın Al"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Online_Content = {
    Text = "Bu Haftanın Sınırı"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Time_Content = {
    Text = "Bu Dönemin Kalan Süresi"
  },
  PanelText_UI_Passport_illustrate_Tip_Text_C_Title_Content = {Text = "Kurallar"},
  PanelText_UI_Pocket_Mail_Text_C_Del_Content = {Text = "Sil"},
  PanelText_UI_Pocket_Mail_Text_C_Time_Content = {Text = "Zaman:"},
  PanelText_UI_Pocket_Mail_Text_C_Tips_Content = {
    Text = "Koleksiyon Sayısı"
  },
  PanelText_UI_Pocket_Mail_Text_C_Title2_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Pocket_Mail_Text_C_Title_Content = {
    Text = "Alınabilir posta yok"
  },
  PanelText_UI_Pocket_Mail_Text_C_select_Title_Content = {
    Text = "Bir Harf Seç"
  },
  PanelText_UI_PopMsg_Text_C_Precautions2_Content = {Text = "Duyuru"},
  PanelText_UI_PopMsg_Text_C_Precautions_Content = {Text = "Duyuru"},
  PanelText_UI_Popup_DonationBox_Text_C_Reward_Content = {Text = "Envanter"},
  PanelText_UI_Popup_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "Edinim Hızı:"
  },
  PanelText_UI_Protagonist_Item_Skill_Text_C_Current_Content = {Text = "Mevcut"},
  PanelText_UI_Protagonist_Item_Skill_Text_C_No_Content = {
    Text = "Elde Edilmedi"
  },
  PanelText_UI_Pvp_Blood_Share_Text_C_Release_Content = {
    Text = "Serbest bırakmak için tıkla"
  },
  PanelText_UI_Pvp_Item_Card_Text_C_Replace_Content = {Text = "Değiştir"},
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Done_Content = {
    Text = "Beni takip etti"
  },
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Mutual_Content = {
    Text = "Karşılıklı"
  },
  PanelText_UI_Pvp_Item_Dan_Text_C_Current_Content = {
    Text = "Mevcut Kademe"
  },
  PanelText_UI_Pvp_Item_Formation_Text_C_Conflict_Content = {
    Text = "Konum Çatışması"
  },
  PanelText_UI_Pvp_Item_List_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Double_Content = {
    Text = "Çift Ödüller"
  },
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Topic_Content = {
    Text = "Araştırma Ayrıcalıkları"
  },
  PanelText_UI_Pvp_Item_Ranking_Text_C_Current_Content = {
    Text = "Mevcut Ödüller"
  },
  PanelText_UI_Pvp_Item_Role_Text_C_Decks_Content = {Text = "Deste"},
  PanelText_UI_Pvp_Item_Role_Text_C_Maniac_Content = {Text = "Aliemus"},
  PanelText_UI_Pvp_Item_Role_Text_C_Role_Wins_Content = {
    Text = "Galibiyetler"
  },
  PanelText_UI_Pvp_Panel_Battle_Text_High_Content = {Text = "Teslim Ol"},
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_C_NoTask_Content = {
    Text = "Henüz yorum yok"
  },
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_Time_Content = {
    Text = "İlk yorumu sen yap"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Decks_Content = {Text = "Deste"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Effect_Content = {Text = "Etki"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Hoist_Content = {
    Text = "Arithmetica Maliyeti"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Maniac_Content = {Text = "Aliemus"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_TotalWins_Content = {
    Text = "Toplam Galibiyet"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_Wins_Content = {
    Text = "Sezon Galibiyetleri"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Skill_Tag_Content = {
    Text = "Taşkınlık"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Source_Content = {Text = "Kaynak"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_TotalWins_Content = {
    Text = "Toplam Galibiyet"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Wins_Content = {
    Text = "Sezon Galibiyetleri"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_None_Content = {
    Text = "Henüz ilgili koleksiyon yok"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_Time_Content = {
    Text = "Bu Diyar henüz Traphase için alınabilir değil."
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Awaker_Name_Content = {Text = "Uyandıran"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_KeeperSkill_Name_Content = {Text = "Müfreze"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_1_Content = {
    Text = "Ayrıntılar"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_2_Content = {Text = "Sıralama"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_3_Content = {Text = "Yorum"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Train_Name_Content = {
    Text = "Uyanış Deneme Görevi"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Weapon_Name_Content = {
    Text = "Kader Çarkı"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_NoTask_Content = {Text = "Kayıt yok"},
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_SeasonWins_Content = {
    Text = "Sezon Galibiyetleri"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_TotalWins_Content = {
    Text = "Toplam Galibiyet"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Decks_Content = {Text = "Deste"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Effect_Content = {Text = "Etki"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Maniac_Content = {Text = "Aliemus"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Role_Wins_Content = {
    Text = "Galibiyetler"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Wins_Content = {
    Text = "Galibiyetler"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Detail_Content = {
    Text = "Alana girmek için lütfen soldan seçim yap."
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_1_Content = {
    Text = "Alana girmek için lütfen soldan seçim yap."
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_Content = {
    Text = "Alana girmek için lütfen soldan seçim yap."
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Name_Content = {
    Text = "Ayrıntılar"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_None2_Content = {
    Text = "Henüz malzeme yok"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_None_Content = {
    Text = "İlgili filtre sonucu yok"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Time_Content = {
    Text = "Belirli yollarla elde edilebilir."
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Award_Content = {Text = "Ödüller"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_CardEdit_Content = {
    Text = "Hazır Düzen"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Robot_Content = {Text = "Kapat"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Speed_Content = {Text = "Kapat"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Collection_Content = {Text = "Topla"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_DraftPick_Content = {
    Text = "Sıralı Seçim Modu Sv."
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Expression_Content = {Text = "Duygular"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Integral_Content = {
    Text = "Sezon Puanları"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Matching_Content = {
    Text = "Eşleştirmeyi Başlat"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Robot_Content = {Text = "Aç"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Speed_Content = {Text = "Aç"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Password_Content = {
    Text = "Şifre Modu"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Precon_Content = {
    Text = "Serbest Seçim Modu Sv."
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Progress_Content = {
    Text = "Rütbe Ödülleri"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Content = {
    Text = "Serbest Seçim Modu"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Score_Content = {Text = "PTS"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Ranking_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Record_Content = {
    Text = "Traphase Kaydı"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Reward_Content = {
    Text = "Daha fazla ödül kazanmak için daha yüksek rütbelere eriş."
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Robot_Content = {
    Text = "Simüle Rakip"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Content = {
    Text = "Sıralı Seçim Modu"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Score_Content = {Text = "PTS"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Rule_Content = {Text = "Kurallar"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Speed_Content = {
    Text = "Tam Eşleşme"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Store_Content = {Text = "Dükkan"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Time_Content = {
    Text = "Mevcut Sezon:"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Title_Content = {Text = "Traphase"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Victory_Content = {
    Text = "Toplam Galibiyet:"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Weekly_Content = {
    Text = "Haftalık Ödüller"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_list_Content = {Text = "Sıralama"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Name_Content = {Text = "Son"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Unclickable_Content = {Text = "Son"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Zongshanghai_Content = {
    Text = "Toplam Hasar"
  },
  PanelText_UI_Pvp_Panel_Match_Text_C_Second_Content = {Text = "Saniye"},
  PanelText_UI_Pvp_Panel_Match_Text_C_Win_Content = {
    Text = "Oyun Başlasın!"
  },
  PanelText_UI_Pvp_Panel_Match_Text_Name_Content = {
    Text = "Eşleştirmeyi Başlat"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "Ödül Yerleşimi"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Integral_Content = {
    Text = "Sezon Puanları"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Show_Content = {
    Text = "Sonraki Adım"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Sync_Content = {
    Text = "Uyandıran Afinite Artışı"
  },
  PanelText_UI_Pvp_Panel_Playback_Text_C_Angle_Content = {
    Text = "Görüş Açısını Değiştir"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_1_Content = {Text = "Takip Et"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_2_Content = {Text = "Takip Et"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_1_Content = {Text = "Övgü"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_2_Content = {Text = "Övüldü"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Enemy_Content = {Text = "Düşman"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Fail_Content = {
    Text = "Başarısızlık"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Harm_Content = {Text = "Hasar"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Ourside_Content = {Text = "Sen"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Outcome_Content = {Text = "Zafer"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_OwnRespectable_Content = {
    Text = "Onurlu rakip!"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_01_Content = {Text = "Puan"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_02_Content = {Text = "Puan"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Respectable_Content = {
    Text = "Onurlu rakip!"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Shields_Content = {Text = "Kalkan"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Treat_Content = {
    Text = "İyileştirme"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Victory_Content = {Text = "Zafer"},
  PanelText_UI_Pvp_Panel_Train_Text_C_KeeperSkills_Content = {Text = "Müfreze"},
  PanelText_UI_Pvp_Panel_Train_Text_C_Position_Content = {Text = "Vardiya"},
  PanelText_UI_Pvp_Panel_Train_Text_C_Reset_Content = {Text = "Sıfırla"},
  PanelText_UI_Pvp_Panel_Train_Text_C_SelectRelic_Content = {
    Text = "Bir Kalıntı Seç"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Weapons_Content = {Text = "Çark"},
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_01_Content = {Text = "Puan"},
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_02_Content = {Text = "Puan"},
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Breaking_Content = {
    Text = "Sunucuyla bağlantı kesildi"
  },
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Quit_Content = {
    Text = "Giriş Ekranına Dön"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Decks_Content = {Text = "Deste"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Effect_Content = {Text = "Etki"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Maniac_Content = {Text = "Aliemus"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Role_Wins_Content = {
    Text = "Galibiyetler"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Wins_Content = {
    Text = "Galibiyetler"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Bonus_Content = {
    Text = "Sezon Bonusu"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Continue_Content = {
    Text = "Devam etmek için tıkla"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Streak_Content = {
    Text = "Galibiyet Serisi Bonusu"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Title_Content = {
    Text = "Aydınlanma"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Use_Content = {
    Text = "Şu anda kullanımda"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Tips_Text_C_Title_Content = {
    Text = "Aydınlanma"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Content = {
    Text = "Duyguları Yönet"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Content = {
    Text = "Tüm İfadeler"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Sel_Content = {
    Text = "Tüm İfadeler"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Sel_Content = {
    Text = "Duyguları Yönet"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Title_Content = {
    Text = "Duyguları Yönet"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Use_Content = {Text = "Duygular"},
  PanelText_UI_Pvp_Popup_Fail_Text_C_Close_Content = {
    Text = "Devam etmek için herhangi bir yere tıkla"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Continue_Content = {
    Text = "Devam etmek için tıkla"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Fail_Content = {
    Text = "Başarısızlık"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Failure_Content = {
    Text = "Başarısızlık"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Victory_Content = {
    Text = "Savaş Başarısız"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_Reward_1_Content = {
    Text = "Savaş Tarzı Ödülleri"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Create_Content = {
    Text = "Savaş Oluştur"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Joinin_Content = {
    Text = "Savaşa Katıl"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_Title_Content = {
    Text = "Şifre Modu"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Cancel_Content = {Text = "İptal"},
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Confirm_Content = {Text = "Onayla"},
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Title_Content = {
    Text = "Dizilimi İçe Aktar"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Placeholder_Content = {
    Text = "6 haneli bir <color=#5EF2FF>Parola</color> gir"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Cancel_Content = {Text = "İptal"},
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Confirm_Content = {Text = "Onayla"},
  PanelText_UI_Pvp_Popup_PasswordCode_Text_Title_Content = {Text = "Parola Gir"},
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Cancel_Content = {Text = "İptal"},
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Copy_Content = {
    Text = "Parolayı Kopyala"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Wait_Content = {
    Text = "Bekleyiş..."
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_Title_Content = {
    Text = "Şifre Modu"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Cancel_Content = {Text = "İptal"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Done_Content = {
    Text = "Beni takip etti"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Mutual_Content = {
    Text = "Karşılıklı"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Ready_Content = {Text = "Hazırlan"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Reject_Content = {Text = "Reddet"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Wait_Content = {
    Text = "Rakip bekleniyor..."
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_C_Copy_Content = {Text = "Kopyala"},
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Name_Content = {
    Text = "Tekrarı İzle"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Title_Content = {
    Text = "Görüş Açısı"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Initial_Content = {
    Text = "Başlangıç Eli"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Prompt_Content = {
    Text = "İstenmeyen kartları değiştirmek için tıkla"
  },
  PanelText_UI_Pvp_Popup_Reward_Tips_Text_C_Title_Content = {
    Text = "Rütbe Ödülleri"
  },
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Confirm_Content = {Text = "Onayla"},
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Title_Content = {
    Text = "1 Kalıntı seç"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Close_Content = {
    Text = "Devam etmek için herhangi bir yere tıkla"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Pendants_Content = {Text = "Zafer"},
  PanelText_UI_Pvp_Popup_Settle_Text_C_Succeed_Content = {Text = "Zafer!"},
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Highest_Content = {
    Text = "En Yüksek Puan"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Title_Content = {
    Text = "Traphase Kaydı"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity1_Content = {Text = "Ödüller"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity2_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity3_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity4_Content = {Text = "Ödüller"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Award_Content = {Text = "Ödüller"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Big_Content = {
    Text = "Koruyucu Bilgisi"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game1_Content = {
    Text = "Haftalık Sıralama"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game2_Content = {
    Text = "Haftalık Sıralama"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Grade_Content = {Text = "Rütbe"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Hint_Content = {
    Text = "Sezon sonu uzlaşma ödüllerini almak için bu sezon bir maç kazanın."
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_NoTask_Content = {Text = "Kayıt yok"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_RankTip_Content = {
    Text = "Sezon Sıralamasına girmek için bu sezon bir maça katılın."
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_Pvp_Content = {
    Text = "Serbest Seçim Modu"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_RotationMode_Content = {
    Text = "Sıralı Seçim Modu"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Reward_Content = {Text = "Puanlar"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Scope_Content = {
    Text = "Rütbe Aralığı"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Small_Content = {
    Text = "Traphase Unvanı"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Title_2_Content = {
    Text = "Traphase Unvanı"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Fail_Content = {
    Text = "Başarısızlık"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Red_Content = {
    Text = "Devam etmek için tıkla"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Victory_Content = {Text = "Zafer"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Yellow_Content = {
    Text = "Devam etmek için tıkla"
  },
  PanelText_UI_Pvp_Popup_list_Tips_Text_C_Title_Content = {
    Text = "Liderlik Tablosu"
  },
  PanelText_UI_Pvp_Popup_list_Tips_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Pvp_Team_Main_Text_C_Name_10_Content = {
    Text = "Kader Çarkı Donat"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_1_Content = {
    Text = "Müfreze Donat"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_2_Content = {Text = "4. Yuva"},
  PanelText_UI_Pvp_Team_Main_Text_C_Name_3_Content = {Text = "3. Yuva"},
  PanelText_UI_Pvp_Team_Main_Text_C_Name_4_Content = {Text = "2. Yuva"},
  PanelText_UI_Pvp_Team_Main_Text_C_Name_5_Content = {Text = "4. Yuva"},
  PanelText_UI_Pvp_Team_Main_Text_C_Name_6_Content = {
    Text = "Müfreze Donat"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_7_Content = {
    Text = "Kader Çarkı Donat"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_8_Content = {
    Text = "Kader Çarkı Donat"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_9_Content = {
    Text = "Kader Çarkı Donat"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_Content = {
    Text = "Hızlı Dizilim"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Realms_Content = {
    Text = "Diyar Etkin Değil"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Title_Content = {
    Text = "Hazır Düzen"
  },
  PanelText_UI_Pvp_Team_Main_Text_Name_Content = {
    Text = "Hızlı Dizilim"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Copy_Content = {Text = "Kopyala"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Done_Content = {
    Text = "Beni takip etti"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Mutual_Content = {
    Text = "Karşılıklı"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Proficiency_Content = {
    Text = "Toplam Galibiyet"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Remove_Content = {Text = "Düzenle"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Save_Content = {Text = "Sil"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Title_Content = {
    Text = "Yorum Ayrıntıları"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Additional_Content = {Text = "Bonus"},
  PanelText_UI_Recharge_Courtesy_Item_Text_C_DiscountMultipleTitle_Content = {Text = "DEĞER"},
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Haved_Content = {
    Text = "Zaten Sahip"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Sellout_Content = {Text = "Tükendi"},
  PanelText_UI_Recharge_Exchange_Text_C_Buy_Title_Content = {
    Text = "Kullanılan Gümüşler"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Cost_Tips_Content = {Text = "Tüketme"},
  PanelText_UI_Recharge_Exchange_Text_C_Least_Content = {Text = "Dak"},
  PanelText_UI_Recharge_Exchange_Text_C_Redeemed_Content = {Text = "Toplam"},
  PanelText_UI_Recharge_Exchange_Text_C_Utmost_Content = {Text = "Maks"},
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Not_Content = {
    Text = "Yetersiz Para Birimi"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Title_Content = {
    Text = "Borsa Onayla"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_illustrate_Content = {
    Text = "Oynanış Kuralları"
  },
  PanelText_UI_Recharge_Instructions_Text_C_Title_Content = {Text = "Müfredat"},
  PanelText_UI_Recharge_Instructions_Text_Name_Content = {Text = "İlerle"},
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Cost_Tips_Content = {Text = "Toplam"},
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Tips_Content = {
    Text = "İstemediğin eşyaların seçimini kaldırabilirsin."
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Title_Content = {
    Text = "Satın Alma Onayı"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Buttom_Content = {
    Text = "Her kademe için ilk satın alımda, yükleme miktarınıza eşit bonus Gümüş kazanın. (Her kademe için tek seferlik teklif)"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law1_Content = {
    Text = "Özel Satışlar"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law2_Content = {
    Text = "Fon Uzlaşma Yasası"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Refresh_Content = {
    Text = "Destek ile İletişime Geç"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Title_Content = {
    Text = "Özsu Çıkarımı"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_PayTip_Content = {
    Text = "Gösterilen fiyat yalnızca referans içindir. Gerçek ödemeler, geçerli para birimi üzerinden güncel kurla işlenecektir."
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Desc_Content = {
    Text = "Etkinlik Açıklaması"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Slogan_Content = {
    Text = "Sadece 24 Saat!\n1 Standart Uyanışçı seç!"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_SpecialTime_Content = {Text = "Kalan"},
  PanelText_UI_Recharge_Panel_GiftBag_Text_PayTip_Content = {
    Text = "Gösterilen fiyat yalnızca referans içindir. Gerçek ödemeler, geçerli para birimi üzerinden güncel kurla işlenecektir."
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Bigitle_Content = {
    Text = "Ay Evresi Nöbeti"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Buttom_Tips_Content = {
    Text = "İki kat Gümüş kazan. Tek seferlik teklif."
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Cost_Tips_Content = {Text = "Tüketme"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Expired_Content = {
    Text = "Süresi Doldu"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Flushed_Content = {Text = "Yenileme"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get1_Title_Content = {Text = "Hemen Al"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get2_Title_Content = {Text = "Günlük:"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Illustrate_Content = {
    Text = "Bu eşya birden fazla kez satın alınabilir."
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_OnekeyPurchase_Content = {
    Text = "Hepsini Satın Al"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Refresh_Content = {
    Text = "Destek ile İletişime Geç"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Tips_Content = {
    Text = "Toplamda 300 + 3000 Gümüş!"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Today_Content = {
    Text = "Bugün Alındı"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_Get2_Title2_Content = {Text = "(30g)"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigitle_Content = {
    Text = "Ay Evresi Nöbeti"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigtitle_Content = {
    Text = "Ay Evresi Nöbeti"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buttom_Tips_Content = {
    Text = "Her kademedeki ilk satın alımında, yüklediğin miktara eşit bonus Gümüş kazanırsın. (Her kademe için tek seferlik teklif)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buy_Content = {Text = "Satın Al"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Cost_Tips_Content = {Text = "Tüketme"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Double_Content = {Text = "Fazladan"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Expired_Content = {
    Text = "Süresi Doldu"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Extra_Content = {Text = "Fazladan"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Flushed_Content = {Text = "Yenileme"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_NumName_Content = {
    Text = "Gümüş Çekirdek Özü"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_Title_Content = {Text = "Hemen Al"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_NumName_Content = {Text = "Gümüş"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title2_Content = {Text = "(30g)"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title_Content = {Text = "Günlük:"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Illustrate_Content = {
    Text = "Bu eşya birden fazla kez satın alınabilir."
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_OnekeyPurchase_Content = {
    Text = "Hepsini Satın Al"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Refresh_Content = {
    Text = "Destek ile İletişime Geç"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip1_Content = {
    Text = "Her gün giriş yap ve\nGümüş <color=#57F8FE><size=38>×6000</size></color> al!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip2_Content = {
    Text = "Her gün giriş yap, \n<color=#57F8FE><size=38>6000</size></color> Menofin ve <color=#57F8FE><size=38>600</size></color> Anı Tüy Kalemi al!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Get1_Title_Content = {Text = "Hemen Al"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Illustrate_Content = {
    Text = "Oynanış Kuralları"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Need_Content = {
    Text = "Gereksinimler"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Tips_Content = {
    Text = "Günlük Olarak Postayla Teslim (30g)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Title_Content = {
    Text = "Kılıf İçi İkmal"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Tips_Content = {
    Text = "Toplamda *300 + 6000 Gümüş!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Title_Content = {
    Text = "Mythag Mağazası"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Today_Content = {
    Text = "Bugün Alındı"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Month_Content = {
    Text = "Ay Evresi Nöbeti"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Recharge_Content = {Text = "Şarj"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Root_Content = {
    Text = "Kök Köpüğü"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Month_Content = {
    Text = "Ay Evresi Nöbeti"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Recharge_Content = {Text = "Şarj"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Root_Content = {
    Text = "Kök Köpüğü"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Upgrade_Content = {Text = "Yükseltme"},
  PanelText_UI_Recharge_Panel_Main_Text_Get2_Title2_Content = {Text = "(30g)"},
  PanelText_UI_Recharge_Panel_Main_Text_Name_Content = {Text = "Satın Al"},
  PanelText_UI_Recharge_Panel_Main_Text_Tips_Content = {
    Text = "Toplamda *300 + 6000 Gümüş!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_Content = {
    Text = "Ay Evresi Nöbeti"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_Content = {Text = "Şarj"},
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Root_Content = {
    Text = "Kök Köpüğü"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Month_Content = {
    Text = "Ay Evresi Nöbeti"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Recharge_Content = {Text = "Şarj"},
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Root_Content = {
    Text = "Kök Köpüğü"
  },
  PanelText_UI_Recharge_Panel_Month_Tips_Text_C_Today_Content = {
    Text = "Ay Evresi Nöbeti ödülün alınabilir!"
  },
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Disable_Content = {Text = "Satın Al"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Normal_Content = {Text = "Satın Al"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Title_Content = {
    Text = "Mythag Mağazası"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cancel_Content = {Text = "İptal"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Confirm_Content = {Text = "Satın Al"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cost_Tips_Content = {Text = "Tüketme"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_Content = {Text = "Onayla"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_En_Content = {Text = "başlık"},
  PanelText_UI_Recharge_Reset_Item_Text_C_Double_Content = {
    Text = "İlk Satın Alma"
  },
  PanelText_UI_Recharge_Reset_Item_Text_C_Extra_Content = {Text = "Fazladan"},
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_Activate_Content = {Text = "Etkin"},
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_NoeGet_Content = {
    Text = "Uyandırıcı Kilitli"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_Name_Content = {
    Text = "Yetenek Etkinleştir"
  },
  PanelText_UI_Research_Panel_Ceri_Text_C_Activate_Content = {Text = "Etkin"},
  PanelText_UI_Research_Panel_Ceri_Text_C_Title_Content = {
    Text = "Yeteneklere Genel Bakış"
  },
  PanelText_UI_Research_Panel_Challenge_Item_Text_C_Undone_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_PlanName_Content = {
    Text = "Mevcut İlerleme"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_ReachName_Content = {
    Text = "Tüm Başarımlar Kilidi Açıldı"
  },
  PanelText_UI_Research_Panel_Challenge_Text_Title_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Count_Content = {Text = "Kurallar"},
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Extra_Content = {Text = "[EXTRA]"},
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_NoTask_Content = {
    Text = "Şimdilik yeni görev yok"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special2_Content = {
    Text = "Her 20 fazla seviye için +1 Ödül."
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special_Content = {Text = "Koşullar"},
  PanelText_UI_Research_Panel_Dispatch_Content_Text_Underway_Content = {
    Text = "Sürüyor..."
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Tip_Content = {
    Text = "Ödüller Hazır"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Unclickable_Content = {Text = "Kilitli"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Underway_Content = {
    Text = "Devam Ediyor"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Content = {Text = "Kalan"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Normal_Content = {Text = "Tüketme"},
  PanelText_UI_Research_Panel_Dispatch_Text_Title_Content = {Text = "Görev"},
  PanelText_UI_Research_Popup_Dispatch_Text_Title_Content = {
    Text = "Bonuslara Genel Bakış"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Agin_Content = {
    Text = "Yeniden Ata"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Dispatch_Content = {
    Text = "Uyandırıcıları Konuşlandır"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Reward_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Title_Content = {
    Text = "Görev Raporu"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Close_Content = {Text = "Kapat"},
  PanelText_UI_Research_Popup_Recall_Text_C_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Dispatch_Content = {
    Text = "Mevcut Toplam Seviye"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Extra_Content = {Text = "[EXTRA]"},
  PanelText_UI_Research_Popup_Recall_Text_C_Level_Content = {
    Text = "Toplam Konuşlandırılmış Seviye"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special2_Content = {
    Text = "Her 20 fazla seviye için +1 Ödül."
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special_Content = {Text = "Koşullar"},
  PanelText_UI_Research_Popup_Recall_Text_C_Title_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Research_Popup_Report_Text_C_Title_Content = {
    Text = "Soruşturma Raporu"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_C_Tip_Content = {
    Text = "Daha sonra \"Ayarlar - Dil\" kısmından sıfırlanabilir"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_Name_Content = {Text = "Onayla"},
  PanelText_UI_Setting_Popup_ChooseLang_Text_Title_Content = {Text = "Dil Seç"},
  PanelText_UI_Setting_Popup_Code_Text_C_Clean_Content = {Text = "Tamamlama"},
  PanelText_UI_Setting_Popup_Code_Text_C_Paste_Content = {
    Text = "Yapıştır"
  },
  PanelText_UI_Setting_Popup_Code_Text_C_Tips_Content = {
    Text = "Kurtuluş Kodunu Gir"
  },
  PanelText_UI_Setting_Popup_Down_Text_C_Downing_Content = {
    Text = "İndiriliyor.."
  },
  PanelText_UI_Setting_Popup_Examine_Text_C_Examine_Content = {
    Text = "Oyun kaynaklarının bütünlüğü denetleniyor"
  },
  PanelText_UI_Setting_Popup_Main_Text_C_Tips_Content = {Text = "Dahili GM"},
  PanelText_UI_Setting_Popup_Main_Text_C_Title_Content = {Text = "Ayarlar"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_1_Content = {Text = "Al"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_2_Content = {Text = "Al"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Title_Content = {
    Text = "Giriş Ödülleri"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_1_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_2_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Shop_Item_Commodity_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Shop_Item_Commodity_Text_C_Value_Content = {Text = "DEĞER"},
  PanelText_UI_Shop_Item_Toggle_Text_C_Recommend_Content = {
    Text = "Bugünün Önerisi"
  },
  PanelText_UI_Shop_Popup_Tips_Text_C_Tips_Content = {
    Text = "Yetersiz Para Birimi"
  },
  PanelText_UI_Social_Item_Avatar_Text_C_Lv_Content = {Text = "Sv."},
  PanelText_UI_Social_Item_Data_Left_Text_C_Assist_Content = {
    Text = "Destek Sayısı"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Awaker_Content = {
    Text = "Uyandırıcılar"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Birthday_Content = {
    Text = "Doğum Günü"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Concern2_Content = {Text = "Takip Et"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Conclude_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Difficulty_Content = {
    Text = "Soruşturma"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Dream_Content = {
    Text = "Hayali Dalış"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Fans_Content = {Text = "Takipçi"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Highest_Content = {
    Text = "En Yüksek Kayıt"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Indestructible_Content = {
    Text = "Işıksız Âlem: Dönüşüm Aralığı"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Lv_2_Content = {Text = "Sv."},
  PanelText_UI_Social_Item_Data_Left_Text_C_Pagoda_Content = {
    Text = "Işıksız Diyar"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Privacy_Content = {
    Text = "Bu Koruyucu ilerlemesini gizlemiş."
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Register_Content = {
    Text = "Giriş Günleri"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Society_Content = {Text = "Lonca"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Survey_Content = {
    Text = "Soruşturma Durumu"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Placeholder_Content = {
    Text = "Biyografini düzenle..."
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Abyss_Content = {
    Text = "D-Etkisi Yasak Bölgesi"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Assist_Content = {
    Text = "Destek Sayısı"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Attention_Content = {Text = "Takip Et"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Awaker_Content = {
    Text = "Uyandırıcılar"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Ban_Content = {Text = "Engelleme"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Birthday_Content = {
    Text = "Doğum Günü"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Collection_Content = {Text = "İlerleme"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Concern2_Content = {Text = "Takip Et"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Conclude_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Difficulty_Content = {
    Text = "Soruşturma"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Dream_Content = {
    Text = "Hayali Dalış"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Fans_Content = {Text = "Takipçi"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Gender_Content = {Text = "Cinsiyet"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Hard_Content = {Text = "Zor"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Highest_Content = {
    Text = "En Yüksek Kayıt"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Indestructible_Content = {
    Text = "Işıksız Âlem: Dönüşüm Aralığı"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Interrelated_Content = {
    Text = "Karşılıklı"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Lv_2_Content = {Text = "Sv."},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Normal_Content = {Text = "Normal"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Notset_Content = {
    Text = "Ayarlanmadı"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Pagoda_Content = {
    Text = "Işıksız Diyar"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Privacy_Content = {
    Text = "Bu Koruyucu ilerlemesini gizlemiş."
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Register_Content = {
    Text = "Giriş Günleri"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Society_Content = {Text = "Lonca"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Survey_Content = {
    Text = "Soruşturma Durumu"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_1_Content = {Text = "Toplam"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_2_Content = {
    Text = "En Yüksek Kayıt"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_NickNamePre_Content = {Text = "Not:"},
  PanelText_UI_Social_Item_Data_Right_Text_C_Help_Content = {
    Text = "Destek Uyandıran"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Lv_1_Content = {Text = "Sv."},
  PanelText_UI_Social_Item_Data_Right_Text_C_Not_Content = {
    Text = "Destek Uyandıran Yok"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Null_1_Content = {
    Text = "Gösterilen Uyandıran Yok"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Squiggle_Content = {
    Text = "Gümüş bilgiyi doğurur."
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Team_Content = {
    Text = "Uyandıran Görünümü"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Accept_Content = {Text = "Kabul Et"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Cancel_Content = {
    Text = "İptal Edildi"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Done_Content = {
    Text = "Beni takip etti"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Mutual_Content = {
    Text = "Karşılıklı"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse2_Content = {Text = "Reddedildi"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse_Content = {Text = "Reddet"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Timeout_Content = {
    Text = "Zaman Aşımına Uğradı"
  },
  PanelText_UI_Social_Item_PveRecord_Text_Fail_Content = {
    Text = "Başarısızlık"
  },
  PanelText_UI_Social_Item_PveRecord_Text_Victory_Content = {Text = "Zafer"},
  PanelText_UI_Social_Item_PvpData_Text_C_Point_01_Content = {Text = "Puan"},
  PanelText_UI_Social_Item_PvpData_Text_Fail_Content = {
    Text = "Başarısızlık"
  },
  PanelText_UI_Social_Item_PvpData_Text_Victory_Content = {Text = "Zafer"},
  PanelText_UI_Social_Item_PvpRecord_Text_Fail_Content = {
    Text = "Başarısızlık"
  },
  PanelText_UI_Social_Item_PvpRecord_Text_Victory_Content = {Text = "Zafer"},
  PanelText_UI_Social_Item_Pvp_Text_C_Dispaly_Content = {
    Text = "Savaş Günlüğünü Aç"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Input_Content = {
    Text = "İzlemek için Tekrar Kodunu Gir..."
  },
  PanelText_UI_Social_Item_Pvp_Text_C_NoTask_Content = {
    Text = "Traphase Kaydı Yok"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Nor_Content = {
    Text = "Soruşturma"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Sel_Content = {
    Text = "Soruşturma"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Nor_Content = {Text = "Traphase"},
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Sel_Content = {Text = "Traphase"},
  PanelText_UI_Social_Item_Pvp_Text_C_Search_Content = {
    Text = "Tekrarı İzle"
  },
  PanelText_UI_Social_Item_Pvp_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Attention_Content = {Text = "Takip Et"},
  PanelText_UI_Social_Item_Rank_Text_C_Following_Content = {
    Text = "Takip Ediliyor"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Interrelated_Content = {
    Text = "Karşılıklı"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Assist_Content = {
    Text = "Destek Sayısı"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Awaker_Content = {
    Text = "Uyandırıcılar"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Birthday_Content = {
    Text = "Doğum Günü"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Concern2_Content = {Text = "Takip Et"},
  PanelText_UI_Social_Panel_Data_Text_C_Conclude_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Difficulty_Content = {Text = "Zor"},
  PanelText_UI_Social_Panel_Data_Text_C_Dream_Content = {
    Text = "Hayali Dalış"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Fans_Content = {Text = "Takipçi"},
  PanelText_UI_Social_Panel_Data_Text_C_Help_Content = {
    Text = "Destek Uyandıran"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Indestructible_Content = {
    Text = "Dile Getirilemez"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Lv_1_Content = {Text = "Sv."},
  PanelText_UI_Social_Panel_Data_Text_C_Lv_2_Content = {Text = "Sv."},
  PanelText_UI_Social_Panel_Data_Text_C_Not_Content = {
    Text = "Destek Uyandıran Yok"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Null_1_Content = {
    Text = "Gösterilen Uyandıran Yok"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Pagoda_Content = {
    Text = "Işıksız Kule"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Privacy_Content = {
    Text = "Bu Koruyucu ilerlemesini gizlemiş."
  },
  PanelText_UI_Social_Panel_Data_Text_C_Register_Content = {
    Text = "Giriş Günleri"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Society_Content = {Text = "Lonca"},
  PanelText_UI_Social_Panel_Data_Text_C_Squiggle_Content = {
    Text = "Gümüş bilgiyi doğurur."
  },
  PanelText_UI_Social_Panel_Data_Text_C_Survey_Content = {
    Text = "Soruşturma Durumu"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Team_Content = {
    Text = "Uyandıran Görünümü"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Title_Content = {
    Text = "Koruyucu Profili"
  },
  PanelText_UI_Social_Panel_HelpList_Filter_Text_C_Selected_Content = {Text = "Seçildi"},
  ["PanelText_UI_Social_Panel_HelpList_Item_Text_C_ Interrelated_Content"] = {
    Text = "Karşılıklı"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Attention_Content = {Text = "Takip Et"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Commonly_Content = {Text = "Favori"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Conflict_Content = {
    Text = "Diyar Çatışması"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Fans_Content = {Text = "Takipçi"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Following_Content = {
    Text = "Takip Ediliyor"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Lv_Content = {Text = "Sv."},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recent_Content = {
    Text = "Son Destekler"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recommend_Content = {
    Text = "Bugünün Önerisi Takip"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_CommonlyAssist_Content = {Text = "Favori"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_1_Content = {Text = "Yenileme"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_Content = {
    Text = "Konuşlandır"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_1_Content = {Text = "Yenileme"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_Content = {
    Text = "Konuşlandır"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Mail_Content = {Text = "Kurallar"},
  PanelText_UI_Social_Panel_HelpList_Text_C_NoTask_Content = {
    Text = "Destek Alınabilir değil. Lütfen filtre ayarınızı yeniden düzenleyin"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Time_Content = {
    Text = "Karşılıklı olduklarının Uyandıranlarını ödünç alabilirsin."
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Title_Content = {
    Text = "Destek Seç"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Attention_Content = {Text = "Takip Et"},
  PanelText_UI_Social_Panel_Main_Item_Text_C_Done_Content = {
    Text = "Beni takip etti"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Following_Content = {
    Text = "Takip Ediliyor"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Interrelated_Content = {
    Text = "Karşılıklı"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Mutual_Content = {
    Text = "Karşılıklı"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Unblock_Content = {
    Text = "Engellemeyi Kaldır"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_Unfollow_Content = {
    Text = "Takibi Bırak"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Concern_Content = {Text = "Yeni"},
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_NoTask_Content = {
    Text = "Henüz kimseyi takip etmiyorsun"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_NoTask_Content = {Text = "Sonuç yok"},
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_Name_Content = {
    Text = "Tümünü Takip Et"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Concern_Content = {Text = "Yeni"},
  PanelText_UI_Social_Panel_Main_Text_C_NoTask_Content = {Text = "Takip yok"},
  PanelText_UI_Social_Panel_Main_Text_C_Stranger_Content = {Text = "Yabancı"},
  PanelText_UI_Social_Panel_Main_Text_C_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_1_Content = {
    Text = "İsme göre ara"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_2_Content = {
    Text = "İsme göre ara"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_Interaction_Content = {Text = "Etkileşim"},
  PanelText_UI_Social_Panel_RankList_Text_C_NoTask_Content = {Text = "Kayıt yok"},
  PanelText_UI_Social_Panel_RankList_Text_C_PlayerInfo_Content = {Text = "Usta"},
  PanelText_UI_Social_Panel_RankList_Text_C_Rank_Content = {Text = "Rütbe"},
  PanelText_UI_Social_Panel_RankList_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Social_Panel_Rank_Text_C_All_Content = {Text = "Tümü"},
  PanelText_UI_Social_Panel_Rank_Text_C_Friend_Content = {Text = "Takip Et"},
  PanelText_UI_Social_Panel_Rank_Text_C_Interaction_Content = {Text = "Etkileşim"},
  PanelText_UI_Social_Panel_Rank_Text_C_NoTask_Content = {Text = "Kayıt yok"},
  PanelText_UI_Social_Panel_Rank_Text_C_PlayerInfo_Content = {
    Text = "Koruyucu Bilgisi"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Rank_Content = {Text = "Rütbe"},
  PanelText_UI_Social_Panel_Rank_Text_C_Sign_Content = {Text = "Giriş"},
  PanelText_UI_Social_Panel_Rank_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Social_Popup_Awaker_Text_C_Owned_Content = {
    Text = "Zaten Sahip"
  },
  PanelText_UI_Social_Popup_Birthday_Text_C_Day_Content = {Text = "g"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Month_Content = {Text = "Ay"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Title_Content = {
    Text = "Doğum Günü Düzenle"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_NoTask_Content = {Text = "Destek Yok"},
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_SearchTip_Content = {Text = "UID gir"},
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Search_Content = {Text = "Ara"},
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Title_Content = {Text = "Favori"},
  PanelText_UI_Social_Popup_CommonlyAssist_Text_Time_Content = {
    Text = "Diğer yerleri keşfet"
  },
  PanelText_UI_Social_Popup_FriendlyInvite_Text_Title_Content = {
    Text = "Traphase Maçı Daveti"
  },
  PanelText_UI_Social_Popup_Introduction_Text_C_Placeholder_Content = {
    Text = "Biyografini düzenle..."
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Content = {Text = "Seç"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Desc_Content = {
    Text = "<size=25>Standart Traphase modu. Her iki taraf da önceden hazırlanmış takımlarıyla savaşa girer.</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Name_Content = {
    Text = "Serbest Seçim Modu"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Content = {Text = "Seç"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Desc_Content = {
    Text = "<size=25>Gelişmiş Traphase modu. Her iki taraf da rastgele bir havuzdan sırayla kart seçer.</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Name_Content = {
    Text = "Sıralı Seçim Modu"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_Title_Content = {Text = "Mod Seç"},
  PanelText_UI_Social_Popup_Match_Text_C_Waiting_Content = {Text = "Bekleyiş"},
  PanelText_UI_Social_Popup_Match_Text_Name_Content = {Text = "İptal"},
  PanelText_UI_Social_Popup_Match_Text_Title_Content = {
    Text = "Dostluk Maçı"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Content = {
    Text = "Avatar Çerçevesi"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Sel_Content = {
    Text = "Avatar Çerçevesi"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Sel_Content = {Text = "Avatar"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Using_Content = {
    Text = "Kullanımda"
  },
  PanelText_UI_Social_Popup_Situation_Tips_Text_C_AffixInfo_Content = {
    Text = "Soruşturma Durumu"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_C_Cost_Content = {Text = "Tüketme"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Cancel_Name_Content = {Text = "İptal"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Confirm_Name_Content = {Text = "Onayla"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Title_Content = {
    Text = "Cinsiyet Değiştir"
  },
  PanelText_UI_Social_Popup_WatchList_Text_C_NoTask_Content = {
    Text = "Henüz yeni takipçi yok"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Name_FollowAll_Content = {
    Text = "Tümünü Takip Et"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Tip_Content = {
    Text = "En son 100 takipçiyi görüntüle"
  },
  PanelText_UI_Social_Tips_InviteBubble_Text_Name_Content = {
    Text = "Dostluk Maçı"
  },
  PanelText_UI_Story_Item_History_Text_Text_C_Choice_1_Content = {Text = ">>>"},
  PanelText_UI_Story_Item_History_Text_Text_C_Choice_2_Content = {Text = ">>>"},
  PanelText_UI_Story_Item_History_Text_Text_C_Choice_3_Content = {Text = ">>>"},
  PanelText_UI_Story_Item_History_Text_Text_C_Current_Content = {Text = ">>>"},
  PanelText_UI_Story_Panel_Main_Text_C_High_Content = {
    Text = "Giriş Arka Planını Sıfırla"
  },
  PanelText_UI_Story_Panel_Main_Text_C_Normal_Content = {
    Text = "Giriş Arka Planı Olarak Ayarla"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Continue_Content = {Text = "Devam et"},
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Title_Content = {
    Text = "Hafıza Arşivlendi"
  },
  PanelText_UI_Story_Portrait_Test_Text_C_Close_Content = {Text = "Kapat"},
  PanelText_UI_Story_Portrait_Test_Text_C_Hide_Content = {Text = "Gizli"},
  PanelText_UI_Summon_Btn_Jump_Text_C_Look_Content = {
    Text = "Görüntüle"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Difficulty_Content = {Text = "Zorluk"},
  PanelText_UI_Summon_Btn_Realms_Text_C_Directional_Content = {
    Text = "Mevcut Seçim"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Name_Content = {Text = "Seç"},
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Full_Content = {
    Text = "Tam Yükseltilmiş"
  },
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Have_Content = {
    Text = "Zaten Sahip"
  },
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Max_Content = {Text = "MAKS"},
  PanelText_UI_Summon_Item_Probability_Text_C_Name_Content = {Text = "İsim"},
  PanelText_UI_Summon_Item_Probability_Text_C_Role_Content = {
    Text = "Kapsamlı Olasılık"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Time_Content = {Text = "İsim"},
  PanelText_UI_Summon_Item_Probability_Text_C_Type_Content = {Text = "Tür"},
  PanelText_UI_Summon_Item_Probability_Text_Limit_Content = {Text = "Sınırlı"},
  PanelText_UI_Summon_Item_SelectLimit_Text_C_Up_Content = {Text = "YÜKSELT!"},
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_GiftTitle_Content = {
    Text = "Bir Kostüm Kuponu talep et!"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_1_Content = {
    Text = "×2 Garantili"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_2_Content = {
    Text = "×3 Garantili"
  },
  PanelText_UI_Summon_Panel_Main_Text_Award_Content = {
    Text = "Ekstra Ödüller"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Choose_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Difficult_Title_Content = {Text = "Zorluk"},
  PanelText_UI_Summon_Panel_Main_Text_C_FirstLimit_Content = {
    Text = "İlk Kez Sınırlı"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_FreeLimit_Content = {Text = "Ücretsiz"},
  PanelText_UI_Summon_Panel_Main_Text_C_Hint_Content = {
    Text = "Diyar Değiştir"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_LimitName_Content = {
    Text = "5× Uyanış"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Limited_Content = {
    Text = "Sınırlı Uyandıran"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Look_Content = {
    Text = "Görüntüle"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Name_Content = {Text = "Kalıcı"},
  PanelText_UI_Summon_Panel_Main_Text_C_Realms_Content = {
    Text = "Bir Diyar Seç"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_RecAwaker_Content = {
    Text = "Önerilen Uyandıran"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_School_Intro_Title_Content = {
    Text = "Diyar Özellikleri:"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Summon_Content = {
    Text = "5 Kez Uyanış"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_System_Name_Content = {Text = "Uyanış"},
  PanelText_UI_Summon_Panel_Main_Text_C_TryName_Content = {
    Text = "Uyanış Deneme Görevi"
  },
  PanelText_UI_Summon_Panel_Main_Text_Desc_2_Content = {Text = "Açıklama"},
  PanelText_UI_Summon_Panel_Main_Text_FreeTen_Content = {Text = "Ücretsiz"},
  PanelText_UI_Summon_Panel_Main_Text_Recommend_Content = {
    Text = "Yeni Başlayan Önerilen Uyanış"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Choose_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Title_Content = {
    Text = "Uyandırıcı Seçildi"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Detail_Content = {Text = "Kurallar"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Inventory_Content = {Text = "Envanter"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Name_Content = {Text = "İsim"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Not_Content = {Text = "Kayıt yok"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Prompt_Content = {
    Text = "Bu sayfada son 6 aya ait Uyanış kayıtlarını görebilirsin. Veriler yaklaşık bir saatlik gecikmeyle güncellenebilir."
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_REcording_Content = {Text = "Kayıtlar"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Role_Content = {
    Text = "Uyanış Türü"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Time_Content = {
    Text = "Uyanış Zamanı"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_1_Content = {
    Text = "Uyanış Türü"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_Content = {Text = "Tür"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Up_Content = {
    Text = "Oranı Artırılmış Eşya"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Name_Content = {Text = "İsim"},
  PanelText_UI_Summon_Popup_Main_Text_C_Not_Content = {Text = "Kayıt yok"},
  PanelText_UI_Summon_Popup_Main_Text_C_Prompt_Content = {
    Text = "Bu sayfada son 6 aya ait Uyanış kayıtlarını görebilirsin. Veriler yaklaşık bir saatlik gecikmeyle güncellenebilir."
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Role_Content = {
    Text = "Uyanış Türü"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Time_Content = {
    Text = "Uyanış Zamanı"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Title_Content = {Text = "Kayıtlar"},
  PanelText_UI_Summon_Popup_Main_Text_C_Type_Content = {Text = "Tür"},
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Change_Content = {
    Text = "Yeniden Seç"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_ChooseTitle_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Choose_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_InfoTitle_Content = {
    Text = "Etkinlik Kuralları"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_Title_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Confirm_Content = {
    Text = "Seçimi Onayla"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Tip_Content = {
    Text = "Detayları görmek için bir Uyanışçıya uzun bas"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Confirm_Content = {
    Text = "Seçimi Onayla"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Tip_Content = {
    Text = "Detayları görmek için bir Uyanışçıya uzun bas"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Title_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Activity_Content = {
    Text = "Ücretsiz Kader Çarkı"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Game_Content = {
    Text = "Ücretsiz Uyandıran"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Info_Content = {
    Text = "Her 150 [Realm Study] Uyanış için, yukarıda listelenenler arasından Seçiminize göre 1 Uyanışçı/Kader Çarkı elde edebilirsiniz."
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Plan_Content = {Text = "İlerleme"},
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Check_Content = {
    Text = "Ayrıntıları Görüntüle"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Git_Content = {Text = "Al"},
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Detail_Content = {
    Text = "Ayrıntılar"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Inventory_Content = {Text = "Envanter"},
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Up_Content = {
    Text = "Oranı Artırılmış Eşya"
  },
  PanelText_UI_Summon_Popup_Realms_Text_C_Introduce_Content = {
    Text = "Yalnızca seçtiğin Diyar’ın Uyandıranlarını elde etmek için bir Diyar seç. Seçimini dilediğin zaman değiştirebilirsin."
  },
  PanelText_UI_Summon_Popup_Realms_Text_C_Title_Content = {
    Text = "Diyar Seçimi"
  },
  PanelText_UI_Summon_Popup_Recording_Text_C_Prompt_Content = {
    Text = "Bu sayfada son 6 aya ait Uyanış kayıtlarını görebilirsin. Veriler yaklaşık bir saatlik gecikmeyle güncellenebilir."
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_ChooseTitle_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_Choose_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_InfoTitle_Content = {
    Text = "Etkinlik Kuralları"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_Title_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Summon_Popup_Share_Text_C_Share_Content = {
    Text = "Şuraya Paylaş:"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_Autofine_Content = {
    Text = "Otomatik Yükseliş"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_C_Name_Content = {
    Text = "Uyandırma ×1"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_Autofine_Content = {
    Text = "Otomatik Yükseliş"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_C_Name_Content = {
    Text = "Uyandırma ×1"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_Autofine_Content = {
    Text = "Otomatik Yükseliş"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_C_Name_Content = {
    Text = "Uyandırma ×1"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_C_Share_Content = {
    Text = "İlk Paylaşım Ödülü"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Confirm_Name_Content = {Text = "Onayla"},
  PanelText_UI_Summon_Popup_Total_Show_Text_Name_Content = {Text = "Uyanış"},
  PanelText_UI_Summon_Popup_Total_Show_Text_ReSummon_Content = {
    Text = "5 Kez Uyanış"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Toggle_Content = {
    Text = "Hızlı Uyanış"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Name_Content = {
    Text = "Uyandırma ×1"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Share_Content = {
    Text = "İlk Paylaşım Ödülü"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Auto_Content = {
    Text = "Önerilen WoD"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_ChooseTitle_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Choose_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Confirm_Content = {
    Text = "Seçimi Onayla"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_InfoTitle_Content = {
    Text = "Etkinlik Kuralları"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_Title_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Task_Item_Detail_List_New_Text_C_Get_Content = {Text = "Al"},
  PanelText_UI_Task_Panel_Main_New_Text_C_Achievement_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_ActionReports_Content = {
    Text = "Görev Raporu"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_GrowUp_Content = {
    Text = "Gelişim Kaydı"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Master_Content = {
    Text = "Diyar Ustalığı"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips2_Content = {Text = "Boş Liste"},
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips_Content = {
    Text = "Günlük Görev Tamamlandı!"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Title_Content = {
    Text = "Şimdilik yeni görev yok..."
  },
  PanelText_UI_Task_Popup_Career_Item_Text_C_Undone_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Task_Popup_Career_Item_Text_Name_Content = {Text = "Al"},
  PanelText_UI_Task_Popup_Career_New_Text_C_1_Content = {
    Text = "Mevcut İlerleme"
  },
  PanelText_UI_Task_Popup_Career_New_Text_C_Chapter_Award_Content = {
    Text = "Tamamlama Ödülleri"
  },
  PanelText_UI_Task_Popup_Career_Text_C_1_Content = {
    Text = "Mevcut İlerleme"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Award_Content = {
    Text = "Tamamlama Ödülleri"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Get_Content = {
    Text = "Ödül Alındı"
  },
  PanelText_UI_Task_Popup_Career_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_Name_2_Content = {
    Text = "Tümünü Al"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_ReachName_Content = {
    Text = "Tüm Başarımlar Tamamlandı"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Info1_Content = {
    Text = "Daha fazlasını kazanmak için Koruyucu Seviyeni yükselt"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Level1_Content = {
    Text = "Koruyucu TP"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Undone1_Content = {
    Text = "Tamamlanmadı"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_Name_Content = {Text = "Al"},
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Info_Content = {
    Text = "Daha fazlasını kazanmak için Koruyucu Seviyeni yükselt"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Level_Content = {
    Text = "Koruyucu TP"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_Name_Content = {Text = "Al"},
  PanelText_UI_Task_Popup_Challenge_New_Text_C_1_Content = {Text = "İSİM"},
  PanelText_UI_Task_Popup_Challenge_New_Text_C_2_Content = {Text = "GİRİŞ"},
  PanelText_UI_Task_Popup_Challenge_New_Text_C_3_Content = {Text = "SEVİYE"},
  PanelText_UI_Task_Popup_Challenge_New_Text_C_Title_Content = {
    Text = "Başarımlar"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_1_Content = {Text = "Koruyucu"},
  PanelText_UI_Task_Popup_Challenge_Text_C_2_Content = {Text = "GİRİŞ"},
  PanelText_UI_Task_Popup_Challenge_Text_C_3_Content = {Text = "SEVİYE"},
  PanelText_UI_Task_Popup_Challenge_Text_C_OneKey_Content = {
    Text = "Hepsini Topla"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Reach_Content = {
    Text = "Gümüş Anahtar Bize Yol Göstersin."
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Title_Content = {
    Text = "Giriş Sertifikası"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Award_Content = {
    Text = "Görev Ödülleri"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Special_Content = {Text = "Koşullar"},
  PanelText_UI_Team_Item_Awaker_List_Text_C_Disable_Content = {
    Text = "Devre Dışı Bırak"
  },
  PanelText_UI_Team_Item_Awaker_List_Text_C_Help_Content = {
    Text = "Destek Uyandıran"
  },
  PanelText_UI_Team_Item_Awaker_List_Text_C_Lv_Content = {Text = "Sv"},
  PanelText_UI_Team_Item_Awaker_List_Text_C_Lv_Dissolution_Content = {Text = "Sv."},
  PanelText_UI_Team_Item_MyTeam_List_Text_C_Current_Content = {
    Text = "Şu Anda Konuşlandırıldı"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Guide_Content = {
    Text = "Bugünün Önerisi"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Hint_Content = {
    Text = "*Bir Uyanan yalnızca bir SSR Kader Çarkı kuşanabilir."
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Recommend_Content = {
    Text = "Bugünün Önerisi"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Remove_Content = {
    Text = "Tümünü Çıkar"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Save_Content = {Text = "Kaydet"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Uninstall_Content = {
    Text = "Tümünü Çıkar"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Foundation_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Lv_Content = {
    Text = "Seviye İlerlemesi"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Refining_Content = {
    Text = "Transkripsiyon İlerlemesi"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Null_Content = {
    Text = "Etkin bir set etkisi yok"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Title_Content = {Text = "Set Etkisi"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Added_Content = {
    Text = "Yeni Ahit Planı"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_2_Content = {Text = "Çıkar"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_3_Content = {Text = "Geliştir"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_4_Content = {Text = "Kuşan"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Null_Content = {
    Text = "Bu parça için alınabilir Ahit yok"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Quantity_Content = {
    Text = "Kaydedilmiş Setler"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Save_Content = {
    Text = "Yeni Ahit Planı"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Suit_Content = {Text = "Plan Yok"},
  PanelText_UI_Team_Item_Suit_Text_C_Current_Content = {
    Text = "Kuşanılmış"
  },
  PanelText_UI_Team_Item_Talent_Text_C_Activate_Content = {Text = "Etkin"},
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Foundation_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Lv_Content = {
    Text = "Seviye İlerlemesi"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Refining_Content = {
    Text = "Transkripsiyon İlerlemesi"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Null_Content = {
    Text = "Etkin bir set etkisi yok"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Title_Content = {Text = "Set Etkisi"},
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Empty_Content = {
    Text = "Soldan bir WoD seç"
  },
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Not_Content = {
    Text = "Etkin Değil"
  },
  PanelText_UI_Team_Panel_Awaker_Main_Text_C_Zhanli_Content = {
    Text = "Dövüş Gücü"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Recommend_Content = {
    Text = "Bugünün Önerisi"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Remove_Content = {
    Text = "Tümünü Çıkar"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Save_Content = {Text = "Kaydet"},
  PanelText_UI_Team_Panel_Main_Popup_Team_Text_C_AffixInfo_Content = {
    Text = "Takım Bilgisi"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Activated_Content = {Text = "Etkin"},
  PanelText_UI_Team_Panel_Main_Text_C_Boundaries_Tips_Content = {
    Text = "Diyar Önerisi"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Cost_Tips_Content = {
    Text = "Gereksinimler:"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Empty_Content = {
    Text = "Müfreze Donatılmamış"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Frequency_Content = {Text = "Kez"},
  PanelText_UI_Team_Panel_Main_Text_C_Hint_Content = {
    Text = "Bu savaşta kullanılan Uyandırıcılar, Kader Çarkları ve Müfreze diğer Bölgesel D-Etkisi Yasak Bölgeleri’nde görevlendirilemez."
  },
  PanelText_UI_Team_Panel_Main_Text_C_Lives_Desc_Content = {
    Text = "Kalan Acil Gnosis:"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Lv1_Content = {Text = "Sv"},
  PanelText_UI_Team_Panel_Main_Text_C_Lv2_Content = {Text = "Sv"},
  PanelText_UI_Team_Panel_Main_Text_C_Lv3_Content = {Text = "Sv"},
  PanelText_UI_Team_Panel_Main_Text_C_Lv4_Content = {Text = "Sv"},
  PanelText_UI_Team_Panel_Main_Text_C_Name_1_Content = {
    Text = "Serbest Bırak"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Name_2_Content = {Text = "Destek"},
  PanelText_UI_Team_Panel_Main_Text_C_NoActivate_Content = {
    Text = "Etkin Değil"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Prohibit_Content = {
    Text = "Bu seviye için Müfreze devre dışı"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Skill_Content = {Text = "Müfreze"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips2_Content = {
    Text = "Takım Bilgisi"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_1_Content = {Text = "Destek"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips_2_Content = {Text = "Destek"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips_Content = {Text = "Kaldır"},
  PanelText_UI_Team_Panel_Main_Text_Career_Content = {
    Text = "Diyar Gereksinimi"
  },
  PanelText_UI_Team_Panel_Main_Text_Madness_Content = {
    Text = "Delilik Zorluğu yalnızca İlk Tamamlama Ödülleri verir."
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Delete_Content = {Text = "Seti Sil"},
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Edit_Content = {
    Text = "Seti Düzenle"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Recommend_Content = {
    Text = "Bugünün Önerisi"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Remove_Content = {
    Text = "Tümünü Çıkar"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Save_Content = {
    Text = "Planı Kaydet"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Guide_Content = {
    Text = "Bugünün Önerisi"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Hint_Content = {
    Text = "*Bir Uyanan yalnızca bir SSR Kader Çarkı kuşanabilir."
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_2_Content = {Text = "Çıkar"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_3_Content = {Text = "Yükseliş"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Null_Content = {
    Text = "Henüz Kader Çarkı Yok"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Title_Content = {
    Text = "Kader Çarkı Seç"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Uninstall_Content = {
    Text = "Tümünü Çıkar"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Attribute_Content = {
    Text = "Özellikler"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Level_Content = {Text = "Sv."},
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Name_Content = {
    Text = "Uyandıran Ayrıntıları"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "Uyandırıcıları Seç"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Xx_Content = {
    Text = "Ayrıntılar"
  },
  PanelText_UI_Team_Popup_MyTeam_Awaker_List_Text_C_Name_Content = {Text = "Seç"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name01_Content = {Text = "Kaos"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name02_Content = {Text = "Aequor"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name03_Content = {Text = "Caro"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name04_Content = {Text = "Ultra"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "Sınıf Yeteneği"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_C_Task_Content = {
    Text = "İlk tamamlamada şunları elde edeceksin:"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_Title_Content = {
    Text = "İlk Tamamlama Ödülü"
  },
  PanelText_UI_Vx_Battle_Chaowei_Butter_Text_C_ExtraTurn_Content = {Text = "Ekstra Tur"},
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Normal_Content = {
    Text = "Yükselişe Göre Sırala"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Select_Content = {
    Text = "Yükselişe Göre Sırala"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Normal_Content = {Text = "Düzen"},
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Select_Content = {Text = "Düzen"},
  PanelText_UI_Weapon_Item_Select_List_Text_No_Weapon2_Content = {
    Text = "Alınabilir Kader Çarkı yok"
  },
  PanelText__Text_C_Dress_Content = {Text = "Değiştir"},
  PanelText__Text_C_Dressing_Content = {
    Text = "Kuşanılmış"
  },
  PanelText__Text_C_Empty_Content = {
    Text = "Kaldırıldı"
  },
  PanelText__Text_C_Goto_Content = {Text = "Satın Al"},
  PanelText__Text_C_Have_Content = {
    Text = "Zaten Sahip"
  },
  PanelText__Text_C_Reveal_Content = {Text = "Gizli"}
})
return Text_PanelText
