__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_PanelText = readonly({
  PanelText_Battle_UltiSkill_Painting_EX_Text_C_UltiSkill_Content = {
    Text = "Übertriebene Verherrlichung"
  },
  PanelText_Btn_Block_Window_Text_C_Display_Content = {
    Text = "Karten anzeigen"
  },
  PanelText_Btn_Block_Window_Text_C_Hide_Content = {
    Text = "Versteckte Karten"
  },
  PanelText_Btn_Get_Text_Name_Content = {Text = "Abholen"},
  PanelText_Com_RedDot_Text_C_GroupNew_Content = {Text = "Neu"},
  PanelText_Com_RedDot_Text_C_New_Content = {Text = "Neu"},
  PanelText_Com_Text_New_Text_C_New_Content = {Text = "Neu"},
  ["PanelText_GmPanel_Text_C_Battle_Test (1)_Content"] = {Text = "Kampf 2.0"},
  PanelText_GmPanel_Text_C_Battle_Test2_Content = {Text = "PvP-Kampf"},
  PanelText_GmPanel_Text_C_Battle_Test_Content = {
    Text = "PvP-Matching"
  },
  PanelText_GmPanel_Text_C_Gb_Content = {Text = "Schließen"},
  PanelText_GmPanel_Text_C_Hm_Content = {
    Text = "Wechseln der Bildschirmgrafikeinstellungen auf hohe/niedrige Konfiguration"
  },
  PanelText_GmPanel_Text_C_Placeholder_Content = {
    Text = "Suche eingeben"
  },
  PanelText_GmPanel_Text_C_Xy_Content = {
    Text = "Testprotokoll"
  },
  PanelText_GmPanel_Text_C_Yc_Content = {
    Text = "GM-Panel verstecken"
  },
  PanelText_GmParamEquipPanel_Text_C_Fs_Content = {Text = "Senden"},
  PanelText_GmParamEquipPanel_Text_C_Tc_Content = {Text = "Verlassen"},
  PanelText_GmParamPanel_Text_C_Fs_Content = {Text = "Senden"},
  PanelText_GmParamPanel_Text_C_Param_Content = {
    Text = "Konfiguration"
  },
  PanelText_GmParamPanel_Text_C_Tc_Content = {Text = "Verlassen"},
  PanelText_Icon_Common_Text_C_New_Content = {Text = "Neu"},
  PanelText_Icon_Common_Text_C_NoEquip_Content = {
    Text = "Nicht ausrüstbar"
  },
  PanelText_Item_Battle_AwakerSkill_1_Text_C_CD_Content = {Text = "Abkühlung"},
  PanelText_Item_Battle_AwakerSkill_1_Text_C_Ready_Content = {
    Text = "Verherrlichung"
  },
  PanelText_Panel_Announcement_Text_C_Panel_Title_Content = {
    Text = "Ankündigung"
  },
  PanelText_Panel_Battle_Monster_Information_Text_C_Monster_Content = {
    Text = "Monsterabsicht"
  },
  PanelText_Panel_Battle_Monster_Information_Text_C_Story_Content = {
    Text = "Monstergeschichte"
  },
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Canel_Content = {Text = "Abbrechen"},
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Canel_Content = {Text = "Abbrechen"},
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Enter_Content = {
    Text = "Herausforderung"
  },
  PanelText_Panel_Gm_PVP_Text_C_Canel_Content = {Text = "Abbrechen"},
  PanelText_Panel_Gm_PVP_Text_C_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_Popup_Gm_Effect_Side_Text_Content = {
    Text = "Effekt bearbeiten"
  },
  PanelText_Popup_Gm_Effect_Text_Cancel_Content = {Text = "Schließen"},
  PanelText_Popup_Gm_Effect_Text_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_RedPoint_New_Text_C_New_Content = {Text = "Neu"},
  PanelText_Simple_List_Panel_Text_Content = {Text = "Schließen"},
  PanelText_Text_C_Activate_Text_C_Activate_Content = {
    Text = "Aktivierungsmaterial"
  },
  PanelText_UI_Address_Panel_Main_Text_C_NoTask1_Content = {
    Text = "Wähle Kontaktperson"
  },
  PanelText_UI_Address_Panel_Main_Text_C_Title_Content = {
    Text = "Kommunikator"
  },
  PanelText_UI_Address_Panel_Main_Text_Time_Content = {
    Text = "Klicke auf die Liste, um auszuwählen"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_C_NoTask_Content = {
    Text = "Keine neuen Nachrichten"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Title_Content = {
    Text = "Kommunikator"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Achievement_Content = {
    Text = "Bündnis Zersetzung"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Alchemy_Content = {
    Text = "Materialherstellung"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Permute_Content = {
    Text = "Materialtausch"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Recast_Content = {
    Text = "Bündnis Nachdruck"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveItem_Content = {
    Text = "Material-Absturz"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveWeapon_Content = {
    Text = "Schicksalsrad zerlegen"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_Title_Content = {Text = "Alchemie"},
  PanelText_UI_Alchemy_Popup_Break_Down_Placeholder_Content = {
    Text = "Zum Antworten klicken"
  },
  PanelText_UI_Alchemy_Popup_MyTeam_Awaker_List_Optimize_Text_Btn_Save_Content = {Text = "Speichern"},
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Name_Content = {Text = "Austausch"},
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Possess_Tips_Content = {
    Text = "Wird ersetzt"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Tips_Content = {
    Text = "Derzeit gibt es keine zerlegbaren Gegenstände"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Title_Content = {
    Text = "Materialien für den Austausch"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Whole_Content = {
    Text = "Alles auswählen"
  },
  PanelText_UI_Alchemy_Popup_Recast_Text_C_Name_Content = {
    Text = "Neu drucken"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_All_Content = {
    Text = "Alles auswählen"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Cap_Content = {
    Text = "Erfolgreich auf das aktuelle Level-Limit gestärkt"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNum_Content = {Text = "Menge"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Mail_Content = {Text = "Regeln"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_MaterialsNull_Content = {
    Text = "Es gibt noch keine entsprechenden Bündnisse"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "Das Ausrichten hat das Maximum erreicht"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Null_Content = {
    Text = "Bitte wählen Sie die Gegenstände zum Zerlegen"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Resolve_Content = {
    Text = "Erhalten durch Zerlegung"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Sel_Content = {
    Text = "Ausgewählt"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Screen_Content = {Text = "Filtern"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Reset_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle1_Content = {Text = "Set"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle2_Content = {Text = "Position"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle3_Content = {
    Text = "Hauptattribut"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle4_Content = {
    Text = "Nebenattribute"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_SiftTitle_Text_C_Tips_Content = {
    Text = "Klicke, um auszuwählen"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_All_Content = {
    Text = "Alles auswählen"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Cap_Content = {
    Text = "Erfolgreich auf das aktuelle Level-Limit gestärkt"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNum_Content = {Text = "Menge"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_MaterialsNull_Content = {
    Text = "Es gibt noch keine entsprechenden Bündnisse"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_NormotopiaCap_Content = {
    Text = "Stapel-Limit erreicht"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Null_Content = {
    Text = "Bitte wählen Sie die Gegenstände zum Zerlegen"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Resolve_Content = {
    Text = "Erhalten durch Zerlegung"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Sel_Content = {
    Text = "Ausgewählt"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_All_Content = {
    Text = "Alles auswählen"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Cap_Content = {
    Text = "Erfolgreich auf das aktuelle Level-Limit gestärkt"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNum_Content = {Text = "Menge"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Mail_Content = {Text = "Regeln"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "Das Ausrichten hat das Maximum erreicht"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Null_Content = {
    Text = "Bitte wählen Sie die Gegenstände zum Zerlegen"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Resolve_Content = {
    Text = "Erhalten durch Zerlegung"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Sel_Content = {
    Text = "Ausgewählt"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_WeaponNull_Content = {
    Text = "Keine zugehörige Schicksalslinie"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_All_Content = {
    Text = "Alles auswählen"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Cap_Content = {
    Text = "Erfolgreich auf das aktuelle Level-Limit gestärkt"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNum_Content = {Text = "Menge"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_NormotopiaCap_Content = {
    Text = "Stapel-Limit erreicht"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Null_Content = {
    Text = "Bitte wählen Sie die Gegenstände zum Zerlegen"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Resolve_Content = {
    Text = "Erhalten durch Zerlegung"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Sel_Content = {
    Text = "Ausgewählt"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_WeaponNull_Content = {
    Text = "Keine zugehörige Schicksalslinie"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Name_Content = {Text = "Zerlegen"},
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Whole_Content = {
    Text = "Alles auswählen"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_None_Tips_Content = {
    Text = "Bitte wähle von links das Material zum Zerlegen"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Possess_Tips_Content = {
    Text = "Wird zerlegt"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Slider_Tips_Content = {
    Text = "Zerlegungsanzahl"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Tips_Content = {
    Text = "Keine zerlegbaren Materialien"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Title_Content = {
    Text = "Materialien durch Zerlegen erhalten"
  },
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Have_Content = {Text = "Ja"},
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Not_Content = {Text = "Nichtig"},
  PanelText_UI_Announcement_Item_Title_Text_New_Info_Content = {Text = "Neu"},
  PanelText_UI_Awaker_Button_Addition_Text_C_Tips_Content = {Text = "Bonus"},
  PanelText_UI_Awaker_Item_Info_Text_C_Attribute_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Attributes_Title_Content = {
    Text = "Attribute ."
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Configuration_Content = {
    Text = "Teamkonfiguration"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Grade_Content = {Text = "Level"},
  PanelText_UI_Awaker_Item_Info_Text_C_High_Content = {
    Text = "Aktuell anzeigen"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Content = {
    Text = "Synchro-Rate"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Title_Content = {Text = "Affinität"},
  PanelText_UI_Awaker_Item_Info_Text_C_No_Content = {
    Text = "Nicht erhalten"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Normal_Content = {
    Text = "Vorschau auf Level 60"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Potential_Content = {
    Text = "Gnostischer Fortschritt"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Score_Force_Content = {Text = "Kampfkraft"},
  PanelText_UI_Awaker_Item_Info_Text_C_Title_Content = {Text = "Realm"},
  PanelText_UI_Awaker_Item_Info_Text_C_Xx_Content = {
    Text = "Detaillierte Informationen"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Full_Content = {
    Text = "Erleuchten voll"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Got_Content = {
    Text = "Bereits erwacht"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Already_Content = {Text = "Besitzt"},
  PanelText_UI_Awaker_Item_List_Text_C_Disable_Content = {
    Text = "Nicht austauschbar"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Full_Content = {
    Text = "Persönlichkeitsvertiefung ist voll"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Click_Content = {
    Text = "Rückverfolgung"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Content = {
    Text = "Rückverfolgung"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Click_Content = {Text = "Erwachen"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Content = {Text = "Erwachen"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Click_Content = {Text = "Archiv"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Content = {Text = "Archiv"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Click_Content = {Text = "Bündnis"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Content = {Text = "Bündnis"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Click_Content = {Text = "Fähigkeit"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Content = {Text = "Fähigkeit"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Click_Content = {Text = "Zustand"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Content = {Text = "Zustand"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_TalentSelected_Content = {Text = "Talent"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Talent_Content = {Text = "Talent"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Click_Content = {Text = "Schicksrad"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Content = {Text = "Schicksrad"},
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Consume_Content = {
    Text = "Um die Ursprungsform zu entsperren, müssen folgende Gegenstände verbraucht werden. Bestätigen?"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_1_Content = {Text = "Abbrechen"},
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_2_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Title_Content = {
    Text = "Ursprungsfreigabe bestätigen"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Click_Content = {Text = "Allgemein"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Content = {Text = "Allgemein"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Click_Content = {
    Text = "Aufgabenmodus"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Content = {
    Text = "Aufgabenmodus"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Current_Content = {Text = "Aktuell"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Lower_Content = {
    Text = "Nächste Stufe"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Mad_Content = {
    Text = "Überlimit Exaltieren freigeschaltet"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Solved_Content = {
    Text = "Freigeschaltet"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Unsolved_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_WillSolved_Content = {
    Text = "Wird freigeschaltet"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Ranking_Content = {
    Text = "Vorschau der Erhöhung"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Skill_Story_Content = {
    Text = "Aktivierungsmaterialien"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Solved_Content = {
    Text = "Freigeschaltet"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Click_Content = {
    Text = "Ermittlungsmodus"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Content = {
    Text = "Ermittlungsmodus"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Unsolved_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_CN_Content = {Text = "Aktiviert"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_WillSolved_Content = {
    Text = "Wird freigeschaltet"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Solved_Content = {
    Text = "Freigeschaltet"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Unsolved_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_1_Content = {
    Text = "Genesis-Rückkehr"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_2_Content = {
    Text = "Entwicklungsrücksetzung"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_1_Content = {
    Text = "Rückgabe-Vorschau"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_2_Content = {
    Text = "Rückgabe-Vorschau"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_3_Content = {
    Text = "Rückgabe-Vorschau"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_TipDesc_Content = {
    Text = "Nach einer “Entwicklungs-Rückspulung“ oder “Geist-Erweckung-Rückspulung“ kann keine “Schwarzer Pool-Rückgabe“ mehr durchgeführt werden"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Click_Content = {
    Text = "Aufgabenmodus"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Content = {
    Text = "Aufgabenmodus"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Click_Content = {Text = "Spezial"},
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Content = {Text = "Spezial"},
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Click_Content = {
    Text = "Ermittlungsmodus"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Content = {
    Text = "Ermittlungsmodus"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Warning_CN_Content = {Text = "Ausgelöst"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Attribute_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Full_Content = {
    Text = "Maximallevel erreicht"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_High_Content = {
    Text = "Aktuell anzeigen"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Insufficient_Content = {
    Text = "Wachaufkörperstufe nicht ausreichend"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Maniac_Content = {
    Text = "Verherrlichung"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Material_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_1_Content = {Text = "Aktuell"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_2_Content = {Text = "Aktuell"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_3_Content = {
    Text = "Nächste Stufe"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_4_Content = {
    Text = "Nächste Stufe"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Normal_Content = {
    Text = "Maximalstufen-Vorschau"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_PressTip_Content = {
    Text = "Lange Druck auf Handkarte, um sie vergrößert anzusehen"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Skill_Tag_Content = {
    Text = "Verherrlichung"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Tale_Content = {Text = "Geschichte"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Text_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Attribute_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Maniac_Content = {
    Text = "Verherrlichung"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Material_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_1_Content = {Text = "Aktuell"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_2_Content = {Text = "Aktuell"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_3_Content = {
    Text = "Nächste Stufe"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_4_Content = {
    Text = "Nächste Stufe"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Tale_Content = {Text = "Geschichte"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Text_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Material_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Tips_Content = {
    Text = "Automatische Einfügung"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_Confirm_Content = {Text = "Aufstieg"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_2_Content = {
    Text = "Option zwei"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_3_Content = {
    Text = "Option drei"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_Content = {
    Text = "Bilden Bedingungen"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Material_Content = {
    Text = "Bilden Materialien"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_New_Content = {
    Text = "Aber neue Fähigkeit aktivieren"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Title_Content = {
    Text = "Bilden Bedingungen<WordSize20:（einer davon wählen）>"
  },
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Prop_Title_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Tips_Content = {
    Text = "Detaillierte Informationen"
  },
  PanelText_UI_Awaker_Item_Trinket_Detail_Text_C_Empty_Content = {
    Text = "Bitte wähle die Bündnis-Ausrüstung"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Deplete_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Fast_Content = {
    Text = "Schnell einfügen"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_1_Content = {Text = "Aufstieg"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_2_Content = {
    Text = "Transkription"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_3_Content = {Text = "Aufstieg"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Refinement_Content = {
    Text = "Bündnis Details"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Normal_Content = {Text = "Kampf"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Select_Content = {Text = "Kampf"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Normal_Content = {Text = "Alltag"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Select_Content = {Text = "Alltag"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Normal_Content = {
    Text = "Phasenduell"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Select_Content = {
    Text = "Phasenduell"
  },
  PanelText_UI_Awaker_Item_Weapon_Refine_Text_C_Coin_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Blackpool_Content = {
    Text = "Zurück zur Vorschau"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_3_Content = {
    Text = "Genesis-Rückkehr"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_4_Content = {
    Text = "Stapel-Rückverfolgung"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Cost_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Current_Content = {
    Text = "Aktueller Effekt"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Expend_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Fast_Content = {
    Text = "Schnell einfügen"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Full_Content = {
    Text = "Maximalstufe"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_1_Content = {Text = "Aktuell"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_2_Content = {Text = "Aktuell"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_3_Content = {
    Text = "Nach dem Stapeln"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_4_Content = {
    Text = "Nach dem Stapeln"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_5_Content = {
    Text = "Nächste Stufe"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_6_Content = {
    Text = "Nächste Stufe"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Next_Content = {
    Text = "<Blue:Nächster Effekt>"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Overlay_Content = {
    Text = "Zurück zur Vorschau"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Level_Content = {
    Text = "Schicksalsrad-Stapelstufe"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Name_Content = {
    Text = "Stapelposition"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Title_Content = {
    Text = "Wähle Stapelmaterial"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Warning_Content = {
    Text = "Maximales Stapel-Level erreicht"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_BackTraceTip_Content = {
    Text = "Nach der Verwendung von “Stapel-Rückverfolgung“ kann keine “Genesis-Rückkehr“ mehr durchgeführt werden."
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_Title_Content = {
    Text = "Schicksalsrad-Details"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Click_Content = {
    Text = "Rückverfolgung"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Content = {
    Text = "Rückverfolgung"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Breakthrough_Content = {Text = "Bilden"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Enhance_Content = {
    Text = "Verstärkung"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Equip_Content = {
    Text = "Ausrüstung anlegen"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Fast_Content = {
    Text = "Schnell einfügen"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_1_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Refine_Content = {
    Text = "Stapelposition"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Click_Content = {
    Text = "Stapelposition"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Content = {
    Text = "Stapelposition"
  },
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Message_Content = {
    Text = "Awaker-Info."
  },
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Story_Content = {Text = "Geschichte"},
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Title_Content = {
    Text = "Grundinformationen"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_1_Content = {
    Text = "Normale Form"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_2_Content = {
    Text = "Normale Form"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_3_Content = {
    Text = "Normale Form"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_1_Content = {
    Text = "Genesis Form"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_2_Content = {
    Text = "Genesis Form"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_3_Content = {
    Text = "Genesis Form"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Null_Content = {
    Text = "Am aktuellen Standort sind keine Bunde verfügbar"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Strengthen_Content = {
    Text = "Verstärkung"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Title_Content = {
    Text = "Bündnis-Fessel"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_UnBindAll_Content = {
    Text = "Alle lösen"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Contrast_Content = {Text = "Vergleich"},
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info1_Content = {
    Text = "Schicksal erkennen"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info2_Content = {
    Text = "Schicksalsrad"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info3_Content = {
    Text = "Schicksalsrad"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty1_Content = {
    Text = "Linke Seite: Schicksalsrad ausrüsten"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty_Content = {
    Text = "Linke Seite: Schicksalsrad ausrüsten"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Unlock_Content = {
    Text = [[
Bilden Erwecker
Zweite Rad des Schicksals freischalten]]
  },
  PanelText_UI_Awaker_Popup_Attribute_Detail_Text_C_Title_Content = {
    Text = "Eigenschaftsdetails"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_1_Content = {
    Text = "Details anzeigen"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_2_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_NoTask_Content = {
    Text = "Keine rückverfolgbaren Gegenstände"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Title_Content = {
    Text = "Wähle Rückverfolgungsziel"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_1_Content = {
    Text = "Permanenter Erwecker"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_2_Content = {
    Text = "Spezieller Erwecker"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_3_Content = {Text = "Schicksrad"},
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_BindTip_Content = {
    Text = "Bündnisse, die von anderen Erweckern ausgerüstet oder in Aufstellungen/Plänen/Unterstützung vorhanden sind, wurden automatisch entfernt"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Tip_Content = {
    Text = "Fesselung des folgenden Bündnisses bestätigen?"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Title_Content = {
    Text = "Bindungsänderung bestätigen"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Cancel_Name_Content = {Text = "Abbrechen"},
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Confirm_Name_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Tip_Content = {
    Text = "Es fehlen benötigte Materialien. Sollen die folgenden Materialien verbraucht werden, um den Mangel zu decken?"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Title_Content = {
    Text = "Ergänzungs-Hinweis"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Expired_Content = {
    Text = "Folgende Gegenstände sind abgelaufen und können nicht mehr verwendet werden"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Title_Content = {
    Text = "Gegenstand abgelaufen"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_No_Trinket_Content = {
    Text = "Keine auswählbaren Materialien"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_Title_Content = {
    Text = "Wähle ein Bündnis"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Content_Content = {
    Text = "Maximales Level erreicht"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Title_Content = {
    Text = "Stufe erhöht"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Xuyao_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Popup_MyTeam_List_Text_C_William_Content = {
    Text = "Keine Aufstiegsmaterialien"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Coin_Count_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Material_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Name_Content = {
    Text = "Gnostischer Fortschritt"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Title_Content = {
    Text = "Stufenobergrenze erhöht"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Preview_Content = {
    Text = "Nach der Rückverfolgung erhältst du die folgenden Materialien"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Title_Content = {
    Text = "Rückgabe-Vorschau"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Content_Content = {
    Text = "Stufenobergrenze"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Title_Content = {
    Text = "Fähigkeitsaufstieg"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Xuyao_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Condition_Content = {
    Text = "Freischaltbedingungen"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Current_Content = {Text = "Aktuell"},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_High_Content = {
    Text = "Aktuell anzeigen"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Lower_Content = {
    Text = "Nächste Stufe"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Normal_Content = {
    Text = "Maximalstufen-Vorschau"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_Require_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Popup_Tip_Preview_Text_C_Title_Content = {
    Text = "Bilden Materialvorschau"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Info_Content = {
    Text = "Klicke auf den leeren Bereich, um zu schließen"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_New_Content = {
    Text = "Aber neue Fähigkeit aktivieren"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Succeed_Content = {
    Text = "Bilden erfolgreich"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Breakthrough_Content = {
    Text = "Synchronisierungsanforderung"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Now_Content = {Text = "Aktuell"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Reward_Content = {
    Text = "Stufenbelohnung"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Screening_Content = {
    Text = "Belohnung abgeholt"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Tips_Content = {Text = "Ansehen"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Title_Content = {
    Text = "Synchro-Rate"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Unlock_Content = {
    Text = "Archiv freigeschaltet"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_illustrate_Content = {Text = "Regeln"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_Name_Content = {Text = "Abholen"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Activation_Content = {Text = "Aktiviert"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Lv_Content = {
    Text = "Stufenobergrenze erhöht"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Content = {
    Text = "Stufenobergrenze erhöht"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Name_Content = {
    Text = "Übertriebene Verherrlichung"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Activation_Content = {Text = "Aktiviert"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Name_Content = {
    Text = "Letzte Regel"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_Activation_Content = {
    Text = "Nicht aktiviert"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_MaxMad_Activation_Content = {
    Text = "Nicht aktiviert"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Solved_Content = {
    Text = "Freigeschaltet"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Title_Content = {
    Text = "Persönlichkeitsvertiefung"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unlock_Content = {
    Text = "Eigenschaftssteigerung"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unsolved_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_WillSolved_Content = {
    Text = "Wird freigeschaltet"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Material_Content = {
    Text = "Bilden Materialien"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Reward_Content = {
    Text = "Bilden Belohnung"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Title_Content = {
    Text = "Bilden Vorschau"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_Screening_Content = {
    Text = "Belohnung abgeholt"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_BindTip_Content = {
    Text = "Nach dem Binden wird das Hauptattribut des Bündnisses um zusätzliche 50% erhöht!"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Bind_Content = {
    Text = "Bündnis fesseln"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Empty_Suit_Content = {
    Text = "Keine aktiven Set-Effekte"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Foundation_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Rule_Content = {Text = "Regeln"},
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Suit_Content = {Text = "Set-Effekt"},
  PanelText_UI_Awaker_Popup_Trinket_Change_Text_C_Equipped_Content = {
    Text = "Ausgerüstet"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_AutoRefinement_Content = {
    Text = "Automatische Transkription"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Empty_Content = {
    Text = "Klicke, um neue Unterattribute zu erhalten"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Exchange_Content = {
    Text = "Austausch-Einstellungen"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Foundation_Content = {
    Text = "Ursprüngliche Nebenattribute"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Hoist_Content = {
    Text = "Neue Nebenattribute"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_1_Content = {
    Text = "Transkription"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_2_Content = {Text = "Ersetzen"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_No_Entries_Content = {
    Text = "Keine Attribute"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Skip_Content = {
    Text = "Animation überspringen"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Text_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_illustrate_Content = {
    Text = "Transkriptionsanleitung"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Filtrate_Content = {
    Text = "SSR und darunter Materialien"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Shortcut_Content = {
    Text = "Schnell einsetzen"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Upper_Limit_Content = {
    Text = "Maximallevel erreicht"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_List_Text_C_None_Content = {
    Text = "Keine ungerüstete Schicksalslinie"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_1_Content = {
    Text = "Bitte wähle die Bündnis-Ausrüstung"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_2_Content = {
    Text = "Keine aktiven Set-Effekte"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Foundation_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Suit_Content = {Text = "Set-Effekt"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Contrast_Content = {Text = "Vergleich"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Empty_Content = {
    Text = "Bitte wähle die Bündnis-Ausrüstung"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_None_Content = {
    Text = "Am aktuellen Standort sind keine Bunde verfügbar"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Notselected_Content = {
    Text = "Bitte wähle die Bündnis-Ausrüstung"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Suit_Content = {Text = "Set-Effekt"},
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_None_Content = {
    Text = "Noch kein Bündnis für nicht ausgerüstete"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Consume_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Deplete_Content = {
    Text = "Verbraucht Materialien"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Exchange_Content = {
    Text = "Austausch-Einstellungen"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Content = {
    Text = "Schnell einfügen"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_High_Content = {
    Text = "Steige eine Stufe auf"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Normal_Content = {
    Text = "Steige eine Stufe auf"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_MaxLevel_Content = {
    Text = "Verstärkung"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_High_Content = {
    Text = "Level Up bis Max"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_Normal_Content = {
    Text = "Level Up bis Max"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Name_3_Content = {Text = "Aufstieg"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Title_Content = {Text = "Level"},
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_AutoSelect_Content = {
    Text = "Automatische Auswahl"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Cancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Confirm_Content = {
    Text = "Bündnis lösen"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_NeedTrinket_Content = {
    Text = "Bündnis erforderlich"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Title_Content = {
    Text = "Bündnis lösen"
  },
  PanelText_UI_Awaker_Popup_Whole_Body_Text_C_Reveal_Content = {Text = "Verstecken"},
  PanelText_UI_Awaker_Popup_illustrate_Tips_Text_C_Title_Content = {
    Text = "Affix-Beschreibung"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Tips_Content = {Text = "Übersicht"},
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Title_Content = {
    Text = "Erwachte Fähigkeit"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Type_Content = {Text = "Typ"},
  PanelText_UI_Awaker_Weapon_Enhance_Success_Text_C_Succeed_Content = {
    Text = "Stärkung erfolgreich"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Info_Content = {
    Text = "Klicke auf den leeren Bereich, um zu schließen"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Succeed_Content = {
    Text = "Stapel erfolgreich"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Attribute_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Choose_Content = {
    Text = "·Wähle Erwachensform"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Helicopter_Content = {
    Text = "·Verstärkungs-Vorschau"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Skill_Content = {Text = "Fähigkeit"},
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Title_Content = {
    Text = "Erwachte Verstärkung"
  },
  PanelText_UI_Bag_Item_Appearance_Text_C_Got_Content = {Text = "Erhalten"},
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_AavtarName_Content = {
    Text = "Avatar und Ausdruck"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Avatar_Info_Content = {
    Text = "Details-Vorschau"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Source_Content = {Text = "Quelle"},
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Time_Content = {
    Text = "Verbleibende Gültigkeitsdauer:"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_AavtarName_Content = {
    Text = "Avatar und Ausdruck"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "Details-Vorschau"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "Schlüsselbefehl-Effekt:"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Source_Content = {
    Text = "Quelle abrufen"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Time_Content = {
    Text = "Verbleibende Gültigkeitsdauer"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Attack_Content = {
    Text = "Grundangriff"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Defense_Content = {
    Text = "Basisverteidigung"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Physique_Content = {
    Text = "Grundkonstitution"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Full_Content = {
    Text = "Erleuchten voll"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Title_Content = {
    Text = "Wähle Erwachenskörper-Fragment"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Yes_Content = {Text = "Besitzt"},
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Cancel_Name_Content = {
    Text = "Details anzeigen"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Confirm_Name_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_BtnName_Content = {Text = "Abholen"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Emoji_Content = {Text = "Emoji"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_NoTask_Content = {
    Text = "Alle Skins erhalten"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_RatePreview_Content = {
    Text = "Wahrscheinlichkeitsvorschau"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Title_Content = {
    Text = "Äußere Vorschau"
  },
  PanelText_UI_Bag_Panel_Main_Text_AmountName_Content = {Text = "Menge"},
  PanelText_UI_Bag_Panel_Main_Text_C_2_Select_Content = {
    Text = "Reihenfolge"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Cap_Content = {
    Text = "Erfolgreich auf das aktuelle Level-Limit gestärkt"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_None2_Content = {
    Text = "Inventar ist leer"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_NormotopiaCap_Content = {
    Text = "Stapel-Limit erreicht"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Replacement_Content = {Text = "Austausch"},
  PanelText_UI_Bag_Panel_Main_Text_C_Resolve_Content = {Text = "Zerlegen"},
  PanelText_UI_Bag_Panel_Main_Text_C_Synthesis_Content = {Text = "Synthese"},
  PanelText_UI_Bag_Panel_Main_Text_C_recast_Content = {
    Text = "Neuschmieden"
  },
  PanelText_UI_Bag_Panel_Main_Text_Intensify_Content = {
    Text = "Verstärkung"
  },
  PanelText_UI_Bag_Panel_Main_Text_Normotopia_Content = {
    Text = "Stapelposition"
  },
  PanelText_UI_Bag_Panel_Main_Text_Title_Content = {Text = "Inventar"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_BtnName_Content = {Text = "Abholen"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Emoji_Content = {Text = "Emoji"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_NoTask_Content = {
    Text = "Keine Daten vorhanden"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Title_Content = {
    Text = "Äußere Vorschau"
  },
  PanelText_UI_Battle_Item_CounterAwaker_Text_C_CounterAwaker_Content = {
    Text = "Spezialangriffs-Erwecker"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Disabled_CN_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Display_Content = {
    Text = "Karten anzeigen"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Hide_Content = {
    Text = "Versteckte Karten"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_High_CN_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Normal_CN_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Count_Content = {
    Text = "Fusionsschwarm"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_End_EN_No_Content = {Text = "Ende"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Insufficient_Content = {
    Text = "Nicht genug Platz"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Name_Content = {Text = "Ende"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Setting_Content = {
    Text = "Einstellungen"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Unclickable_Content = {Text = "Ende"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Zongshanghai_Content = {
    Text = "Gesamtschaden"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_insufficient_Content = {
    Text = "Nicht genug Platz"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_CD_Content = {Text = "Abkühlung"},
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Cooling_Content = {
    Text = "Abkühlung, nächste Runde wieder nutzbar"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Title_Content = {
    Text = "Übertriebene Verherrlichung"
  },
  PanelText_UI_Battle_Popup_Anger_Text_C_CD_Content = {Text = "Abkühlung"},
  PanelText_UI_Battle_Popup_Anger_Text_C_Cooling_Content = {
    Text = "Abkühlung, nächste Runde wieder nutzbar"
  },
  PanelText_UI_Battle_Popup_Anger_Text_Title_Content = {
    Text = "Verherrlichung"
  },
  PanelText_UI_Battle_Popup_AttachPost_Text_C_AttachPost_Content = {Text = "Verfolgung"},
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Title_Content = {
    Text = "Wähle ein Kartenset"
  },
  PanelText_UI_Battle_Popup_Elite_Text_C_Victory_Content = {
    Text = "Gefahrenalarm"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Hang_Content = {
    Text = "Kampf beginnt"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Title_Content = {
    Text = "Höchste Alarmstufe"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Continue_Content = {
    Text = "Klicke, um fortzufahren"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Victory_Content = {
    Text = "Kampf verloren"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_1_Content = {Text = "Abbrechen"},
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_2_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Title_Content = {
    Text = "Blutroter Schmelzofen"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Awaker_School_Content = {Text = "Schutzherr"},
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Nature_Content = {Text = "Team-Info"},
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Property_Content = {
    Text = "Notfallversorgung"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill2_Content = {Text = "Keyflare"},
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill_Tag_Content = {Text = "Posse"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeeperSkill_Content = {Text = "Freigeben"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenAwaken_Content = {Text = "Freigeben"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenNewChaos_Content = {Text = "Freigeben"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_Title_Content = {
    Text = "Bitte wähle einen Befehl"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_AwakenTitle_Content = {
    Text = "Keyflare-Erwecken"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_NewChaosTitle_Content = {
    Text = "Kombinierte Posse"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Hang_Content = {
    Text = "Kampf beginnt"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Title_Content = {
    Text = "Kampf beginnt"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips2_Content = {
    Text = "Eintauschen?"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips_Content = {
    Text = "Der Notfall-Geist ist erschöpft, möchtest du [Currency] ausgeben?"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Cost_Content = {Text = "Verbrauch"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Tips_Content = {
    Text = "(Nach dem Einlösen wird der Notfall-Geistkörper direkt verbraucht und der Charakter wird wiederauferstanden. Beim Rückzug wird der Notfall-Geistkörper zurückerstattet)"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Cancel_Name_Content = {Text = "Abbrechen"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_Confirm_Name_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Title_Content = {
    Text = "Wiederbelebung Bestätigung"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_AffixInfo_Content = {
    Text = "Affix-Beschreibung"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Arousal_Content = {Text = "Erwecken"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Deepen_Tag_Content = {
    Text = "Persönlichkeitsvertiefung"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Destiny_Content = {Text = "Schicksrad"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Gnosisi_Content = {Text = "Erwecken"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Maniac_Content = {
    Text = "Wahnsinnspunkte"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Property_Content = {
    Text = "Eigenschaftsdetails"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Secret_Content = {Text = "Bündnis"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Skill_Tag_Content = {
    Text = "Verherrlichung"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Talent_Content = {Text = "Talent"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Awakening_Content = {Text = "Erwecken"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Trinket_Content = {Text = "Bündnis"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Weapon_Content = {Text = "Schicksrad"},
  PanelText_UI_Battle_Popup_Round_Enemy_Text_C_Our_Content = {
    Text = "Aktion des Feindes"
  },
  PanelText_UI_Battle_Popup_Round_Mine_Text_C_Our_Content = {
    Text = "Unsere Aktion"
  },
  PanelText_UI_Battle_Popup_SelectAwaker_Text_C_Title_Content = {
    Text = "Bitte wählen Sie einen Erweckten"
  },
  PanelText_UI_Battle_Popup_Settle_Text_C_Succeed_Content = {
    Text = "Schlacht gewonnen"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Activate_Content = {Text = "Befehl"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Defense_Content = {Text = "VERT"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_1_Content = {
    Text = "Nicht wählbar"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_2_Content = {
    Text = "Nicht wählbar"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Frantic_Content = {Text = "Wahnsinn"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Name_Content = {Text = "Kampf"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Title_Content = {
    Text = "Bitte wählen Sie eine Tentakelhaltung"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Cancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Lock_Content = {
    Text = "Zeitliche Rückkehr: Kampf auf eine vorherige Runde zurückspulen"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Sure_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Title_Content = {
    Text = "Rückverfolgungsrunde"
  },
  PanelText_UI_Battle_Tip_CounterAwaker_Text_C_Title_Content = {
    Text = "Feindeigenschaft"
  },
  PanelText_UI_Card_Panel_Discard_Text_C_Title_Content = {
    Text = "Handkartenstapel"
  },
  PanelText_UI_Chaper_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_Content = {
    Text = "Kumulative Belohnungen"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_En_Content = {
    Text = "Kann erhalten"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Cancel_Content = {Text = "Beenden"},
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Confirm_Content = {
    Text = "Immer noch untersuchen"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Joinin_Content = {
    Text = "Es wird empfohlen, die folgenden Umfragelevel abzuschließen"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Screening_Content = {
    Text = "Heute keine weiteren Erinnerungen"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Bright_Content = {Text = "Gebet"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Content = {Text = "Gebet"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Begone_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Creation_Content = {Text = "Relikt"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkactivity_Content = {Text = "Gebet"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkgame_Content = {Text = "Relikt"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Demon_Content = {
    Text = "Keine Gebete verfügbar"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Bright_Content = {Text = "Relikt"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Content = {Text = "Relikt"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Mail_Content = {
    Text = "Keine Relikte"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_No_Content = {
    Text = "Keine Gravuren"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Not_Content = {
    Text = "Keine Schöpfungen"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Walk_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_mail_Content = {
    Text = "Postfach leer"
  },
  PanelText_UI_Chaper_Popup_Level_Success_Text_C_Title_Content = {
    Text = "Level-Erfolge"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Achievement_Content = {
    Text = "Vorschau des Feindes"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Cost_Tips_Content = {
    Text = "Teamanforderungen:"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Grade_Content = {
    Text = "Empfohlenes Level"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Monster_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Recommend_Content = {
    Text = "Reichsempfehlung"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Reward_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Suppress_Content = {
    Text = "Fusionsschwarm"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Title_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Monster_Content = {Text = "Monster"},
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Title_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Chaper_Popup_Particulars_View_Text_C_Replay_Content = {
    Text = "Aufzeichnung"
  },
  PanelText_UI_Chaper_Popup_StageAchieve_View_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Difficulty_Content = {Text = "Schwierig"},
  PanelText_UI_Chapter_Dream_View_Text_C_Nightmare_Content = {Text = "Wahnsinn"},
  PanelText_UI_Chapter_Dream_View_Text_C_Remember_Content = {Text = "Erinnerung"},
  PanelText_UI_Chapter_Dream_View_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Difficulty_Content = {Text = "Schwierig"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Nightmare_Content = {Text = "Albtraum"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Remember_Content = {Text = "Erinnerung"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Simple_Content = {Text = "Einfach"},
  PanelText_UI_Chapter_Item_Achievement_List_Text_C_Lost_Content = {
    Text = "Nicht erreicht"
  },
  PanelText_UI_Chapter_Item_Achievement_List_Text_Lost_Content = {
    Text = "Nicht erreicht"
  },
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Expect_Content = {Text = "Demnächst"},
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Tips_Content = {
    Text = "Vollständig"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect1_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect2_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect_Content = {Text = "Demnächst"},
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Tips_Content = {
    Text = "Vollständig"
  },
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Chaoter_Content = {
    Text = "Traumansicht"
  },
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Item_Dream_02_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Item_Dream_03_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Item_Dream_04_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Chaoter_Content = {
    Text = "Traumansicht"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Item_Skill_Text_C_Level_Content = {Text = "Zustand"},
  PanelText_UI_Chapter_Item_Special_01_Text_C_Chaoter_Content = {
    Text = "Traumansicht"
  },
  PanelText_UI_Chapter_Item_Special_01_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Item_Special_02_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Item_Special_03_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Item_StageAchieve_Text_C_Lost_Content = {
    Text = "Nicht erreicht"
  },
  PanelText_UI_Chapter_Item_Success_List_Text_Lost_Content = {
    Text = "Nicht erreicht"
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Award_Content = {
    Text = "Alle Belohnungsbedingungen erfüllt"
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Award_Content = {Text = "Erreicht"},
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Difficulty_Content = {Text = "Schwierig"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_Nightmare_Content = {Text = "Wahnsinn"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_NoTask_Content = {
    Text = "Keine Einsatzprotokolle"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_Time_Content = {
    Text = "Neu ab 21.12.2023 05:00, bleibt gespannt"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Title_Content = {Text = "Ermittlung"},
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_2_Content = {
    Text = "Level-Erfolge"
  },
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_Content = {
    Text = "Level-Bewertung"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_01_Content = {Text = "Schwierig"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Content = {Text = "Schwierig"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Now_Content = {Text = "Schwierig"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_01_Content = {Text = "Wahnsinn"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Content = {Text = "Wahnsinn"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Now_Content = {Text = "Wahnsinn"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Progress_Content = {
    Text = "Ermittlungsfortschritt"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_01_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Now_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tab_Special_Content = {
    Text = "Zeitlich begrenztes Event"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tishi_Content = {
    Text = "Level-Erfolge"
  },
  PanelText_UI_Chapter_Popup_Achievement_Text_C_Title_Content = {Text = "Erfolge"},
  PanelText_UI_Chapter_Popup_Chapter_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Chapter_Popup_Monster_Details_Text_C_Title_Content = {
    Text = "Details des Feindes"
  },
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Effect_Content = {Text = "Effekt"},
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Story_Content = {Text = "Geschichte"},
  PanelText_UI_Chapter_Popup_Yuanxing_Text_Title_Content = {
    Text = "Ermittlungsbewertung"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Difficulty_Content = {Text = "Schwierig"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Nightmare_Content = {Text = "Wahnsinn"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Progress_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Remember_Content = {Text = "Erinnerung"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Tab_Special_Content = {
    Text = "Zeitlich begrenztes Event"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Difficulty_Content = {Text = "Schwierig"},
  PanelText_UI_Chapter_Spur_View_Text_C_Nightmare_Content = {Text = "Wahnsinn"},
  PanelText_UI_Chapter_Spur_View_Text_C_Progress_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Remember_Content = {Text = "Erinnerung"},
  PanelText_UI_Chapter_Spur_View_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Chapter_Spur_View_Text_C_Review_Content = {Text = "Vorspiel"},
  PanelText_UI_Chapter_Spur_View_Text_C_Simple_Content = {Text = "Normal"},
  PanelText_UI_Chapter_Spur_View_Text_C_Tab_Special_Content = {
    Text = "Zeitlich begrenztes Event"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Condition_Content = {
    Text = "Freischaltkriterien nicht erfüllt"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Name_Content = {
    Text = "Beim Betreten der Handlung"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_NoTask_Content = {
    Text = "Fortpflanzungswahn noch nicht freigeschaltet"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_StoryDesc_Content = {
    Text = "Mit dem Fortgang der „Verlangenswelle“ wurden die Erwecker von mysteriösen Kräften beeinflusst und in den Zustand der „Fortpflanzungsbesessenheit“ versetzt... Achtung, Hüter!"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Tip_Content = {
    Text = "Während des “Verlangenswelle“-Ereignisses ist zeitweise ein ermäßigter Preis verfügbar. Sie können die Anforderungen an die Affinität ignorieren und das entsprechende Ereignis bereits mit “Realität Startpunkt“*1 entsperren!"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Title_Content = {
    Text = "Party-Einladung"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Collection_History_Details_Text_C_Lock_Content = {
    Text = "Noch keine Bildmaterialien erhalten"
  },
  PanelText_UI_Collection_History_Details_Text_Title_Content = {
    Text = "Aufzeichnung"
  },
  PanelText_UI_Collection_Item_Comprehensive_Text_C_Placeholder_Content = {
    Text = "Nomen suchen"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_High_Content = {
    Text = "Hintergrundmusik zurücksetzen"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Label_Content = {Text = "Phonograph"},
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Mail_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Normal_Content = {
    Text = "Als Hintergrundmusik festlegen"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Title_Content = {Text = "Archiv"},
  PanelText_UI_Collection_Item_Music_Text_C_Label_Content = {Text = "Phonograph"},
  PanelText_UI_Collection_Item_Music_Text_C_Mail_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Title_Content = {Text = "Archiv"},
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_UnLock_Content = {
    Text = "Freischalten"
  },
  PanelText_UI_Collection_Item_Video_Text_C_UnLock_Content = {
    Text = "Freischalten"
  },
  PanelText_UI_Collection_Panel_EquipDetail_Text_C_Title_Content = {Text = "Geschichte"},
  PanelText_UI_Collection_Panel_Equip_Text_C_None2_Content = {
    Text = "Noch kein Material vorhanden"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_None_Content = {
    Text = "Keine relevanten Sammlungen"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Collection_Panel_Event_Text_C_Placeholder_Content = {
    Text = "Nomen suchen"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Label_Content = {Text = "Chronik"},
  PanelText_UI_Collection_Panel_History_Text_C_Mail_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Title_Content = {Text = "Archiv"},
  PanelText_UI_Collection_Panel_LoginPV_Text_Title_Content = {
    Text = "Login-Hintergrund ändern"
  },
  PanelText_UI_Collection_Panel_LoginPV_Text_Title_En_Content = {
    Text = "Login-Hintergrund ändern"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Creation_Content = {Text = "Relikt"},
  PanelText_UI_Collection_Panel_Main_Text_C_Event_Content = {Text = "Ereignis"},
  PanelText_UI_Collection_Panel_Main_Text_C_Image_Content = {Text = "Bild"},
  PanelText_UI_Collection_Panel_Main_Text_C_Music_Content = {Text = "Phonograph"},
  PanelText_UI_Collection_Panel_Main_Text_C_Progress_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Role_Content = {Text = "Charakter"},
  PanelText_UI_Collection_Panel_Main_Text_C_Title_Content = {Text = "Archiv"},
  PanelText_UI_Collection_Panel_Main_Text_C_Trinket_Content = {Text = "Bündnis"},
  PanelText_UI_Collection_Panel_Main_Text_C_Weapon_Content = {Text = "Schicksrad"},
  PanelText_UI_Collection_Panel_Main_Text_C_World_Content = {Text = "Holozän"},
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Mail_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Title_Content = {Text = "Archiv"},
  PanelText_UI_Collection_Panel_Organize_Text_C_Mail_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Collection_Panel_Organize_Text_Title_Content = {Text = "Archiv"},
  PanelText_UI_Collection_Panel_Relic_Text_C_Mail_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Collection_Panel_Relic_Text_C_Title_Content = {Text = "Geschichte"},
  PanelText_UI_Collection_Panel_Relic_Text_Title_Content = {Text = "Archiv"},
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Cancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Display_Content = {
    Text = "Erweckungskörper anzeigen"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_DownLoadCG_Content = {
    Text = "Originalbild herunterladen"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_HideAwaker_Content = {
    Text = "Wenn dieses Bild als Schlafsaal-Hintergrund festgelegt wird, werden die Charakterbilder der Besucher ausgeblendet."
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Hide_Content = {
    Text = "Erwachenden verstecken"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_High_Content = {
    Text = "Hintergrund zurücksetzen"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Normal_Content = {
    Text = "Als Schlafsaalhintergrund festlegen"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Save_Content = {Text = "Speichern"},
  PanelText_UI_Collection_Panel_Unlock_Text_C_Cost_Content = {Text = "Verbrauch"},
  PanelText_UI_Collection_Panel_World_Text_C_Chronicle_Content = {Text = "Chronik"},
  PanelText_UI_Collection_Panel_World_Text_C_Comprehensive_Content = {
    Text = "Holozän-Verbotenes Buch"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Label_Content = {Text = "Holozän"},
  PanelText_UI_Collection_Panel_World_Text_C_Organize_Content = {
    Text = "Organisation"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Title_Content = {Text = "Archiv"},
  PanelText_UI_Collection_Panel_World_Text_Progress_Content = {
    Text = "Sammelstatus"
  },
  PanelText_UI_Common_Awaker_Favor_Text_C_Sync_Content = {
    Text = "Wachkörper Affinität erhöhen"
  },
  PanelText_UI_Common_Btn_Receive_Small_Text_C_Name_Content = {Text = "Abholen"},
  PanelText_UI_Common_Btn_Share_Text_C_Across_Content = {
    Text = "Erstes Teilen erhalten"
  },
  PanelText_UI_Common_Btn_Share_Text_C_Share_Content = {
    Text = "Erstes Teilen erhalten"
  },
  PanelText_UI_Common_Btn_Small_240x90_Text_Name_Content = {
    Text = "Talent aktivieren"
  },
  PanelText_UI_Common_Group_Coin_Text_C_Text_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Common_Item_Detail_Text_C_AavtarName_Content = {
    Text = "Avatar und Ausdruck"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "Details-Vorschau"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Close_Content = {Text = "Einklappen"},
  PanelText_UI_Common_Item_Detail_Text_C_Equipped_Content = {
    Text = "Ausgerüstet"
  },
  PanelText_UI_Common_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "Schlüsselbefehl-Effekt:"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Source_Content = {
    Text = "Quelle abrufen"
  },
  PanelText_UI_Common_Item_Hint_Text_C_Recommend_Content = {Text = "Empfehlen"},
  PanelText_UI_Common_Item_Tip_Bg_Text_C_Name_Content = {Text = "Sortierung"},
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Dispatch_Content = {
    Text = "Einsatz läuft"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Expired_Content = {Text = "Abgelaufen"},
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NoEquip_Content = {
    Text = "Nicht ausrüstbar"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NotActive_Content = {
    Text = "Nicht wirksam"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_UpperLimit_Content = {
    Text = "Limit erreicht"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Using_Content = {
    Text = "In Verwendung"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Full_Content = {
    Text = "Die Aufstieg ist voll"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Double_Content = {Text = "Doppelt"},
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Nor_Content = {
    Text = "Zusätzlich"
  },
  PanelText_UI_Common_Melt_Disaster_Text_C_Suppress_Content = {
    Text = "Fusionsschwarm"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_AbandonCard_Content = {
    Text = "Ablagestapel"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_DrawCard_Content = {Text = "Ziehstapel"},
  PanelText_UI_Common_Popup_Card_List_Text_C_Empty_Content = {
    Text = "Der Zugstapel ist derzeit leer"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_NoTask_Content = {
    Text = "Keine Karten"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Cancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Common_Popup_Consume_Text_C_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Title_Content = {
    Text = "Gegenstandsverwendung bestätigen"
  },
  PanelText_UI_Common_Popup_Tip_01_Text_C_Screening_Content = {
    Text = "Heute keine weiteren Hinweise"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_Screening_Content = {
    Text = "Heute keine weiteren Hinweise"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_ShopNeed_Content = {
    Text = "Aktuelle Gutscheine"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_Screening_Content = {
    Text = "Heute keine weiteren Hinweise"
  },
  PanelText_UI_Common_Popup_Tip_4_Text_C_Info_Content = {
    Text = "<WhiteQuality:Klicken Sie auf den leeren Bereich, um zu schließen>"
  },
  PanelText_UI_Common_Popup_Tip_5_Text_C_Info_Content = {
    Text = "Klicke auf den leeren Bereich, um zu schließen"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_C_Tips_Content = {
    Text = "Nach der Namensänderung kann dieser 72 Stunden lang nicht geändert werden"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_NameCancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Common_Popup_Tip_6_Text_NameConfirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_Placeholder_Content = {
    Text = "Bitte geben Sie Ihren Namen ein"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_Title_Content = {
    Text = "Namen ändern"
  },
  PanelText_UI_Common_Popup_Tips_6_Text_null_Content = {
    Text = "（Beschädigt）"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Material_Content = {
    Text = "Bilden Materialien"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Reward_Content = {
    Text = "Bilden Belohnung"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Title_Content = {
    Text = "Bilden Vorschau"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Day_Content = {Text = "Tag"},
  PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Month_Content = {Text = "Monat"},
  PanelText_UI_Common_Popup_Tips_Small_Text_C_Scroll_Tips_Content = {
    Text = "Nach oben und unten wischen, um mehr Belohnungen zu sehen"
  },
  PanelText_UI_Community_Acclaim_Tips_Text_C_Name_1_Content = {
    Text = "Zur Bewertung"
  },
  PanelText_UI_Community_Steer_Tips_Text_Thanks_Name_Content = {
    Text = "Besonderer Dank"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_LetterTitle_Content = {
    Text = "An die sehr geehrten Freiwilligen der Lokalisierung:"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Name_Content = {
    Text = "Lokalisierungs-Freiwilliger"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Signature_Content = {
    Text = "Verwaltungsrat der Missaga University"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Sincerely_Content = {
    Text = "Herzlichen Dank"
  },
  PanelText_UI_Community_ThanksLetter_Text_Prefix_Content = {
    Text = "Durch Ihr feines Sprachgefühl und Ihre Leidenschaft für das Spiel verwandeln Sie steife maschinelle Übersetzungen in lebendige Sprache. Genau diese selbstlose Begeisterung ermöglicht es den globalen Hütern, das authentische Erlebnis von „Vergessene Vorabend“ zu genießen. \n       Die Misaq Universität bedankt sich herzlich bei folgenden Hütern für ihre herausragenden Beiträge:"
  },
  PanelText_UI_Community_ThanksLetter_Text_Suffix_Content = {
    Text = "Möge der Silberschlüssel uns leiten"
  },
  PanelText_UI_Community_ThanksLetter_Text_Title_Content = {
    Text = "Besonderer Dank"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Award_Content = {Text = "Archiviert"},
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Free_Unlock_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Lock_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Copy_Story_View_Text_C_ReadTip_Content = {
    Text = "Die empfohlene Reihenfolge stellt lediglich die empfohlene Lesereihenfolge dar und entspricht nicht zwingend der chronologischen Reihenfolge."
  },
  PanelText_UI_Course_Panel_Main_Text_C_NoTask_Content = {
    Text = "Keine Lehrinhalte dieser Art"
  },
  PanelText_UI_Course_Panel_Main_Text_C_Placeholder_Content = {
    Text = "Lehrmaterial suchen"
  },
  PanelText_UI_Course_Panel_Text_Title_Content = {Text = "Tutorial"},
  PanelText_UI_Dbgcopy_Item_Select_Goods_Text_C_Sellout_Content = {
    Text = "Ausverkauft"
  },
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Achievement_Content = {
    Text = "Level-Erfolge"
  },
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Star_Content = {
    Text = "Sternenbewertung"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Arousal_Sellout_Content = {
    Text = "Ausverkauft"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Curse_Content = {
    Text = "Zwischen den Flüchen"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Sell_Sellout_Content = {
    Text = "Ausverkauft"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Spend_Content = {Text = "Kosten"},
  PanelText_UI_Dbgcopy_Panel_Main_New_Text_C_Count_Content = {
    Text = "Fusionsschwarm"
  },
  PanelText_UI_Dbgcopy_Panel_RelicPreview_Text_Name_Content = {Text = "Zurück"},
  PanelText_UI_Dbgcopy_Panel_RelicStrength_Text_C_Title_Content = {
    Text = "Verstärkungskunst"
  },
  PanelText_UI_Dbgcopy_Panel_Select_Arousal_Text_C_Name_Content = {Text = "Auswahl"},
  PanelText_UI_Dbgcopy_Panel_Select_Extra_Text_C_Name_Content = {Text = "Aufgeben"},
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Display_Content = {
    Text = "Ereignis anzeigen"
  },
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Hide_Content = {
    Text = "Versteckte Ereignisse"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Monster_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Tip_Content = {
    Text = "Bitte Geheimnisträger beachten, dass unterschiedliche Level-Abschnitte unterschiedliche Umweltmerkmale und unterschiedliche Startartefakte mit sich bringen."
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Title_Content = {
    Text = "Levelkapitel-Effektbeschreibung"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Replace_Content = {
    Text = "Charakter wechseln"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_TeamAwaker_Content = {
    Text = "Aktuelle Teamcharaktere"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Title_Content = {
    Text = "Charakterwechsel wählen"
  },
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Suppress_Content = {Text = "Zucht"},
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Title_Content = {
    Text = "D-Wellen-Effekterklärung"
  },
  PanelText_UI_Dbgcopy_Popup_ydbj_yty_01_Text_C_Dcks_Content = {
    Text = "Ermittlung gestartet"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_BtnName_Content = {
    Text = "Training beginnen"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Dungeons_Item_Common_Element_Text_C_Award_Content = {
    Text = "Belohnung +100%"
  },
  PanelText_UI_Dungeons_Item_Common_Tier2_Text_C_Current_Content = {
    Text = "Abgeschlossen"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Extra_Content = {
    Text = "Zusätzlicher Durchgang"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Extra_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Undone_Content = {
    Text = "Herausforderung nicht abgeschlossen"
  },
  PanelText_UI_Dungeons_Item_RailWayRank_Text_C_Null_Content = {
    Text = "Keine Formation vorhanden"
  },
  PanelText_UI_Dungeons_Material_View_Text_C_ActivityAchievement_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_All_Content = {Text = "Alles"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Awaker_Content = {Text = "Einsatz"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_BattleStatistics_Content = {
    Text = "Kampfstatistike"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Damage_Content = {
    Text = "Verursacht Schaden"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Heal_Content = {
    Text = "Verursacht Heilung"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_BattleStatistics_Content = {
    Text = "Keine Daten vorhanden"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_RoundStatistics_Content = {
    Text = "Keine Daten vorhanden"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_RoundStatistics_Content = {
    Text = "Rundenstatistik"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Shield_Content = {
    Text = "Schild erzeugen"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_BattleStatistics_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_RoundStatistics_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Experience_Content = {
    Text = "Tiefseetauchlevel"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Highest_Content = {
    Text = "Wöchentliche Höchstpunktzahl"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Rank_Content = {Text = "Rangliste"},
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Record_Content = {
    Text = "Heutige Leistung"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Store_Content = {
    Text = "Tauschladen"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Title_Content = {
    Text = "Ermittlungsstufentitel"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Diving_Record_Content = {
    Text = "Tiefseerekord"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Main_Title_Content = {
    Text = "Traumtauchen"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Highest_Content = {
    Text = "Wöchentliche Höchstpunktzahl"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record2_Content = {
    Text = "Diese Woche Leistung"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record_Content = {
    Text = "Diese Woche Leistung"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Reward2_Content = {
    Text = "Tiefseerekord"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Store_Content = {
    Text = "Tauschladen"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Title_Content = {
    Text = "Ermittlungsstufentitel"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_illustrate_Content = {
    Text = "Spielregeln"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_list_Content = {
    Text = "Saisonrangliste"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Appraise_Content = {
    Text = "Bewertungsstatistik"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Finish_Content = {
    Text = "Ermittlung erfolgreich"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_High_Content = {
    Text = "Neuer Rekord!"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Remind_Content = {
    Text = "Erhöhe die Fähigkeiten des Erwachten und fordere dann starke Feinde heraus!"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Score_Content = {
    Text = "Gesamtbewertung"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Synthesis_Content = {
    Text = "(=Summe ×3)"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Award_Content = {
    Text = "Abschlussbelohnung"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Highest_Content = {
    Text = "Höchste Aufzeichnung"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Record_Content = {
    Text = "Heutige Leistung"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Reward_Content = {
    Text = "Wöchentliche Prüfungen"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Score_Content = {
    Text = "Wöchentliche Gesamtbewertung"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Store_Content = {
    Text = "Tauschladen"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Title_Content = {
    Text = "Ermittlungstitel"
  },
  PanelText_UI_Dungeons_Panel_Material_Text_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Appraise_Content = {
    Text = "Bewertungsstatistik"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_BattleData_Content = {
    Text = "Ermittlungsdaten"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Finish_Content = {
    Text = "Ermittlung abgeschlossen"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_High_Content = {
    Text = "Neuer Rekord!"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "Abrechnung erhalten"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Integral_Content = {
    Text = "Ermittlungsbewertung"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Limit_Content = {
    Text = "※Gegenstandslimit erreicht"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Score_Content = {
    Text = "Gesamtbewertung"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Statistics_Content = {
    Text = "Kampfstatisik"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Sync_Content = {
    Text = "Wachkörper Affinität erhöhen"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Synthesis_Content = {
    Text = "(=Summe ×3)"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_TeamInfo_Content = {Text = "Team-Info"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval1_Content = {Text = "Intervall"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval2_Content = {
    Text = "Rundenumbruch"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_1_Content = {
    Text = "Chaosdomäne"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_2_Content = {
    Text = "Blutmondturm"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_3_Content = {
    Text = "Abgrund des dunklen Meeres"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_4_Content = {
    Text = "Hyperdimensional Reise"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_1_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_2_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_3_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_4_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Tips_Content = {
    Text = "Lichtloser Austausch"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_illustrate_Content = {
    Text = "Spielregeln"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card2_Content = {
    Text = "（einschließlich Orison）"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card_Content = {
    Text = "Kartenstatistik"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_KeyToken_Content = {Text = "Posse"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Null_Content = {
    Text = "Keine Relikte verfügbar"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_PlayerLevel_Content = {
    Text = "Geheimnisträger-Level"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Relic_Content = {Text = "Relikt"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Reset_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamData_Content = {Text = "Team-Daten"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamProperty_Content = {
    Text = "Team-Attribute"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Team_Content = {
    Text = "Ermittlungsteam"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Uid_Content = {Text = "Hüter-ID:"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Dungeons_Panel_Trinket_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Activity_Awaker_Content = {
    Text = "Vergessenes Kapitel · Begrenzung"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Award_Content = {
    Text = "Belohnung abschließen"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Emoji_Content = {Text = "Emoji"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Introduce_Content = {
    Text = "Fähigkeitsbeschreibung"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_1_Content = {Text = "Abholen"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_Content = {
    Text = "Demo starten"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Normal_Awaker_Content = {Text = "Permanente"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Star_Awaker_Content = {
    Text = "Sternekapitel · Limitiert"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Undone_Content = {
    Text = "Unvollständig"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Wake_Content = {
    Text = "Zum Erwachen"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_ActivityAchievement_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_AwardText_Content = {
    Text = "Wöchentliche Belohnungen verfügbar"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_AwardText_Content = {
    Text = "Wöchentliche Belohnungen verfügbar"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Info_Content = {
    Text = "Hüter-Informationen"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_More_Content = {
    Text = "Details anzeigen"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Rank_Content = {Text = "Rang"},
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Replay_Content = {
    Text = "Wiedergabe der Aufzeichnungen"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Value_Content = {
    Text = "Trainingspunkte"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_Title_Content = {Text = "Rangliste"},
  PanelText_UI_Dungeons_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Dungeons_Popup_Award_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Awaker_Content = {Text = "Einsatz"},
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Damage_Content = {
    Text = "Verursacht Schaden"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Heal_Content = {
    Text = "Verursacht Heilung"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Shield_Content = {
    Text = "Schild erzeugen"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Title_Content = {
    Text = "Kampfstatistik"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_FilterAwaker_Content = {
    Text = "Filter Erwecker"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_No_Records_Content = {
    Text = "Keine Aufzeichnungen zur Untersuchung vorhanden"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Refresh_Content = {Text = "Wechseln"},
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Title_Content = {
    Text = "Abgeschlossenes Protokoll"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_Fliter_Type_Content = {
    Text = "Gesamtrunden"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Award_Content = {
    Text = "Highscore-Rangliste"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Big_Content = {
    Text = "Rangbereich"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Current_Content = {
    Text = "Aktuelle Belohnung"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Empty_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_FilterAwaker_Content = {
    Text = "Wähle Erweckungseinheit"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Grade_Content = {
    Text = "Ermittlungstitel"
  },
  ["PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Haven't_Content"] = {
    Text = "Keine Belohnungen"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Highest_Content = {
    Text = "Höchste Aufzeichnung"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_1_Content = {
    Text = "Hüter-Informationen"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_2_Content = {
    Text = "Ermittlungstitel"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_3_Content = {
    Text = "Höchste Aufzeichnung"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_4_Content = {Text = "Rang"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_5_Content = {Text = "Formation"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_6_Content = {
    Text = "Aufzeichnungen"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Me_Content = {Text = "Mein Rang"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Prompt_Content = {
    Text = "Die Belohnung wird basierend auf dem höchsten Untersuchungsrang in den verschiedenen Reich eingestuft und jeden Montag um 9:00 Uhr per Post gesendet"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward1_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward2_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Ranking_Content = {Text = "Rang"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Reward_Content = {Text = "Belohnung"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season1_Content = {
    Text = "Saisonrangliste"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season2_Content = {
    Text = "Saisonrangliste"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Small_Content = {
    Text = "Kleiner oder gleich"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking1_Content = {
    Text = "Saisonrangliste"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking2_Content = {
    Text = "Saisonrangliste"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Title_Content = {
    Text = "Ermittlungsrangliste"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_illustrate_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Big_Content = {
    Text = "Rangbereich"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_DivingTitle_Content = {
    Text = "Ermittlungstitel"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Exp_Content = {
    Text = "Höchster Fortschritt"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Grade_Content = {
    Text = "Ermittlungstitel"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Info_Content = {
    Text = "Hüter-Informationen"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Nor_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Sel_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Content = {Text = "Rang"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Nor_Content = {
    Text = "Saisonrangliste"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Sel_Content = {
    Text = "Saisonrangliste"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Replay_Content = {
    Text = "Aufzeichnung"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Reward_Content = {Text = "Belohnung"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Round_Content = {Text = "Rundenzahl"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Team_Content = {Text = "Formation"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Title_Content = {
    Text = "Gästeliste"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Big_Content = {
    Text = "Größer als"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Reward_Content = {Text = "Belohnung"},
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Small_Content = {
    Text = "Kleiner oder gleich"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Title_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Dungeons_Popup_Rules_Tip_Text_C_Title_Content = {
    Text = "Spielanleitung"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Award_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_2_Content = {Text = "Resonanz"},
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Title_Content = {
    Text = "Spitzturmfleischtaube"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Award_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Challenge_Content = {
    Text = "Standardmodus"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Daily_Content = {
    Text = "Tägliche Herausforderungen"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Name_Content = {
    Text = "Spitzturm-Fleischtaube"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_NoTask_Content = {
    Text = "Platz ist frei"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_EnergyCost_Content = {
    Text = "Arithmetica"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Extra_Content = {
    Text = "Zusätzlicher Bonus"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_KeeperSkill_Content = {Text = "Keyflare"},
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Manual_Content = {
    Text = "Manueller Kampf"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UltiEnergy_Content = {Text = "Aliemus"},
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UseCard_Content = {
    Text = "Karte spielen"
  },
  PanelText_UI_Dungeons_Trinket_View_Text_C_ActivityAchievement_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Lost_Content = {
    Text = "Nicht erreicht"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title2_Content = {
    Text = "Punkte kumuliert zu"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title_Content = {
    Text = "Sterne in diesem Level erreicht"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Lost_Content = {
    Text = "Nicht erreicht"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Title_Content = {
    Text = "Sternebewertung in diesem Level erreicht"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Null_Content = {
    Text = "Keine Formation vorhanden"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Underway_Content = {
    Text = "Kampfdatenübertragung"
  },
  PanelText_UI_Dungeous_Item_Reward_Text_C_Present_Content = {Text = "Aktuell"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Additional_Content = {
    Text = "Heute zusätzliche Belohnung +50% unbegrenzt"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardNum_Content = {
    Text = "Doppelte Belohnungen heute"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardText_Content = {
    Text = "Wöchentliche Belohnungen verfügbar"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Boundaries_Tips_Content = {
    Text = "Empfohlene Domäne"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Name_Content = {
    Text = "Reproduktion"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Recommend_Content = {
    Text = "Empfohlene Domäne"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_1_Content = {Text = "Chaos"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_2_Content = {Text = "Ultra"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_3_Content = {Text = "Fleisch"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_4_Content = {Text = "Aequor"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Special_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_AwardText_Content = {
    Text = "Wöchentliche Belohnungen verfügbar"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Award_Content = {
    Text = "Details des Feindes"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Boundaries_Tips_Content = {
    Text = "Empfohlene Domäne"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Reward_Content = {
    Text = "Abschlussbelohnung"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Special_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_Title_Content = {
    Text = "Transzendentes Wesen"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Boundaries_Tips_Content = {
    Text = "Empfohlene Domäne"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Difficulty_Content = {Text = "Tauchtiefe"},
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Reward_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Score_Content = {
    Text = "Wöchentliche Höchstpunktzahl"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Special_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_RewardShow_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_StrongAwakers_Content = {
    Text = "Verstärkung Erwecker"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Suppress_Content = {
    Text = "Fusionsschwarm"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Remuneration_Content = {
    Text = "Charakterbelohnung"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Special_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Hint_Content = {
    Text = "*In der Korrosionszone können eingesetzte Erwachte und Schicksalsräder nicht in anderen Zonen eingesetzt werden"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Rank_Content = {Text = "Rangliste"},
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Title_Content = {
    Text = "Fusionskatastrophe Sperrzone"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Train_Content = {
    Text = "Spezialtrainingswert"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly_Content = {
    Text = "Spezialtrainingsbelohnung"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Hint_Content = {
    Text = "*Nach dem Abschluss können die eingesetzten Erwachten, Schicksalsräder und Schlüssel nicht in anderen Korrosionszonen eingesetzt werden"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Title_Content = {
    Text = "Fusionskatastrophe Sperrzone"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Train_Content = {
    Text = "Spezialtrainingswert"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Weekly_Content = {
    Text = "Spezialtrainingsbelohnung"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Extra_Content = {
    Text = "Extra Pass Aufstellung"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Integral_Content = {
    Text = "Abschlusspunkte"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_LineUp_Content = {
    Text = "Teamzusammensetzung zum Räumen"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Monster_Content = {
    Text = "Monstervorschau"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Extra_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_None_Content = {
    Text = "Keine Aufstellungen"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Replay_Content = {
    Text = "Aufzeichnung"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Special_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_Extra_None_Content = {
    Text = "Herausforderung nicht abgeschlossen"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Integral_Content = {
    Text = "Abschluss von Spezialtraining"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_LineUp_Content = {
    Text = "Abschluss von Aufstellung"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Monster_Content = {
    Text = "Monstervorschau"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Name_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_None_Content = {
    Text = "Herausforderung nicht abgeschlossen"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Special_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Suppress_Content = {
    Text = "Fusionsschwarm"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Challenge_Content = {
    Text = "Herausforderung"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Choose_Content = {
    Text = "Schwierigkeitsgrad auswählen"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Experience_Content = {
    Text = "Spezifikationen des Eleganten Zimmers"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Hard_Content = {Text = "Schwierig"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Madness_Content = {Text = "Wahnsinn"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Normal_Content = {Text = "Normal"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Rank_Content = {Text = "Ehrenliste"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Record_Content = {
    Text = "Unterwegs Erinnerungen festhalten"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "Kleine“N“Unterstützung"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Title_Content = {
    Text = "Rasender Freude-Express"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award2_Content = {
    Text = "Rechtsordnung des Bereichs"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award_Content = {
    Text = "Details des Feindes"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Boundaries_Tips_Content = {
    Text = "Empfohlene Domäne"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Cost_Tips_Content = {
    Text = "Teamanforderungen:"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Replay_Content = {
    Text = "Aufzeichnung"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Reward_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Special_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Tishi_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award2_Content = {
    Text = "Geheimgang-Gesetze"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award_Content = {
    Text = "Details des Feindes"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Boundaries_Tips_Content = {
    Text = "Empfohlene Domäne"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Cost_Tips_Content = {
    Text = "Teamanforderungen"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Reward_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Special_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Tishi_Content = {
    Text = "Sternenfortschritt"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Additional_Content = {
    Text = "Heute zusätzliche Belohnung +50% unbegrenzt"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_AwardNum_Content = {
    Text = "Doppelte Belohnungen heute"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Boundaries_Tips_Content = {
    Text = "Empfohlene Domäne"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Cw_Content = {Text = "Ultra"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Hd_Content = {Text = "Chaos"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Recommend_Content = {
    Text = "Empfohlene Domäne"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Sh_Content = {Text = "Aequor"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Special_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Xr_Content = {Text = "Fleisch"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_Name_Content = {
    Text = "Reproduktion"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_1_Content = {
    Text = "Kein Schicksalsrad ausgewählt"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_2_Content = {
    Text = "Klicke links, um auszuwählen"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_Content = {
    Text = "*Ein Erwachter kann nur ein SSR-Schicksalsrad ausrüsten"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "Wähle Schicksalsrad"
  },
  PanelText_UI_Dungeous_Popup_FailTip_Text_C_Title_Content = {
    Text = "Wie kann ich stärker werden?"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "Sternenbelohnungsvorschau"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_En_Content = {
    Text = "Kann erhalten"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Title_Content = {
    Text = "Bewertungsstatistik"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Total_Content = {
    Text = "Aktuelle Gesamtbewertung"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Coin_Content = {
    Text = "Nicht genug Währung"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Explain_Content = {Text = "Regeln"},
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_RewardPreview_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Swept_Content = {
    Text = "Wiederherstellungsanzahl"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Text_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Tips_Content = {
    Text = "Ermittlungsbewertung drei Sterne erreicht, freigeschaltet"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_Title_Content = {
    Text = "Wiederherstellungsbestätigung"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Deplete_Content = {
    Text = "Wiederherstellungskosten"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Swept_Content = {
    Text = "Wiederherstellungsanzahl"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Team_Content = {
    Text = "Ermittlungsteam"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Title_Content = {
    Text = "Wiederherstellungsbestätigung"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Difficulty_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Prohibit_Content = {
    Text = "Schlüsselbefehle in diesem Level deaktiviert"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Skill_Content = {
    Text = "Geheimnisträger-Fähigkeiten"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Title_Content = {
    Text = "Herausforderungsteam"
  },
  PanelText_UI_Dungeous_Popup_Tips_New_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity2_Content = {
    Text = "Erster Durchlauf Belohnung"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity_Content = {
    Text = "Erster Durchlauf Belohnung"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game2_Content = {
    Text = "Kumulative Belohnungen"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game_Content = {
    Text = "Kumulative Belohnungen"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Again_Content = {
    Text = "Herausforderung zurücksetzen"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Boundaries_Tips_Content = {
    Text = "Empfohlene Domäne"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Cw_Content = {Text = "Ultra"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Hd_Content = {Text = "Chaos"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Monster_Content = {
    Text = "Monstervorschau"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Sh_Content = {Text = "Aequor"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Title_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Xr_Content = {Text = "Fleisch"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_illustrate_Content = {
    Text = "Spielregeln"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Again_Content = {
    Text = "Herausforderung zurücksetzen"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Tips_Content = {
    Text = "Belohnungsdetails"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Title_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_illustrate_Content = {
    Text = "Spielregeln"
  },
  PanelText_UI_Dungeous_illustrate_Tip_Text_C_Title_Content = {
    Text = "Lichtloses Reich"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Finish_Content = {
    Text = "Event beendet, Abruf gestoppt"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Full_Content = {
    Text = "Aktuelles Speicherlimit erreicht"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Reward_Content = {
    Text = "Erhalte Materialien"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_SpeedTitle_Content = {
    Text = "Speichergeschwindigkeit:"
  },
  PanelText_UI_Event_Activity_Castor_Text_None_Content = {
    Text = "Keine Materialien verfügbar"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Finish_Content = {
    Text = "Event beendet"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Full_Content = {
    Text = "Der Bestand hat das Maximum erreicht"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_None_Content = {
    Text = "Keine gespendeten Materialien verfügbar"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Reward_Content = {Text = "Inventar"},
  PanelText_UI_Event_Activity_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "Geschwindigkeit:"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Finish_Content = {
    Text = "Event beendet"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Full_Content = {
    Text = "Aktuelles Speicherlimit erreicht"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Reward_Content = {
    Text = "Information speichern"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_SpeedTitle_Content = {
    Text = "Speichergeschwindigkeit"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Finish_Content = {
    Text = "Event beendet, Abruf gestoppt"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Full_Content = {
    Text = "Aktuelles Speicherlimit erreicht"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Reward_Content = {
    Text = "Erhalte Materialien"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_SpeedTitle_Content = {
    Text = "Speichergeschwindigkeit:"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_None_Content = {
    Text = "Keine Materialien verfügbar"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Label_Content = {
    Text = "Mrs. Greys kleiner Laden"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Mail_Content = {Text = "Regeln"},
  PanelText_UI_Event_Activity_Main_Text_C_Title_Content = {
    Text = "Bazar der Kirche"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Finish_Content = {
    Text = "Event beendet, Abruf gestoppt"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Full_Content = {
    Text = "Aktuelles Speicherlimit erreicht"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Reward_Content = {
    Text = "Erhalte Materialien"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_SpeedTitle_Content = {
    Text = "Geschwindigkeit abrufen"
  },
  PanelText_UI_Event_Activity_Miriam_Text_None_Content = {
    Text = "Keine Materialien verfügbar"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Finish_Content = {
    Text = "Event beendet, Abruf gestoppt"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Full_Content = {
    Text = "Aktuelles Speicherlimit erreicht"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Reward_Content = {
    Text = "Erhalte Materialien"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_SpeedTitle_Content = {
    Text = "Speichergeschwindigkeit:"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_None_Content = {
    Text = "Keine Materialien verfügbar"
  },
  PanelText_UI_Event_Activity_Pollux_Text_None_Content = {
    Text = "Keine Materialien verfügbar"
  },
  PanelText_UI_Event_Activity_RewardList_Text_C_Reward_Content = {
    Text = "Verkaufsliste"
  },
  PanelText_UI_Event_Activity_RewardPool_Text_C_Name_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Event_Activity_RewardPool_Text_Name_Content = {
    Text = "Alles tauschen"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Close_Content = {
    Text = "Klicke auf den leeren Bereich, um zurückzukehren"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_CoreReward_Content = {
    Text = "Besondere Saat"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Result_Content = {
    Text = "Austauschresultate"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_C_Desc_Content = {
    Text = "Meister, wirst du Karen heute auch beim Aufräumen helfen? Das ist wirklich großartig! Dies ist eine kleine Geste von Karen – bitte nimm sie unbedingt an!"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_1_Content = {Text = "Abgeholt"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_2_Content = {Text = "Abgeholt"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_3_Content = {Text = "Abgeholt"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_4_Content = {Text = "Abgeholt"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_5_Content = {Text = "Abgeholt"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_6_Content = {Text = "Abgeholt"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_7_Content = {Text = "Abgeholt"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Title_Content = {
    Text = "Karens Dankesgabe"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_C_Desc_Content = {
    Text = "Sonnenschein, Sandstrand, Meereswellen und unzählige lächelnde Gesichter – erlebe im sommerlichen Traum ein aufregendes Volleyball-Match!"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_Title_Content = {
    Text = "Sommerlanges Fest"
  },
  PanelText_UI_Event_Activity_SummonBenefits_Text_C_Summon_Content = {
    Text = "Kostenlose Beschwörung"
  },
  PanelText_UI_Event_Activity_Thing_Item_Text_C_Sold_Out_Content = {
    Text = "Bereits ausverkauft"
  },
  PanelText_UI_Event_Activity_Thing_Item_Text_C_Special_Tips_Content = {Text = "Spezial"},
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Finish_Content = {
    Text = "Event beendet, Speicherung gestoppt"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Full_Content = {
    Text = "Speichermaterial erreicht das Limit"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Reward_Content = {
    Text = "Speichermaterial"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_SpeedTitle_Content = {
    Text = "Speichergeschwindigkeit:"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "Rand-Speicher"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_Name_Content = {Text = "Abholen"},
  PanelText_UI_Event_Activity_TwentyFour_Text_None_Content = {
    Text = "Keine Materialien verfügbar"
  },
  PanelText_UI_Event_Activity_XiaomaoGift_Text_C_Receive_Content = {
    Text = "Verbleibende Weckversuche:"
  },
  PanelText_UI_Event_Challenge_Item_Text_C_Finish_Content = {
    Text = "Letzter Durchgang"
  },
  PanelText_UI_Event_Item_Return_Text_C_Close_Content = {
    Text = "Klicke auf den Bildschirm, um zu schließen"
  },
  PanelText_UI_Event_Item_Return_Text_C_Finish_Content = {Text = "Abgeholt"},
  PanelText_UI_Event_Item_SignDay_Text_C_CanReceive_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Event_Item_SignDay_Text_C_Got_Content = {Text = "Abgeholt"},
  PanelText_UI_Event_Item_SignDay_Text_C_Nor_Content = {Text = "Abzuholen"},
  PanelText_UI_Event_Item_WeaponOptional_Text_C_Got_Content = {Text = "Besitzt"},
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Title_Content = {
    Text = "Bereich der Kirche"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Introduction_Content = {
    Text = "Pssst... Tief durchatmen, entspanne deine Tentakel. Jetzt wirst du in das Bewusstsein von \"24\" eintauchen und geheime Erinnerungen erforschen"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "Erinnerungscode"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Awaker_Content = {
    Text = "Testversion Erwacker"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_FristCreation_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Leader_Content = {
    Text = "Boss-Vorschau"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Record_Content = {
    Text = "Herausforderung"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_StarTitle_Content = {Text = "Sternziel"},
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Title_Content = {
    Text = "Drehbuchverwirrung"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Creation_Content = {
    Text = "Level-Schöpfungen"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Double_Content = {
    Text = "Doppelte Herausforderung"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_FristCreation_Content = {
    Text = "Anfangs Schöpfung"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Leader_Content = {
    Text = "Boss-Vorschau<WordSize20:>"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_MeltErosion_Content = {
    Text = "Fusionsschwarm"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Monster_Content = {
    Text = "Monstervorschau"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Record_Content = {
    Text = "Herausforderung"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_RemainNum_Content = {
    Text = "Verbleibende Anzahl der Klone"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Replay_Content = {
    Text = "Aufzeichnung"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Event_Panel_Challenge_Text_C_RewardTitle_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_SweepName_Content = {
    Text = "Durchkämmen"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Title_Content = {
    Text = "Drehbuchverwirrung"
  },
  PanelText_UI_Event_Panel_Challenge_Text_Career_Content = {
    Text = "Reich erfordern 1"
  },
  PanelText_UI_Event_RewardGroup_Text_C_Reset_Content = {
    Text = "Verbleibende Rücksetzversuche:"
  },
  PanelText_UI_Event_Reward_Item_Text_C_Not_Content = {
    Text = "Unvollständig"
  },
  PanelText_UI_Event_Reward_Item_Text_C_Receive_Content = {Text = "Abholen"},
  PanelText_UI_Event_Task_Item_Text_C_Not_Content = {
    Text = "Nicht erreicht"
  },
  PanelText_UI_Event_Task_Item_Text_C_Receive_Content = {Text = "Abholen"},
  PanelText_UI_Event_WeaponOptional_Text_C_Receive_Content = {
    Text = "Verbleibende Weckversuche:"
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Introduction_Content = {
    Text = "Komm, lass uns mit Wahnsinn, Mord und Schmerz die Noten für das Blitz-Requiem zwischen den Sternen spielen. \n Das törichte, chaotische höchste Wesen sollte nicht erwachen, weder jetzt noch in der Zukunft."
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Title_Content = {
    Text = "Requiem der Sternen"
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Introduction_Content = {
    Text = "Das, was die Gottheit versprach, ist nun nahe. \n Tausende von Jahren des Wartens stehen vor einem freudigen Ende, das verheißene Land wird aus dem Meer emporsteigen. \n Die Gottheit wird aus der Brust der Göttlichen Mutter wiedergeboren, wenn die sieben Tage enden, wird eine neue Welt erscheinen."
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Title_Content = {
    Text = "Schöpfung sieben Tage"
  },
  PanelText_UI_Events_Item_Castor_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Castor_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_Free_Content = {Text = "Kostenlos"},
  PanelText_UI_Events_Item_GiftBag_Text_C_High_Content = {Text = "Kostenlos"},
  PanelText_UI_Events_Item_GiftBag_Text_C_Noraml_Content = {Text = "Abholen"},
  PanelText_UI_Events_Item_GiftBag_Text_C_Soldout_Content = {Text = "Abgeholt"},
  PanelText_UI_Events_Item_Hamline_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Hamline_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Killed_Content = {
    Text = "Tötungs-Confirmed!"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Progress_Content = {
    Text = "Aber herausfordernd"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Full_Content = {
    Text = "Erleuchten voll"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Have_Content = {Text = "Besitzt"},
  PanelText_UI_Events_Item_OriDoll_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_OriDoll_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_PreOrderGift_Text_C_Lock_Content = {
    Text = "Nach dem Kauf abholbar"
  },
  PanelText_UI_Events_Item_RAIDProgressGroup_Text_C_Kill_Content = {
    Text = "Fänge insgesamt"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Career_Content = {
    Text = "Teamanforderungen"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Finish_Content = {Text = "Beendet"},
  PanelText_UI_Events_Item_RAID_Text_C_Kill_Content = {Text = "Gefangen"},
  PanelText_UI_Events_Item_RAID_Text_CareerLimit_Content = {Text = "Unbegrenzt"},
  PanelText_UI_Events_Item_RAID_Text_Lock_Content = {
    Text = "Noch nicht verfügbar"
  },
  PanelText_UI_Events_Item_Rome_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Rome_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_SignDiamond_Text_C_Receive_Content = {Text = "Abgeholt"},
  PanelText_UI_Events_Item_Sorel_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Sorel_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Stage_Text_C_Undone_Content = {
    Text = "Unvollständig"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_NormalTip_Content = {
    Text = "Durchschnittliche Schwierigkeit steht zum Abschluss"
  },
  PanelText_UI_Events_Item_SurveyDiary_Text_Name_Content = {Text = "Abholen"},
  PanelText_UI_Events_Item_Tab_Text_C_Return_Content = {
    Text = "Rückkehr-Event"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Career_Content = {
    Text = "Teamanforderungen"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Finish_Content = {Text = "Beendet"},
  PanelText_UI_Events_Item_TeamSchool_Text_CareerLimit_Content = {Text = "Unbegrenzt"},
  PanelText_UI_Events_Item_Tulu_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Tulu_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_LockTips_Content = {
    Text = "Nach Abschluss der Vorstufen des Einsatzprotokolls freischalten"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Killed_Content = {Text = "Zerstört!"},
  PanelText_UI_Events_Item_WorldBoss_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Progress_Content = {
    Text = "Verbleibende Anzahl der Klone"
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "Wirf deinen Körper fort, wirf deine Vernunft fort, in dieser reinen Willenswelt spüre Seine Existenz. \n Er ist dein Ein und Alles."
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Title_Content = {
    Text = "Bleak Meerestide"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Introduction_Content = {
    Text = "Mund weit aufreißen, kräftig zubeißen.\nFressen oder gefressen werden, das ist das Gesetz des Kampfes, das Schicksal der Bestien"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Title_Content = {
    Text = "Wildes Streben"
  },
  PanelText_UI_Events_OriHelot_Text_C_Fall_Content = {
    Text = "Beutevorschau"
  },
  PanelText_UI_Events_OriHelot_Text_C_LockTips_Content = {
    Text = "Level Freischaltungshinweis"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_Challenge_Content = {
    Text = "Requiem der Sternen"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_ProgressTitle_Content = {
    Text = "Welt Tötungsfortschritt"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Ordinary_Content = {
    Text = "Normale Reise"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_PassportUp_Content = {
    Text = "Reiseaufstieg"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Senior_Content = {
    Text = "Fortgeschrittene Chronik"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_illustrate_Content = {
    Text = "Aktionsbeschreibung"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_PayTip_Content = {
    Text = "Der aktuelle angezeigte Preis entspricht dem Standardwährungspreis und dient nur zu Informationszwecken. Bei der Zahlung gelten die tatsächliche Währung und der tatsächliche Preis."
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Introduction_Content = {
    Text = "Die Scheinwerfer flammen auf. Der Applaus verklingt. Das Publikum wartet voller Vorfreude.\nEs ist Zeit, die Bühne zu betreten, meine lieben Kinder. Geht hinaus — spielt, reißt eure Seelen auf und verkauft eure tiefsten Geheimnisse. Nehmt eure verheerendsten Wunden und formt sie zu Süßigkeiten für das Vergnügen des Publikums. Badet gierig in jenem einzelnen Lichtstrahl, der nur für euch leuchtet, bis der Vorhang fällt und euch und euer Publikum gleichermaßen begräbt.\n\nDies ist die Bühne, für die ihr bestimmt seid — erhebt euch! Habt keine Angst; Lampenfieber ist nicht nötig."
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Title_Content = {
    Text = "Bühne der Puppe"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Challenge_Content = {
    Text = "Bühne der Puppe"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Shop_Content = {
    Text = "Theater-Geschenkeladen"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Topic_Content = {
    Text = "Selbstfesselung des Webers"
  },
  PanelText_UI_Events_Panel_Attendance_Text_C_GiftTitle_Content = {
    Text = "Aufgabe abschließen und Phantasma-Robe-Tauschcoupon erhalten"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_1_Content = {
    Text = "Traumtauchen"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_2_Content = {
    Text = "Phasenduell"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_Content = {
    Text = "Traumtauchen"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Over_Content = {
    Text = "Die Erfahrungen des Hüters wurden heute erlangt:"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Title_Content = {
    Text = "Die Erfahrungen des Hüters wurden heute erlangt:"
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Not_Unlocked_Content = {
    Text = "Noch nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Shop_Content = {
    Text = "Rückkehr-Schule-Laden"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Challenge_Content = {
    Text = "Pfad der Heiligen Halle"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Speichergrenze:"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Finish_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Fundraising_Content = {
    Text = "Wohlwollen der Bürger"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Not_unlocked_Content = {
    Text = "<Gray:Nicht freigeschaltet>"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Pv_Content = {Text = "Erinnerung"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Record_Content = {Text = "Blutfarbe"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Resonance_Content = {
    Text = "Resonanz: Seelenspalte"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Shop_Content = {
    Text = "Bazar der Kirche"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Topic_Content = {
    Text = "Hirte der Seelen·Replik"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Award_Content = {
    Text = "Zeitlich begrenzte Belohnung"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Limit_Content = {
    Text = "Ermittlungsbelohnung"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Over_Content = {
    Text = "Alle Belohnungen abgeholt"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Pass_Content = {
    Text = "Abschlussbelohnung"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Title_Content = {
    Text = "Belohnungsvorschau"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Introduction_Content = {
    Text = "♪~~♫~~♪~~♫~~♪~~♫~~\nUnterhalb des Schneebergs erinnert sich jeder Führer daran, und jedes Kind singt es noch immer. Sie ist der Wille des ragenden Berges in Fleisch gehüllt, sie ist die gnädige Göttin Umapati. Ihre göttliche Macht liegt verstreut in der Sterblichenwelt; ihre Schätze sind nicht zu finden. Sie sind nah genug zum Berühren; sie hinterlassen keine Spur. \nGib etwas auf. Halte an etwas fest. Wer der wahren Gestalt der Göttin gegenüber ein falsches Herz trägt, wird für immer im Schneegebirge begraben, gemeinsam mit dem Berg, der starb."
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Title_Content = {
    Text = "Umapatis Schätze"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Challenge_Content = {
    Text = "Umapatis Schätze"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Record_Content = {
    Text = "Sonderoperation"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Shop_Content = {
    Text = "Rituale der Fee"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Topic_Content = {
    Text = "Neumond und tiefer Schnee"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Introduction_Content = {
    Text = "Das Leben eines Vogels ist zweifellos ein Leben in Freiheit. Du solltest sehen, wie es aus dem Ei schlüpft und die Freiheit des Lebens aus den Händen des Todes zurückgewinnt. Du solltest sehen, wie es das Fliegen lernt und die Freiheit des eigenständigen Überlebens aus dem behaglichen Nest zurückerobert. Wenn du nun den Schlüssel zur Freiheit in den Abgrund des Todes wirfst, wird es zweifellos ohne zu zögern herunterspringen und in der engen Existenz und der unendlichen Freiheit den Tod als Sturm direkt ins Auge sehen."
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Title_Content = {
    Text = "Flug durch den blauen Himmel"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Challenge_Content = {
    Text = "Flug durch den blauen Himmel"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Castor_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Record_Content = {
    Text = "Abweichende Traumwelt"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Shop_Content = {
    Text = "Wissensdurst"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Topic_Content = {
    Text = "Spiegelnder Gefangener"
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Introduction_Content = {
    Text = "Seitdem vergoss sie keine einzige Träne mehr. \n Alleine trieb sie umher, wanderte durch eine Welt voller Fremdartigkeit. \n Ein großartiger Plan stand kurz vor seinem Beginn – als ihr letzter Abschiedsgruß. \n Sie war die erfolgreichste Psychiaterin – dies war ihre erfolgreichste Therapie."
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Title_Content = {
    Text = "Angst-Heilung"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Challenge_Content = {
    Text = "Angst-Heilung"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Clementine_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Record_Content = {
    Text = "Bewusstseinsdrift"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Resonance_Content = {
    Text = "Resonanz: Keine"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Shop_Content = {
    Text = "Neurodiagnosezimmer"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Topic_Content = {
    Text = "Verborgen unter der Erinnerung"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Empty_Content = {
    Text = "Alle Belohnungen erhalten"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Lottery_Content = {
    Text = "Einmal ziehen"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Rate_Content = {
    Text = "Wahrscheinlichkeitsbeschreibung"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Tip_Content = {
    Text = "<color=#e3c96e>Phantasma-Robe des Silbernen Zentrums</color> kann ab der <color=#e3c96e>5.</color> Ziehung mit einer Chance erhalten werden"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Topic_Content = {
    Text = "Hirte der Seelen"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_Free_Content = {Text = "Kostenlos"},
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Introduction_Content = {
    Text = "In diesem Küstenstädtchen gibt es eine belebte Einkaufsstraße. Der Seehandel hat hier zahlreiche moderne Waren zusammengebracht, und solange du genug Leonian Florin zahlst, wirst du immer mit zufriedenstellenden Produkten belohnt. \n Nur ein kleines Geschäft an der Straßenecke bildet eine Ausnahme; es ist ein Laden voller magischer Antiquitäten, in dem die Besitzerin mit dem breiten Hut dir langsam ein Lächeln schenkt, während der Rauch aus ihrer Pfeife aufsteigt. \n „Willkommen im Sorgenladen, hier werden all Ihre Bedürfnisse erfüllt, solange Sie eine angemessene Belohnung zahlen...“ \n „Natürlich, natürlich, die Preise sind fair, wir betrügen niemanden.“"
  },
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Title_Content = {Text = "Hexenladen"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Challenge_Content = {Text = "Hexenladen"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Shop_Content = {
    Text = "Hexen-Schatzkammer"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Topic_Content = {
    Text = "Regenstadt Schatten"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Introduction_Content = {
    Text = "Die Saitenmusik ist bereits zum Zenit gestiegen, der dreizehnte Glockenschlag hat bereits ertönt.\nHeute Nacht wird das Essmesser des Dichters für uns rezitieren.\nHeute Nacht wird die Kehle der Mutter uns in ihren Schoß nehmen."
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Title_Content = {
    Text = "Seelenfestmahl"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Challenge_Content = {
    Text = "Seelenfestmahl"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Doresain_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Record_Content = {
    Text = "Einsatzprotokoll"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Shop_Content = {
    Text = "Restaurant des Königspalasts"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Topic_Content = {
    Text = "Nekrotische Ästhetik"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Ordinary_Content = {
    Text = "Normale Reise"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_PassportUp_Content = {
    Text = "Reiseaufstieg"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Senior_Content = {
    Text = "Fortgeschrittene Chronik"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_illustrate_Content = {
    Text = "Aktionsbeschreibung"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Introduction_Content = {
    Text = "Donnerklang, ertönt an der Spitze seines Stabs.\nTauche in den langen Traum ein, bis zum letzten Akt der Zerstörung"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Title_Content = {
    Text = "Donnergrollen"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Challenge_Content = {
    Text = "Donnergrollen"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Hamline_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Resonance_Content = {
    Text = "Resonanz: Keine"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Shop_Content = {
    Text = "Schlafender Palast"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Topic_Content = {
    Text = "unsichtbare Symphonie"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Introduction_Content = {
    Text = "Im verfallenen Gewächshaus ist eine einsame Rose gefangen"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Title_Content = {
    Text = "Garten der Erinnerungen"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Challenge_Content = {
    Text = "Garten der Erinnerungen"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Horla_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Resonance_Content = {
    Text = "Resonanz: Garten-Elegie"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Shop_Content = {
    Text = "Kolettes Blumenhaus"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Topic_Content = {
    Text = "Bevor der Frühling verwelkt"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Reward_Content = {
    Text = "Staubentfernungszulage"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Sign_Content = {
    Text = "Karens Dankesgabe"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Task_Content = {
    Text = "Reinigungsstand"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Topic_Content = {
    Text = "Wunderbare Reinigungsreise"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Introduction_Content = {
    Text = [[
Sie steht erneut auf der Erde, und die Rache, die alles verbrennt, kommt wie erwartet. 

Das ist die rastlose Jagd, das ist das lodernde Feuer des Herrn der explodierenden Flammen. 

Sie wird jeden Winkel durchstreifen und alle jagen, die einen Pakt mit dem Tod geschlossen haben. 

Flieh, flieh, flieh in die tiefere Dunkelheit, flieh an einen Ort, von dem du denkst, dass du nicht gefunden wirst. 

Obwohl das sinnlos ist, denn Er wird durch jede Welt schreiten. 

Er wird alles jagen, bis alles zu Asche verbrannt ist.]]
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Title_Content = {Text = "Aschejagd"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Challenge_Content = {Text = "Aschejagd"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Speichergrenze:"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Record_Content = {
    Text = "Bewusstseinsdrift"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Shop_Content = {
    Text = "Versteckte Basis"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Topic_Content = {
    Text = "Tausende strahlende Lichter fallen"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Describe_Content = {
    Text = "Du siehst nicht nur die Wahl der Seele, sondern auch ihr schwankendes Leben"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Lake_City_Text_C_Title_Content = {
    Text = "Pfad der Heiligen Halle"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_illustrate_Content = {
    Text = "Spielregeln"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Introduction_Content = {
    Text = "Die Aufgaben, die Puppe zuweist, sind nie einfach.\nAuch wenn sie die Leute mehrmals daran erinnerte, „Spaß zu haben“, wie kann ein Hüter nicht nervös sein, wenn er zum ersten Mal mit einer Gruppe von Erweckern aufbricht?\nAber denk daran, „Spaß zu haben“"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Title_Content = {
    Text = "Drehbuchverwirrung"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Challenge_Content = {
    Text = "Drehbuchverwirrung"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Pv_Content = {
    Text = "Bild abspielen"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Resonance_Content = {
    Text = "Resonanz: Regisseur-Code"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Shop_Content = {
    Text = "Magischer Skriptladen"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Topic_Content = {
    Text = "Die Magie der Geschichten · Replikation"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Introduction_Content = {
    Text = "Stärke, Macht, Reichtum, Freiheit... Auf Leviathans Land wird Es dir alles gewähren, wonach du dich sehnst.\nVorausgesetzt natürlich, dass du der Letzte bist, der noch steht."
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Title_Content = {
    Text = "Gier und Blutdurst"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Challenge_Content = {
    Text = "Gier und Blutdurst"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Record_Content = {
    Text = "Bewusstseinsdrift"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Shop_Content = {
    Text = "Arena-Altar"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Topic_Content = {
    Text = "Leviathans Spiel"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Challenge_Content = {
    Text = "Drehbuchverwirrung"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Desc_Content = {
    Text = "Die Aufgaben, die Puppe zuweist, sind nie einfach.\nAuch wenn sie die Leute mehrmals daran erinnerte, „Spaß zu haben“, wie kann ein Hüter nicht nervös sein, wenn er zum ersten Mal mit einer Gruppe von Erweckern aufbricht?\nAber denk daran, „Spaß zu haben“"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Own_Content = {Text = "Besitz"},
  PanelText_UI_Events_Panel_MagicStory_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Resonance_Content = {
    Text = "Resonanz: Regisseur-Code"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Shop_Content = {
    Text = "Magischer Skriptladen"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Topic_Content = {
    Text = "Die Magie der Geschichte"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentActivity_Content = {Text = "Arcade"},
  PanelText_UI_Events_Panel_Main_Text_C_PermanentRule_Content = {Text = "Arcade"},
  PanelText_UI_Events_Panel_Main_Text_C_Pv_Content = {
    Text = "Bild abspielen"
  },
  PanelText_UI_Events_Panel_Main_Text_C_SevenDays_Content = {
    Text = "Sieben-Tage-Check-in"
  },
  PanelText_UI_Events_Panel_Main_Text_C_illustrate_Content = {
    Text = "Aktionsbeschreibung"
  },
  PanelText_UI_Events_Panel_Main_Text_Title_Content = {Text = "Event"},
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Introduction_Content = {
    Text = "Betritt diesen schwierigen und heiligen Weg. Am Ende wird sich die letzte Tür für dich öffnen"
  },
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Title_Content = {
    Text = "Göttliches Reich erscheint"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Challenge_Content = {
    Text = "Göttliches Reich erscheint"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Miriam_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Record_Content = {
    Text = "Abweichende Traumwelt"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Resonance_Content = {
    Text = "Resonanz: Tiefsee-Ritual"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Shop_Content = {
    Text = "Antwort des Abgrunds"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Topic_Content = {
    Text = "Tieftauchritual"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Introduction_Content = {
    Text = "Himmel~klar~Meer~ruhig~\nMosk~Freund~Kohleball~setze die Segel!\nSturm, keine Angst, Blitz, keine Angst, Mosk, Freund, Kohleball~\nFür die Freiheit, auf·brechen"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Title_Content = {
    Text = "Mosk und Meer"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Challenge_Content = {
    Text = "Mosk und Meer"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Record_Content = {Text = "Sucht"},
  PanelText_UI_Events_Panel_Mosk_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Shop_Content = {
    Text = "Mosk's Schatzkammer"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Topic_Content = {
    Text = "Ruf von Mosk"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Introduction_Content = {
    Text = "Eines Tages bemerkst du plötzlich, dass du anders geworden bist. \n Niemand bemerkt dies, denn du zeigst weiterhin dasselbe Verhalten und hast dasselbe schöne Aussehen. \n Aber du weißt sehr gut, dass das einst strahlend rote Herz jetzt von einer Maske aus Nebel bedeckt ist. \n \"Wenn ich weiter so tun kann, bin ich dann immer noch derselbe wie früher?\" \n Glücklicherweise bleibt diese Frage nicht länger als eine Sekunde in deinem Kopf; schließlich weiß vor dem Abnehmen der Maske niemand, was du wirklich denkst. \n \"Dann lass uns aufbrechen~\""
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Title_Content = {
    Text = "Verlorenes Selbst"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Challenge_Content = {
    Text = "Verlorenes Selbst"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Record_Content = {
    Text = "Multidimensionale Verbindung"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Shop_Content = {
    Text = "Mouchetters Hütte"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Topic_Content = {
    Text = "Opfer des Nebelreichs"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Introduction_Content = {
    Text = "Aus Seiner @1 Dunkelheit @2 erstrahlt der große @3, das Welt verfügt"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Title_Content = {
    Text = "Dunkle Gebärmutter"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Challenge_Content = {
    Text = "Dunkle Gebärmutter"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Homology_Content = {
    Text = "Aktivitätszeitraum verdoppelt die Erhöhung der Affinität durch alle Methoden!"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Pv_Content = {
    Text = "Bild abspielen"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Record_Content = {Text = "Rosenhymne"},
  PanelText_UI_Events_Panel_Murphy_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Shop_Content = {
    Text = "Heilige Eizelle ausbrüten"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Topic_Content = {
    Text = "Sterne in der richtigen Position · Nachbildung"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Challenge_Content = {
    Text = "Bleak Meerestide"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_GiftTitle_Content = {
    Text = "Aufgabe abschließen und Phantasma-Robe-Tauschcoupon erhalten"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_ProgressTitle_Content = {
    Text = "Fremdartige Gezeiten-Tötungsfortschritt"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Topic_Content = {
    Text = "Göttliches Reich auftaucht"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Introduction_Content = {
    Text = "Sie betrachtete die große Tür am Ende der Welt und trat ohne zu zögern einen Schritt vor. \n Klick, sie drehte den Türgriff und konnte es kaum erwarten, hinter die Tür zu schauen. \n Doch hinter der Tür war nichts, sie trat ins Leere und fiel in die Nichtigkeit. \n Sie hätte wissen müssen, dass ein Geschenk, das zu direkt kommt, immer einen hohen Preis hat."
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Title_Content = {
    Text = "Tor der Leere"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Challenge_Content = {
    Text = "Tor der Leere"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_OriDoll_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Record_Content = {
    Text = "Bewusstseinsdrift"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Resonance_Content = {
    Text = "Resonanz: Keine"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Shop_Content = {
    Text = "Lehren des Meisters"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Topic_Content = {
    Text = "Halbschritt entfernt"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Challenge_Content = {
    Text = "Wildes Streben"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_OriHelot_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Shop_Content = {
    Text = "Riesenmaul des Berges"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Topic_Content = {
    Text = "Wenn der Schneeberg schmilzt·Replik"
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Introduction_Content = {
    Text = "Das, was der Gott versprochen hat, ist nahe. \n Tausende von Jahren des Wartens werden zu einem freudigen Ende führen, das verheißene Land wird aus dem Meer emporsteigen. \n Der Gott wird aus dem Brustkorb der Göttlichen Mutter wiedergeboren, am Ende der sieben Tage wird die neue Welt erscheinen."
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Title_Content = {
    Text = "Schöpfung sieben Tage"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Challenge_Content = {
    Text = "Schöpfung sieben Tage"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Shop_Content = {
    Text = "Göttermutter-Schlafgemach"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Topic_Content = {
    Text = "Opferritual der Göttlichen Geburt"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_ChallengeTip_Content = {
    Text = "Zeitlich begrenzte Event-Zusammenarbeit"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Challenge_Content = {
    Text = "Phasenduell"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Record_Content = {
    Text = "Ich bin dran"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Shop_Content = {Text = "Ladenname"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Topic_Content = {
    Text = "Regenstadt Schatten"
  },
  PanelText_UI_Events_Panel_PermanentActivity_Text_C_Reward_Content = {
    Text = "Verbleibende Belohnungen"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Introduction_Content = {
    Text = "Zwischen Vernunft und Absturz entfaltet sich das täuschende Gemälde langsam. \n Die Trugbilder, die du verachtest, malen prächtige Farben, \n die Kontrollverluste, die du fürchtest, bilden die Form der Loyalität. \n Hier ist Wahnsinn das Instinkt der Kunst, die Quelle der Welt, \n die einzige Wahrheit, die nicht lügen kann."
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Title_Content = {
    Text = "Vorübergehender Text"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Challenge_Content = {
    Text = "Vorübergehender Text"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Record_Content = {
    Text = "Bewusstseinsdrift"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Shop_Content = {
    Text = "Pickmans Atelier"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Topic_Content = {
    Text = "Vorübergehender Text"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Introduction_Content = {
    Text = "Die Liebe und der Hass, die Zärtlichkeit und der Schmerz, das, was wir hatten, und das, was wir verpasst haben, sind längst untrennbar verwoben. \n Lass unser gemeinsames Blut fließen, es wird sich an einem Ort vereinen und unser untrennbares Schicksal bilden."
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Title_Content = {
    Text = "Verschmelzendes Schmerzblut"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Challenge_Content = {
    Text = "Tor der Leere"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Record_Content = {
    Text = "Einsatzprotokoll"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Shop_Content = {Text = "Laden"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Topic_Content = {
    Text = "Die Nacht der Mitternachtssonne"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Introduction_Content = {
    Text = "Als das unheilvolle weiße Licht erneut durch die Fenster des Hohen Hauses dringt, hat er Dich bereits eingeladen.\nUmfassen, verschlucken, mitreißen, drängen... \nAntworte dem Ruf aus den Tiefen des Ozeans, schließe Dich der rastlosen Jagd an – Deine Vergangenheit, Dein Selbst, all das ist längst bedeutungslos."
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Title_Content = {
    Text = "Die Jagd des Hohen Hauses"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Challenge_Content = {
    Text = "Die Jagd des Hohen Hauses"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Record_Content = {
    Text = "Bewusstseinsdrift"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Shop_Content = {
    Text = "Jagdgründe"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Topic_Content = {
    Text = "Ebwynnos Evermore"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Challenge_Content = {
    Text = "Flut der Silberpfoten"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Rank_Content = {
    Text = "Fang-Ranglisten"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Reward_Content = {
    Text = "Schwarze Katze – Fangprotokoll"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Topic_Content = {
    Text = "Miauzi Verpflichtet!"
  },
  PanelText_UI_Events_Panel_RailWay_StageGroup_Text_C_Title_Content = {
    Text = "Der Zug bricht auf"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Challenge_Content = {
    Text = "Der Zug bricht auf"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Rank_Content = {
    Text = "Gästeliste"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "Kleine“N“Unterstützung"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Reward_Content = {
    Text = "Spur der Schienenlänge"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Topic_Content = {
    Text = "Rasender Freude-Express"
  },
  PanelText_UI_Events_Panel_Reward_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Events_Panel_Reward_Text_Title_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Introduction_Content = {
    Text = "Wir sind Fleischfresser, wir sind die Nachkommen der Wölfe. Die köstlichen, blutenden Fleischstücke werden schließlich in unsere Mägen gelangen."
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Title_Content = {
    Text = "Heilige Jagd"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Challenge_Content = {
    Text = "Heilige Jagd"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Rome_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Record_Content = {
    Text = "Abweichende Traumwelt"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Shop_Content = {
    Text = "Tribut darbieten"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Topic_Content = {
    Text = "Rom! Spezialaktion"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Introduction_Content = {
    Text = "Stimmt, heutzutage sind gewöhnliche Detektive nicht mehr in Mode. \nWenn du weder fliegen noch einen Wissenschaftler als Assistenten hast, überdenke deine Karriereplanung"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Title_Content = {
    Text = "Mondnachtlegende"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Challenge_Content = {
    Text = "Mondnachtlegende"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Homology_Content = {
    Text = "Aktivitätszeitraum verdoppelt die Erhöhung der Affinität durch alle Methoden!"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Pv_Content = {
    Text = "Bild abspielen"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Record_Content = {
    Text = "Jagdglück!"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Shop_Content = {
    Text = "Glücksklub"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Topic_Content = {
    Text = "Handbuch des Meisterdetektivs·Replik"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Introduction_Content = {
    Text = "Wissenschaft — irrelevant.\n\nEthik — irrelevant.\n\nMoral — irrelevant.\n\nLeben, Tod, Hoffnung, Verzweiflung... Am Ende aller Enden enthält ein Notizbuch im Keller dieselbe Schlussfolgerung, geschrieben von zwei verschiedenen Händen.\n\nUnd Sie sagten: „Sieh — Liebe ist das einzige Thema. Das ewige.\""
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Title_Content = {
    Text = "Notizen im Dunkelraum"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Challenge_Content = {
    Text = "Notizen im Dunkelraum"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Record_Content = {
    Text = "vergessene Liebe Samen"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Shop_Content = {
    Text = "Löwenzahn Garten"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Topic_Content = {
    Text = "Umgekehrtes Neugeboren"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Introduction_Content = {
    Text = "Jahre später klopfte eine Biografin an einem Abend an ihre Tür.\nSie sprachen viel, von Achaten bis hin zu dem verfallenden Rosensitz...\nNun hat die Schriftstellerin diese Fragmente zu einem Buch zusammengestellt und es euch präsentiert"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Title_Content = {
    Text = "Rosen-Erinnerungen"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Challenge_Content = {
    Text = "Rosen-Erinnerungen"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Homology_Content = {
    Text = "Aktivitätszeitraum verdoppelt die Erhöhung der Affinität durch alle Methoden!"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Pv_Content = {
    Text = "Bild abspielen"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Record_Content = {Text = "Rosenhymne"},
  PanelText_UI_Events_Panel_Sorel_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Shop_Content = {
    Text = "Goldrotes Fest"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Topic_Content = {
    Text = "Mit der Roseninschrift"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Limit_Content = {
    Text = "Ermittlungsbelohnung"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Over_Content = {
    Text = "Alle Belohnungsbedingungen erfüllt"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Pass_Content = {
    Text = "Abschlussbelohnung"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Title_Content = {
    Text = "Nach Abschluss des Tests der Erweckungseinheit können Belohnungen erhalten werden"
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Introduction_Content = {
    Text = "Der altmodische Sextant bestimmt den Winkel der Sterne, die alten Seekarten legen die erwarteten Routen fest, und der abgedroschene Kompass entscheidet über die Richtung des Fortschritts...\nSogar im tiefen, kalten Schwarzen Meer gibt es Entdecker, die mit gewöhnlichem Kupfer und Eisen den Menschen den Weg weisen.\nMöge jeder Führer nicht in Verwirrung geraten."
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Title_Content = {
    Text = "Verloren in der Tiefsee"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Challenge_Content = {
    Text = "Verloren in der Tiefsee"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Record_Content = {
    Text = "Letzte Steuerung"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Shop_Content = {
    Text = "Besatzungsschätze"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Topic_Content = {
    Text = "Im Sturm wankend"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Introduction_Content = {
    Text = "Freundschaft steht an erster Stelle, Wettbewerb an zweiter – Blödsinn!\nSchwitzt und kämpft unter dem gleißenden blauen Himmel, auf zum Sieg!"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Title_Content = {
    Text = "Beachvolleyball-Turnier"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Challenge_Content = {
    Text = "Beachvolleyball-Turnier"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Record_Content = {
    Text = "Abweichende Traumwelt"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Shop_Content = {Text = "Seehotel"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Sign_Content = {
    Text = "Sommerlanges Fest"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Topic_Content = {
    Text = "Sommer-Sonderaktion · Teil 1"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Introduction_Content = {
    Text = "In der warmen Sonne ist alles so gemütlich und glücklich. \n Du blickst in den himmelblauen Himmel, wie in einem Märchenbuch, und beschließt, die Leinwand mit eigenen Händen zu zerreißen und aus der falschen Welt herauszutreten."
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Progress_Content = {
    Text = "Sternenfortschritt"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Title_Content = {
    Text = "Unter dem Sonnenlicht gibt es Neues"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Challenge_Content = {
    Text = "Unter dem Sonnenlicht gibt es Neues"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Record_Content = {
    Text = "Abweichende Traumwelt"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Shop_Content = {
    Text = "Gebäude des Studentenrats"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Topic_Content = {
    Text = "Wenn alles wie gewohnt ist"
  },
  PanelText_UI_Events_Panel_SurveyDiary_Text_C_Return_Content = {
    Text = "Rückkehr-Belohnung"
  },
  PanelText_UI_Events_Panel_Task_Text_C_OneKeyName_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Events_Panel_Task_Text_Title_Content = {
    Text = "Reinigungsstand"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Introduction_Content = {
    Text = "Überquere das Tor der letzten Extreme und erreiche das Reich der unendlichen Weisheit.\nStelle dich den Frevelhaften und erkenne, was „Selbst“ bedeutet.\nDies ist der „Ultimative Test“, den Er dir gegeben hat"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Title_Content = {Text = "Endtest"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Challenge_Content = {Text = "Endtest"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Shop_Content = {Text = "Echo"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Topic_Content = {Text = "Wandeltür"},
  PanelText_UI_Events_Panel_TeamSchool_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Challenge_Content = {
    Text = "Katzen-Tanz-Chaos"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Tip_Content = {
    Text = "Täglich werden unterschiedliche Schulkatzen-Level freigeschaltet. Bei erfolgreicher Herausforderung winken großzügige Belohnungen!"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Topic_Content = {
    Text = "Uma Nya Nya Rate"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Describe_Content = {
    Text = "Die Zeit fließt und kehrt zurück – die verwelkten Blumen erblühen erneut."
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Title_Content = {
    Text = "Verwirrte Begierde"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_illustrate_Content = {
    Text = "Spielregeln"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Challenge_Content = {
    Text = "Verwirrte Begierde"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Homology_Content = {
    Text = "Aktivitätszeitraum verdoppelt die Erhöhung der Affinität durch alle Methoden!"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Pv_Content = {
    Text = "Bild abspielen"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_RecordTip_Content = {
    Text = "Zeitlich begrenztes Angebot freischalten"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Record_Content = {
    Text = "Fortpflanzungswahn"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Shop_Content = {
    Text = "Begierde-Sünde"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Topic_Content = {
    Text = "Fleischliche Begierden"
  },
  PanelText_UI_Events_Panel_Try_Text_C_Fail_Content = {
    Text = "Unvollständig"
  },
  PanelText_UI_Events_Panel_Try_Text_C_Summon_Content = {
    Text = "Zum Erwachen"
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Introduction_Content = {
    Text = "Beten, opfern, sich hingeben – die Tiefe der Menschheit ist für Ihn nur laute Farce.\nDoch diese Farce hinterlässt manchmal Spuren, in den Augen... oder dem Herzen des Götterkönigs."
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Title_Content = {
    Text = "Tiefseeblick"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Challenge_Content = {
    Text = "Tiefseeblick"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Tulu_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Record_Content = {
    Text = "Tag der Krönung"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Resonance_Content = {
    Text = "Resonanz: Berge verschlingen"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Shop_Content = {
    Text = "Wahrnehmungsabgrund"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Topic_Content = {
    Text = "Göttlicher König erwacht"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Challenge_Content = {
    Text = "Erinnerungscode"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Speichergrenze:"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finish_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Not_unlocked_Content = {
    Text = "<Gray:Nicht freigeschaltet>"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Pv_Content = {
    Text = "Bild abspielen"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Record_Content = {
    Text = "Ruhige Spaltung"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Resonance_Content = {
    Text = "Resonanz: Dissoziative Symptome"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Shop_Content = {
    Text = "Persönlichkeitsanalyse"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Topic_Content = {
    Text = "Mehrfachheilung·Replik"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Describe_Content = {
    Text = "Isalaou, die Stadt im See, soll der Geburtsort von Wanda sein. \nDiesmal wirst du durch die Tür der Träume schreiten und dort die alte Türme voller Glockenzungen erreichen"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Resonance_Content = {Text = "Resonanz"},
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Title_Content = {
    Text = "Stadt im See"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_illustrate_Content = {
    Text = "Spielregeln"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Can_Unlockable_Content = {
    Text = "Kann abgeholt werden"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Challenge_Content = {
    Text = "Stadt im See"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Fill_Up_Content = {
    Text = "(Bis zur Auffüllung:"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Finished_Content = {Text = "Beendet"},
  PanelText_UI_Events_Panel_Wanda_Text_C_Not_unlocked_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Pv_Content = {
    Text = "Bild abspielen"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Receive_Content = {
    Text = "Zeit bis zur Abholung"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Record_Content = {
    Text = "Brennende Gruppenfest"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Resonance_Content = {
    Text = "Resonanz: Stellvertretungsbefehl"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Shop_Content = {
    Text = "Wandas Wunderkiste"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Topic_Content = {
    Text = "Brennende Gruppenfest"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Challenge_Content = {
    Text = "Gemeinsame Schlacht Ursprünglich"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_ProgressTitle_Content = {
    Text = "Gemeinsame Ursprüngliche Schlacht - Fortschritt"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Rank_Content = {Text = "Rangliste"},
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Record_Content = {
    Text = "Sondereinsatzdokument"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Topic_Content = {
    Text = "Entscheidung: Urschatten"
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Introduction_Content = {
    Text = "Aus Liebe entsteht Groll, aus Groll entsteht Hass, dick, anhaltend und düster...\nDer Himmel antwortet nicht auf deine Bitten, und es gibt keinen Ausweg unter der Erde, daher antwortet das Lachen, das im nächtlichen Dunst verborgen ist, deinem Ruf, und du musst keinen Preis zahlen. \nSieh sie an, gehorche ihr, verschmelze mit ihr, werde sie."
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Title_Content = {
    Text = "Obsidian-Matriarchin"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_ChallengeTip_Content = {
    Text = "Spielmodus zeitlich begrenzt geöffnet"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Challenge_Content = {
    Text = "Obsidian-Matriarchin"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_RecordTip_Content = {
    Text = "Eingeschränkter freier Zugang"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Record_Content = {
    Text = "Bewusstseinsdrift"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Reward_Content = {
    Text = "Erreichungsbelohnung"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Shop_Content = {
    Text = "Verlassene Opfergabe"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Topic_Content = {
    Text = "Huangpu Flüstern"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Awards_Content = {Text = "Belohnung"},
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_CurRate_Content = {
    Text = "Aktuelle Wahrscheinlichkeit"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_InitRate_Content = {
    Text = "Anfangswahrscheinlichkeit"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Item_Content = {
    Text = "Belohnungsgegenstand"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Rate_Content = {
    Text = "Wahrscheinlichkeit"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_Desc_Content = {
    Text = "Aktivitätsbeschreibung"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_InfoTitle_Content = {
    Text = "Aktivitätsbeschreibung"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_OptionWeapon_Content = {
    Text = "Alle verfügbaren Schicksalsräder anzeigen"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_Slogan_Content = {
    Text = "Nur 24 Stunden lang verfügbar!\nWähle einen permanenten Erwachenskörper aus!"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_SpecialTime_Content = {
    Text = "Verbleibend"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_PayTip_Content = {
    Text = "Der aktuelle angezeigte Preis entspricht dem Standardwährungspreis und dient nur zu Informationszwecken. Bei der Zahlung gelten die tatsächliche Währung und der tatsächliche Preis."
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_1_Content = {
    Text = "Details anzeigen"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_2_Content = {Text = "Abholen"},
  PanelText_UI_Events_Popup_Optional_Text_C_Title_Content = {
    Text = "Selbstgewähltes Schicksalsrad"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistAwaker_Content = {
    Text = "Unterstützungscharakter"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistCount_Content = {
    Text = "Kampfunterstützung Anzahl"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Assist_Content = {
    Text = "Unterstützungs-Rangliste"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Assist_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Kill_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Assist_Content = {
    Text = "Hüter-Informationen"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Kill_Content = {
    Text = "Hüter-Informationen"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_KillCount_Content = {
    Text = "Gesamtanzahl Fänge"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Kill_Content = {
    Text = "Hüter-Rangliste"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Assist_Content = {Text = "Rang"},
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Kill_Content = {Text = "Rang"},
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Title_Content = {Text = "Rangliste"},
  PanelText_UI_Events_RAID_StageGroup_Text_C_Introduction_Content = {
    Text = "Schwarz, schwarz, schwarz...\nDie pechschwarzen Monster kreischen, brüllen und tanzen wild, strömen wie eine Flut auf dich zu.\n„Pfft—\"\n„Dieses hier hatte kaum Silber. Denk daran, nächstes Mal mehr mitzubringen.\""
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Title_Content = {
    Text = "Flut der Silberpfoten"
  },
  PanelText_UI_Events_Stage_Tip_Text_C_Title_Content = {
    Text = "Ermittlungsbelohnung"
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Introduction_Content = {
    Text = "Schwarz, schwarze Wellen strömen unaufhörlich. \n Wahnsinnige Katzen umringen dich, sie stürmen aus unzähligen Dimensionen auf dich zu."
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Title_Content = {
    Text = "Katzen-Tanz-Chaos"
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "Stellt euch eurer ursprünglichen Verzweiflung entgegen. Stellt euch eurer ursprünglichen Angst entgegen.\n Steht an der Seite des unsichtbaren Gegenübers und besiegt Ihn"
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Title_Content = {
    Text = "Gemeinsame Schlacht Ursprünglich"
  },
  PanelText_UI_Events_illustrate_Tip_Text_C_Title_Content = {
    Text = "Erwachte Beschreibung"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Full_Content = {
    Text = "Materialien bereit"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Goto_Content = {Text = "Gehe zu"},
  PanelText_UI_GuideNote_Item_Material_Text_C_Source_Content = {
    Text = "Quelle abrufen"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Sweep_Content = {
    Text = "Reproduktion"
  },
  PanelText_UI_GuideNote_Item_Task_Text_C_Recieve_Content = {Text = "Abholen"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Goto_Content = {Text = "Gehe zu"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Source_Content = {
    Text = "Quelle abrufen"
  },
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Sweep_Content = {
    Text = "Reproduktion"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Change_Content = {Text = "Wechseln"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Choose_Content = {
    Text = "Zum Auswählen klicken"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Detail_Content = {Text = "Details"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_ExcludeTalent_Content = {Text = "Talent"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Level_Content = {Text = "Level"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_More_Content = {Text = "Mehr"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_NoTask_Content = {
    Text = "Einen Erweckten Körper auswählen"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Skill_Content = {Text = "Fähigkeit"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Talent_Content = {Text = "Talent"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Abyss_Content = {Text = "Gehe zu"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_DailyChallenge_Content = {Text = "Gehe zu"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Pvp_Content = {Text = "Gehe zu"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RailyWay_Content = {Text = "Gehe zu"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RotationMode_Content = {Text = "Gehe zu"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Rank_Abyss_Content = {Text = "Rang"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Abyss_Content = {
    Text = "Verbleibende Belohnungen"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_DailyChallenge_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Pvp_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RailyWay_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RotationMode_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_DailyChallenge_Content = {Text = "Punkte"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_Pvp_Content = {Text = "Punkte"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RailyWay_Content = {
    Text = "Höchste Pkt."
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RotationMode_Content = {Text = "Punkte"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Abyss_Content = {
    Text = "Fusionskatastrophe Sperrzone"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_DailyChallenge_Content = {
    Text = "Traumtauchen"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Pvp_Content = {
    Text = "Phasenduell – Vorgruppierungsmodus"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RailyWay_Content = {
    Text = "Rasender Freude-Express"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RotationMode_Content = {
    Text = "Phasenduell – Wahlmodus"
  },
  PanelText_UI_GuideNote_PermTrainBase_Text_C_Goto_Content = {Text = "Gehe zu"},
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Goto_Content = {Text = "Gehe zu"},
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ItemsPreview_Content = {
    Text = "Vorschau verbleibender Ressourcen"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Null_Content = {
    Text = "Keine verbleibenden Ressourcen"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ProgressTitle_Content = {
    Text = "Spielfortschritt"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Title_Content = {
    Text = "Ermittlungseinsatz"
  },
  PanelText_UI_Guide_ChangeName_Image_Confim_Dis_Bg_Content = {Text = "Gravur"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Dis_Content = {Text = "Signatur"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Nor_Content = {Text = "Signatur"},
  PanelText_UI_Guide_ChangeName_Text_C_Myself_Content = {Text = "Ihr Name"},
  PanelText_UI_Guide_ChangeName_Text_C_Return_Content = {
    Text = "Zurück zur Geschlechtsauswahl"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Tips_Content = {
    Text = "Bitte geben Sie Ihren Namen ein"
  },
  PanelText_UI_Guide_ChangeName_Text_Confim_Nor_Content = {Text = "Gravur"},
  PanelText_UI_Home_Panel_Main_Text_C_Title_Content = {
    Text = "Forschungszentrum"
  },
  PanelText_UI_Homeland_Item_Building_Text_C_Done_Content = {Text = "Voll"},
  PanelText_UI_Homeland_Panel_Main_Text_C_Tips_Content = {
    Text = "Bonusübersicht"
  },
  PanelText_UI_InvitationCode_Item_Player_Text_Name_Content = {Text = "Abholen"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_BindingTip_Content = {
    Text = "Du bist nicht allein in einem Universum, in dem unzählige Silberschlüssel schimmern, gebunden an den Wegweiser, den Hüter des Geheimnisses."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_High_Content = {
    Text = "Bindungseinladung"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_Nor_Content = {
    Text = "Bindungseinladung"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Clean_Content = {Text = "Beseitigen"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Condition_Content = {
    Text = "Eingeladene Hüter können nach Erreichen der Stufe 5/10/15/20 Silberschlüssel-Glimmer-Belohnungen erhalten."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Copy_Content = {Text = "Kopieren"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Desc_Content = {
    Text = "Kopieren Sie den Einladungscode und führen Sie Seelen aus unendlichen Universen an, um gemeinsam die Reise der Auflösung anzutreten."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InputTip_Content = {
    Text = "Gib den exklusiven Einladungscode deines Freundes ein, um die Belohnung sofort abzuholen"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InviteCount_Content = {
    Text = "Anzahl der eingeladenen Personen"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_High_Content = {
    Text = "Event-Einladung"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_Nor_Content = {
    Text = "Event-Einladung"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InvitedCount_Content = {Text = "300!"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_MyCode_Content = {
    Text = "Mein Einladungscode"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Paste_Content = {Text = "Einfügen"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Share_Content = {Text = "Teilen"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Tips_Content = {
    Text = "Gib den Einladungscode ein"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Value_Content = {
    Text = "Silberschlüssel Glimmer"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_illustrate_Content = {
    Text = "Aktionsbeschreibung"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_Title_Content = {
    Text = "Event-Einladung"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Null_Content = {
    Text = "Keine eingeladenen Geheimwächter auf Stufe 5 vorhanden"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title2_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title_Content = {
    Text = "Einladungsliste"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Acquire_Content = {
    Text = "Erhalte neuen Schlüsselbefehl"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Tips_Content = {
    Text = "Klicke auf den Bildschirm, um zu schließen"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Current_Content = {
    Text = "Aktuell in Verwendung"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Disable_Content = {
    Text = "Nicht nutzbar"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_1_Content = {Text = "Auswahl"},
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_2_Content = {Text = "Abbrechen"},
  PanelText_UI_Keeper_Skill_Panel_Text_C_NoTask_Content = {
    Text = "Keine Schlüsselbefehle vorhanden"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Title_Content = {Text = "Posse"},
  PanelText_UI_Keeper_Skill_Panel_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Login_Panel_ServerSelect_Text_Panel_Title_Content = {Text = "Serverwahl"},
  PanelText_UI_Login_Popup_Tips_Text_C_Activity_Content = {
    Text = "Event-Ankündigung"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_BugFix_Content = {
    Text = "Problemlösung"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Game_Content = {
    Text = "Ankündigung"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title2_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title_Content = {
    Text = "Keine Ankündigungen"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title_En_Content = {
    Text = "Postfach leer"
  },
  PanelText_UI_Login_Popup_Tips_Text_Title_Content = {
    Text = "Ankündigung"
  },
  PanelText_UI_Login_Text_C_Announcement_Content = {
    Text = "Ankündigung"
  },
  PanelText_UI_Login_Text_C_Deal_Content = {Text = "Abkommen"},
  PanelText_UI_Login_Text_C_Enter_Content = {
    Text = "Universität betreten"
  },
  PanelText_UI_Login_Text_C_Fight_Content = {Text = "Kampf 2.0"},
  PanelText_UI_Login_Text_C_Plot_Content = {
    Text = "Avg Story Test"
  },
  PanelText_UI_Login_Text_C_Quit_Content = {Text = "Beenden"},
  PanelText_UI_Login_Text_C_Repair_Content = {Text = "Reparieren"},
  PanelText_UI_Login_Text_C_Service_Content = {
    Text = "Kundendienst"
  },
  PanelText_UI_Login_Text_C_Set_Content = {
    Text = "Einstellungen"
  },
  PanelText_UI_Login_Text_C_Setting_Content = {
    Text = "Einstellungen"
  },
  PanelText_UI_Login_Text_C_Sweep_Content = {
    Text = "QR-Code scannen"
  },
  PanelText_UI_Login_Text_C_Title1_Content = {
    Text = "Vergessene Vorabend"
  },
  PanelText_UI_Login_Text_C_User_Content = {
    Text = "Benutzerzentrum"
  },
  PanelText_UI_Mail_Text_C_All_Content = {
    Text = "Alles abholen"
  },
  PanelText_UI_Mail_Text_C_Collection_Content = {
    Text = "Gespeicherte E-Mails"
  },
  PanelText_UI_Mail_Text_C_Delete01_Content = {Text = "Löschen"},
  PanelText_UI_Mail_Text_C_Delete_Content = {
    Text = "Gelesenes löschen"
  },
  PanelText_UI_Mail_Text_C_Empty_Content = {
    Text = "Keine neuen Mails"
  },
  PanelText_UI_Mail_Text_C_Mail_Content = {
    Text = "Anzahl der E-Mails"
  },
  PanelText_UI_Mail_Text_C_Name_Content = {Text = "Abholen"},
  PanelText_UI_Mail_Text_C_NoTask1_Content = {
    Text = "Keine Nachrichten"
  },
  PanelText_UI_Mail_Text_C_Select_Letter_Content = {
    Text = "Wähle 1 E-Mail"
  },
  PanelText_UI_Mail_Text_C_Time_Content = {Text = "Zeit:"},
  PanelText_UI_Mail_Text_C_Tips_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Mail_Text_C_Title_Content = {
    Text = "Briefkasten"
  },
  PanelText_UI_Mail_Text_Time2_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Mail_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Close_Content = {
    Text = "Klicke auf den Bildschirm, um zu schließen"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Daily_Content = {
    Text = "Tägliche Probe"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Finish_Content = {
    Text = "Heute abgeschlossen"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Receive_Content = {Text = "Abgeholt"},
  PanelText_UI_Main_Daily_Tips_Text_C_Reward_Content = {
    Text = "Belohnung abschließen"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Skill_Tag_Content = {
    Text = "Ermittlungsweg"
  },
  PanelText_UI_Main_Favor_Tip_Text_C_Name_Content = {
    Text = "Synchro-Rate"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Awaken_Content = {
    Text = "Erweckungsdatum"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Favor_Content = {
    Text = "Aktuelle Affinitätsrate"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Tip_Content = {
    Text = "Nach der Einladung des Erweckers erhält dieser in bestimmten Abständen eine Affinität"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Title_Content = {Text = "Wohnheim"},
  PanelText_UI_Main_Helicopter_Tips_Text_Name_1_Content = {Text = "Einladen"},
  PanelText_UI_Main_Helicopter_Tips_Text_Name_2_Content = {Text = "Abbrechen"},
  PanelText_UI_Main_Helicopter_Tips_Text_ResetBg_Content = {
    Text = "Standard Ton und Bild"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Not_Content = {
    Text = "Unvollständig"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Proxy_Content = {
    Text = "Agentenbeweis"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Receive_Content = {Text = "Abholen"},
  PanelText_UI_Main_Panel_1_Text_Abyss_Content = {
    Text = "Fusionskatastrophe Sperrzone"
  },
  PanelText_UI_Main_Panel_1_Text_C_Acclaim_Content = {
    Text = "Gute Bewertung"
  },
  PanelText_UI_Main_Panel_1_Text_C_Activity_Content = {Text = "Event"},
  PanelText_UI_Main_Panel_1_Text_C_Awaker_Content = {Text = "Erwecker"},
  PanelText_UI_Main_Panel_1_Text_C_Bag_Content = {Text = "Inventar"},
  PanelText_UI_Main_Panel_1_Text_C_Close_1_Content = {Text = "Schließen"},
  PanelText_UI_Main_Panel_1_Text_C_Close_Content = {Text = "Schließen"},
  PanelText_UI_Main_Panel_1_Text_C_Collection_Content = {Text = "Archiv"},
  PanelText_UI_Main_Panel_1_Text_C_Community_Content = {
    Text = "Gemeinschaft"
  },
  PanelText_UI_Main_Panel_1_Text_C_Daily_Content = {
    Text = "Tägliche Probe"
  },
  PanelText_UI_Main_Panel_1_Text_C_Dbg_Content = {
    Text = "Interludium"
  },
  PanelText_UI_Main_Panel_1_Text_C_DungeonNote_Content = {
    Text = "Geheimgang Notizen"
  },
  PanelText_UI_Main_Panel_1_Text_C_Formation_Content = {Text = "Formation"},
  PanelText_UI_Main_Panel_1_Text_C_Full_Content = {
    Text = "Bereits abgeschlossen"
  },
  PanelText_UI_Main_Panel_1_Text_C_GamePassport_Content = {Text = "Archiv"},
  PanelText_UI_Main_Panel_1_Text_C_Lesson_Content = {Text = "Lehrplan"},
  PanelText_UI_Main_Panel_1_Text_C_Main_Content = {Text = "Ermittlung"},
  PanelText_UI_Main_Panel_1_Text_C_Mission_Content = {Text = "Handbuch"},
  PanelText_UI_Main_Panel_1_Text_C_Pvp_Content = {Text = "Traphase\n"},
  PanelText_UI_Main_Panel_1_Text_C_Recall_Content = {Text = "Arcade"},
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Content = {Text = "Erweckung"},
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Nor_Content = {Text = "Erweckung"},
  PanelText_UI_Main_Panel_1_Text_C_Store_Content = {
    Text = "Misaq-Geschäft"
  },
  PanelText_UI_Main_Panel_1_Text_C_Welfare_Content = {
    Text = "Unmengen an Waren, zeitlich begrenzt verfügbar"
  },
  PanelText_UI_Main_Panel_1_Text_Diving_Content = {
    Text = "Traumtauchen"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_Title_Content = {
    Text = "Aktive Aufgaben"
  },
  PanelText_UI_Michi_Popup_Strengthen_Succeed_Text_C_Info_Content = {
    Text = "Klicke auf den leeren Bereich, um zu schließen"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Consume_Content = {Text = "Verbrauch"},
  PanelText_UI_Other_Donate_Tips_Text_C_Donated_Content = {
    Text = "Kumulativ gespendet"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Fund_Content = {
    Text = "Alumni-Spendenfonds"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Least_Content = {Text = "Minimal"},
  PanelText_UI_Other_Donate_Tips_Text_C_Title_Content = {
    Text = "Silberprimus spenden"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Utmost_Content = {Text = "Maximal"},
  PanelText_UI_Other_Fund_Tips_Text_C_Describe_Content = {
    Text = "Spenden Sie Silberkernquellflüssigkeit, sammeln Sie Beiträge, Ihre Wohltat wird belohnt. Ihr „Gesamtbeitrag„ ist die Summe der gespendeten Silberkernquellflüssigkeit."
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Donated_Content = {
    Text = "Gesamtbeitrag"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Title_Content = {
    Text = "Alumni-Spendenfonds"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_illustrate_Content = {Text = "Regeln"},
  PanelText_UI_Other_Physical_Tips_Text_C_All_Content = {
    Text = "Alles wiederherstellen:"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Auto_Content = {
    Text = "Automatische Wiederherstellung"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_1_Content = {Text = "Abbrechen"},
  PanelText_UI_Other_Physical_Tips_Text_C_Name_2_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_Content = {Text = "Abbrechen"},
  PanelText_UI_Other_Physical_Tips_Text_C_Next_Content = {
    Text = "Nächste Wiederherstellung:"
  },
  PanelText_UI_Other_Physical_Tips_Text_Name_Content = {Text = "Abbrechen"},
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Energy_Content = {
    Text = "Verbraucht Energie:"
  },
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Info_Content = {
    Text = "Klicke auf den leeren Bereich, um zu schließen"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Next_Content = {
    Text = "Verbraucht Silberkernkristalle"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Now_Content = {
    Text = "Silberkernkristalle"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Question_Content = {
    Text = "Möchtest du den Schlüssel erhalten?"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Next_Content = {
    Text = "Erschöpfungsschlüssel"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Now_Content = {
    Text = "Schlüsselträger"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Title_Content = {
    Text = "Schlüssel erhalten"
  },
  PanelText_UI_Other_Popup_Trinket_LevelUp_Text_C_Success_Content = {
    Text = "Stärkung erfolgreich"
  },
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_HP_Content = {Text = "Blutmenge"},
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_Wait_Content = {
    Text = "Warten auf die Wahlmodus-Informationen"
  },
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Attack_Content = {Text = "Erster Zug"},
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Defend_Content = {Text = "Nachteil"},
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Adjust_Content = {
    Text = "Erwachenskörper-Position ändern"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_My_Content = {Text = "Bereit!"},
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_Other_Content = {Text = "Bereit!"},
  PanelText_UI_PVP_Panel_TeamRotation_Text_BtnName_Content = {
    Text = "Ausgewählt"
  },
  PanelText_UI_Passport_Choose_Tip_Text_C_Title_Content = {
    Text = "Bitte wählen Sie Ihre Belohnung"
  },
  PanelText_UI_Passport_Exchange_Text_C_Buy_Title_Content = {
    Text = "Level erhöhen"
  },
  PanelText_UI_Passport_Exchange_Text_C_Cost_Tips_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Passport_Exchange_Text_C_Title_Content = {
    Text = "Themenlevel erhöhen"
  },
  PanelText_UI_Passport_Instructions_Text_C_Remainder_Content = {
    Text = "Verbleibende Zeit dieser Periode"
  },
  PanelText_UI_Passport_Instructions_Text_C_Title_Content = {Text = "Lehrplan"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Additional_Content = {
    Text = "Sofort freischalten"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Condition_Content = {
    Text = "Nach dem Upgrade abholbar"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_1_Content = {
    Text = "Sofort erhöhen"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_3_Content = {Text = "Stufe"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_4_Content = {
    Text = "Aufgabenlevel"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_Content = {
    Text = "Sofort <color=#5EF2FF><size=32>10</size> Stufen</color> im Aufgabenlevel steigern"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Introduce_Content = {
    Text = "Löse die fortgeschrittene Aufgabe und steigere sie auf Level 40, um im Aufgaben-Geschenk ein Schicksalsrad oder 5 Lumenkerne als Belohnung auswählen zu können"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Name_Content = {
    Text = "Trainingsbefehl"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_1_Content = {
    Text = "Tägliche Aufgaben\nBelohnungen ×3"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_2_Content = {
    Text = "Kampfrunde\nRückverfolgung"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_3_Content = {
    Text = "Phasenduell\n Voller Kartenspaß"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_Content = {
    Text = "·In diesem Themenprotokoll haben Sie Privilegien:"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Prompt_Content = {
    Text = "Bitte spielen Sie maßvoll und konsumieren Sie vernünftig"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_1_Content = {Text = "Gekauft"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_2_Content = {Text = "Gekauft"},
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Senior (1)_Content"] = {
    Text = "Fortgeschritten, Fortg."
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Senior_Content = {
    Text = "Höhere Themen"
  },
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Super (1)_Content"] = {
    Text = "Sonderklasse"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Super_Content = {Text = "Kernthema"},
  PanelText_UI_Passport_Money_Item_New_Text_C_TempUnlock_Content = {
    Text = "In dieser Saison können alle Karten in der Traphase verwendet werden"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_ThisIssue_Content = {
    Text = "Inhalt aller aktuellen fortgeschrittenen Themen"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Condition_Content = {
    Text = "Nach dem Upgrade abholbar"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_1_Content = {
    Text = "Sofort erhöhen"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_3_Content = {Text = "Stufe"},
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_4_Content = {
    Text = "Aufgabenlevel und erhalten"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Introduce_Content = {
    Text = "Eine handgefertigte Geschenkschachtel, die wertvolle Schicksalsräder enthält. \nLöse hochrangige Aufgaben und erreiche Stufe 40, um als Belohnung aus der Aufgabenkiste entweder ein Schicksalsrad oder 5 Lumen-Kerne auszuwählen."
  },
  PanelText_UI_Passport_Money_Item_Text_C_Name_Content = {
    Text = "Themenpräsentikiste"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Prompt_Content = {
    Text = "Bitte spielen Sie maßvoll und konsumieren Sie vernünftig"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_1_Content = {Text = "Gekauft"},
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_2_Content = {Text = "Gekauft"},
  ["PanelText_UI_Passport_Money_Item_Text_C_Senior (1)_Content"] = {
    Text = "Fortgeschritten, Fortg."
  },
  PanelText_UI_Passport_Money_Item_Text_C_Senior_Content = {
    Text = "Höhere Themen"
  },
  ["PanelText_UI_Passport_Money_Item_Text_C_Super (1)_Content"] = {
    Text = "Sonderklasse"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Super_Content = {Text = "Kernthema"},
  PanelText_UI_Passport_Money_Item_Text_C_ThisIssue_Content = {
    Text = "Inhalt aller aktuellen fortgeschrittenen Themen"
  },
  PanelText_UI_Passport_Panel_Main_New_Text_C_Mail_Content = {Text = "Regeln"},
  PanelText_UI_Passport_Panel_Main_New_Text_C_Title_Content = {Text = "Lehrplan"},
  PanelText_UI_Passport_Panel_Main_Text_C_Experience_Content = {
    Text = "Aufgabenerfahrung"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Full_Content = {
    Text = "Maximallevel erreicht"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Instructions_Grade_Content = {
    Text = "Aufgabenlevel"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Mail_Content = {Text = "Regeln"},
  PanelText_UI_Passport_Panel_Main_Text_C_Name_Content = {
    Text = "Level erhöhen"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Online_Content = {
    Text = "Wöchentliches Erfahrungslimit"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Title_Content = {Text = "Lehrplan"},
  PanelText_UI_Passport_Popup_Player_LevelUp_Text_C_Title_Content = {
    Text = "Aufgabenlevel erhöht"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Cancel_Name_Content = {Text = "Abbrechen"},
  PanelText_UI_Passport_Popup_Recharge_Text_Confirm_Name_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Title_Content = {
    Text = "Kauf bestätigen"
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Content_Content = {
    Text = "Eine handgefertigte Geschenkschachtel, die wertvolle Schicksalsräder enthält. \nLöse hochrangige Aufgaben und erreiche Stufe 40, um als Belohnung aus der Aufgabenkiste entweder ein Schicksalsrad oder 5 Lumen-Kerne auszuwählen."
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Title_Content = {
    Text = "Themenpräsentikiste"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Experience_Content = {
    Text = "Aufgabenerfahrung"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Full_Content = {
    Text = "Maximallevel erreicht"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_GainExperience_Content = {
    Text = "Erfahrung erhalten"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_2_Content = {Text = "Kaufstufe"},
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Online_Content = {
    Text = "Wöchentliches Limit"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Ordinary_Title_Content = {Text = "Grundkurs"},
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Content = {
    Text = "Themenfortschritt"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Title_Content = {
    Text = "Höhere Themen"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Timing_Content = {
    Text = "Diese Periode"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Unlock_Content = {
    Text = "Sofort freischalten"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Experience_Content = {
    Text = "Aufgabenerfahrung"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Full_Content = {
    Text = "Maximallevel erreicht"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_2_Content = {Text = "Kaufstufe"},
  PanelText_UI_Passport_Reward_Item_Text_C_Name_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Online_Content = {
    Text = "Wöchentliches Limit"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Ordinary_Title_Content = {Text = "Grundkurs"},
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Content = {
    Text = "Themenfortschritt"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Title_Content = {
    Text = "Höhere Themen"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Tab_Special_Content = {
    Text = "Fortgeschritten, Fortg."
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Timing_Content = {
    Text = "Verbleibende Zeit dieser Periode"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Introduce_Content = {
    Text = "Löse die fortgeschrittene Aufgabe und steigere sie auf Level 40, um im Aufgaben-Geschenk ein Schicksalsrad oder 5 Lumenkerne als Belohnung auswählen zu können"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Reward_Content = {
    Text = "Vorschau auf die Geschenkbox dieser Periode"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Time_1_Content = {
    Text = "Verbleibende Aktivitätszeit dieser Periode"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Double_Content = {
    Text = "Doppelte Erfahrung"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Tab_Special_Content = {Text = "Event"},
  PanelText_UI_Passport_Task_Description_Text_C_Name_Content = {Text = "Abholen"},
  PanelText_UI_Passport_Task_Description_Text_C_Tab_Special_Content = {Text = "Event"},
  PanelText_UI_Passport_Task_Item_Text_C_Experience_Content = {
    Text = "Aufgabenerfahrung"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Full_Content = {
    Text = "Maximallevel erreicht"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_3_Content = {Text = "Kaufstufe"},
  PanelText_UI_Passport_Task_Item_Text_C_Name_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Online_Content = {
    Text = "Wöchentliches Limit"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Time_Content = {
    Text = "Verbleibende Zeit dieser Periode"
  },
  PanelText_UI_Passport_illustrate_Tip_Text_C_Title_Content = {Text = "Regeln"},
  PanelText_UI_Pocket_Mail_Text_C_Del_Content = {Text = "Löschen"},
  PanelText_UI_Pocket_Mail_Text_C_Time_Content = {Text = "Zeit:"},
  PanelText_UI_Pocket_Mail_Text_C_Tips_Content = {
    Text = "Sammlungszahl"
  },
  PanelText_UI_Pocket_Mail_Text_C_Title2_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Pocket_Mail_Text_C_Title_Content = {
    Text = "Keine Nachrichten"
  },
  PanelText_UI_Pocket_Mail_Text_C_select_Title_Content = {
    Text = "Wähle 1 Brief"
  },
  PanelText_UI_Popup_DonationBox_Text_C_Reward_Content = {Text = "Inventar"},
  PanelText_UI_Popup_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "Geschwindigkeit:"
  },
  PanelText_UI_Protagonist_Item_Skill_Text_C_Current_Content = {Text = "Aktuell"},
  PanelText_UI_Protagonist_Item_Skill_Text_C_No_Content = {
    Text = "Nicht erhalten"
  },
  PanelText_UI_Pvp_Blood_Share_Text_C_Release_Content = {
    Text = "Klicke, um freizugeben"
  },
  PanelText_UI_Pvp_Item_Card_Text_C_Replace_Content = {Text = "Ersetzen"},
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Done_Content = {
    Text = "Folgt mir bereits"
  },
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Mutual_Content = {
    Text = "Gegenseitiges Folgen"
  },
  PanelText_UI_Pvp_Item_Dan_Text_C_Current_Content = {Text = "Rang"},
  PanelText_UI_Pvp_Item_Formation_Text_C_Conflict_Content = {
    Text = "Positionskonflikt"
  },
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Double_Content = {
    Text = "Doppelte Waren"
  },
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Topic_Content = {
    Text = "Aufgabenprivilegien"
  },
  PanelText_UI_Pvp_Item_Ranking_Text_C_Current_Content = {
    Text = "Aktuelle Belohnung"
  },
  PanelText_UI_Pvp_Item_Role_Text_C_Decks_Content = {Text = "Kartendeck"},
  PanelText_UI_Pvp_Item_Role_Text_C_Maniac_Content = {Text = "Aliemus"},
  PanelText_UI_Pvp_Item_Role_Text_C_Role_Wins_Content = {Text = "Siege"},
  PanelText_UI_Pvp_Panel_Battle_Text_High_Content = {Text = "Ergeben"},
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_C_NoTask_Content = {
    Text = "Keine Kommentare"
  },
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_Time_Content = {
    Text = "Mach den ersten Kommentar"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Decks_Content = {Text = "Kartendeck"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Effect_Content = {Text = "Effekt"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Hoist_Content = {
    Text = "Arithmetica-Kosten"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Maniac_Content = {Text = "Aliemus"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_TotalWins_Content = {
    Text = "Gesamtsiege"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_Wins_Content = {
    Text = "Saison Siege"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Skill_Tag_Content = {
    Text = "Verherrlichung"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Source_Content = {Text = "Quelle"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_TotalWins_Content = {
    Text = "Gesamtsiege"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Wins_Content = {
    Text = "Saison Siege"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_None_Content = {
    Text = "Keine relevanten Sammlungen"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_Time_Content = {
    Text = "Das Reich ist für die Traphase noch nicht freigeschaltet"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Awaker_Name_Content = {Text = "Erwecker"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_KeeperSkill_Name_Content = {Text = "Posse"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_1_Content = {Text = "Details"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_2_Content = {Text = "Rangliste"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_3_Content = {Text = "Kommentar"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Train_Name_Content = {
    Text = "Erwachte Testversion"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Weapon_Name_Content = {Text = "Schicksrad"},
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_SeasonWins_Content = {
    Text = "Saison Siege"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_TotalWins_Content = {
    Text = "Gesamtsiege"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Decks_Content = {Text = "Kartendeck"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Effect_Content = {Text = "Effekt"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Maniac_Content = {Text = "Aliemus"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Role_Wins_Content = {Text = "Siege"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Wins_Content = {Text = "Siege"},
  PanelText_UI_Pvp_Panel_Formation_Text_C_Detail_Content = {
    Text = "Bitte wähle von links, wer antreten soll"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_1_Content = {
    Text = "Bitte wähle von links, wer antreten soll"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_Content = {
    Text = "Bitte wähle von links, wer antreten soll"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Name_Content = {Text = "Details"},
  PanelText_UI_Pvp_Panel_Formation_Text_C_None2_Content = {
    Text = "Noch kein Material vorhanden"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_None_Content = {
    Text = "Keine relevanten Suchergebnisse"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Time_Content = {
    Text = "Kann durch bestimmte Wege erhalten werden"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Award_Content = {
    Text = "Siegesbelohnung"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_CardEdit_Content = {
    Text = "Deck bearbeiten"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Robot_Content = {Text = "Schließen"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Speed_Content = {Text = "Schließen"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Collection_Content = {Text = "Sammlung"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_DraftPick_Content = {
    Text = "Wahlmodus Level"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Expression_Content = {
    Text = "Kampf-Emoticon"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Integral_Content = {
    Text = "Saisonpunkte"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Matching_Content = {
    Text = "Matchmaking starten"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Robot_Content = {Text = "Aktivieren"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Speed_Content = {Text = "Aktivieren"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Password_Content = {
    Text = "Passwortkampf"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Precon_Content = {
    Text = "Vorgruppierungsstufe"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Progress_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Content = {
    Text = "Phasenduell"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Score_Content = {Text = "Punkte"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Ranking_Content = {Text = "Rangliste"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Record_Content = {
    Text = "Schachrekord"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Reward_Content = {
    Text = "Erreiche höhere Ränge für mehr Belohnungen"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Robot_Content = {
    Text = "Match gegen KI"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Content = {
    Text = "Spitzenschach"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Score_Content = {Text = "Punkte"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Rule_Content = {Text = "Regeln"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Speed_Content = {
    Text = "Geschwindigkeit zuerst"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Store_Content = {Text = "Laden"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Time_Content = {
    Text = "Saison verbleibend"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Title_Content = {
    Text = "Phasenduell"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Victory_Content = {
    Text = "Siege insgesamt:"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Weekly_Content = {
    Text = "Wöchentliche Belohnungen"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_list_Content = {Text = "Rangliste"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Name_Content = {Text = "Ende"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Unclickable_Content = {Text = "Ende"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Zongshanghai_Content = {
    Text = "Gesamtschaden"
  },
  PanelText_UI_Pvp_Panel_Match_Text_C_Second_Content = {Text = "Sekunden"},
  PanelText_UI_Pvp_Panel_Match_Text_C_Win_Content = {
    Text = "Match erfolgreich"
  },
  PanelText_UI_Pvp_Panel_Match_Text_Name_Content = {
    Text = "Matchmaking starten"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "Abrechnung erhalten"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Integral_Content = {
    Text = "Saisonpunkte"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Show_Content = {
    Text = "Nächster Schritt"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Sync_Content = {
    Text = "Wachkörper Affinität erhöhen"
  },
  PanelText_UI_Pvp_Panel_Playback_Text_C_Angle_Content = {
    Text = "Perspektive wechseln"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_1_Content = {Text = "Beobachten"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_2_Content = {Text = "Beobachten"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_1_Content = {Text = "Lob"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_2_Content = {Text = "Gelobt"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Enemy_Content = {Text = "Feind"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Fail_Content = {Text = "Fehlschlag"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Harm_Content = {Text = "Schaden"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Ourside_Content = {Text = "Unser Team"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Outcome_Content = {Text = "Sieg"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_OwnRespectable_Content = {
    Text = "Ehrenwerter Gegner!"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_01_Content = {Text = "Teilen"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_02_Content = {Text = "Teilen"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Respectable_Content = {
    Text = "Ehrenwerter Gegner!"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Shields_Content = {Text = "Schild"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Treat_Content = {Text = "Heilen"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Victory_Content = {Text = "Sieg"},
  PanelText_UI_Pvp_Panel_Train_Text_C_KeeperSkills_Content = {
    Text = "Schlüsselbefehl hinzufügen"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Position_Content = {
    Text = "Verschiebung"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Reset_Content = {
    Text = "Zurücksetzen"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_SelectRelic_Content = {
    Text = "Wähle Schöpfung"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Weapons_Content = {
    Text = "Füge Schicksalsrad hinzu"
  },
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_01_Content = {Text = "Teilen"},
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_02_Content = {Text = "Teilen"},
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Breaking_Content = {
    Text = "Verbindung zum Server unterbrochen"
  },
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Quit_Content = {
    Text = "Zurück zum Anmeldebildschirm"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Decks_Content = {Text = "Kartendeck"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Effect_Content = {Text = "Effekt"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Maniac_Content = {Text = "Aliemus"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Role_Wins_Content = {Text = "Siege"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Wins_Content = {Text = "Siege"},
  PanelText_UI_Pvp_Popup_Dan_Text_C_Bonus_Content = {
    Text = "Saisonbonus"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Continue_Content = {
    Text = "Klicke, um fortzufahren"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Streak_Content = {
    Text = "Siegesserien-Bonus"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Title_Content = {Text = "Erwachen"},
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Use_Content = {
    Text = "Derzeit in Verwendung"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Tips_Text_C_Title_Content = {Text = "Erwachen"},
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Content = {
    Text = "Ausdrucksverwaltung"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Content = {
    Text = "Ausdrucksübersicht"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Sel_Content = {
    Text = "Ausdrucksübersicht"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Sel_Content = {
    Text = "Ausdrucksverwaltung"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Title_Content = {
    Text = "Ausdrucksverwaltung"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Use_Content = {
    Text = "Kampf-Emoticon"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Close_Content = {
    Text = "Klicke auf den leeren Bereich, um fortzufahren"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Continue_Content = {
    Text = "Klicke, um fortzufahren"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Fail_Content = {Text = "Fehlschlag"},
  PanelText_UI_Pvp_Popup_Fail_Text_C_Victory_Content = {
    Text = "Kampf verloren"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_Reward_1_Content = {
    Text = "Kampfstil-Belohnung"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Create_Content = {
    Text = "Kampfvereinbarung erstellen"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Joinin_Content = {
    Text = "Beitreten zur Herausforderung"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_Title_Content = {
    Text = "Kampfvereinbarung"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Cancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Title_Content = {
    Text = "Importieren der Formation"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Placeholder_Content = {
    Text = "Geben Sie einen 6-stelligen Phasenwert ein"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Cancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_Title_Content = {
    Text = "Eingabewert der Phase"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Cancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Copy_Content = {
    Text = "Kopie Phasenwert"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Wait_Content = {
    Text = "Warten, bis andere Schutzherren eingeben"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_Title_Content = {
    Text = "Warten auf den Beitritt"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Cancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Done_Content = {
    Text = "Folgt mir bereits"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Mutual_Content = {
    Text = "Gegenseitiges Folgen"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Ready_Content = {Text = "Bereit"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Reject_Content = {Text = "Ablehnen"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Wait_Content = {
    Text = "Warten auf den Beginn"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_C_Copy_Content = {Text = "Kopieren"},
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Name_Content = {
    Text = "Aufzeichnung ansehen"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Title_Content = {
    Text = "Wähle Blickwinkel"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Initial_Content = {
    Text = "Startkarten"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Prompt_Content = {
    Text = "Klicke, um unerwünschte Karten zu ersetzen"
  },
  PanelText_UI_Pvp_Popup_Reward_Tips_Text_C_Title_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Confirm_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Title_Content = {
    Text = "Wähle 1 Relikt"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Close_Content = {
    Text = "Klicke auf den leeren Bereich, um fortzufahren"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Succeed_Content = {
    Text = "Schlacht gewonnen"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Highest_Content = {
    Text = "Höchste historische Punktzahl im Spiel:"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Title_Content = {
    Text = "Schachrekord"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity1_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity2_Content = {
    Text = "Saisonrangliste"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity3_Content = {
    Text = "Saisonrangliste"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity4_Content = {
    Text = "Rangbelohnung"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Award_Content = {Text = "Belohnung"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Big_Content = {
    Text = "Hüter-Informationen"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game1_Content = {
    Text = "Tagesrangliste"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game2_Content = {
    Text = "Tagesrangliste"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Grade_Content = {Text = "Rang"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Hint_Content = {
    Text = "Gewinne in dieser Saison ein Spiel, um am Ende der Saison eine Belohnung zu erhalten."
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_RankTip_Content = {
    Text = "Nimm in dieser Saison an einem Spiel teil, um in die „Saisonrangliste\" zu kommen."
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_Pvp_Content = {
    Text = "Phasenduell"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_RotationMode_Content = {
    Text = "Spitzenpartie"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Reward_Content = {
    Text = "Saison-Höchstpunktzahl"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Scope_Content = {
    Text = "Rangbereich"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Small_Content = {
    Text = "Schachtitel"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Title_2_Content = {
    Text = "Schachtitel"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Fail_Content = {Text = "Fehlschlag"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Red_Content = {
    Text = "Klicke, um fortzufahren"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Victory_Content = {Text = "Sieg"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Yellow_Content = {
    Text = "Klicke, um fortzufahren"
  },
  PanelText_UI_Pvp_Popup_list_Tips_Text_C_Title_Content = {Text = "Rangliste"},
  PanelText_UI_Pvp_Team_Main_Text_C_Name_10_Content = {
    Text = "Schicksalsrad ausrüsten"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_1_Content = {
    Text = "Ausrüstungsbefehl"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_2_Content = {
    Text = "4. Erwachter"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_3_Content = {
    Text = "3. Erwachter"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_4_Content = {
    Text = "Position 2 Erwachen"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_5_Content = {
    Text = "Erweckter Platz 1"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_6_Content = {
    Text = "Ausrüstungsbefehl"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_7_Content = {
    Text = "Schicksalsrad ausrüsten"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_8_Content = {
    Text = "Schicksalsrad ausrüsten"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_9_Content = {
    Text = "Schicksalsrad ausrüsten"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_Content = {
    Text = "Schnelle Teamaufstellung"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Realms_Content = {
    Text = "Grenzbereich nicht aktiviert"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Title_Content = {
    Text = "Traphase Teamaufstellung"
  },
  PanelText_UI_Pvp_Team_Main_Text_Name_Content = {
    Text = "Schnelle Teamaufstellung"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Copy_Content = {Text = "Kopieren"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Done_Content = {
    Text = "Folgt mir bereits"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Mutual_Content = {
    Text = "Gegenseitiges Folgen"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Proficiency_Content = {
    Text = "Fähigkeitsgrad"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Remove_Content = {Text = "Bearbeiten"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Save_Content = {Text = "Löschen"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Title_Content = {
    Text = "Kommentar Details"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Additional_Content = {
    Text = "Zusätzlich geschenkt"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_DiscountMultipleTitle_Content = {Text = "Superwert"},
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Haved_Content = {Text = "Besitzt"},
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Sellout_Content = {
    Text = "Bereits ausverkauft"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Buy_Title_Content = {
    Text = "Anzahl der Silberkerne eintauschen"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Cost_Tips_Content = {Text = "Verbrauch"},
  PanelText_UI_Recharge_Exchange_Text_C_Least_Content = {Text = "Minimal"},
  PanelText_UI_Recharge_Exchange_Text_C_Redeemed_Content = {
    Text = "Kumulativ eingelöst:"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Utmost_Content = {Text = "Maximal"},
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Not_Content = {
    Text = "Nicht genug Währung"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Title_Content = {
    Text = "Einlösen bestätigen"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_illustrate_Content = {
    Text = "Spielregeln"
  },
  PanelText_UI_Recharge_Instructions_Text_C_Title_Content = {Text = "Lehrplan"},
  PanelText_UI_Recharge_Instructions_Text_Name_Content = {Text = "Gehe zu"},
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Cost_Tips_Content = {
    Text = "Gesamtverbrauch"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Tips_Content = {
    Text = "Du kannst unnötige Gegenstände entfernen"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Title_Content = {
    Text = "Kauf bestätigen"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Buttom_Content = {
    Text = "Zusätzliche „Silberkernquellflüssigkeit\" bei Erstaufladung pro Stufe, nur einmalig"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law1_Content = {
    Text = "Merkantilismus"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law2_Content = {
    Text = "Gesetz über die Geldabrechnung"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Refresh_Content = {
    Text = "Kundendienst kontaktieren"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Title_Content = {
    Text = "Quellflüssigkeitsextraktion"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_PayTip_Content = {
    Text = "Der aktuelle angezeigte Preis entspricht dem Standardwährungspreis und dient nur zu Informationszwecken. Bei der Zahlung gelten die tatsächliche Währung und der tatsächliche Preis."
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Desc_Content = {
    Text = "Aktivitätsbeschreibung"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Slogan_Content = {
    Text = "Nur 24 Stunden lang verfügbar!\nWähle einen permanenten Erwachenskörper aus!"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_SpecialTime_Content = {
    Text = "Verbleibend"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_PayTip_Content = {
    Text = "Der aktuelle angezeigte Preis entspricht dem Standardwährungspreis und dient nur zu Informationszwecken. Bei der Zahlung gelten die tatsächliche Währung und der tatsächliche Preis."
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Bigitle_Content = {
    Text = "Mondphasenbeobachtung"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Buttom_Tips_Content = {
    Text = "Doppelte Erstaufladung pro Stufe, nur einmalig"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Cost_Tips_Content = {Text = "Verbrauch"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Expired_Content = {Text = "Abgelaufen"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Flushed_Content = {
    Text = "Aktualisieren"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get1_Title_Content = {
    Text = "Sofort erhalten"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get2_Title_Content = {
    Text = "Tägliche Geschenke"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Illustrate_Content = {
    Text = "Kann kumulativ gekauft werden"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_OnekeyPurchase_Content = {
    Text = "Ein-Klick-Kauf"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Refresh_Content = {
    Text = "Kundendienst kontaktieren"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Tips_Content = {
    Text = "*Insgesamt 300 Silberkernkristalle + 3000 Silberkerne erhältlich"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Today_Content = {
    Text = "Heute abgeholt"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_Get2_Title2_Content = {
    Text = "（30 Tage）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigitle_Content = {
    Text = "Mondphasenbeobachtung"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigtitle_Content = {
    Text = "Mondphasenbeobachtung"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buttom_Tips_Content = {
    Text = "Bei jedem ersten Kauf einer Stufe wird zusätzlich Silber in Höhe des Aufladebetrags geschenkt. (Einmalig pro Stufe)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buy_Content = {Text = "Kaufen"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Cost_Tips_Content = {Text = "Verbrauch"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Double_Content = {
    Text = "Zusätzlich"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Expired_Content = {Text = "Abgelaufen"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Extra_Content = {
    Text = "Zusätzlich"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Flushed_Content = {
    Text = "Aktualisieren"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_NumName_Content = {
    Text = "Quellflüssigkeit"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_Title_Content = {
    Text = "Sofort erhalten"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_NumName_Content = {Text = "Silberkern"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title2_Content = {
    Text = "（30 Tage）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title_Content = {
    Text = "Tägliche Geschenke"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Illustrate_Content = {
    Text = "Kann kumulativ gekauft werden"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_OnekeyPurchase_Content = {
    Text = "Ein-Klick-Kauf"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Refresh_Content = {
    Text = "Kundendienst kontaktieren"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip1_Content = {
    Text = "Tägliche Anmeldung bringt insgesamt\nSilberkerne <color=#57F8FE><size=38>×6000</size></color>!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip2_Content = {
    Text = "Tägliche Anmeldung bringt insgesamt\n<color=#57F8FE><size=38>6000</size></color> Menophin und<color=#57F8FE><size=38>600</size></color> Verfolgungsfeder!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Get1_Title_Content = {
    Text = "Sofort erhalten"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Illustrate_Content = {
    Text = "Spielregeln"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Need_Content = {
    Text = "Erforderlich"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Tips_Content = {
    Text = "Tägliche Geschenke per E-Mail (30 Tage)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Title_Content = {
    Text = "Scheidenversorgung"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Tips_Content = {
    Text = "*Insgesamt 300 + 6000 Silber erhältlich!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Title_Content = {
    Text = "Misaq-Geschäft"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Today_Content = {
    Text = "Heute abgeholt"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Month_Content = {
    Text = "Mondphasenbeobachtung"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Recharge_Content = {Text = "Aufladen"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Root_Content = {
    Text = "Wurzel Schaum"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Month_Content = {
    Text = "Mondphasenbeobachtung"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Recharge_Content = {Text = "Aufladen"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Root_Content = {
    Text = "Wurzel Schaum"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Get2_Title2_Content = {
    Text = "（30 Tage）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Name_Content = {Text = "Kaufen"},
  PanelText_UI_Recharge_Panel_Main_Text_Tips_Content = {
    Text = "*Insgesamt 300 + 6000 Silber erhältlich!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_Content = {
    Text = "Mondphasenbeobachtung"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_Content = {Text = "Aufladen"},
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Root_Content = {
    Text = "Wurzel Schaum"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Month_Content = {
    Text = "Mondphasenbeobachtung"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Recharge_Content = {Text = "Aufladen"},
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Root_Content = {
    Text = "Wurzel Schaum"
  },
  PanelText_UI_Recharge_Panel_Month_Tips_Text_C_Today_Content = {
    Text = "Klicke, um die Mondphasenbeobachtungsbelohnung zu erhalten"
  },
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Disable_Content = {Text = "Kaufen"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Normal_Content = {Text = "Kaufen"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Title_Content = {
    Text = "Misaq-Geschäft"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cancel_Content = {Text = "Abbrechen"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Confirm_Content = {Text = "Kaufen"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cost_Tips_Content = {Text = "Verbrauch"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_Content = {
    Text = "Kauf bestätigen"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_En_Content = {Text = "Title"},
  PanelText_UI_Recharge_Reset_Item_Text_C_Double_Content = {
    Text = "Erste Aufladung"
  },
  PanelText_UI_Recharge_Reset_Item_Text_C_Extra_Content = {
    Text = "Zusätzlich"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_Activate_Content = {Text = "Aktiviert"},
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_NoeGet_Content = {
    Text = "Erweckter nicht erhalten"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_Name_Content = {
    Text = "Talent aktivieren"
  },
  PanelText_UI_Research_Panel_Ceri_Text_C_Activate_Content = {Text = "Aktiviert"},
  PanelText_UI_Research_Panel_Ceri_Text_C_Title_Content = {
    Text = "Talent Übersicht"
  },
  PanelText_UI_Research_Panel_Challenge_Item_Text_C_Undone_Content = {
    Text = "Unvollständig"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_PlanName_Content = {
    Text = "Fortschritt"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_ReachName_Content = {
    Text = "Alle Erfolge erreicht"
  },
  PanelText_UI_Research_Panel_Challenge_Text_Title_Content = {Text = "Erfolge"},
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Count_Content = {Text = "Regeln"},
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Extra_Content = {
    Text = "[Zusätzlich]"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_NoTask_Content = {
    Text = "Vorübergehend keine neuen Aufgabeneinsätze verfügbar"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special2_Content = {
    Text = "Bei jeder Überschreitung von 20 Leveln des Gesamteinsatzes erhält man eine zusätzliche Belohnung"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special_Content = {
    Text = "Erfolgsbedingungen"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_Underway_Content = {
    Text = "Einsatz läuft"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Tip_Content = {Text = "Abzuholen"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Unclickable_Content = {
    Text = "Nicht freigeschaltet"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Underway_Content = {
    Text = "In Bearbeitung"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Content = {
    Text = "Verbleibend"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Normal_Content = {Text = "Verbrauch"},
  PanelText_UI_Research_Panel_Dispatch_Text_Title_Content = {Text = "Senden"},
  PanelText_UI_Research_Popup_Dispatch_Text_Title_Content = {
    Text = "Überblick über die Einsatzboni"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Agin_Content = {
    Text = "Nochmals Aufgaben"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Dispatch_Content = {
    Text = "Einsatz erwecken"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Reward_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Title_Content = {
    Text = "Einsatzbericht"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Close_Content = {Text = "Schließen"},
  PanelText_UI_Research_Popup_Recall_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Dispatch_Content = {
    Text = "Gesamtlevel"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Extra_Content = {
    Text = "[Zusätzlich]"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Level_Content = {
    Text = "Gesendete Gesamtstufe"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special2_Content = {
    Text = "Einsatz Gesamtlevel über 20 erhöht, erhält man eine zusätzliche Belohnung"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special_Content = {
    Text = "Erfolgsbedingungen"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Title_Content = {
    Text = "Wähle einen Erwecker, um ihn zu entsenden"
  },
  PanelText_UI_Research_Popup_Report_Text_C_Title_Content = {
    Text = "Ermittlungsbericht"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_C_Tip_Content = {
    Text = "Die Sprache kann später unter “Einstellungen“ erneut ausgewählt werden."
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_Name_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_Title_Content = {
    Text = "Sprache auswählen"
  },
  PanelText_UI_Setting_Popup_Code_Text_C_Clean_Content = {Text = "Beseitigen"},
  PanelText_UI_Setting_Popup_Code_Text_C_Paste_Content = {Text = "Einfügen"},
  PanelText_UI_Setting_Popup_Code_Text_C_Tips_Content = {
    Text = "Gib den Gutscheincode ein"
  },
  PanelText_UI_Setting_Popup_Down_Text_C_Downing_Content = {
    Text = "Ressourcen werden heruntergeladen"
  },
  PanelText_UI_Setting_Popup_Examine_Text_C_Examine_Content = {
    Text = "Überprüft die Integrität der Spielressourcen"
  },
  PanelText_UI_Setting_Popup_Main_Text_C_Tips_Content = {
    Text = "Interner GM"
  },
  PanelText_UI_Setting_Popup_Main_Text_C_Title_Content = {
    Text = "Einstellungen"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_1_Content = {Text = "Abholen"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_2_Content = {Text = "Abholen"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Title_Content = {
    Text = "Anmeldebelohnung"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_1_Content = {
    Text = "Nicht erreicht"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_2_Content = {
    Text = "Nicht erreicht"
  },
  PanelText_UI_Shop_Item_Commodity_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Shop_Item_Commodity_Text_C_Value_Content = {Text = "Superwert"},
  PanelText_UI_Shop_Item_Toggle_Text_C_Recommend_Content = {Text = "Empfehlung"},
  PanelText_UI_Shop_Popup_Tips_Text_C_Tips_Content = {
    Text = "Nicht genug Währung"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Assist_Content = {
    Text = "Kampfunterstützung Anzahl"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Awaker_Content = {
    Text = "Erwachten verbinden"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Birthday_Content = {Text = "Geburtstag"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Concern2_Content = {Text = "Beobachten"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Conclude_Content = {
    Text = "Erfolg erreicht"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Difficulty_Content = {
    Text = "Ermittlungseinsatz"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Dream_Content = {
    Text = "Traumtauchen"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Fans_Content = {Text = "Anhänger"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Highest_Content = {
    Text = "Höchster Rekord"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Indestructible_Content = {
    Text = "Lichtloses Reich: Rotationslücke"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Pagoda_Content = {
    Text = "Lichtloses Reich"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Privacy_Content = {
    Text = "Der Geheimnisträger hat den Untersuchungsstatus auf privat gesetzt"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Register_Content = {
    Text = "Anmeldetage"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Society_Content = {Text = "Gilde"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Survey_Content = {
    Text = "Ermittlungsstatus"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Placeholder_Content = {
    Text = "Bitte geben Sie eine persönliche Beschreibung ein"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Abyss_Content = {
    Text = "Fusionskatastrophe Sperrzone"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Assist_Content = {
    Text = "Kampfunterstützung Anzahl"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Attention_Content = {Text = "Beobachten"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Awaker_Content = {
    Text = "Erwachten verbinden"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Ban_Content = {Text = "Blockieren"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Birthday_Content = {Text = "Geburtstag"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Collection_Content = {
    Text = "Sammlungsfortschritt"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Concern2_Content = {Text = "Beobachten"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Conclude_Content = {
    Text = "Erfolg erreicht"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Difficulty_Content = {
    Text = "Ermittlungseinsatz"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Dream_Content = {
    Text = "Traumtauchen"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Fans_Content = {Text = "Anhänger"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Gender_Content = {Text = "Geschlecht"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Hard_Content = {Text = "Schwierig"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Highest_Content = {
    Text = "Höchster Rekord"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Indestructible_Content = {
    Text = "Lichtloses Reich: Rotationslücke"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Interrelated_Content = {
    Text = "Gegenseitiges Folgen"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Normal_Content = {Text = "Normal"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Notset_Content = {
    Text = "Nicht eingestellt"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Pagoda_Content = {
    Text = "Lichtloses Reich: Riss"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Privacy_Content = {
    Text = "Der Geheimnisträger hat den Untersuchungsstatus auf privat gesetzt"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Register_Content = {
    Text = "Anmeldetage"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Society_Content = {Text = "Gilde"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Survey_Content = {
    Text = "Ermittlungsstatus"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_1_Content = {Text = "Gesamt"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_2_Content = {
    Text = "Höchste Aufzeichnung"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_NickNamePre_Content = {
    Text = "Bemerkung :"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Help_Content = {
    Text = "Kampfunterstützung Erwachter"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Not_Content = {
    Text = "Keine Unterstützungserweckter eingestellt"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Null_1_Content = {
    Text = "Erweckter nicht angezeigt"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Squiggle_Content = {
    Text = "Silber bringt Wissen."
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Team_Content = {
    Text = "Erwachte Präsentation"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Accept_Content = {
    Text = "Akzeptieren"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Cancel_Content = {
    Text = "Bereits abgebrochen"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Done_Content = {
    Text = "Folgt mir bereits"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Mutual_Content = {
    Text = "Gegenseitiges Folgen"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse2_Content = {Text = "Abgelehnt"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse_Content = {Text = "Ablehnen"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Timeout_Content = {
    Text = "Zeitüberschreitung"
  },
  PanelText_UI_Social_Item_PveRecord_Text_Fail_Content = {Text = "Fehlschlag"},
  PanelText_UI_Social_Item_PveRecord_Text_Victory_Content = {Text = "Sieg"},
  PanelText_UI_Social_Item_PvpData_Text_C_Point_01_Content = {Text = "Teilen"},
  PanelText_UI_Social_Item_PvpData_Text_Fail_Content = {Text = "Fehlschlag"},
  PanelText_UI_Social_Item_PvpData_Text_Victory_Content = {Text = "Sieg"},
  PanelText_UI_Social_Item_PvpRecord_Text_Fail_Content = {Text = "Fehlschlag"},
  PanelText_UI_Social_Item_PvpRecord_Text_Victory_Content = {Text = "Sieg"},
  PanelText_UI_Social_Item_Pvp_Text_C_Dispaly_Content = {
    Text = "Kampflogbuch freigeben"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Input_Content = {
    Text = "Geben Sie “Kampflogbuch“ ein, um die Wiederholung anzusehen"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen von Traphase verfügbar"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Nor_Content = {
    Text = "Ermittlungseinsatz"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Sel_Content = {
    Text = "Ermittlungseinsatz"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Nor_Content = {
    Text = "Phasenduell"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Sel_Content = {
    Text = "Phasenduell"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Search_Content = {
    Text = "Aufzeichnung ansehen"
  },
  PanelText_UI_Social_Item_Pvp_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Attention_Content = {Text = "Beobachten"},
  PanelText_UI_Social_Item_Rank_Text_C_Following_Content = {
    Text = "Bereits gefolgt"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Interrelated_Content = {
    Text = "Bereits gegenseitig gefolgt"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Assist_Content = {
    Text = "Kampfunterstützung Anzahl"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Awaker_Content = {
    Text = "Erwachten verbinden"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Birthday_Content = {Text = "Geburtstag"},
  PanelText_UI_Social_Panel_Data_Text_C_Concern2_Content = {Text = "Beobachten"},
  PanelText_UI_Social_Panel_Data_Text_C_Conclude_Content = {
    Text = "Erfolg erreicht"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Difficulty_Content = {Text = "Schwierig"},
  PanelText_UI_Social_Panel_Data_Text_C_Dream_Content = {
    Text = "Traumtauchen"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Fans_Content = {Text = "Anhänger"},
  PanelText_UI_Social_Panel_Data_Text_C_Help_Content = {
    Text = "Kampfunterstützung Erwachter"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Indestructible_Content = {
    Text = "Unbeschreiblich"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Not_Content = {
    Text = "Keine Unterstützungserweckter eingestellt"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Null_1_Content = {
    Text = "Erweckter nicht angezeigt"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Pagoda_Content = {
    Text = "Turm ohne Licht"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Privacy_Content = {
    Text = "Der Geheimnisträger hat den Untersuchungsstatus auf privat gesetzt"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Register_Content = {
    Text = "Anmeldetage"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Society_Content = {Text = "Gilde"},
  PanelText_UI_Social_Panel_Data_Text_C_Squiggle_Content = {
    Text = "Silber bringt Wissen."
  },
  PanelText_UI_Social_Panel_Data_Text_C_Survey_Content = {
    Text = "Ermittlungsstatus"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Team_Content = {
    Text = "Erwachte Präsentation"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Title_Content = {
    Text = "Schutzherr Archiv"
  },
  PanelText_UI_Social_Panel_HelpList_Filter_Text_C_Selected_Content = {
    Text = "Ausgewählt"
  },
  ["PanelText_UI_Social_Panel_HelpList_Item_Text_C_ Interrelated_Content"] = {
    Text = "Gegenseitiges Folgen"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Attention_Content = {Text = "Beobachten"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Commonly_Content = {
    Text = "Häufig verwendete Unterstützung"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Conflict_Content = {
    Text = "Grenzgebiet-Konflikt"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Fans_Content = {Text = "Anhänger"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Following_Content = {
    Text = "Bereits gefolgt"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recent_Content = {
    Text = "Letzte Unterstützung"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recommend_Content = {
    Text = "Empfohlene Beobachtung"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_CommonlyAssist_Content = {
    Text = "Häufig verwendete Unterstützung"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_1_Content = {
    Text = "Aktualisieren"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_Content = {Text = "Auftritt"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_1_Content = {
    Text = "Aktualisieren"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_Content = {Text = "Auftritt"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Mail_Content = {Text = "Regeln"},
  PanelText_UI_Social_Panel_HelpList_Text_C_NoTask_Content = {
    Text = "Keine Unterstützungs-Erweckten"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Time_Content = {
    Text = "Mit den Kampfunterstützungen der gegenseitig befreundeten Geheimnisträger in den Kampf ziehen"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Title_Content = {
    Text = "Wähle Unterstützung"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Attention_Content = {Text = "Beobachten"},
  PanelText_UI_Social_Panel_Main_Item_Text_C_Done_Content = {
    Text = "Folgt mir bereits"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Following_Content = {
    Text = "Bereits gefolgt"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Interrelated_Content = {
    Text = "Gegenseitiges Folgen"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Mutual_Content = {
    Text = "Gegenseitiges Folgen"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Unblock_Content = {
    Text = "Blockierung aufheben"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_Unfollow_Content = {Text = "Entfolgen"},
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Concern_Content = {
    Text = "Neu hinzugefügt"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_NoTask_Content = {
    Text = "Niemanden gefolgt"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_NoTask_Content = {
    Text = "Keine relevanten Suchergebnisse"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_Name_Content = {
    Text = "Alle beobachten"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Concern_Content = {
    Text = "Neu hinzugefügt"
  },
  PanelText_UI_Social_Panel_Main_Text_C_NoTask_Content = {
    Text = "Keine Follower"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Stranger_Content = {Text = "Fremder"},
  PanelText_UI_Social_Panel_Main_Text_C_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_1_Content = {
    Text = "Gib den Namen ein, um zu suchen"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_2_Content = {
    Text = "Gib den Namen ein, um zu suchen"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_Interaction_Content = {
    Text = "Interaktion"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_PlayerInfo_Content = {Text = "Experte"},
  PanelText_UI_Social_Panel_RankList_Text_C_Rank_Content = {Text = "Rang"},
  PanelText_UI_Social_Panel_Rank_Text_C_All_Content = {Text = "Alles"},
  PanelText_UI_Social_Panel_Rank_Text_C_Friend_Content = {Text = "Beobachten"},
  PanelText_UI_Social_Panel_Rank_Text_C_Interaction_Content = {
    Text = "Interaktion"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_NoTask_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_PlayerInfo_Content = {
    Text = "Hüter-Informationen"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Rank_Content = {Text = "Rang"},
  PanelText_UI_Social_Panel_Rank_Text_C_Sign_Content = {
    Text = "Beschreibung"
  },
  PanelText_UI_Social_Popup_Awaker_Text_C_Owned_Content = {Text = "Besitzt"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Day_Content = {Text = "Tag"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Month_Content = {Text = "Monat"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Title_Content = {
    Text = "Geburtstag bearbeiten"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_NoTask_Content = {
    Text = "Keine Kampfunterstützungspartner"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_SearchTip_Content = {
    Text = "Gib die UID ein, um den Geheimnishüter zu finden"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Search_Content = {
    Text = "Durchsuchen"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Title_Content = {
    Text = "Häufig verwendete Unterstützung"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_Time_Content = {
    Text = "Schau dich woanders um"
  },
  PanelText_UI_Social_Popup_FriendlyInvite_Text_Title_Content = {
    Text = "Freundschaftsspiel-Einladung"
  },
  PanelText_UI_Social_Popup_Introduction_Text_C_Placeholder_Content = {
    Text = "Bitte geben Sie eine persönliche Beschreibung ein"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Content = {Text = "Auswahl"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Desc_Content = {
    Text = "Kämpfe mit einem vorgefertigten Deck"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Name_Content = {
    Text = "Vorgruppierungsmodus"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Content = {Text = "Auswahl"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Desc_Content = {
    Text = "Wahlkampf mit einem zufälligen Kartensatz"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Name_Content = {Text = "Wahlmodus"},
  PanelText_UI_Social_Popup_MatchMode_Text_Title_Content = {
    Text = "Wähle Modus"
  },
  PanelText_UI_Social_Popup_Match_Text_C_Waiting_Content = {Text = "Wartet"},
  PanelText_UI_Social_Popup_Match_Text_Name_Content = {Text = "Abbrechen"},
  PanelText_UI_Social_Popup_Match_Text_Title_Content = {
    Text = "Freundschaftsspiel"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Content = {
    Text = "Avatar-Rahmen"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Sel_Content = {
    Text = "Avatar-Rahmen"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Sel_Content = {Text = "Avatar"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Using_Content = {
    Text = "In Verwendung"
  },
  PanelText_UI_Social_Popup_Situation_Tips_Text_C_AffixInfo_Content = {
    Text = "Ermittlungsstatus"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_C_Cost_Content = {Text = "Verbrauch"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Cancel_Name_Content = {Text = "Abbrechen"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Confirm_Name_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_Title_Content = {
    Text = "Geschlecht wechseln"
  },
  PanelText_UI_Social_Popup_WatchList_Text_C_NoTask_Content = {
    Text = "Keine neuen Follower"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Name_FollowAll_Content = {
    Text = "Alle beobachten"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Tip_Content = {
    Text = "Sie können die 100 neuesten Anhänger einsehen"
  },
  PanelText_UI_Social_Tips_InviteBubble_Text_Name_Content = {
    Text = "Freundschaftsspiel"
  },
  PanelText_UI_Story_Panel_Main_Text_C_High_Content = {
    Text = "Login-Hintergrund zurücksetzen"
  },
  PanelText_UI_Story_Panel_Main_Text_C_Normal_Content = {
    Text = "Als Login-Hintergrund festlegen"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Continue_Content = {
    Text = "Weiterreisen"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Title_Content = {
    Text = "Speicherarchivierung"
  },
  PanelText_UI_Story_Portrait_Test_Text_C_Close_Content = {Text = "Schließen"},
  PanelText_UI_Story_Portrait_Test_Text_C_Hide_Content = {Text = "Verstecken"},
  PanelText_UI_Summon_Btn_Jump_Text_C_Look_Content = {Text = "Ansehen"},
  PanelText_UI_Summon_Btn_Realms_Text_C_Difficulty_Content = {
    Text = "Einstiegslevel"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Directional_Content = {
    Text = "Aktuelle Ausrichtung"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Name_Content = {Text = "Wählen"},
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Full_Content = {
    Text = "Die Aufstieg ist voll"
  },
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Have_Content = {Text = "Besitzt"},
  PanelText_UI_Summon_Item_Probability_Text_C_Name_Content = {
    Text = "Bezeichnung"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Role_Content = {
    Text = "Gesamtwahrscheinlichkeit"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Time_Content = {
    Text = "Bezeichnung"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Type_Content = {Text = "Typ"},
  PanelText_UI_Summon_Item_Probability_Text_Limit_Content = {Text = "Limitiert"},
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_GiftTitle_Content = {
    Text = "Aufgabe abschließen und Phantasma-Robe-Tauschcoupon erhalten"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_1_Content = {
    Text = "Es müssen zwei davon vorhanden sein"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_2_Content = {
    Text = "Es müssen drei sein"
  },
  PanelText_UI_Summon_Panel_Main_Text_Award_Content = {
    Text = "Zusätzliche Belohnung"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Choose_Content = {
    Text = "Starte die Auswahl"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Difficult_Title_Content = {
    Text = "Einstiegslevel"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_FirstLimit_Content = {
    Text = "Erste Auflage - zeitlich begrenzt"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_FreeLimit_Content = {Text = "Kostenlos"},
  PanelText_UI_Summon_Panel_Main_Text_C_Hint_Content = {
    Text = "Aber hier klicken, um das Gebiet zu wechseln"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_LimitName_Content = {
    Text = "Fünfmal erwecken"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Limited_Content = {
    Text = "Limitierte Zeitrolle"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Look_Content = {Text = "Ansehen"},
  PanelText_UI_Summon_Panel_Main_Text_C_Realms_Content = {
    Text = "Gebiet auswählen"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_RecAwaker_Content = {
    Text = "Empfohlener Erwecker"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_School_Intro_Title_Content = {
    Text = "Reichseigenschaft——"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Summon_Content = {
    Text = "Fünfmal erwecken"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_System_Name_Content = {Text = "Erweckung"},
  PanelText_UI_Summon_Panel_Main_Text_C_TryName_Content = {
    Text = "Erwachte Testversion"
  },
  PanelText_UI_Summon_Panel_Main_Text_Desc_2_Content = {
    Text = "Beschreibung"
  },
  PanelText_UI_Summon_Panel_Main_Text_FreeTen_Content = {Text = "Kostenlos"},
  PanelText_UI_Summon_Panel_Main_Text_Recommend_Content = {
    Text = "Neugeboren Empfehlung Erwecken"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Choose_Content = {
    Text = "Starte die Auswahl"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Title_Content = {
    Text = "Erwecker festgelegt"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Detail_Content = {Text = "Regeln"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Inventory_Content = {
    Text = "Gegenstandsliste"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Name_Content = {
    Text = "Bezeichnung"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Not_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Prompt_Content = {
    Text = "Auf dieser Seite können die Weckprotokolle der letzten 6 Monate eingesehen werden, Daten können um etwa eine Stunde verzögert sein"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_REcording_Content = {
    Text = "Historische Aufzeichnungen"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Role_Content = {
    Text = "Erweckungstyp"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Time_Content = {
    Text = "Erweckungszeit"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_1_Content = {
    Text = "Erweckungstyp"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_Content = {Text = "Typ"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Up_Content = {
    Text = "UP-Gegenstände"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Name_Content = {
    Text = "Bezeichnung"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Not_Content = {
    Text = "Keine Aufzeichnungen"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Prompt_Content = {
    Text = "Auf dieser Seite können die Weckprotokolle der letzten 6 Monate eingesehen werden, Daten können um etwa eine Stunde verzögert sein"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Role_Content = {
    Text = "Erweckungstyp"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Time_Content = {
    Text = "Erweckungszeit"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Title_Content = {
    Text = "Erweckungshistorie"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Type_Content = {Text = "Typ"},
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Change_Content = {
    Text = "Neu auswählen"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_ChooseTitle_Content = {
    Text = "Wähle Erwachenskörper"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Choose_Content = {
    Text = "Starte die Auswahl"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_InfoTitle_Content = {
    Text = "Spielanleitung"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_Title_Content = {
    Text = "Wähle Erwachenskörper"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Confirm_Content = {
    Text = "Auswahl bestätigen"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Tip_Content = {
    Text = "Lange drücken, um die Details des Erwachten anzuzeigen"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Confirm_Content = {
    Text = "Auswahl bestätigen"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Tip_Content = {
    Text = "Lange drücken, um die Details des Erwachten anzuzeigen"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Title_Content = {
    Text = "Wähle Erwachenskörper"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Activity_Content = {
    Text = "Schicksalsrad verschenken"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Game_Content = {
    Text = "Erwachte Geschenk"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Info_Content = {
    Text = "Nach 150 Wachsamkeiten von [Reich-Studie] erhältst du zusätzlich einen beliebigen Erwecker/Rad des Schicksals"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Plan_Content = {
    Text = "Fortschritt"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Check_Content = {
    Text = "Details anzeigen"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Git_Content = {Text = "Abholen"},
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Detail_Content = {
    Text = "Detailbeschreibung"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Inventory_Content = {
    Text = "Gegenstandsliste"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Up_Content = {
    Text = "UP-Gegenstände"
  },
  PanelText_UI_Summon_Popup_Realms_Text_C_Introduce_Content = {
    Text = "Wähle Bereich, der erweckte Charakter wird aus diesem Bereich sein, kann später geändert werden"
  },
  PanelText_UI_Summon_Popup_Realms_Text_C_Title_Content = {
    Text = "Bestimmtes Gebiet"
  },
  PanelText_UI_Summon_Popup_Recording_Text_C_Prompt_Content = {
    Text = "Auf dieser Seite können die Weckprotokolle der letzten 6 Monate eingesehen werden, Daten können um etwa eine Stunde verzögert sein"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_ChooseTitle_Content = {
    Text = "Wähle Erwachenskörper"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_Choose_Content = {
    Text = "Starte die Auswahl"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_InfoTitle_Content = {
    Text = "Spielanleitung"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_Title_Content = {
    Text = "Wähle Erwachenskörper"
  },
  PanelText_UI_Summon_Popup_Share_Text_C_Share_Content = {
    Text = "Teilen bis:"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_Autofine_Content = {
    Text = "Automatisches Stapeln"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_C_Name_Content = {
    Text = "Einmal erwecken"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_Autofine_Content = {
    Text = "Automatisches Stapeln"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_C_Name_Content = {
    Text = "Einmal erwecken"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_Autofine_Content = {
    Text = "Automatisches Stapeln"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_C_Name_Content = {
    Text = "Einmal erwecken"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_C_Share_Content = {
    Text = "Erstes Teilen erhalten"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Confirm_Name_Content = {
    Text = "Bestätigen"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Name_Content = {
    Text = "Wiedererweckung"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_ReSummon_Content = {
    Text = "Fünfmal erwecken"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Toggle_Content = {
    Text = "Schnelle Erweckung"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Name_Content = {
    Text = "Einmal erwecken"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Share_Content = {
    Text = "Erstes Teilen erhalten"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Auto_Content = {
    Text = "Empfehlung für automatische Schicksalsrad-Erhaltung"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_ChooseTitle_Content = {
    Text = "Wähle Erwachenskörper"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Choose_Content = {
    Text = "Wähle Erwachenskörper"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Confirm_Content = {
    Text = "Auswahl bestätigen"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_InfoTitle_Content = {
    Text = "Spielanleitung"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_Title_Content = {
    Text = "Wähle Erwachenskörper"
  },
  PanelText_UI_Task_Item_Detail_List_New_Text_C_Get_Content = {Text = "Abholen"},
  PanelText_UI_Task_Panel_Main_New_Text_C_Achievement_Content = {
    Text = "Karriereerfolge"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_ActionReports_Content = {
    Text = "Missionsbericht"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_GrowUp_Content = {
    Text = "Wachstumsprotokoll"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Master_Content = {
    Text = "Reichsbeherrschung"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips2_Content = {
    Text = "Aufgabenliste leer"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips_Content = {
    Text = "Tägliche Aufgaben abgeschlossen"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Title_Content = {
    Text = "Keine Aufgaben"
  },
  PanelText_UI_Task_Popup_Career_Item_Text_C_Undone_Content = {
    Text = "Unvollständig"
  },
  PanelText_UI_Task_Popup_Career_Item_Text_Name_Content = {Text = "Abholen"},
  PanelText_UI_Task_Popup_Career_New_Text_C_1_Content = {
    Text = "Fortschritt"
  },
  PanelText_UI_Task_Popup_Career_New_Text_C_Chapter_Award_Content = {
    Text = "Belohnung abschließen"
  },
  PanelText_UI_Task_Popup_Career_Text_C_1_Content = {
    Text = "Fortschritt"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Award_Content = {
    Text = "Belohnung abschließen"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Get_Content = {
    Text = "Belohnung abgeholt"
  },
  PanelText_UI_Task_Popup_Career_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_Name_2_Content = {
    Text = "Alles abholen"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_ReachName_Content = {
    Text = "“Alle“Erfolge erreicht"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Info1_Content = {
    Text = "Erhöhe das Untersuchungslevel, um Belohnungen zu erhalten"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Level1_Content = {Text = "Level"},
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Undone1_Content = {
    Text = "Unvollständig"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_Name_Content = {Text = "Abholen"},
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Info_Content = {
    Text = "Erhöhe das Untersuchungslevel, um Belohnungen zu erhalten"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Level_Content = {Text = "Level"},
  PanelText_UI_Task_Popup_Challenge_Item_Text_Name_Content = {Text = "Abholen"},
  PanelText_UI_Task_Popup_Challenge_New_Text_C_1_Content = {
    Text = "Geheimnishüter"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_2_Content = {
    Text = "Aufnahmezeit"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_3_Content = {
    Text = "Ermittlungsstufe"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_Title_Content = {
    Text = "Erfolg freischalten"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_1_Content = {Text = "Schutzherr"},
  PanelText_UI_Task_Popup_Challenge_Text_C_2_Content = {
    Text = "Aufnahmezeit"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_3_Content = {
    Text = "Ermittlungsstufe"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_OneKey_Content = {
    Text = "Ein-Klick-Abholung"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Reach_Content = {
    Text = "Möge der Silberne Schlüssel uns leiten"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Title_Content = {
    Text = "Schülerausweis"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Award_Content = {
    Text = "Aufgabenbelohnung"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Special_Content = {
    Text = "Einsatzbedingungen"
  },
  PanelText_UI_Team_Item_Awaker_List_Text_C_Disable_Content = {
    Text = "Deaktivieren"
  },
  PanelText_UI_Team_Item_Awaker_List_Text_C_Help_Content = {
    Text = "Kampfunterstützung Erwachter"
  },
  PanelText_UI_Team_Item_MyTeam_List_Text_C_Current_Content = {
    Text = "Aktuell im Einsatz"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Guide_Content = {Text = "Empfehlung"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Hint_Content = {
    Text = "*Ein Erwachter kann nur ein SSR-Schicksalsrad ausrüsten"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Recommend_Content = {Text = "Empfehlung"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Remove_Content = {
    Text = "Ein-Klick-Demontage"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Save_Content = {Text = "Speichern"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Uninstall_Content = {
    Text = "Ein-Klick-Demontage"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Foundation_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Lv_Content = {
    Text = "Stufenfortschritt"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Refining_Content = {
    Text = "Transkriptionsfortschritt"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Null_Content = {
    Text = "Keine aktiven Set-Effekte"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Title_Content = {Text = "Set-Effekt"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Added_Content = {
    Text = "Neuer Bündnisplan"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_2_Content = {Text = "Abnehmen"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_3_Content = {
    Text = "Verstärkung"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_4_Content = {
    Text = "Ausrüstung"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Null_Content = {
    Text = "Am aktuellen Standort sind keine Bunde verfügbar"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Quantity_Content = {
    Text = "Anzahl der Pläne"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Save_Content = {
    Text = "Neuer Bündnisplan"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Suit_Content = {
    Text = "Keine verfügbaren Pläne"
  },
  PanelText_UI_Team_Item_Suit_Text_C_Current_Content = {
    Text = "Aktuell in Verwendung"
  },
  PanelText_UI_Team_Item_Talent_Text_C_Activate_Content = {Text = "Aktiviert"},
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Foundation_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Lv_Content = {
    Text = "Stufenfortschritt"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Refining_Content = {
    Text = "Transkriptionsfortschritt"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Null_Content = {
    Text = "Keine aktiven Set-Effekte"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Title_Content = {Text = "Set-Effekt"},
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Empty_Content = {
    Text = "Linke Seite: Schicksalsrad ausrüsten"
  },
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Not_Content = {
    Text = "Nicht wirksam"
  },
  PanelText_UI_Team_Panel_Awaker_Main_Text_C_Zhanli_Content = {Text = "Kampfkraft"},
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Recommend_Content = {Text = "Empfehlung"},
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Remove_Content = {
    Text = "Ein-Klick-Demontage"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Save_Content = {Text = "Speichern"},
  PanelText_UI_Team_Panel_Main_Popup_Team_Text_C_AffixInfo_Content = {Text = "Team-Info"},
  PanelText_UI_Team_Panel_Main_Text_C_Activated_Content = {Text = "Aktiviert"},
  PanelText_UI_Team_Panel_Main_Text_C_Boundaries_Tips_Content = {
    Text = "Reichsempfehlung"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Cost_Tips_Content = {
    Text = "Teamanforderungen:"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Empty_Content = {
    Text = "Schlüsselbefehl nicht ausgerüstet"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Frequency_Content = {Text = "Anzahl"},
  PanelText_UI_Team_Panel_Main_Text_C_Hint_Content = {
    Text = "*Nach dem Abschluss können die eingesetzten Erwachten, Schicksalsräder und Schlüssel nicht in anderen Korrosionszonen eingesetzt werden"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Lives_Desc_Content = {
    Text = "Verbleibende Notfall-Geist Nutzungen:"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Name_1_Content = {Text = "Aufheben"},
  PanelText_UI_Team_Panel_Main_Text_C_Name_2_Content = {
    Text = "Kampfunterstützung"
  },
  PanelText_UI_Team_Panel_Main_Text_C_NoActivate_Content = {
    Text = "Nicht aktiviert"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Prohibit_Content = {
    Text = "Schlüsselbefehle in diesem Level deaktiviert"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Skill_Content = {Text = "Posse"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips2_Content = {Text = "Team-Info"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips_1_Content = {
    Text = "Kampfunterstützung"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_2_Content = {
    Text = "Kampfunterstützung"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_Content = {
    Text = "Unterstützung aufheben"
  },
  PanelText_UI_Team_Panel_Main_Text_Career_Content = {
    Text = "Gefordertes Reich"
  },
  PanelText_UI_Team_Panel_Main_Text_Madness_Content = {
    Text = "Nur bei erstmaliger Meisterung des Wahnsinnsmodus gibt es Belohnungen"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Delete_Content = {
    Text = "Plan löschen"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Edit_Content = {
    Text = "Plan bearbeiten"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Recommend_Content = {
    Text = "Empfohlene Ausrüstung"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Remove_Content = {
    Text = "Ein-Klick-Demontage"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Save_Content = {
    Text = "Als Vorlage speichern"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Guide_Content = {Text = "Empfehlung"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Hint_Content = {
    Text = "*Ein Erwachter kann nur ein SSR-Schicksalsrad ausrüsten"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_2_Content = {Text = "Abnehmen"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_3_Content = {
    Text = "Stapelposition"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Null_Content = {
    Text = "Keine Schicksalsräder"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Title_Content = {
    Text = "Wähle Schicksalsrad"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Uninstall_Content = {
    Text = "Ein-Klick-Demontage"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Attribute_Content = {
    Text = "Eigenschaften"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Name_Content = {
    Text = "Erwachte Details"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "Wähle Erwachenskörper"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Xx_Content = {
    Text = "Detaillierte Informationen"
  },
  PanelText_UI_Team_Popup_MyTeam_Awaker_List_Text_C_Name_Content = {Text = "Auswahl"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name01_Content = {Text = "Chaos"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name02_Content = {Text = "Aequor"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name03_Content = {Text = "Fleisch"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name04_Content = {Text = "Ultra"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "Berufstalent"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_C_Task_Content = {
    Text = "Sofort nach Abschluss des Ereignisses erhalten"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_Title_Content = {
    Text = "Erster Durchlauf Belohnung"
  },
  PanelText_UI_Vx_Battle_Chaowei_Butter_Text_C_ExtraTurn_Content = {
    Text = "Zusätzliche Runde"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Normal_Content = {
    Text = "Stapel-Reihenfolge"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Select_Content = {
    Text = "Stapel-Reihenfolge"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Normal_Content = {
    Text = "Reihenfolge"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Select_Content = {
    Text = "Reihenfolge"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_No_Weapon2_Content = {
    Text = "Keine ausrüstbare Schicksalslinie"
  },
  PanelText__Text_C_Dress_Content = {Text = "Wechseln"},
  PanelText__Text_C_Dressing_Content = {
    Text = "Ausrüstung anlegen"
  },
  PanelText__Text_C_Empty_Content = {
    Text = "Abgebrochen"
  },
  PanelText__Text_C_Goto_Content = {
    Text = "Zum Kauf gehen"
  },
  PanelText__Text_C_Have_Content = {Text = "Besitzt"},
  PanelText__Text_C_Reveal_Content = {Text = "Verstecken"}
})
return Text_PanelText
