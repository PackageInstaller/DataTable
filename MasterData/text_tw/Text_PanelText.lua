__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_PanelText = readonly({
  PanelText_Battle_UltiSkill_Painting_EX_Text_C_UltiSkill_Content = {
    Text = "超限爆發"
  },
  PanelText_Btn_Block_Window_Text_C_Display_Content = {
    Text = "顯示卡牌"
  },
  PanelText_Btn_Block_Window_Text_C_Hide_Content = {
    Text = "隱藏卡牌"
  },
  PanelText_Btn_Get_Text_Name_Content = {Text = "領取"},
  ["PanelText_GmPanel_Text_C_Battle_Test (1)_Content"] = {Text = "戰鬥2.0"},
  PanelText_GmPanel_Text_C_Battle_Test2_Content = {Text = "PvP戰鬥"},
  PanelText_GmPanel_Text_C_Gb_Content = {Text = "關閉"},
  PanelText_GmPanel_Text_C_Hm_Content = {
    Text = "切換畫面效果高/低配"
  },
  PanelText_GmPanel_Text_C_Placeholder_Content = {
    Text = "輸入搜索"
  },
  PanelText_GmPanel_Text_C_Xy_Content = {
    Text = "測試協議"
  },
  PanelText_GmPanel_Text_C_Yc_Content = {
    Text = "隱藏GM面板"
  },
  PanelText_GmParamEquipPanel_Text_C_Fs_Content = {Text = "發 送"},
  PanelText_GmParamPanel_Text_C_Fs_Content = {Text = "發 送"},
  PanelText_Icon_Common_Text_C_NoEquip_Content = {
    Text = "無法裝備"
  },
  PanelText_Item_Battle_AwakerSkill_1_Text_C_CD_Content = {Text = "冷卻中"},
  PanelText_Item_Battle_AwakerSkill_1_Text_C_Ready_Content = {
    Text = "狂氣爆發"
  },
  PanelText_Panel_Battle_Monster_Information_Text_C_Monster_Content = {
    Text = "怪物意圖"
  },
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Confirm_Content = {Text = "確認"},
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Enter_Content = {Text = "挑戰"},
  PanelText_Panel_Gm_PVP_Text_C_Confirm_Content = {Text = "確認"},
  PanelText_Popup_Gm_Effect_Side_Text_Content = {
    Text = "編輯效果"
  },
  PanelText_Popup_Gm_Effect_Text_Cancel_Content = {Text = "關閉"},
  PanelText_Popup_Gm_Effect_Text_Confirm_Content = {Text = "確認"},
  PanelText_Simple_List_Panel_Text_Content = {Text = "關閉"},
  PanelText_Text_C_Activate_Text_C_Activate_Content = {
    Text = "激發材料"
  },
  PanelText_UI_Address_Panel_Main_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Address_Panel_Main_Text_C_NoTask1_Content = {
    Text = "選擇聯絡人"
  },
  PanelText_UI_Address_Panel_Main_Text_C_Title_Content = {Text = "通訊器"},
  PanelText_UI_Address_Panel_Main_Text_Time_Content = {
    Text = "點擊清單進行選擇"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_C_NoTask_Content = {
    Text = "暫無新訊息"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Title_Content = {Text = "通訊器"},
  PanelText_UI_Alchemy_Panel_Main_Text_C_Permute_Content = {
    Text = "材料置換"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveWeapon_Content = {
    Text = "命輪分解"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_Title_Content = {Text = "冶煉室"},
  PanelText_UI_Alchemy_Popup_Break_Down_Placeholder_Content = {
    Text = "點擊輸入答案"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Name_Content = {Text = "置換"},
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Possess_Tips_Content = {
    Text = "即將置換"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Tips_Content = {
    Text = "當前沒有可以分解的道具"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Title_Content = {
    Text = "置換所需材料"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Whole_Content = {Text = "全選"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_All_Content = {Text = "全選"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Cap_Content = {
    Text = "已強化至當前等級上限"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNum_Content = {Text = "數量"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Mail_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_MaterialsNull_Content = {
    Text = "尚無相關密契"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "正位已達上限"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Null_Content = {
    Text = "請選擇要分解的物品"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Resolve_Content = {
    Text = "分解獲得"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Sel_Content = {Text = "已選"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Screen_Content = {Text = "篩選"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Confirm_Content = {Text = "確認"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle1_Content = {Text = "套裝"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle3_Content = {Text = "主屬性"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle4_Content = {Text = "副屬性"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_SiftTitle_Text_C_Tips_Content = {
    Text = "點擊選擇"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_All_Content = {Text = "全選"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Cap_Content = {
    Text = "已強化至當前等級上限"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNum_Content = {Text = "數量"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_MaterialsNull_Content = {
    Text = "尚無相關密契"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_NormotopiaCap_Content = {
    Text = "疊位已達上限"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Null_Content = {
    Text = "請選擇要分解的物品"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Resolve_Content = {
    Text = "分解獲得"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Sel_Content = {Text = "已選"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_All_Content = {Text = "全選"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Cap_Content = {
    Text = "已強化至當前等級上限"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNum_Content = {Text = "數量"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Mail_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "正位已達上限"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Null_Content = {
    Text = "請選擇要分解的物品"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Resolve_Content = {
    Text = "分解獲得"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Sel_Content = {Text = "已選"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_WeaponNull_Content = {
    Text = "尚無相關命輪"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_All_Content = {Text = "全選"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Cap_Content = {
    Text = "已強化至當前等級上限"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNum_Content = {Text = "數量"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_NormotopiaCap_Content = {
    Text = "疊位已達上限"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Null_Content = {
    Text = "請選擇要分解的物品"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Resolve_Content = {
    Text = "分解獲得"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Sel_Content = {Text = "已選"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_WeaponNull_Content = {
    Text = "尚無相關命輪"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Whole_Content = {Text = "全選"},
  PanelText_UI_Alchemy_Popup_Resolve_Text_None_Tips_Content = {
    Text = "請從左側選擇需要分解的素材"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Possess_Tips_Content = {
    Text = "即將分解"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Slider_Tips_Content = {
    Text = "分解次數"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Tips_Content = {
    Text = "尚未擁有可以分解的素材"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Title_Content = {
    Text = "分解可獲得材料"
  },
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Not_Content = {Text = "無"},
  PanelText_UI_Awaker_Item_Info_Text_C_Attribute_Content = {Text = "屬性"},
  PanelText_UI_Awaker_Item_Info_Text_C_Configuration_Content = {
    Text = "隊伍配置"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Grade_Content = {Text = "等級"},
  PanelText_UI_Awaker_Item_Info_Text_C_High_Content = {
    Text = "顯示當前"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Content = {Text = "同調率"},
  PanelText_UI_Awaker_Item_Info_Text_C_No_Content = {Text = "未獲得"},
  PanelText_UI_Awaker_Item_Info_Text_C_Normal_Content = {
    Text = "60級預覽"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Potential_Content = {
    Text = "靈知深化"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Score_Force_Content = {Text = "戰力"},
  PanelText_UI_Awaker_Item_Info_Text_C_Xx_Content = {
    Text = "詳細資訊"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Full_Content = {
    Text = "啟靈已滿"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Got_Content = {Text = "已喚醒"},
  PanelText_UI_Awaker_Item_List_Text_C_Already_Content = {Text = "已擁有"},
  PanelText_UI_Awaker_Item_List_Text_C_Disable_Content = {
    Text = "不可更換"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Full_Content = {
    Text = "人格深化已滿"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Click_Content = {Text = "啟靈"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Content = {Text = "啟靈"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Click_Content = {Text = "檔案"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Content = {Text = "檔案"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Click_Content = {Text = "狀態"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Content = {Text = "狀態"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_TalentSelected_Content = {Text = "天賦"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Talent_Content = {Text = "天賦"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Click_Content = {Text = "命輪"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Content = {Text = "命輪"},
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Consume_Content = {
    Text = "解鎖本源形態需要消耗以下道具，是否確認？"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_2_Content = {Text = "確定"},
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Title_Content = {
    Text = "解鎖本源確認"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Click_Content = {
    Text = "課題模式"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Content = {
    Text = "課題模式"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Current_Content = {Text = "當前"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Lower_Content = {Text = "下一級"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Mad_Content = {
    Text = "超限狂氣爆發解鎖"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Solved_Content = {Text = "已解鎖"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Unsolved_Content = {Text = "未解鎖"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_WillSolved_Content = {
    Text = "此次解鎖"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Ranking_Content = {
    Text = "提升預覽"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Skill_Story_Content = {
    Text = "啟動材料"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Solved_Content = {Text = "已解鎖"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Click_Content = {
    Text = "調查模式"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Content = {
    Text = "調查模式"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Unsolved_Content = {Text = "未解鎖"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_CN_Content = {Text = "已啟動"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_WillSolved_Content = {
    Text = "此次解鎖"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Solved_Content = {Text = "已解鎖"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Unsolved_Content = {Text = "未解鎖"},
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_1_Content = {
    Text = "黑池歸還"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_2_Content = {
    Text = "養成回溯"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_1_Content = {
    Text = "返還預覽"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_2_Content = {
    Text = "返還預覽"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_3_Content = {
    Text = "返還預覽"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_TipDesc_Content = {
    Text = "「養成回溯」或「啟靈回溯」後，無法再進行「黑池歸還」"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Click_Content = {
    Text = "課題模式"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Content = {
    Text = "課題模式"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Click_Content = {
    Text = "調查模式"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Content = {
    Text = "調查模式"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Warning_CN_Content = {Text = "已激發"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Attribute_Content = {Text = "屬性"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Full_Content = {
    Text = "已達等級上限"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_High_Content = {
    Text = "顯示當前"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Insufficient_Content = {
    Text = "喚醒體升格等級不足"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Maniac_Content = {
    Text = "狂氣爆發"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_1_Content = {Text = "當前"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_2_Content = {Text = "當前"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_3_Content = {Text = "下一級"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_4_Content = {Text = "下一級"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Normal_Content = {
    Text = "滿級預覽"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_PressTip_Content = {
    Text = "長按手牌可放大查看"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Skill_Tag_Content = {
    Text = "狂氣爆發"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Attribute_Content = {Text = "屬性"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Maniac_Content = {
    Text = "狂氣爆發"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_1_Content = {Text = "當前"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_2_Content = {Text = "當前"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_3_Content = {Text = "下一級"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_4_Content = {Text = "下一級"},
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Tips_Content = {
    Text = "自動置入"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_Confirm_Content = {Text = "升級"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_2_Content = {Text = "選項二"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_3_Content = {Text = "選項三"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_Content = {
    Text = "升格條件"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_New_Content = {
    Text = "可啟動新技能"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Title_Content = {
    Text = "升格條件<WordSize20:（任選其一）>"
  },
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Prop_Title_Content = {Text = "屬性"},
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Tips_Content = {
    Text = "詳細資訊"
  },
  PanelText_UI_Awaker_Item_Trinket_Detail_Text_C_Empty_Content = {
    Text = "請選擇密契裝備"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_1_Content = {Text = "升級"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_2_Content = {Text = "轉錄"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_3_Content = {Text = "升級"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Refinement_Content = {
    Text = "密契詳情"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Normal_Content = {Text = "戰鬥"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Select_Content = {Text = "戰鬥"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Normal_Content = {
    Text = "相位對弈"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Select_Content = {
    Text = "相位對弈"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Blackpool_Content = {
    Text = "返回預覽"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_3_Content = {
    Text = "黑池歸還"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_4_Content = {
    Text = "疊位回溯"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Current_Content = {
    Text = "當前效果"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Full_Content = {Text = "滿級"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_1_Content = {Text = "當前"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_2_Content = {Text = "當前"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_3_Content = {Text = "疊位後"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_4_Content = {Text = "疊位後"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_5_Content = {Text = "下一階"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_6_Content = {Text = "下一階"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Next_Content = {
    Text = "<Blue:下一階效果>"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Overlay_Content = {
    Text = "返回預覽"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Level_Content = {
    Text = "命輪疊位等階"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Name_Content = {Text = "疊位"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Title_Content = {
    Text = "選擇疊位素材"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Warning_Content = {
    Text = "已達疊位等級上限"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_BackTraceTip_Content = {
    Text = "使用「疊位回溯」後，無法再進行「黑池歸還」。"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_Title_Content = {
    Text = "命輪詳情"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Enhance_Content = {Text = "強化"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Equip_Content = {Text = "裝備中"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Refine_Content = {Text = "疊位"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Click_Content = {Text = "疊位"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Content = {Text = "疊位"},
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Title_Content = {
    Text = "基礎資訊"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_1_Content = {
    Text = "普通形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_2_Content = {
    Text = "普通形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_3_Content = {
    Text = "普通形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_1_Content = {
    Text = "本源形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_2_Content = {
    Text = "本源形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_3_Content = {
    Text = "本源形態"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Null_Content = {
    Text = "當前部位無可用密契"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Strengthen_Content = {Text = "強化"},
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Title_Content = {
    Text = "密契結合"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_UnBindAll_Content = {
    Text = "一鍵析離"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Contrast_Content = {Text = "對比"},
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty1_Content = {
    Text = "左側選擇命輪裝備"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty_Content = {
    Text = "左側選擇命輪裝備"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Unlock_Content = {
    Text = "升格喚醒體\n解鎖第二命輪"
  },
  PanelText_UI_Awaker_Popup_Attribute_Detail_Text_C_Title_Content = {
    Text = "屬性詳情"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_1_Content = {
    Text = "查看詳情"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_2_Content = {Text = "確認"},
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_NoTask_Content = {
    Text = "暫無可回溯的物品"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Title_Content = {
    Text = "選擇開啟回溯目標"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_1_Content = {
    Text = "常駐喚醒體"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_2_Content = {
    Text = "特殊喚醒體"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_3_Content = {Text = "命輪"},
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_BindTip_Content = {
    Text = "已被其他喚醒體裝備或在編隊/方案/助戰中存在的密契被自動卸下"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Tip_Content = {
    Text = "確認結合以下密契？"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Title_Content = {
    Text = "結合確認"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Tip_Content = {
    Text = "當前所需材料不足，是否消耗以下材料進行補全？"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Title_Content = {
    Text = "補全提示"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Expired_Content = {
    Text = "以下物品已過期，將無法使用"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Title_Content = {
    Text = "物品過期"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_No_Trinket_Content = {
    Text = "暫無可選素材"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_Title_Content = {
    Text = "選擇密契"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Title_Content = {
    Text = "等級提升"
  },
  PanelText_UI_Awaker_Popup_MyTeam_List_Text_C_William_Content = {
    Text = "暫無升級材料"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Name_Content = {
    Text = "靈知深化"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Title_Content = {
    Text = "等級上限提升"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Preview_Content = {
    Text = "回溯後可獲得以下材料"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Title_Content = {
    Text = "返還預覽"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Content_Content = {
    Text = "等級上限"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Title_Content = {
    Text = "技能升級"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Condition_Content = {
    Text = "解鎖條件"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Current_Content = {Text = "當前"},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_High_Content = {
    Text = "顯示當前"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Lower_Content = {Text = "下一級"},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Normal_Content = {
    Text = "滿級預覽"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Warning_EN_Content = {
    Text = "Preconditions"
  },
  PanelText_UI_Awaker_Popup_Tip_Preview_Text_C_Title_Content = {
    Text = "升格材料預覽"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Info_Content = {
    Text = "點擊空白處關閉"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_New_Content = {
    Text = "可啟動新技能"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Breakthrough_Content = {
    Text = "同調需求"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Now_Content = {Text = "當前"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Reward_Content = {
    Text = "等級獎勵"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Screening_Content = {
    Text = "獎勵已領取"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Title_Content = {Text = "同調率"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Unlock_Content = {
    Text = "檔案解鎖"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_illustrate_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_Name_Content = {Text = "領取"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Activation_Content = {Text = "已啟動"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Lv_Content = {
    Text = "等級上限提升"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Content = {
    Text = "等級上限提升"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Name_Content = {
    Text = "超限爆發"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Activation_Content = {Text = "已啟動"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Name_Content = {
    Text = "最終法則"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_Activation_Content = {Text = "未啟動"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_MaxMad_Activation_Content = {Text = "未啟動"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Solved_Content = {Text = "已解鎖"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unlock_Content = {
    Text = "屬性提升"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unsolved_Content = {Text = "未解鎖"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_WillSolved_Content = {
    Text = "此次解鎖"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Reward_Content = {
    Text = "升格獎勵"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Title_Content = {
    Text = "升格預覽"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_Screening_Content = {
    Text = "獎勵已領取"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_BindTip_Content = {
    Text = "結合後密契主屬性額外提升 50%！"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Bind_Content = {
    Text = "結合密契"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Empty_Suit_Content = {
    Text = "暫無生效的套裝效果"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Foundation_Content = {Text = "屬性"},
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Rule_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Suit_Content = {
    Text = "套裝效果"
  },
  PanelText_UI_Awaker_Popup_Trinket_Change_Text_C_Equipped_Content = {Text = "已裝備"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_AutoRefinement_Content = {
    Text = "自動轉錄"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Empty_Content = {
    Text = "點擊轉錄獲得新副屬性"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Exchange_Content = {
    Text = "置換設置"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Foundation_Content = {
    Text = "原副屬性"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Hoist_Content = {
    Text = "新副屬性"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_1_Content = {Text = "轉錄"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_2_Content = {Text = "替換"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_No_Entries_Content = {
    Text = "暫無屬性"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Skip_Content = {
    Text = "跳過動畫"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_illustrate_Content = {
    Text = "轉錄說明"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Upper_Limit_Content = {
    Text = "已達等級上限"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_List_Text_C_None_Content = {
    Text = "尚未擁有未裝備的命輪"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_1_Content = {
    Text = "請選擇密契裝備"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_2_Content = {
    Text = "暫無生效的套裝效果"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Foundation_Content = {Text = "屬性"},
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Suit_Content = {
    Text = "套裝效果"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Contrast_Content = {Text = "對比"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Empty_Content = {
    Text = "請選擇密契裝備"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_None_Content = {
    Text = "當前部位無可用密契"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Notselected_Content = {
    Text = "請選擇密契裝備"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Suit_Content = {
    Text = "套裝效果"
  },
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_None_Content = {
    Text = "尚未擁有未裝備的密契"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Exchange_Content = {
    Text = "置換設置"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_High_Content = {Text = "升1級"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Normal_Content = {Text = "升1級"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_MaxLevel_Content = {Text = "強化"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_High_Content = {
    Text = "升至滿級"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_Normal_Content = {
    Text = "升至滿級"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Name_3_Content = {Text = "升級"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Title_Content = {Text = "等級"},
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_AutoSelect_Content = {
    Text = "自動選擇"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Confirm_Content = {
    Text = "析離密契"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Title_Content = {
    Text = "析離密契"
  },
  PanelText_UI_Awaker_Popup_Whole_Body_Text_C_Reveal_Content = {Text = "隱藏"},
  PanelText_UI_Awaker_Popup_illustrate_Tips_Text_C_Title_Content = {
    Text = "詞綴說明"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Tips_Content = {Text = "總覽"},
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Title_Content = {
    Text = "喚醒體天賦"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Type_Content = {Text = "類型"},
  PanelText_UI_Awaker_Weapon_Enhance_Success_Text_C_Succeed_Content = {
    Text = "強化成功"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Info_Content = {
    Text = "點擊空白處關閉"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Succeed_Content = {
    Text = "疊位成功"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Attribute_Content = {Text = "屬性"},
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Choose_Content = {
    Text = "·選擇喚醒體"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Helicopter_Content = {
    Text = "·增幅預覽"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Title_Content = {
    Text = "喚醒體增幅"
  },
  PanelText_UI_Bag_Item_Appearance_Text_C_Got_Content = {Text = "已獲得"},
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_AavtarName_Content = {
    Text = "頭像與表情"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Avatar_Info_Content = {
    Text = "詳情預覽"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Source_Content = {Text = "來源"},
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Time_Content = {
    Text = "剩餘有效時間："
  },
  PanelText_UI_Bag_Item_Detail_Text_C_AavtarName_Content = {
    Text = "頭像與表情"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "詳情預覽"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "鑰令效果："
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Source_Content = {
    Text = "獲取來源"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Time_Content = {
    Text = "剩餘有效時間"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Attack_Content = {
    Text = "基礎攻擊"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Defense_Content = {
    Text = "基礎防禦"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Physique_Content = {
    Text = "基礎體質"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Full_Content = {
    Text = "啟靈已滿"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Title_Content = {
    Text = "選擇喚醒體殘片"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Yes_Content = {Text = "已擁有"},
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Cancel_Name_Content = {
    Text = "查看詳情"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_BtnName_Content = {Text = "領取"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Head_Content = {Text = "頭像"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_NoTask_Content = {
    Text = "已獲得所有外觀"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_RatePreview_Content = {
    Text = "機率預覽"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Title_Content = {
    Text = "外觀預覽"
  },
  PanelText_UI_Bag_Panel_Main_Text_AmountName_Content = {Text = "數量"},
  PanelText_UI_Bag_Panel_Main_Text_C_2_Select_Content = {Text = "順序"},
  PanelText_UI_Bag_Panel_Main_Text_C_Cap_Content = {
    Text = "已強化至當前等級上限"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_NormotopiaCap_Content = {
    Text = "疊位已達上限"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Replacement_Content = {Text = "置換"},
  PanelText_UI_Bag_Panel_Main_Text_C_recast_Content = {Text = "重鑄"},
  PanelText_UI_Bag_Panel_Main_Text_Intensify_Content = {Text = "強化"},
  PanelText_UI_Bag_Panel_Main_Text_Normotopia_Content = {Text = "疊位"},
  PanelText_UI_Bag_Panel_Main_Text_Title_Content = {Text = "物資"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_BtnName_Content = {Text = "領取"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Head_Content = {Text = "頭像"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_NoTask_Content = {
    Text = "暫無資料"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Title_Content = {
    Text = "外觀預覽"
  },
  PanelText_UI_Battle_Item_CounterAwaker_Text_C_CounterAwaker_Content = {
    Text = "特攻喚醒體"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Disabled_CN_Content = {Text = "確 認"},
  PanelText_UI_Battle_Panel_CardStack_Text_C_Display_Content = {
    Text = "顯示卡牌"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Hide_Content = {
    Text = "隱藏卡牌"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_High_CN_Content = {Text = "確 認"},
  PanelText_UI_Battle_Panel_CardStack_Text_C_Normal_CN_Content = {Text = "確 認"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Count_Content = {
    Text = "融災黑潮"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_End_EN_No_Content = {Text = "結束"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Insufficient_Content = {
    Text = "空間不足"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Name_Content = {Text = "結束"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Setting_Content = {Text = "設置"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Unclickable_Content = {Text = "結束"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Zongshanghai_Content = {Text = "總傷害"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_insufficient_Content = {
    Text = "空間不足"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_CD_Content = {Text = "冷卻中"},
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Cooling_Content = {
    Text = "冷卻中，下回合才可以再次使用"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Title_Content = {
    Text = "超限爆發"
  },
  PanelText_UI_Battle_Popup_Anger_Text_C_CD_Content = {Text = "冷卻中"},
  PanelText_UI_Battle_Popup_Anger_Text_C_Cooling_Content = {
    Text = "冷卻中，下回合才可以再次使用"
  },
  PanelText_UI_Battle_Popup_Anger_Text_Title_Content = {
    Text = "狂氣爆發"
  },
  PanelText_UI_Battle_Popup_AttachPost_Text_C_AttachPost_Content = {Text = "追擊"},
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Confirm_Content = {Text = "確認"},
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Title_Content = {
    Text = "選擇一組卡牌"
  },
  PanelText_UI_Battle_Popup_Elite_Text_C_Victory_Content = {
    Text = "危險警報"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Title_Content = {
    Text = "最高警報"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Continue_Content = {
    Text = "點擊繼續"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Victory_Content = {
    Text = "戰鬥失敗"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_2_Content = {Text = "確認"},
  PanelText_UI_Battle_Popup_Furnace_Text_C_Title_Content = {
    Text = "腥紅熔爐"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Nature_Content = {
    Text = "隊伍資訊"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Property_Content = {
    Text = "應急物資"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill2_Content = {
    Text = "銀鑰能量"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill_Tag_Content = {Text = "鑰令"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeeperSkill_Content = {Text = "釋放"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenAwaken_Content = {Text = "釋放"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenNewChaos_Content = {Text = "釋放"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_Title_Content = {
    Text = "請選擇指令"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_AwakenTitle_Content = {
    Text = "銀鑰覺醒"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_NewChaosTitle_Content = {
    Text = "複合鑰令"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Title_Content = {
    Text = "戰鬥開始"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips2_Content = {
    Text = "進行兌換？"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips_Content = {
    Text = "應急靈知體已耗盡，是否花費"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Tips_Content = {
    Text = "（兌換後將直接消耗並且復活，若撤退則會返還應急靈知體）"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_Title_Content = {
    Text = "復活確認"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_AffixInfo_Content = {
    Text = "詞綴說明"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Arousal_Content = {Text = "覺醒"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Destiny_Content = {Text = "命輪"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Gnosisi_Content = {
    Text = "靈知覺醒"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Maniac_Content = {Text = "狂氣值"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Property_Content = {
    Text = "屬性詳情"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Skill_Tag_Content = {
    Text = "狂氣爆發"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Talent_Content = {Text = "天賦"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Awakening_Content = {
    Text = "靈知覺醒"
  },
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Weapon_Content = {Text = "命輪"},
  PanelText_UI_Battle_Popup_Round_Enemy_Text_C_Our_Content = {
    Text = "敵方行動"
  },
  PanelText_UI_Battle_Popup_Round_Mine_Text_C_Our_Content = {
    Text = "我方行動"
  },
  PanelText_UI_Battle_Popup_SelectAwaker_Text_C_Title_Content = {
    Text = "請選擇喚醒體"
  },
  PanelText_UI_Battle_Popup_Settle_Text_C_Succeed_Content = {
    Text = "戰鬥勝利"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Activate_Content = {
    Text = "當前指令"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Defense_Content = {Text = "防禦"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_1_Content = {
    Text = "無法選擇"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_2_Content = {
    Text = "無法選擇"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Frantic_Content = {Text = "瘋狂"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Name_Content = {Text = "戰鬥"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Title_Content = {
    Text = "請選擇觸腕姿態"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Lock_Content = {
    Text = "時序逆行可將戰鬥倒退回過去回合"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Sure_Content = {Text = "確定"},
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Title_Content = {
    Text = "時序逆行"
  },
  PanelText_UI_Battle_Tip_CounterAwaker_Text_C_Title_Content = {
    Text = "敵人特性"
  },
  PanelText_UI_Chaper_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_Content = {
    Text = "累計獎勵"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Confirm_Content = {
    Text = "仍要調查"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Joinin_Content = {
    Text = "建議完成以下調查關卡"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Demon_Content = {
    Text = "暫無刻印"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Not_Content = {
    Text = "暫無造物"
  },
  PanelText_UI_Chaper_Popup_Level_Success_Text_C_Title_Content = {
    Text = "關卡成就"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Achievement_Content = {
    Text = "敵方預覽"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Cost_Tips_Content = {
    Text = "隊伍要求："
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Grade_Content = {
    Text = "推薦等級"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Monster_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Recommend_Content = {
    Text = "界域推薦"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Reward_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Suppress_Content = {
    Text = "融災黑潮"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Title_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Title_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Chaper_Popup_Particulars_View_Text_C_Replay_Content = {Text = "記錄"},
  PanelText_UI_Chaper_Popup_StageAchieve_View_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Difficulty_Content = {Text = "困難"},
  PanelText_UI_Chapter_Dream_View_Text_C_Nightmare_Content = {Text = "癲狂"},
  PanelText_UI_Chapter_Dream_View_Text_C_Remember_Content = {Text = "溯夢"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Difficulty_Content = {Text = "困難"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Nightmare_Content = {Text = "噩夢"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Remember_Content = {Text = "溯夢"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Simple_Content = {Text = "簡單"},
  PanelText_UI_Chapter_Item_Achievement_List_Text_C_Lost_Content = {Text = "未達成"},
  PanelText_UI_Chapter_Item_Achievement_List_Text_Lost_Content = {Text = "未達成"},
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Expect_Content = {
    Text = "敬請期待"
  },
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Tips_Content = {
    Text = "關卡進度"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect1_Content = {
    Text = "尚未解鎖"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect2_Content = {
    Text = "尚未解鎖"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect_Content = {
    Text = "敬請期待"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Tips_Content = {
    Text = "關卡進度"
  },
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Item_Dream_02_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Item_Dream_03_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Item_Dream_04_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Item_Skill_Text_C_Level_Content = {Text = "狀態"},
  PanelText_UI_Chapter_Item_Special_01_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Item_Special_02_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Item_Special_03_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Item_StageAchieve_Text_C_Lost_Content = {Text = "未達成"},
  PanelText_UI_Chapter_Item_Success_List_Text_Lost_Content = {Text = "未達成"},
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Award_Content = {
    Text = "所有獎勵條件已達成"
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Award_Content = {Text = "已達成"},
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Difficulty_Content = {Text = "困難"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_Nightmare_Content = {Text = "癲狂"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_NoTask_Content = {
    Text = "暫無特遣紀錄"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Time_Content = {
    Text = "2023/12/21 05：00上新，敬請期待"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Title_Content = {Text = "調查"},
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_2_Content = {
    Text = "關卡成就"
  },
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_Content = {
    Text = "關卡評分"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_01_Content = {Text = "困難"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Content = {Text = "困難"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Now_Content = {Text = "困難"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_01_Content = {Text = "癲狂"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Content = {Text = "癲狂"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Now_Content = {Text = "癲狂"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Progress_Content = {
    Text = "調查進度"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tab_Special_Content = {
    Text = "限時活動"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tishi_Content = {
    Text = "關卡成就"
  },
  PanelText_UI_Chapter_Popup_Monster_Details_Text_C_Title_Content = {
    Text = "敵方詳情"
  },
  PanelText_UI_Chapter_Popup_Yuanxing_Text_Title_Content = {
    Text = "調查評價"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Difficulty_Content = {Text = "困難"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Nightmare_Content = {Text = "癲狂"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Progress_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Remember_Content = {Text = "溯夢"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Tab_Special_Content = {
    Text = "限時活動"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Difficulty_Content = {Text = "困難"},
  PanelText_UI_Chapter_Spur_View_Text_C_Nightmare_Content = {Text = "癲狂"},
  PanelText_UI_Chapter_Spur_View_Text_C_Progress_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Remember_Content = {Text = "溯夢"},
  PanelText_UI_Chapter_Spur_View_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Chapter_Spur_View_Text_C_Tab_Special_Content = {
    Text = "限時活動"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Condition_Content = {
    Text = "未達解鎖條件"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Name_Content = {
    Text = "進入劇情"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_NoTask_Content = {
    Text = "繁衍狂熱暫未解鎖"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_StoryDesc_Content = {
    Text = "隨著「欲海翻波」的持續，喚醒體們受到了神秘力量影響，陷入了「繁衍狂熱」狀態……請各位守密人小心！"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Tip_Content = {
    Text = "「欲海翻波」活動期間限時優惠開放，可以無視同調率要求，使用 「現實起點」*1 即可解鎖對應事件！"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Title_Content = {
    Text = "晚會邀請"
  },
  PanelText_UI_Collection_History_Details_Text_C_Lock_Content = {
    Text = "暫未獲得圖像資料"
  },
  PanelText_UI_Collection_History_Details_Text_Title_Content = {Text = "記錄"},
  PanelText_UI_Collection_Item_Comprehensive_Text_C_Placeholder_Content = {
    Text = "搜索名詞..."
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_High_Content = {
    Text = "重置背景音樂"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Label_Content = {Text = "留聲機"},
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Mail_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Normal_Content = {
    Text = "設為背景音樂"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Label_Content = {Text = "留聲機"},
  PanelText_UI_Collection_Item_Music_Text_C_Mail_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_UnLock_Content = {Text = "解鎖"},
  PanelText_UI_Collection_Item_Video_Text_C_UnLock_Content = {Text = "解鎖"},
  PanelText_UI_Collection_Panel_Equip_Text_C_None_Content = {
    Text = "暫無相關收藏"
  },
  PanelText_UI_Collection_Panel_Event_Text_C_Placeholder_Content = {
    Text = "搜索名詞..."
  },
  PanelText_UI_Collection_Panel_History_Text_C_Label_Content = {Text = "編年史"},
  PanelText_UI_Collection_Panel_History_Text_C_Mail_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_LoginPV_Text_Title_Content = {
    Text = "修改登錄背景"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Music_Content = {Text = "留聲機"},
  PanelText_UI_Collection_Panel_Main_Text_C_Progress_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Weapon_Content = {Text = "命輪"},
  PanelText_UI_Collection_Panel_Main_Text_C_World_Content = {
    Text = "洪積世界"
  },
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Mail_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_Organize_Text_C_Mail_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Collection_Panel_Organize_Text_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_Relic_Text_C_Mail_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Collection_Panel_Relic_Text_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Display_Content = {
    Text = "顯示喚醒體"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_DownLoadCG_Content = {
    Text = "下載原圖"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_HideAwaker_Content = {
    Text = "設置此圖為宿舍背景後，來客立繪將隱藏"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Hide_Content = {
    Text = "隱藏喚醒體"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Normal_Content = {
    Text = "設為宿舍背景"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Chronicle_Content = {Text = "編年史"},
  PanelText_UI_Collection_Panel_World_Text_C_Comprehensive_Content = {
    Text = "洪積禁典"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Label_Content = {
    Text = "洪積世界"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Organize_Content = {
    Text = "組織勢力"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_World_Text_Progress_Content = {
    Text = "收集進度"
  },
  PanelText_UI_Common_Awaker_Favor_Text_C_Sync_Content = {
    Text = "喚醒體同調率提升"
  },
  PanelText_UI_Common_Btn_Receive_Small_Text_C_Name_Content = {Text = "領取"},
  PanelText_UI_Common_Btn_Small_240x90_Text_Name_Content = {
    Text = "啟動天賦"
  },
  PanelText_UI_Common_Item_Detail_Text_C_AavtarName_Content = {
    Text = "頭像與表情"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "詳情預覽"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Equipped_Content = {Text = "已裝備"},
  PanelText_UI_Common_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "鑰令效果："
  },
  PanelText_UI_Common_Item_Detail_Text_C_Source_Content = {
    Text = "獲取來源"
  },
  PanelText_UI_Common_Item_Hint_Text_C_Recommend_Content = {
    Text = "今日推薦"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Expired_Content = {Text = "已過期"},
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NoEquip_Content = {
    Text = "無法裝備"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_UpperLimit_Content = {
    Text = "已達上限"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Full_Content = {
    Text = "疊位已滿"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Double_Content = {Text = "雙倍"},
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Nor_Content = {Text = "額外"},
  PanelText_UI_Common_Melt_Disaster_Text_C_Suppress_Content = {
    Text = "融災黑潮"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_AbandonCard_Content = {Text = "棄牌堆"},
  PanelText_UI_Common_Popup_Card_List_Text_C_Empty_Content = {
    Text = "當前抽牌堆為空"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_NoTask_Content = {
    Text = "暫無卡牌"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Common_Popup_Consume_Text_C_Title_Content = {
    Text = "道具使用確認"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_ShopNeed_Content = {
    Text = "當前商品券數量"
  },
  PanelText_UI_Common_Popup_Tip_4_Text_C_Info_Content = {
    Text = "<WhiteQuality:點擊空白處關閉>"
  },
  PanelText_UI_Common_Popup_Tip_5_Text_C_Info_Content = {
    Text = "點擊空白處關閉"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_C_Tips_Content = {
    Text = "更改名稱後，72小時內不能再做修改"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_NameConfirm_Content = {Text = "確認"},
  PanelText_UI_Common_Popup_Tip_6_Text_Placeholder_Content = {
    Text = "請輸入您的名字"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_Title_Content = {
    Text = "更改名稱"
  },
  PanelText_UI_Common_Popup_Tips_6_Text_null_Content = {
    Text = "（已損毀）"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Reward_Content = {
    Text = "升格獎勵"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Title_Content = {
    Text = "升格預覽"
  },
  PanelText_UI_Common_Popup_Tips_Small_Text_C_Scroll_Tips_Content = {
    Text = "上下滑動可查看更多獎勵"
  },
  PanelText_UI_Community_Acclaim_Tips_Text_C_Name_1_Content = {
    Text = "前往評價"
  },
  PanelText_UI_Community_Steer_Tips_Text_Thanks_Name_Content = {
    Text = "特別鳴謝"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_LetterTitle_Content = {
    Text = "致尊敬的各位本地化志願者："
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Name_Content = {
    Text = "本地化志願者"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Signature_Content = {
    Text = "彌薩格大學委員會"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Sincerely_Content = {
    Text = "深表感謝"
  },
  PanelText_UI_Community_ThanksLetter_Text_Prefix_Content = {
    Text = "您以敏銳的語感和對遊戲的熱愛，將生硬的機譯文本轉化為鮮活的語言。正是這份無私的熱忱，讓全球守密人都能享受到原汁原味的《忘卻前夜》。\n       彌薩格大學衷心感謝以下守密人們作出的卓越貢獻："
  },
  PanelText_UI_Community_ThanksLetter_Text_Suffix_Content = {
    Text = "願銀鑰指引我們。"
  },
  PanelText_UI_Community_ThanksLetter_Text_Title_Content = {
    Text = "特別鳴謝"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Award_Content = {Text = "已歸檔"},
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Free_Unlock_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Lock_Content = {
    Text = "尚未解鎖"
  },
  PanelText_UI_Copy_Story_View_Text_C_ReadTip_Content = {
    Text = "推薦順序僅代表推薦閱讀順序，不代表嚴格時間順序。"
  },
  PanelText_UI_Course_Panel_Main_Text_C_NoTask_Content = {
    Text = "暫時沒有此類型教學"
  },
  PanelText_UI_Course_Panel_Main_Text_C_Placeholder_Content = {
    Text = "搜索教學..."
  },
  PanelText_UI_Course_Panel_Text_Title_Content = {Text = "教學"},
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Achievement_Content = {
    Text = "關卡成就"
  },
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Star_Content = {
    Text = "星級評分"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Curse_Content = {
    Text = "詛咒之間"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Spend_Content = {Text = "花費"},
  PanelText_UI_Dbgcopy_Panel_Main_New_Text_C_Count_Content = {
    Text = "融災黑潮"
  },
  PanelText_UI_Dbgcopy_Panel_RelicStrength_Text_C_Title_Content = {
    Text = "強化造物"
  },
  PanelText_UI_Dbgcopy_Panel_Select_Arousal_Text_C_Name_Content = {Text = "選擇"},
  PanelText_UI_Dbgcopy_Panel_Select_Extra_Text_C_Name_Content = {Text = "放棄"},
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Display_Content = {
    Text = "顯示事件"
  },
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Hide_Content = {
    Text = "隱藏事件"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Monster_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Tip_Content = {
    Text = "請守密人留意，不同的關卡篇章會帶來不同的環境特徵和不同的初始造物。"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Title_Content = {
    Text = "關卡篇章效果說明"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Replace_Content = {
    Text = "替換角色"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_TeamAwaker_Content = {
    Text = "當前隊內角色"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Title_Content = {
    Text = "選擇更換角色"
  },
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Title_Content = {
    Text = "融災黑潮效果說明"
  },
  PanelText_UI_Dbgcopy_Popup_ydbj_yty_01_Text_C_Dcks_Content = {
    Text = "調查開始"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_BtnName_Content = {
    Text = "開始訓練"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Item_AbyssRank_Text_C_Uid_Content = {Text = "UID："},
  PanelText_UI_Dungeons_Item_Common_Element_Text_C_Award_Content = {
    Text = "獎勵+100%"
  },
  PanelText_UI_Dungeons_Item_Common_Tier2_Text_C_Current_Content = {
    Text = "當前通關"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Extra_Content = {
    Text = "額外通關"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Undone_Content = {
    Text = "未完成挑戰"
  },
  PanelText_UI_Dungeons_Item_RailWayRank_Text_C_Null_Content = {
    Text = "暫無編隊"
  },
  PanelText_UI_Dungeons_Item_RailWayRank_Text_C_Uid_Content = {Text = "UID："},
  PanelText_UI_Dungeons_Material_View_Text_C_ActivityAchievement_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Awaker_Content = {Text = "出戰"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_BattleStatistics_Content = {
    Text = "戰鬥統計"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Damage_Content = {
    Text = "造成傷害"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Heal_Content = {
    Text = "造成治療"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_BattleStatistics_Content = {
    Text = "暫無資料"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_RoundStatistics_Content = {
    Text = "暫無資料"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_RoundStatistics_Content = {
    Text = "回合統計"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Shield_Content = {
    Text = "造成護盾"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Experience_Content = {
    Text = "深潛等級"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Highest_Content = {
    Text = "本賽季最高分"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Record_Content = {
    Text = "本週成績"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Store_Content = {
    Text = "兌換商店"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Title_Content = {
    Text = "調查等級頭銜"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Diving_Record_Content = {
    Text = "深潛紀錄"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Main_Title_Content = {
    Text = "幻夢深潛"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Highest_Content = {
    Text = "本賽季最高分"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record2_Content = {
    Text = "本週成績"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record_Content = {
    Text = "本週成績"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Reward2_Content = {
    Text = "深潛紀錄"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Store_Content = {
    Text = "兌換商店"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Title_Content = {
    Text = "調查等級頭銜"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_illustrate_Content = {
    Text = "玩法規則"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_list_Content = {
    Text = "賽季排行"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Appraise_Content = {
    Text = "評分統計"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Finish_Content = {
    Text = "調查成功"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Remind_Content = {
    Text = "提升喚醒體能力後，再來挑戰強敵吧！"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Score_Content = {Text = "總評分"},
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Synthesis_Content = {
    Text = "（總評分為以下總和×3）"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Award_Content = {
    Text = "通關獎勵"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Highest_Content = {
    Text = "最高記錄"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Record_Content = {
    Text = "本日成績"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Reward_Content = {
    Text = "每週試煉"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Score_Content = {
    Text = "本週累計評分"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Store_Content = {
    Text = "兌換商店"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Title_Content = {
    Text = "調查頭銜"
  },
  PanelText_UI_Dungeons_Panel_Material_Text_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Appraise_Content = {
    Text = "評分統計"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_BattleData_Content = {
    Text = "調查資料"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Finish_Content = {
    Text = "調查完成"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "結算獲得"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Integral_Content = {
    Text = "調查評價"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Limit_Content = {
    Text = "※物品已達上限"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Score_Content = {Text = "總評分"},
  PanelText_UI_Dungeons_Panel_Out_Text_C_Statistics_Content = {
    Text = "戰鬥統計"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Sync_Content = {
    Text = "喚醒體同調率提升"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Synthesis_Content = {
    Text = "（總評分為以下總和×3）"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_TeamInfo_Content = {
    Text = "隊伍資訊"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval1_Content = {Text = "間隙"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval2_Content = {
    Text = "輪轉間隙"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_3_Content = {
    Text = "暗海之淵"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_4_Content = {
    Text = "超維之旅"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_1_Content = {Text = "未解鎖"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_2_Content = {Text = "未解鎖"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_3_Content = {Text = "未解鎖"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_4_Content = {Text = "未解鎖"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Tips_Content = {
    Text = "無光兌換"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_illustrate_Content = {
    Text = "玩法規則"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card_Content = {
    Text = "卡牌統計"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_KeyToken_Content = {Text = "鑰令"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_NoTask_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Null_Content = {
    Text = "暫無造物"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_PlayerLevel_Content = {
    Text = "守密人等級"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamData_Content = {
    Text = "隊伍資料"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamProperty_Content = {
    Text = "隊伍屬性"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Team_Content = {
    Text = "調查隊伍"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Uid_Content = {
    Text = "守密人ID："
  },
  PanelText_UI_Dungeons_Panel_Trinket_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Activity_Awaker_Content = {
    Text = "忘卻篇·限定"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Award_Content = {
    Text = "完成獎勵"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Introduce_Content = {
    Text = "能力介紹"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_1_Content = {Text = "領取"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_Content = {
    Text = "開始試玩"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Normal_Awaker_Content = {Text = "常駐"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Wake_Content = {
    Text = "前往喚醒"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_ActivityAchievement_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_AwardText_Content = {
    Text = "本週可以領取獎勵次數"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_AwardText_Content = {
    Text = "本週可以領取獎勵次數"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Info_Content = {
    Text = "守密人資訊"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_More_Content = {
    Text = "查看詳情"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_NoTask_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Replay_Content = {
    Text = "記錄回放"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Value_Content = {Text = "特訓值"},
  PanelText_UI_Dungeons_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Dungeons_Popup_Award_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Awaker_Content = {Text = "出戰"},
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Damage_Content = {
    Text = "造成傷害"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Heal_Content = {
    Text = "造成治療"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Shield_Content = {
    Text = "造成護盾"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Title_Content = {
    Text = "戰鬥統計"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_FilterAwaker_Content = {
    Text = "篩選喚醒體"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_No_Records_Content = {
    Text = "暫無調查記錄"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Refresh_Content = {Text = "換一批"},
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Title_Content = {
    Text = "通關記錄"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_Fliter_Type_Content = {
    Text = "總回合數"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Big_Content = {
    Text = "排名範圍"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Current_Content = {
    Text = "當前獎勵"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Empty_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_FilterAwaker_Content = {
    Text = "篩選喚醒體"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Grade_Content = {
    Text = "調查頭銜"
  },
  ["PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Haven't_Content"] = {
    Text = "暫無獎勵"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Highest_Content = {
    Text = "最高記錄"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_1_Content = {
    Text = "守密人資訊"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_2_Content = {
    Text = "調查頭銜"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_3_Content = {
    Text = "最高記錄"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_5_Content = {Text = "編隊"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_6_Content = {Text = "記錄"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_NoTask_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Prompt_Content = {
    Text = "每週一9：00根據調查頭銜發送獎勵郵件"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward1_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward2_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Reward_Content = {Text = "獎勵"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season1_Content = {
    Text = "賽季排行"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season2_Content = {
    Text = "賽季排行"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Small_Content = {
    Text = "小於等於"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking1_Content = {
    Text = "賽季排行"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking2_Content = {
    Text = "賽季排行"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Title_Content = {
    Text = "調查排行"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_illustrate_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Big_Content = {
    Text = "排名範圍"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_DivingTitle_Content = {
    Text = "調查頭銜"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Exp_Content = {
    Text = "最高進度"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Grade_Content = {
    Text = "調查頭銜"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Info_Content = {
    Text = "守密人資訊"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_NoTask_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Nor_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Sel_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Nor_Content = {
    Text = "賽季排行"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Sel_Content = {
    Text = "賽季排行"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Replay_Content = {Text = "記錄"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Reward_Content = {Text = "獎勵"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Round_Content = {Text = "回合數"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Team_Content = {Text = "編隊"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Title_Content = {
    Text = "貴賓名錄"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Big_Content = {Text = "大於"},
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Reward_Content = {Text = "獎勵"},
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Small_Content = {
    Text = "小於等於"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Title_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_Dungeons_Popup_Rules_Tip_Text_C_Title_Content = {
    Text = "玩法說明"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Award_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_2_Content = {Text = "共鳴"},
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Title_Content = {
    Text = "尖塔肉鴿"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Award_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Challenge_Content = {
    Text = "標準模式"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Daily_Content = {
    Text = "每日挑戰"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Name_Content = {
    Text = "尖塔肉鴿"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_NoTask_Content = {
    Text = "虛位以待"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Extra_Content = {
    Text = "額外加成"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_KeeperSkill_Content = {
    Text = "銀鑰能量"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Manual_Content = {
    Text = "手動戰鬥"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UltiEnergy_Content = {Text = "狂氣"},
  PanelText_UI_Dungeons_Trinket_View_Text_C_ActivityAchievement_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Lost_Content = {Text = "未達成"},
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title2_Content = {
    Text = "分數累計至"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title_Content = {
    Text = "本關星級數目達"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Lost_Content = {Text = "未達成"},
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Title_Content = {
    Text = "本關評分星級達"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Null_Content = {
    Text = "暫無編隊"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Uid_Title_Content = {Text = "UID ："},
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Underway_Content = {
    Text = "戰鬥資料通訊中"
  },
  PanelText_UI_Dungeous_Item_Reward_Text_C_Present_Content = {Text = "當前"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Additional_Content = {
    Text = "今日獎勵額外+50% 不限次"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardNum_Content = {
    Text = "今日雙倍獎勵次數"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardText_Content = {
    Text = "本週可以領取獎勵次數"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Boundaries_Tips_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Name_Content = {Text = "重現"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Recommend_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_2_Content = {Text = "超維"},
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_AwardText_Content = {
    Text = "本週可以領取獎勵次數"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Award_Content = {
    Text = "敵方詳情"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Boundaries_Tips_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Reward_Content = {
    Text = "通關獎勵"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_Title_Content = {
    Text = "超驗存在"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Award_Content = {
    Text = "首領預覽"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Boundaries_Tips_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Reward_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Score_Content = {
    Text = "本賽季最高分"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_RewardShow_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_StrongAwakers_Content = {
    Text = "強化喚醒體"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Suppress_Content = {
    Text = "融災黑潮"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Remuneration_Content = {
    Text = "人物報酬"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Hint_Content = {
    Text = "*在融災禁區中，已出戰的喚醒體和命輪將無法在其他禁區中出戰。"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Title_Content = {
    Text = "融災禁區"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Train_Content = {
    Text = "當前特訓值"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly_Content = {
    Text = "特訓獎勵"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Hint_Content = {
    Text = "*通關後，本次出戰的喚醒體、命輪和鑰令將無法在其他融災禁區中上場。"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Title_Content = {
    Text = "融災禁區"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Train_Content = {
    Text = "當前特訓值"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Weekly_Content = {
    Text = "特訓獎勵"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Extra_Content = {
    Text = "額外通關陣容"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Integral_Content = {
    Text = "通關積分"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_LineUp_Content = {
    Text = "通關陣容"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Monster_Content = {
    Text = "怪物預覽"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_None_Content = {
    Text = "暫無陣容"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Replay_Content = {Text = "記錄"},
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_Extra_None_Content = {
    Text = "尚未完成挑戰"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Integral_Content = {
    Text = "通關特訓值"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_LineUp_Content = {
    Text = "通關編隊"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Monster_Content = {
    Text = "怪物預覽"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_None_Content = {
    Text = "尚未完成挑戰"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Suppress_Content = {
    Text = "融災黑潮"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Challenge_Content = {Text = "挑戰"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Choose_Content = {
    Text = "選擇難度"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Experience_Content = {
    Text = "雅室規格"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Hard_Content = {Text = "困難"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Madness_Content = {Text = "癲狂"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Rank_Content = {
    Text = "貴賓名錄"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "小「N」的協助"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Title_Content = {
    Text = "疾馳的歡愉專列"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award_Content = {
    Text = "敵方詳情"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Boundaries_Tips_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Cost_Tips_Content = {
    Text = "隊伍要求："
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Replay_Content = {Text = "記錄"},
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Reward_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Tishi_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award2_Content = {
    Text = "密境法則"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award_Content = {
    Text = "敵方詳情"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Boundaries_Tips_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Cost_Tips_Content = {
    Text = "隊伍要求"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Reward_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Tishi_Content = {
    Text = "星級進度"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Additional_Content = {
    Text = "今日獎勵額外+50% 不限次"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_AwardNum_Content = {
    Text = "今日雙倍獎勵次數"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Boundaries_Tips_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Cw_Content = {Text = "超維"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Recommend_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_Name_Content = {Text = "重現"},
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_1_Content = {
    Text = "暫未選擇命輪"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_2_Content = {
    Text = "點擊左側進行選擇"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_Content = {
    Text = "*同一個喚醒體只能裝備一個SSR命輪"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "選擇命輪"
  },
  PanelText_UI_Dungeous_Popup_FailTip_Text_C_Title_Content = {
    Text = "如何變強"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "星級獎勵預覽"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Title_Content = {
    Text = "評分統計"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Total_Content = {
    Text = "當前總評分"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Coin_Content = {
    Text = "貨幣不足"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Explain_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_RewardPreview_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Swept_Content = {
    Text = "重現次數"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Tips_Content = {
    Text = "調查評價達到三星後解鎖"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_Title_Content = {
    Text = "重現確認"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Deplete_Content = {
    Text = "重現消耗"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Swept_Content = {
    Text = "重現次數"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Team_Content = {
    Text = "調查隊伍"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Title_Content = {
    Text = "重現確認"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_NoTask_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Prohibit_Content = {
    Text = "本關禁用鑰令"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Title_Content = {
    Text = "挑戰隊伍"
  },
  PanelText_UI_Dungeous_Popup_Tips_New_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity2_Content = {
    Text = "首通獎勵"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity_Content = {
    Text = "首通獎勵"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game2_Content = {
    Text = "累積獎勵"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game_Content = {
    Text = "累積獎勵"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Again_Content = {
    Text = "重置挑戰"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Boundaries_Tips_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Cw_Content = {Text = "超維"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Monster_Content = {
    Text = "怪物預覽"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_illustrate_Content = {
    Text = "玩法規則"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Again_Content = {
    Text = "重置挑戰"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Tips_Content = {
    Text = "獎勵詳情"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Title_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_illustrate_Content = {
    Text = "玩法規則"
  },
  PanelText_UI_Dungeous_illustrate_Tip_Text_C_Title_Content = {
    Text = "無光之境"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Finish_Content = {
    Text = "活動已結束，已停止獲取"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Full_Content = {
    Text = "當前已達存儲上限"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Reward_Content = {
    Text = "獲得物資"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_SpeedTitle_Content = {
    Text = "存儲速度："
  },
  PanelText_UI_Event_Activity_Castor_Text_None_Content = {
    Text = "暫無物資"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Finish_Content = {
    Text = "活動已結束"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Full_Content = {
    Text = "物資已達上限"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_None_Content = {
    Text = "暫無募捐物資"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Reward_Content = {Text = "物資"},
  PanelText_UI_Event_Activity_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "獲取速度："
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Finish_Content = {
    Text = "活動已結束"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Full_Content = {
    Text = "當前儲存已達上限"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Reward_Content = {
    Text = "儲存資訊"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_SpeedTitle_Content = {
    Text = "儲存速度"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Finish_Content = {
    Text = "活動已結束，已停止獲取"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Full_Content = {
    Text = "當前已達存儲上限"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Reward_Content = {
    Text = "獲得物資"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_SpeedTitle_Content = {
    Text = "存儲速度："
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_None_Content = {
    Text = "暫無物資"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Mail_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Title_Content = {
    Text = "聖堂義賣現場"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Finish_Content = {
    Text = "活動已結束，已停止獲取"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Full_Content = {
    Text = "當前已達存儲上限"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Reward_Content = {
    Text = "獲得物資"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_SpeedTitle_Content = {
    Text = "獲取速度"
  },
  PanelText_UI_Event_Activity_Miriam_Text_None_Content = {
    Text = "暫無物資"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Finish_Content = {
    Text = "活動已結束，已停止獲取"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Full_Content = {
    Text = "當前已達存儲上限"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Reward_Content = {
    Text = "獲得物資"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_SpeedTitle_Content = {
    Text = "存儲速度："
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_None_Content = {
    Text = "暫無物資"
  },
  PanelText_UI_Event_Activity_Pollux_Text_None_Content = {
    Text = "暫無物資"
  },
  PanelText_UI_Event_Activity_RewardList_Text_C_Reward_Content = {
    Text = "義賣清單"
  },
  PanelText_UI_Event_Activity_RewardPool_Text_Name_Content = {
    Text = "全部交換"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Close_Content = {
    Text = "點擊空白處返回"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_CoreReward_Content = {
    Text = "特殊種子"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Result_Content = {
    Text = "交換結果"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_C_Desc_Content = {
    Text = "主人今天也來幫珈倫一起打掃麼？太好了，這是珈倫的一點小心意，還請主人務必收下！"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_1_Content = {Text = "已領取"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_2_Content = {Text = "已領取"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_3_Content = {Text = "已領取"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_4_Content = {Text = "已領取"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_5_Content = {Text = "已領取"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_6_Content = {Text = "已領取"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_7_Content = {Text = "已領取"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Title_Content = {
    Text = "珈倫的謝禮"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_C_Desc_Content = {
    Text = "陽光，沙灘，海浪，還有無數張笑臉，在夏日的幻夢裡，來一場充滿活力的排球賽吧！"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_Title_Content = {
    Text = "徹夏狂歡"
  },
  PanelText_UI_Event_Activity_SummonBenefits_Text_C_Summon_Content = {
    Text = "免費召喚"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Finish_Content = {
    Text = "活動已結束，已停止存儲"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Full_Content = {
    Text = "存儲物質已達上限"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Reward_Content = {
    Text = "存儲物質"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_SpeedTitle_Content = {
    Text = "存儲速度："
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "邊緣儲存"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_Name_Content = {Text = "領取"},
  PanelText_UI_Event_Activity_TwentyFour_Text_None_Content = {
    Text = "暫無物資"
  },
  PanelText_UI_Event_Activity_XiaomaoGift_Text_C_Receive_Content = {
    Text = "剩餘喚醒次數："
  },
  PanelText_UI_Event_Challenge_Item_Text_C_Finish_Content = {
    Text = "上次通關"
  },
  PanelText_UI_Event_Item_Return_Text_C_Close_Content = {
    Text = "點擊螢幕關閉"
  },
  PanelText_UI_Event_Item_Return_Text_C_Finish_Content = {Text = "已領取"},
  PanelText_UI_Event_Item_SignDay_Text_C_CanReceive_Content = {Text = "可領取"},
  PanelText_UI_Event_Item_SignDay_Text_C_Got_Content = {Text = "已領取"},
  PanelText_UI_Event_Item_SignDay_Text_C_Nor_Content = {Text = "待領取"},
  PanelText_UI_Event_Item_WeaponOptional_Text_C_Got_Content = {Text = "已擁有"},
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Title_Content = {
    Text = "聖堂區域"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Introduction_Content = {
    Text = "噓……深呼吸，放鬆你的觸手。 現在你將潛入「24」的意識深處，探尋隱秘的記憶……"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "記憶編碼"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Awaker_Content = {
    Text = "試用喚醒體"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Leader_Content = {
    Text = "首領預覽"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Record_Content = {Text = "挑戰"},
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_StarTitle_Content = {
    Text = "星級目標"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Title_Content = {
    Text = "劇本迷思"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Creation_Content = {
    Text = "關卡造物"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Double_Content = {
    Text = "雙倍挑戰"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Leader_Content = {
    Text = "首領預覽<WordSize20:>"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_MeltErosion_Content = {
    Text = "融災黑潮"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Monster_Content = {
    Text = "怪物預覽"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Record_Content = {Text = "挑戰"},
  PanelText_UI_Event_Panel_Challenge_Text_C_RemainNum_Content = {
    Text = "殘餘分身數量"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Replay_Content = {Text = "記錄"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Event_Panel_Challenge_Text_C_RewardTitle_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_SweepName_Content = {Text = "掃蕩"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Title_Content = {
    Text = "劇本迷思"
  },
  PanelText_UI_Event_RewardGroup_Text_C_Reset_Content = {
    Text = "剩餘重置次數："
  },
  PanelText_UI_Event_Reward_Item_Text_C_Receive_Content = {Text = "領取"},
  PanelText_UI_Event_Task_Item_Text_C_Not_Content = {Text = "未達成"},
  PanelText_UI_Event_Task_Item_Text_C_Receive_Content = {Text = "領取"},
  PanelText_UI_Event_WeaponOptional_Text_C_Receive_Content = {
    Text = "剩餘喚醒次數："
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Introduction_Content = {
    Text = "來，以瘋狂、殺戮與痛苦為音符，頌奏這閃爍於辰星間的安魂曲吧。 \n那癡愚混沌的至高存在，不該甦醒，無論是此刻，還是未來。"
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Introduction_Content = {
    Text = "那神允諾的已然近了。\n數千載的等待即將迎來歡欣的終局，應許之地將從海中升起。\n神明從神母的胸腔中蘇生，七日終結之時，新的世界會降臨。"
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Title_Content = {
    Text = "創生七日"
  },
  PanelText_UI_Events_Item_Castor_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Castor_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_Free_Content = {Text = "免費"},
  PanelText_UI_Events_Item_GiftBag_Text_C_High_Content = {Text = "免費"},
  PanelText_UI_Events_Item_GiftBag_Text_C_Noraml_Content = {Text = "領取"},
  PanelText_UI_Events_Item_GiftBag_Text_C_Soldout_Content = {Text = "已領取"},
  PanelText_UI_Events_Item_Hamline_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Hamline_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Killed_Content = {
    Text = "已擊殺！"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Progress_Content = {Text = "可挑戰"},
  PanelText_UI_Events_Item_Optional_Text_C_Full_Content = {
    Text = "疊位已滿"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Have_Content = {Text = "已擁有"},
  PanelText_UI_Events_Item_OriDoll_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_OriDoll_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_PreOrderGift_Text_C_Lock_Content = {
    Text = "購買後可領取"
  },
  PanelText_UI_Events_Item_RAIDProgressGroup_Text_C_Kill_Content = {
    Text = "抓捕總數"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Career_Content = {
    Text = "隊伍要求"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Finish_Content = {Text = "已結束"},
  PanelText_UI_Events_Item_RAID_Text_Lock_Content = {
    Text = "尚未開放"
  },
  PanelText_UI_Events_Item_Rome_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Rome_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_SignDiamond_Text_C_Receive_Content = {Text = "已領取"},
  PanelText_UI_Events_Item_Sorel_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Sorel_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_NormalTip_Content = {
    Text = "普通難度待通關"
  },
  PanelText_UI_Events_Item_SurveyDiary_Text_Name_Content = {Text = "領取"},
  PanelText_UI_Events_Item_Tab_Text_C_Return_Content = {
    Text = "回歸活動"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Career_Content = {
    Text = "隊伍要求"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Finish_Content = {Text = "已結束"},
  PanelText_UI_Events_Item_Tulu_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Tulu_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_LockTips_Content = {
    Text = "完成特遣紀錄前置關卡解鎖"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Killed_Content = {
    Text = "已消滅！"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Progress_Content = {
    Text = "殘餘分身數量"
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "拋棄身軀，拋棄理智，在這純粹的意志世界，感受祂的存在。\n祂是你的唯一。祂亦是你的全部。"
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Title_Content = {
    Text = "異動海潮"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Introduction_Content = {
    Text = "張大嘴巴，大口撕咬。\n吞食與被吞食，這是戰鬥的規則，這是野獸的命運。"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Title_Content = {
    Text = "野獸雄心"
  },
  PanelText_UI_Events_OriHelot_Text_C_Fall_Content = {
    Text = "掉落預覽"
  },
  PanelText_UI_Events_OriHelot_Text_C_LockTips_Content = {
    Text = "關卡解鎖提示"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_ProgressTitle_Content = {
    Text = "世界擊殺進度"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Ordinary_Content = {
    Text = "普通紀行"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_PassportUp_Content = {
    Text = "紀行進階"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Senior_Content = {
    Text = "高級紀行"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_illustrate_Content = {
    Text = "活動說明"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_PayTip_Content = {
    Text = "當前展示價格為默認貨幣價格，僅供參考。支付時請以實際貨幣和價格為准。"
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Introduction_Content = {
    Text = "燈光亮起。掌聲平息。觀眾們期待著。\n上台的時候到了，我親愛的孩子們。去登台，去表演，去撕開你們的肺腑，出賣你們最深的隱秘。去用你們最慘烈的傷口，做成供人取悅的甜點。去貪婪地享受舞台上那道只為你點亮的光，直到帷幕將你與觀眾一同埋葬。\n這是你們命中注定的舞台，登上它吧！不要害怕，無需怯場。"
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Arachne_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Shop_Content = {
    Text = "劇院禮品店"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Topic_Content = {
    Text = "織者自縛"
  },
  PanelText_UI_Events_Panel_Attendance_Text_C_GiftTitle_Content = {
    Text = "完成任務領取幻衣兌換券"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_1_Content = {
    Text = "幻夢深潛"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_2_Content = {
    Text = "相位對弈"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_Content = {
    Text = "幻夢深潛"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Over_Content = {
    Text = "今日守密人經驗已獲得："
  },
  PanelText_UI_Events_Panel_Award_Text_C_Title_Content = {
    Text = "今日守密人經驗已獲得："
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Not_Unlocked_Content = {
    Text = "暫未解鎖"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Banquet_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Challenge_Content = {
    Text = "聖堂之路"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Fill_Up_Content = {
    Text = "(距離存儲上限："
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Finish_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Not_unlocked_Content = {
    Text = "<Gray:未解鎖>"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Pv_Content = {Text = "溯夢"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Record_Content = {
    Text = "血的顏色"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Resonance_Content = {
    Text = "共鳴：靈魂的岔路"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Shop_Content = {
    Text = "聖堂義賣現場"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Topic_Content = {
    Text = "靈魂的牧人·復刻"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Award_Content = {
    Text = "限時獎勵"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Limit_Content = {
    Text = "調查獎勵"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Over_Content = {
    Text = "所有獎勵已領取"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Pass_Content = {
    Text = "通關獎勵"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Title_Content = {
    Text = "獎勵預覽"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Introduction_Content = {
    Text = "♪~~♫~~♪~~♫~~♪~~♫~~\n在雪山下，所有的嚮導都記得，所有的孩子都將它傳唱。那是巍峨雪山意志的化身，那是慈悲的神女烏摩鉢蒂。\n她的神力散落人間，她的寶物無從尋覓，它們近在咫尺，它們渺無蹤跡。放棄一些什麼吧，堅持一些什麼吧。\n對神女的真身心有不誠者，將與死去的雪山一同，永遠葬身在雪山。"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Title_Content = {
    Text = "烏摩鉢蒂的寶物"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Challenge_Content = {
    Text = "烏摩鉢蒂的寶物"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Record_Content = {
    Text = "特遣記錄"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Shop_Content = {
    Text = "仙女典儀"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Topic_Content = {
    Text = "新月與深雪"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Introduction_Content = {
    Text = "飛鳥的一生，註定是自由的一生。你該看到它的破殼之時，它從死亡手中奪回生的自由。 你該看到它的學飛之時，它從安逸的溫巢中奪回獨自生存的自由。如今若將自由的鑰匙丟入死亡的深淵，那麼它必將毫不猶豫地一躍而下，在狹窄的生命與無限的自由中，選擇直面死亡的暴風。"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Title_Content = {
    Text = "飛躍青空"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Castor_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Challenge_Content = {
    Text = "飛躍青空"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Castor_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Castor_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Shop_Content = {
    Text = "求知的願望"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Topic_Content = {
    Text = "鏡像囚徒"
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Introduction_Content = {
    Text = "自那時起，她便不再落下一滴眼淚。\n獨自一人遊弋徘徊，徘徊在遍地異類的世界。\n一場盛大的計劃即將開始，作為她謝幕的最後告別。\n她是最成功的心理醫生，這是她最成功的一次治療。"
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Title_Content = {
    Text = "恐懼愈療"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Clementine_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Challenge_Content = {
    Text = "恐懼愈療"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Clementine_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Clementine_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Record_Content = {
    Text = "意識潛遊"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Resonance_Content = {
    Text = "共鳴：無"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Shop_Content = {
    Text = "神經診療室"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Topic_Content = {
    Text = "埋於記憶之下"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Empty_Content = {
    Text = "已獲得所有獎勵"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Rate_Content = {
    Text = "機率說明"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Tip_Content = {
    Text = "<color=#e3c96e>銀樞幻衣</color>有機會從第<color=#e3c96e>5</color>次抽取開始獲得"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Topic_Content = {
    Text = "靈魂牧羊人"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_Free_Content = {Text = "免費"},
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Introduction_Content = {
    Text = "這座海濱的小鎮上，擁有一條繁華的商業街。海上貿易令這裡彙集了無數時新的百貨，只要付出足夠的雷歐坊，你總能收穫滿意的商品。\n只有街角一間小小的店鋪除外，那是一家充滿了神奇古董的小店，在煙斗吐出的煙霧中，戴著寬簷帽子的老闆娘會向你緩緩露出一個微笑。\n“歡迎來到解憂小店，這裡能滿足您的一切需要，只要付出足夠的報酬……”\n“當然，當然，價格公道，童叟無欺。”"
  },
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Shop_Content = {
    Text = "魔女的寶庫"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Topic_Content = {
    Text = "雨鎮幽影"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Introduction_Content = {
    Text = "絃樂已升上中天，第十三道鐘聲已然奏響。\n今夜，詩人的餐刀將為我們吟誦。\n今夜，母親的喉管將擁我們入懷。"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Title_Content = {
    Text = "噬靈之饗"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Doresain_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Challenge_Content = {
    Text = "噬靈之饗"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Doresain_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Doresain_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Record_Content = {
    Text = "派遣記錄"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Shop_Content = {
    Text = "王邸餐廳"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Topic_Content = {
    Text = "死靈的美學"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Ordinary_Content = {
    Text = "普通紀行"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_PassportUp_Content = {
    Text = "紀行進階"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Senior_Content = {
    Text = "高級紀行"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_illustrate_Content = {
    Text = "活動說明"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Introduction_Content = {
    Text = "轟鳴之音，在他遊弋的棒尖奏響。\n沉浸長夢，直至毀滅終章。"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Title_Content = {
    Text = "轟鳴之音"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Hamline_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Challenge_Content = {
    Text = "轟鳴之音"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Hamline_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Hamline_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Resonance_Content = {
    Text = "共鳴：無"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Shop_Content = {
    Text = "安眠宮殿"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Topic_Content = {
    Text = "無形交響"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Introduction_Content = {
    Text = "殘敗花房裡囚禁著孤獨的玫瑰。"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Title_Content = {
    Text = "花園往事"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Horla_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Challenge_Content = {
    Text = "花園往事"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Horla_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Horla_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Resonance_Content = {
    Text = "共鳴：花園挽歌"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Reward_Content = {
    Text = "除塵津貼"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Sign_Content = {
    Text = "珈倫的謝禮"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Task_Content = {
    Text = "掃除進度"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Topic_Content = {
    Text = "掃除奇旅"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Introduction_Content = {
    Text = "她再次屹立於大地之上，燼滅一切的復仇便如約而至。\n\n那是永不停息的追獵，那是爆燃之主的炙火。\n\n她將行過每一個角落，獵殺所有與死神簽訂契約之徒。\n\n逃吧，逃吧，逃到更深的黑暗中去吧，逃到自以為不會被找到的地方去吧。\n\n儘管這毫無意義，因為祂終將踏過每一個世界。\n\n祂會獵盡所有，直至一切燼滅如灰。"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Title_Content = {
    Text = "燼滅追獵"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Challenge_Content = {
    Text = "燼滅追獵"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Fill_Up_Content = {
    Text = "(距離存儲上限："
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Record_Content = {
    Text = "意識潛遊"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Shop_Content = {
    Text = "隱秘的據點"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Topic_Content = {
    Text = "墜臨的萬千耀光"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Describe_Content = {
    Text = "你目睹的不只是靈魂的選擇，更是它飄忽搖擺的人生。"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Lake_City_Text_C_Title_Content = {
    Text = "聖堂之路"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_illustrate_Content = {
    Text = "玩法規則"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Introduction_Content = {
    Text = "朵爾交代的任務，從來都不簡單。\n即便她數次提醒大家「要玩得開心」，可首次帶著一群喚醒體出門，守密人怎麼能不膽戰心驚？\n但，要記得「玩得開心」哦。"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Title_Content = {
    Text = "劇本迷思"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Challenge_Content = {
    Text = "劇本迷思"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Resonance_Content = {
    Text = "共鳴：導演密碼"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Shop_Content = {
    Text = "魔法劇本商店"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Topic_Content = {
    Text = "故事的魔法·復刻"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Introduction_Content = {
    Text = "力量，權力，金錢，自由……利維坦的土地上，祂將賜你渴望的一切。\n只要，你能成為最後站著的那個人。"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Title_Content = {
    Text = "貪戮角逐"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Challenge_Content = {
    Text = "貪戮角逐"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Record_Content = {
    Text = "意識潛遊"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Shop_Content = {
    Text = "鬥獸場祭祀台"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Topic_Content = {
    Text = "利維坦的遊戲"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Challenge_Content = {
    Text = "劇本迷思"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Desc_Content = {
    Text = "朵爾交代的任務，從來都不簡單。\n即便她數次提醒大家「要玩得開心」，可首次帶著一群喚醒體出門，守密人怎麼能不膽戰心驚？\n但，要記得「玩得開心」哦。"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Own_Content = {
    Text = "當前擁有"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Resonance_Content = {
    Text = "共鳴：導演密碼"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Shop_Content = {
    Text = "魔法劇本商店"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentActivity_Content = {
    Text = "記憶迴廊"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentRule_Content = {
    Text = "記憶迴廊"
  },
  PanelText_UI_Events_Panel_Main_Text_C_SevenDays_Content = {
    Text = "七日簽到"
  },
  PanelText_UI_Events_Panel_Main_Text_C_illustrate_Content = {
    Text = "活動說明"
  },
  PanelText_UI_Events_Panel_Main_Text_Title_Content = {Text = "活動"},
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Introduction_Content = {
    Text = "踏上這條艱難又神聖的道路吧。在道路的盡頭，那最後的門將為你敞開。"
  },
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Title_Content = {
    Text = "神國誕臨"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Miriam_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Challenge_Content = {
    Text = "神國誕臨"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Miriam_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Miriam_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Resonance_Content = {
    Text = "共鳴：海淵祭儀"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Shop_Content = {
    Text = "沉淵的回應"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Topic_Content = {
    Text = "沉淵之祀"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Introduction_Content = {
    Text = "天空~晴朗~大海~平靜~\n莫絲~朋友~小煤球~出航！\n風暴、不怕、閃電、不怕、莫絲、朋友、小煤球~\n為了自由、要·出·發"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Title_Content = {
    Text = "莫絲與海"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Challenge_Content = {
    Text = "莫絲與海"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Shop_Content = {
    Text = "莫絲的寶庫"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Topic_Content = {
    Text = "默斯克斯的呼喚"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Introduction_Content = {
    Text = "突然有一天，你發現自己變得不一樣了。\n沒有人發現這一點，因為你有著一樣的行為舉止，一樣的盛世容顏。\n但你很清楚，那顆原本鮮紅的心，已經被覆上一張霧氣構成的假面。 \n「如果我能一直偽裝下去，那是否我依然是此前的我？」\n可喜可賀，這個問題並沒有在你的大腦裡停留超過一秒，反正在揭開那張假面之前，沒有人知道你真實的想法。\n「那就，先出發吧~」"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Mouchette_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Record_Content = {
    Text = "多維連接"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Topic_Content = {
    Text = "霧境的燔禮"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Introduction_Content = {
    Text = "自祂@1黑暗的@2中，偉大的@3降臨世界"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Title_Content = {
    Text = "黑暗子宮"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Challenge_Content = {
    Text = "黑暗子宮"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Homology_Content = {
    Text = "活動期間通過所有方式獲取的同調率翻倍！"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Record_Content = {
    Text = "薔薇禮讚"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Shop_Content = {
    Text = "聖胎孵化"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Topic_Content = {
    Text = "群星正位·復刻"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Challenge_Content = {
    Text = "異動海潮"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_GiftTitle_Content = {
    Text = "完成任務領取幻衣兌換券"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_ProgressTitle_Content = {
    Text = "異動海潮擊殺進度"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Topic_Content = {
    Text = "神國上浮"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Introduction_Content = {
    Text = "她注視著世界盡頭的那扇大門，毫不猶豫地跨出了腳步。\n哢噠，她擰開把手，迫不及待地望向門後。\n然而門後空無一物，她一腳踩空，墜入了虛無。\n她早該知道，禮物來得太過直接， 便總會有些高昂的代價。"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Title_Content = {
    Text = "虛無之門"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_OriDoll_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Challenge_Content = {
    Text = "虛無之門"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_OriDoll_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_OriDoll_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Record_Content = {
    Text = "意識潛遊"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Resonance_Content = {
    Text = "共鳴：無"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Shop_Content = {
    Text = "師長的教誨"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_OriHelot_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Challenge_Content = {
    Text = "野獸雄心"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_OriHelot_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_OriHelot_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Shop_Content = {
    Text = "山巒巨口"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Topic_Content = {
    Text = "雪山消融之時·復刻"
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Introduction_Content = {
    Text = "那神允諾的已然近了。\n數千載的等待即將迎來歡欣的終局，應許之地將從海中升起。\n神明從神母的胸腔中蘇生，七日終結之時，新的世界會降臨。"
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Title_Content = {
    Text = "創生七日"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_OriMurphy_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Challenge_Content = {
    Text = "創生七日"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Shop_Content = {
    Text = "神母寢宮"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Topic_Content = {
    Text = "神誕的祭禮"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_ChallengeTip_Content = {
    Text = "限時聯動"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Challenge_Content = {
    Text = "相位對弈"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Record_Content = {
    Text = "逆轉回合"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Topic_Content = {
    Text = "雨鎮幽影"
  },
  PanelText_UI_Events_Panel_PermanentActivity_Text_C_Reward_Content = {
    Text = "剩餘獎勵"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Introduction_Content = {
    Text = "理智與崩潰之間，詭譎的繪卷徐徐展開。\n你唾棄的幻覺，繪就綺麗的色彩，\n你畏懼的失控，構成忠誠的形式。\n在這裡，瘋狂是藝術的本能，是世界的根源，\n是唯一不會撒謊的真實。"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Title_Content = {
    Text = "異界圖卷"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Challenge_Content = {
    Text = "異界圖卷"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Record_Content = {
    Text = "意識潛遊"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Shop_Content = {
    Text = "皮克曼的畫室"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Topic_Content = {
    Text = "畫布的暗面"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Introduction_Content = {
    Text = "那些恨與愛，溫情與傷害，曾擁有的與錯過的，早已糾纏不能理清。\n就讓我們相同的骨血流淌吧，它們將彙聚在一處，構成我們不可分割的命運。"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Pollux_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Record_Content = {
    Text = "天邊之外·下"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Shop_Content = {
    Text = "賜福儀式"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Topic_Content = {
    Text = "極晝的終夜"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Introduction_Content = {
    Text = "當不祥的白光再次穿透高屋的窗扉，他已經向你發出邀約。\n包容、吞沒、裹挾、擁擠…… \n回應來自海洋深處的呼喚，加入這不休的巡獵， 你的過往、你的自我，一切都已無關緊要。"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Title_Content = {
    Text = "高屋巡獵"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Challenge_Content = {
    Text = "高屋巡獵"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Record_Content = {
    Text = "意識潛遊"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Shop_Content = {
    Text = "無邊獵場"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Topic_Content = {
    Text = "永遠的厄波揚斯"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Challenge_Content = {
    Text = "貓海淘銀"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Reward_Content = {
    Text = "黑貓抓捕記錄"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Topic_Content = {
    Text = "貓的「報恩」"
  },
  PanelText_UI_Events_Panel_RailWay_StageGroup_Text_C_Title_Content = {
    Text = "列車啟程"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Challenge_Content = {
    Text = "列車啟程"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Rank_Content = {
    Text = "貴賓名錄"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "小「N」的協助"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Reward_Content = {
    Text = "專列軌跡"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Topic_Content = {
    Text = "疾馳的歡愉專列"
  },
  PanelText_UI_Events_Panel_Reward_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Events_Panel_Reward_Text_Title_Content = {
    Text = "任務獎勵"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Introduction_Content = {
    Text = "我們是食肉者，我們是狼的後代。 那些美味的、流淌鮮血的肉塊，終將落入我們的胃袋。"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Title_Content = {
    Text = "神聖的獵食"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Rome_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Challenge_Content = {
    Text = "神聖的獵食"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Rome_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Rome_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Shop_Content = {
    Text = "敬獻貢禮"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Topic_Content = {
    Text = "羅馬！特別活動"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Introduction_Content = {
    Text = "沒錯，現在已經不流行平平無奇的普通人偵探了。 \n如果你既不能飛天遁地、也沒有一個科學家助理， 請重新制定你的職業規劃。"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Title_Content = {
    Text = "月夜傳說"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Challenge_Content = {
    Text = "月夜傳說"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Homology_Content = {
    Text = "活動期間通過所有方式獲取的同調率翻倍！"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Record_Content = {
    Text = "狩獵愉快！"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Shop_Content = {
    Text = "好運俱樂部"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Topic_Content = {
    Text = "名偵探手冊·復刻"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Introduction_Content = {
    Text = "科學，無關緊要。\n倫理，無關緊要。\n道德，無關緊要。\n生命，死亡，希望，絕望……最終的最終，地下室的筆記本上，用兩種筆跡留下同一個推演。\n祂們說：「看，愛是唯一的、永恆的主題。」"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Title_Content = {
    Text = "暗室手記"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Challenge_Content = {
    Text = "暗室手記"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Record_Content = {
    Text = "被遺忘的愛之種"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Shop_Content = {
    Text = "蒲公英園圃"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Topic_Content = {
    Text = "顛倒的新生"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Introduction_Content = {
    Text = "多年以後，傳記作家在一個黃昏叩響她的家門。\n那天她們聊了很多，從瑪瑙石到薔薇凋零的宅邸……\n如今，作家將這些零碎的話語編纂成書，獻予在座的諸位。"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Title_Content = {
    Text = "薔薇憶事"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Challenge_Content = {
    Text = "薔薇憶事"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Homology_Content = {
    Text = "活動期間通過所有方式獲取的同調率翻倍！"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Record_Content = {
    Text = "薔薇禮讚"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Shop_Content = {
    Text = "金紅慶典"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Topic_Content = {
    Text = "與薔薇書"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Limit_Content = {
    Text = "調查獎勵"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Over_Content = {
    Text = "所有獎勵條件已達成"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Pass_Content = {
    Text = "通關獎勵"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Title_Content = {
    Text = "完成該喚醒體試用後可獲得獎勵"
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Introduction_Content = {
    Text = "老式六分儀確定星辰的夾角，古老的海圖劃定預期的航線，破舊的羅盤決定前進的方向……\n即使是位於深邃冰冷的黑海中，仍有探索者憑藉無比凡俗的銅與鐵，為眾人指引前路。\n願所有引導者，都不至陷入迷茫。"
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Record_Content = {
    Text = "最後的引航"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Shop_Content = {
    Text = "船員的秘寶"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Topic_Content = {
    Text = "於暴雨中搖曳"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Introduction_Content = {
    Text = "友誼第一，比賽第二——才怪！\n在熾熱的晴空下揮灑汗水，向著冠軍進發！"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Title_Content = {
    Text = "沙灘排球賽"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Summer1_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Challenge_Content = {
    Text = "沙灘排球賽"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Shop_Content = {
    Text = "海濱旅店"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Sign_Content = {
    Text = "徹夏狂歡"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Topic_Content = {
    Text = "夏日特別活動·上"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Introduction_Content = {
    Text = "暖和的陽光下，一切都如此溫馨幸福。\n你望著像童話書中一樣湛藍的天空，決定親手撕開畫布，從虛假的世界破膛而出。"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Progress_Content = {
    Text = "星級進度"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Summer2_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Shop_Content = {
    Text = "學生會辦公樓"
  },
  PanelText_UI_Events_Panel_SurveyDiary_Text_C_Return_Content = {
    Text = "返校獎勵"
  },
  PanelText_UI_Events_Panel_Task_Text_C_OneKeyName_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Events_Panel_Task_Text_Title_Content = {
    Text = "掃除進度"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Introduction_Content = {
    Text = "跨越窮極之門，抵達無限智慧的領域。\n直面褻瀆之物，了悟何為「自身」。\n這是祂賜予你的《最終測試》。"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Title_Content = {
    Text = "最終測試"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Tawil_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Challenge_Content = {
    Text = "最終測試"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Shop_Content = {Text = "回聲"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Topic_Content = {
    Text = "萬象門扉"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Challenge_Content = {
    Text = "群貓亂舞"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Tip_Content = {
    Text = "每天開放不同的校貓關卡，挑戰成功可獲得豐富獎勵！"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Topic_Content = {
    Text = "烏撒貓貓律"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Describe_Content = {
    Text = "時間流轉往復，凋零的花再度盛開。"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Title_Content = {
    Text = "紊亂情慾"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_illustrate_Content = {
    Text = "玩法規則"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Challenge_Content = {
    Text = "紊亂情慾"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Homology_Content = {
    Text = "活動期間通過所有方式獲取的同調率翻倍！"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_RecordTip_Content = {
    Text = "限時優惠解鎖"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Record_Content = {
    Text = "繁衍狂熱"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Topic_Content = {
    Text = "慾海翻波"
  },
  PanelText_UI_Events_Panel_Try_Text_C_Summon_Content = {
    Text = "前往喚醒"
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Introduction_Content = {
    Text = "祈禱、奉獻、犧牲，人類的深刻，於祂而言，只是聒噪的鬧劇。\n但這鬧劇，偶爾也會留下痕跡，在神王的眸中……或心裡。"
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Title_Content = {
    Text = "深海凝視"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Tulu_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Challenge_Content = {
    Text = "深海凝視"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Tulu_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Tulu_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Resonance_Content = {
    Text = "共鳴：吞噬山脈"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Shop_Content = {
    Text = "覺知海淵"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Topic_Content = {
    Text = "神王復甦"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Challenge_Content = {
    Text = "記憶編碼"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Fill_Up_Content = {
    Text = "(距離存儲上限："
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finish_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Not_unlocked_Content = {
    Text = "<Gray:未解鎖>"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Record_Content = {
    Text = "寧靜的裂殖"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Resonance_Content = {
    Text = "共鳴：分離性症候"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Topic_Content = {
    Text = "多重療癒·復刻"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Describe_Content = {
    Text = "伊薩拉烏，湖中之城，據說是旺達故鄉的所在。\n這次你將穿過夢境的大門，抵達那遍布鐘舌的古老塔群……"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_illustrate_Content = {
    Text = "玩法規則"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Can_Unlockable_Content = {Text = "可領取"},
  PanelText_UI_Events_Panel_Wanda_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Fill_Up_Content = {
    Text = "(距離補滿："
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Finished_Content = {Text = "已結束"},
  PanelText_UI_Events_Panel_Wanda_Text_C_Not_unlocked_Content = {Text = "未解鎖"},
  PanelText_UI_Events_Panel_Wanda_Text_C_Receive_Content = {
    Text = "距離可領取"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Record_Content = {
    Text = "燃燒的群宴"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Resonance_Content = {
    Text = "共鳴：代行密令"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Shop_Content = {
    Text = "旺達的奇珍寶匣"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Topic_Content = {
    Text = "燃燒的群宴"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_ProgressTitle_Content = {
    Text = "再戰原初進度"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Rank_Content = {
    Text = "榮勳名錄"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Record_Content = {
    Text = "特遣紀錄"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Topic_Content = {
    Text = "決勝：原初之影"
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Introduction_Content = {
    Text = "由愛中生出怨、由怨中生出恨、黏稠的、綿連的、陰沉的……\n求天不應、遁地無門、於是那隱在夜霧中的笑語回應了你的呼喚、你不用付出任何代價。\n看向她、依從她、融於她、成為她。"
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Title_Content = {
    Text = "玄女無相"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_ChallengeTip_Content = {
    Text = "玩法限時開放"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Challenge_Content = {
    Text = "玄女無相"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_RecordTip_Content = {
    Text = "限時免費解鎖"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Record_Content = {
    Text = "意識潛遊"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Reward_Content = {
    Text = "成就獎勵"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Topic_Content = {
    Text = "海城舊聞"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Awards_Content = {Text = "獎項"},
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_CurRate_Content = {
    Text = "當前機率"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_InitRate_Content = {
    Text = "初始機率"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Item_Content = {
    Text = "獎勵道具"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Rate_Content = {Text = "機率"},
  PanelText_UI_Events_Popup_GiftBag_Text_C_Desc_Content = {
    Text = "活動描述"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_InfoTitle_Content = {
    Text = "活動簡介"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_OptionWeapon_Content = {
    Text = "查看全部可選命輪"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_Slogan_Content = {
    Text = "僅限24小時！\n常駐喚醒體選擇其一！"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_SpecialTime_Content = {Text = "剩餘"},
  PanelText_UI_Events_Popup_GiftBag_Text_PayTip_Content = {
    Text = "當前展示價格為默認貨幣價格，僅供參考。支付時請以實際貨幣和價格為准。"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_1_Content = {
    Text = "查看詳情"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_2_Content = {Text = "領取"},
  PanelText_UI_Events_Popup_Optional_Text_C_Title_Content = {
    Text = "自選命輪"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistAwaker_Content = {
    Text = "助戰角色"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistCount_Content = {
    Text = "助戰次數"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Assist_Content = {
    Text = "協助次數榜"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Assist_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Kill_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Assist_Content = {
    Text = "守密人資訊"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Kill_Content = {
    Text = "守密人資訊"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_KillCount_Content = {
    Text = "總抓捕數"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Kill_Content = {
    Text = "抓捕次數榜"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Title_Content = {
    Text = "榮勳名錄"
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Introduction_Content = {
    Text = "黑色，黑色，黑色……\n漆黑的怪物嘶吼著，咆哮著，狂舞著，如潮水般向你衝來。\n 「噗嗤——」\n「這隻銀芯怎麼這麼少，下次記得多帶一點再來。」"
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Title_Content = {
    Text = "貓海淘銀"
  },
  PanelText_UI_Events_Stage_Tip_Text_C_Title_Content = {
    Text = "調查獎勵"
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Introduction_Content = {
    Text = "黑色，黑色的浪潮不停奔湧。\n癲狂的貓貓包圍了你，它們從萬千維度之中向你奔赴而來。"
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Title_Content = {
    Text = "群貓亂舞"
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "面對你們最原初的絕望。面對你們最原初的恐懼。 \n站在看不見的彼此身邊，然後戰勝祂。"
  },
  PanelText_UI_Events_illustrate_Tip_Text_C_Title_Content = {
    Text = "喚醒體說明"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Full_Content = {
    Text = "素材已滿足"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Source_Content = {
    Text = "獲取來源"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Sweep_Content = {Text = "重現"},
  PanelText_UI_GuideNote_Item_Task_Text_C_Recieve_Content = {Text = "領取"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Source_Content = {
    Text = "獲取來源"
  },
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Sweep_Content = {Text = "重現"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Change_Content = {Text = "更換"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Choose_Content = {
    Text = "點擊選擇喚醒體"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Detail_Content = {Text = "詳情"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_ExcludeTalent_Content = {Text = "天賦"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Level_Content = {Text = "等級"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_NoTask_Content = {
    Text = "選擇一名喚醒體"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Talent_Content = {Text = "天賦"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Abyss_Content = {
    Text = "剩餘獎勵"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_DailyChallenge_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Pvp_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RailyWay_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RotationMode_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_DailyChallenge_Content = {Text = "積分"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_Pvp_Content = {Text = "積分"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RailyWay_Content = {
    Text = "賽季進度"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RotationMode_Content = {Text = "積分"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Abyss_Content = {
    Text = "融災禁區"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_DailyChallenge_Content = {
    Text = "幻夢深潛"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Pvp_Content = {
    Text = "相位對弈 - 預組模式"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RailyWay_Content = {
    Text = "疾馳的歡愉專列"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RotationMode_Content = {
    Text = "相位對弈 - 輪選模式"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ItemsPreview_Content = {
    Text = "剩餘資源預覽"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Null_Content = {
    Text = "無剩餘資源"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ProgressTitle_Content = {
    Text = "玩法進度"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Title_Content = {
    Text = "調查行動"
  },
  PanelText_UI_Guide_ChangeName_Image_Confim_Dis_Bg_Content = {Text = "鐫刻"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Dis_Content = {Text = "簽名"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Nor_Content = {Text = "簽名"},
  PanelText_UI_Guide_ChangeName_Text_C_Return_Content = {
    Text = "返回選擇性別"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Tips_Content = {
    Text = "請輸入您的名字"
  },
  PanelText_UI_Guide_ChangeName_Text_Confim_Nor_Content = {Text = "鐫刻"},
  PanelText_UI_Homeland_Item_Building_Text_C_Done_Content = {Text = "已滿"},
  PanelText_UI_Homeland_Panel_Main_Text_C_Tips_Content = {
    Text = "加成總覽"
  },
  PanelText_UI_InvitationCode_Item_Player_Text_Name_Content = {Text = "領取"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_BindingTip_Content = {
    Text = "綁定引路守密人，在無數銀鑰閃爍的宇宙中，你並不寂寞。"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_High_Content = {
    Text = "綁定邀請"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_Nor_Content = {
    Text = "綁定邀請"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Condition_Content = {
    Text = "被邀的守密人在等級達到5/10/15/20級後，可獲得銀鑰輝光獎勵。"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Copy_Content = {Text = "複製"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Desc_Content = {
    Text = "複製邀請碼，引領無限宇宙中的靈魂共赴融蝕之旅。"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InputTip_Content = {
    Text = "填寫好友專屬邀請碼，即可立即領取"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InviteCount_Content = {
    Text = "已邀請人數"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_High_Content = {
    Text = "邀請活動"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_Nor_Content = {
    Text = "邀請活動"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_MyCode_Content = {
    Text = "我的邀請碼"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Paste_Content = {Text = "粘貼"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Tips_Content = {
    Text = "輸入邀請碼"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Value_Content = {
    Text = "銀鑰輝光"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_illustrate_Content = {
    Text = "活動說明"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_Title_Content = {
    Text = "邀請活動"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Null_Content = {
    Text = "暫無達到Lv.5的受邀守密人"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title_Content = {
    Text = "邀請清單"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Acquire_Content = {
    Text = "獲得新鑰令"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Tips_Content = {
    Text = "點擊螢幕關閉"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Current_Content = {
    Text = "當前使用"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Disable_Content = {
    Text = "無法使用"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_1_Content = {Text = "選擇"},
  PanelText_UI_Keeper_Skill_Panel_Text_C_NoTask_Content = {
    Text = "暫無鑰令"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Title_Content = {Text = "鑰令"},
  PanelText_UI_Login_Panel_ServerSelect_Text_Panel_Title_Content = {
    Text = "伺服器選擇"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Activity_Content = {
    Text = "活動告示"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_BugFix_Content = {
    Text = "問題修復"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title_Content = {
    Text = "暫無告示"
  },
  PanelText_UI_Login_Text_C_Build_Title_Content = {Text = "Bvn："},
  PanelText_UI_Login_Text_C_Deal_Content = {Text = "協議"},
  PanelText_UI_Login_Text_C_Enter_Content = {
    Text = "進入大學"
  },
  PanelText_UI_Login_Text_C_Fight_Content = {Text = "戰鬥2.0"},
  PanelText_UI_Login_Text_C_Plot_Content = {
    Text = "Avg劇情測試"
  },
  PanelText_UI_Login_Text_C_Repair_Content = {Text = "修復"},
  PanelText_UI_Login_Text_C_Set_Content = {Text = "設置"},
  PanelText_UI_Login_Text_C_Setting_Content = {Text = "設置"},
  PanelText_UI_Login_Text_C_Sweep_Content = {Text = "掃碼"},
  PanelText_UI_Login_Text_C_Title1_Content = {
    Text = "忘卻前夜"
  },
  PanelText_UI_Login_Text_C_User_Content = {
    Text = "用戶中心"
  },
  PanelText_UI_Login_Text_C_Ver_Title_Content = {Text = "Ver："},
  PanelText_UI_Mail_Text_C_All_Content = {
    Text = "全部領取"
  },
  PanelText_UI_Mail_Text_C_Collection_Content = {
    Text = "郵件珍藏箱"
  },
  PanelText_UI_Mail_Text_C_Delete01_Content = {Text = "刪除"},
  PanelText_UI_Mail_Text_C_Delete_Content = {
    Text = "刪除已讀"
  },
  PanelText_UI_Mail_Text_C_Empty_Content = {
    Text = "沒有新的郵件"
  },
  PanelText_UI_Mail_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Mail_Text_C_Mail_Content = {Text = "郵件數"},
  PanelText_UI_Mail_Text_C_Name_Content = {Text = "領取"},
  PanelText_UI_Mail_Text_C_NoTask1_Content = {
    Text = "暫無信件"
  },
  PanelText_UI_Mail_Text_C_Select_Letter_Content = {
    Text = "選擇一封郵件"
  },
  PanelText_UI_Mail_Text_C_Time_Content = {Text = "時間："},
  PanelText_UI_Main_Daily_Tips_Text_C_Close_Content = {
    Text = "點擊螢幕關閉"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Daily_Content = {
    Text = "每日試訓"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Receive_Content = {Text = "已領取"},
  PanelText_UI_Main_Daily_Tips_Text_C_Reward_Content = {
    Text = "完成獎勵"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Skill_Tag_Content = {
    Text = "調查途徑"
  },
  PanelText_UI_Main_Favor_Tip_Text_C_Name_Content = {Text = "同調率"},
  PanelText_UI_Main_Helicopter_Tips_Text_C_Awaken_Content = {
    Text = "喚醒日期"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Favor_Content = {
    Text = "當前同調率"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Tip_Content = {
    Text = "邀請喚醒體後，每隔一段時間該喚醒體可獲得同調率"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_Name_1_Content = {
    Text = "邀請來客"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_ResetBg_Content = {
    Text = "默認音畫"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Proxy_Content = {
    Text = "代理憑證"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Receive_Content = {Text = "領取"},
  PanelText_UI_Main_Panel_1_Text_Abyss_Content = {
    Text = "融災禁區"
  },
  PanelText_UI_Main_Panel_1_Text_C_Acclaim_Content = {Text = "好評"},
  PanelText_UI_Main_Panel_1_Text_C_Activity_Content = {Text = "活動"},
  PanelText_UI_Main_Panel_1_Text_C_Awaker_Content = {Text = "喚醒體"},
  PanelText_UI_Main_Panel_1_Text_C_Bag_Content = {Text = "物資"},
  PanelText_UI_Main_Panel_1_Text_C_Close_1_Content = {Text = "關閉中"},
  PanelText_UI_Main_Panel_1_Text_C_Close_Content = {Text = "關閉中"},
  PanelText_UI_Main_Panel_1_Text_C_Collection_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Main_Panel_1_Text_C_Community_Content = {Text = "社區"},
  PanelText_UI_Main_Panel_1_Text_C_Daily_Content = {
    Text = "每日試訓"
  },
  PanelText_UI_Main_Panel_1_Text_C_Dbg_Content = {
    Text = "幕間演習"
  },
  PanelText_UI_Main_Panel_1_Text_C_DungeonNote_Content = {
    Text = "密境課室"
  },
  PanelText_UI_Main_Panel_1_Text_C_Formation_Content = {Text = "編隊"},
  PanelText_UI_Main_Panel_1_Text_C_GamePassport_Content = {
    Text = "守密紀行"
  },
  PanelText_UI_Main_Panel_1_Text_C_Lesson_Content = {
    Text = "學期課題"
  },
  PanelText_UI_Main_Panel_1_Text_C_Main_Content = {Text = "調查"},
  PanelText_UI_Main_Panel_1_Text_C_Mission_Content = {
    Text = "學籍檔案"
  },
  PanelText_UI_Main_Panel_1_Text_C_Pvp_Content = {
    Text = "相位對弈\n"
  },
  PanelText_UI_Main_Panel_1_Text_C_Recall_Content = {
    Text = "記憶迴廊"
  },
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Content = {Text = "喚醒"},
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Nor_Content = {Text = "喚醒"},
  PanelText_UI_Main_Panel_1_Text_C_Store_Content = {
    Text = "彌薩格商店"
  },
  PanelText_UI_Main_Panel_1_Text_C_Welfare_Content = {
    Text = "海量福利，限時領取"
  },
  PanelText_UI_Main_Panel_1_Text_Diving_Content = {
    Text = "幻夢深潛"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_Title_Content = {
    Text = "常訓任務"
  },
  PanelText_UI_Michi_Popup_Strengthen_Succeed_Text_C_Info_Content = {
    Text = "點擊空白處關閉"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Donated_Content = {
    Text = "累計已捐獻"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Fund_Content = {
    Text = "校友捐獻基金"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Title_Content = {
    Text = "源液捐獻"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Describe_Content = {
    Text = "捐獻「源液」、累積貢獻、您的善行將得到回饋。 您的「總貢獻值」是累積捐獻的「源液」之和。"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Donated_Content = {
    Text = "當前總貢獻"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Title_Content = {
    Text = "校友捐獻基金"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_illustrate_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_All_Content = {
    Text = "全部恢復："
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Auto_Content = {
    Text = "自動恢復"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_2_Content = {Text = "確定"},
  PanelText_UI_Other_Physical_Tips_Text_C_Next_Content = {
    Text = "下次恢復："
  },
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Info_Content = {
    Text = "點擊空白處關閉"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Next_Content = {
    Text = "消耗銀芯結晶"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Now_Content = {
    Text = "當前銀芯結晶"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Question_Content = {
    Text = "要獲取金鑰嗎？"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Next_Content = {
    Text = "消耗金鑰"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Now_Content = {
    Text = "持有金鑰"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Title_Content = {
    Text = "金鑰獲取"
  },
  PanelText_UI_Other_Popup_Trinket_LevelUp_Text_C_Success_Content = {
    Text = "強化成功"
  },
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_Wait_Content = {
    Text = "等待輪選資訊展示"
  },
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Defend_Content = {Text = "後手"},
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Adjust_Content = {
    Text = "點擊更改喚醒體站位"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_My_Content = {
    Text = "準備就緒！"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_Other_Content = {
    Text = "準備就緒！"
  },
  PanelText_UI_PVP_Panel_TeamRotation_Text_BtnName_Content = {Text = "選定"},
  PanelText_UI_Passport_Choose_Tip_Text_C_Title_Content = {
    Text = "請選擇獲得的獎勵"
  },
  PanelText_UI_Passport_Exchange_Text_C_Buy_Title_Content = {
    Text = "提升等級"
  },
  PanelText_UI_Passport_Exchange_Text_C_Title_Content = {
    Text = "提升課題等級"
  },
  PanelText_UI_Passport_Instructions_Text_C_Remainder_Content = {
    Text = "本期剩餘時間"
  },
  PanelText_UI_Passport_Instructions_Text_C_Title_Content = {
    Text = "學期課題"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Additional_Content = {
    Text = "解鎖立即獲得"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Condition_Content = {
    Text = "完成所有課題可累計獲得"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_3_Content = {Text = "級"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_4_Content = {
    Text = "課題等級"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_Content = {
    Text = "立即提升<color=#5EF2FF><size=32>10</size>級</color>課題等級"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Introduce_Content = {
    Text = "解鎖高階課題並提升到40級，可在課題禮匣中選一個命輪或「流明之芯」×5作為獎勵"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Name_Content = {
    Text = "訓令表彰"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_1_Content = {
    Text = "基礎活性\n三倍獎勵"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_2_Content = {
    Text = "戰鬥回合\n回溯"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_3_Content = {
    Text = "相位對弈\n全卡暢玩"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_Content = {
    Text = "本期課題持續期間擁有特權"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Prompt_Content = {
    Text = "請適度娛樂，理性消費"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_1_Content = {Text = "已購買"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_2_Content = {Text = "已購買"},
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Senior (1)_Content"] = {Text = "高級"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Senior_Content = {
    Text = "高階課題"
  },
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Super (1)_Content"] = {Text = "特級"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Super_Content = {
    Text = "核心課題"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_TempUnlock_Content = {
    Text = "立即獲得核心課題限定獎勵"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_ThisIssue_Content = {
    Text = "完成所有課題可累計獲得"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Condition_Content = {
    Text = "升級後可領取"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_3_Content = {Text = "級"},
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_4_Content = {
    Text = "課題等級，並獲得"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Introduce_Content = {
    Text = "封裝著珍貴命輪的精製禮匣，純手工打造。\n解鎖高階課題並提升到40級，可在課題禮匣中挑選一個命輪或「流明之芯」×5作為獎勵。"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Name_Content = {
    Text = "課題禮匣"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Prompt_Content = {
    Text = "請適度娛樂，理性消費"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_1_Content = {Text = "已購買"},
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_2_Content = {Text = "已購買"},
  ["PanelText_UI_Passport_Money_Item_Text_C_Senior (1)_Content"] = {Text = "高級"},
  PanelText_UI_Passport_Money_Item_Text_C_Senior_Content = {
    Text = "高階課題"
  },
  ["PanelText_UI_Passport_Money_Item_Text_C_Super (1)_Content"] = {Text = "特級"},
  PanelText_UI_Passport_Money_Item_Text_C_Super_Content = {
    Text = "核心課題"
  },
  PanelText_UI_Passport_Money_Item_Text_C_ThisIssue_Content = {
    Text = "包含當期高階課題全部內容"
  },
  PanelText_UI_Passport_Panel_Main_New_Text_C_Mail_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Passport_Panel_Main_New_Text_C_Title_Content = {
    Text = "學期課題"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Experience_Content = {
    Text = "課題經驗"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Full_Content = {Text = "已滿級"},
  PanelText_UI_Passport_Panel_Main_Text_C_Instructions_Grade_Content = {
    Text = "課題等級"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Mail_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Name_Content = {
    Text = "提升等級"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Online_Content = {
    Text = "本週經驗上限"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Title_Content = {
    Text = "學期課題"
  },
  PanelText_UI_Passport_Popup_Player_LevelUp_Text_C_Title_Content = {
    Text = "課題等級提升"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Passport_Popup_Recharge_Text_Title_Content = {
    Text = "購買確認"
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Content_Content = {
    Text = "封裝著珍貴命輪的精製禮匣，純手工打造。\n解鎖高階課題並提升到40級，可在課題禮匣中挑選一個命輪或「流明之芯」×5作為獎勵。"
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Title_Content = {
    Text = "課題禮匣"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Experience_Content = {
    Text = "課題經驗"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Full_Content = {Text = "已滿級"},
  PanelText_UI_Passport_Reward_Item_New_Text_C_GainExperience_Content = {
    Text = "獲取經驗"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_2_Content = {
    Text = "購買等級"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Online_Content = {
    Text = "本週上限"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Ordinary_Title_Content = {
    Text = "基礎課題"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Content = {
    Text = "課題進階"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Title_Content = {
    Text = "高階課題"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Unlock_Content = {
    Text = "解鎖立即獲得"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Experience_Content = {
    Text = "課題經驗"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Full_Content = {Text = "已滿級"},
  PanelText_UI_Passport_Reward_Item_Text_C_Name_2_Content = {
    Text = "購買等級"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Online_Content = {
    Text = "本週上限"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Ordinary_Title_Content = {
    Text = "基礎課題"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Content = {
    Text = "課題進階"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Title_Content = {
    Text = "高階課題"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Tab_Special_Content = {Text = "高級"},
  PanelText_UI_Passport_Reward_Item_Text_C_Timing_Content = {
    Text = "本期剩餘時間"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Introduce_Content = {
    Text = "解鎖高階課題並提升到40級，可在課題禮匣中選一個命輪或「流明之芯」×5作為獎勵"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Reward_Content = {
    Text = "本期禮匣預覽"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Time_1_Content = {
    Text = "本期剩餘活動時間"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Double_Content = {
    Text = "雙倍經驗"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Tab_Special_Content = {Text = "活動"},
  PanelText_UI_Passport_Task_Description_Text_C_Name_Content = {Text = "領取"},
  PanelText_UI_Passport_Task_Description_Text_C_Tab_Special_Content = {Text = "活動"},
  PanelText_UI_Passport_Task_Item_Text_C_Experience_Content = {
    Text = "課題經驗"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Full_Content = {Text = "已滿級"},
  PanelText_UI_Passport_Task_Item_Text_C_Name_3_Content = {
    Text = "購買等級"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Online_Content = {
    Text = "本週上限"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Time_Content = {
    Text = "本期剩餘時間"
  },
  PanelText_UI_Passport_illustrate_Tip_Text_C_Title_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Pocket_Mail_Text_C_Del_Content = {Text = "刪除"},
  PanelText_UI_Pocket_Mail_Text_C_Time_Content = {Text = "時間："},
  PanelText_UI_Pocket_Mail_Text_C_Tips_Content = {Text = "珍藏數"},
  PanelText_UI_Pocket_Mail_Text_C_Title_Content = {
    Text = "暫無信件"
  },
  PanelText_UI_Pocket_Mail_Text_C_select_Title_Content = {
    Text = "選擇一封信件"
  },
  PanelText_UI_Popup_DonationBox_Text_C_Reward_Content = {Text = "物資"},
  PanelText_UI_Popup_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "獲取速度："
  },
  PanelText_UI_Protagonist_Item_Skill_Text_C_Current_Content = {Text = "當前"},
  PanelText_UI_Protagonist_Item_Skill_Text_C_No_Content = {Text = "未獲得"},
  PanelText_UI_Pvp_Blood_Share_Text_C_Release_Content = {
    Text = "點擊釋放"
  },
  PanelText_UI_Pvp_Item_Card_Text_C_Replace_Content = {Text = "替換"},
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Done_Content = {
    Text = "已關注我"
  },
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Mutual_Content = {
    Text = "互相關注"
  },
  PanelText_UI_Pvp_Item_Dan_Text_C_Current_Content = {
    Text = "當前段位"
  },
  PanelText_UI_Pvp_Item_Formation_Text_C_Conflict_Content = {
    Text = "定位衝突"
  },
  PanelText_UI_Pvp_Item_List_Text_C_Uid_Title_Content = {Text = "UID ："},
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Double_Content = {
    Text = "福利雙倍"
  },
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Topic_Content = {
    Text = "課題特權"
  },
  PanelText_UI_Pvp_Item_Ranking_Text_C_Current_Content = {
    Text = "當前獎勵"
  },
  PanelText_UI_Pvp_Item_Role_Text_C_Decks_Content = {Text = "牌組"},
  PanelText_UI_Pvp_Item_Role_Text_C_Maniac_Content = {Text = "狂氣"},
  PanelText_UI_Pvp_Item_Role_Text_C_Role_Wins_Content = {Text = "勝場"},
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_C_NoTask_Content = {
    Text = "暫無評論"
  },
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_Time_Content = {
    Text = "作出第一個評論吧"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Decks_Content = {Text = "牌組"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Maniac_Content = {Text = "狂氣"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_TotalWins_Content = {Text = "總勝場"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_Wins_Content = {
    Text = "本月勝場"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Skill_Tag_Content = {
    Text = "狂氣爆發"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Source_Content = {Text = "來源"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_TotalWins_Content = {Text = "總勝場"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Wins_Content = {
    Text = "本賽季勝場"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_None_Content = {
    Text = "暫無相關收藏"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_Time_Content = {
    Text = "該界域在相位對弈暫未開放"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Awaker_Name_Content = {Text = "喚醒體"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_KeeperSkill_Name_Content = {Text = "鑰令"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_1_Content = {Text = "詳情"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_3_Content = {Text = "評論"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Train_Name_Content = {
    Text = "喚醒體試用"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Weapon_Name_Content = {Text = "命輪"},
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_NoTask_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_SeasonWins_Content = {
    Text = "本月勝場"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_TotalWins_Content = {Text = "總勝場"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Decks_Content = {Text = "牌組"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Maniac_Content = {Text = "狂氣"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Role_Wins_Content = {Text = "勝場"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Wins_Content = {Text = "勝場"},
  PanelText_UI_Pvp_Panel_Formation_Text_C_Detail_Content = {
    Text = "請從左側選擇上場"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_1_Content = {
    Text = "請從左側選擇上場"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_Content = {
    Text = "請從左側選擇上場"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Name_Content = {Text = "詳情"},
  PanelText_UI_Pvp_Panel_Formation_Text_C_None_Content = {
    Text = "無相關篩選結果"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Time_Content = {
    Text = "可通過特定途徑獲取"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Award_Content = {
    Text = "勝場獎勵"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_CardEdit_Content = {
    Text = "預組編隊"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Robot_Content = {Text = "關閉"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Speed_Content = {Text = "關閉"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_DraftPick_Content = {
    Text = "輪選等級"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Expression_Content = {
    Text = "對戰表情"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Integral_Content = {
    Text = "賽季積分"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Matching_Content = {
    Text = "開始匹配"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Robot_Content = {Text = "開啟"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Speed_Content = {Text = "開啟"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Password_Content = {
    Text = "密碼對戰"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Precon_Content = {
    Text = "預組等級"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Progress_Content = {
    Text = "段位獎勵"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Content = {
    Text = "預組模式"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Score_Content = {Text = "積分"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Record_Content = {
    Text = "對弈紀錄"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Reward_Content = {
    Text = "到達更高段位獲得更多獎勵"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Robot_Content = {
    Text = "模擬對手"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Content = {
    Text = "輪選模式"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Score_Content = {Text = "積分"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Rule_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Time_Content = {
    Text = "當前賽季剩餘"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Title_Content = {
    Text = "相位對弈"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Victory_Content = {
    Text = "勝場累計："
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Weekly_Content = {
    Text = "每週獎勵"
  },
  PanelText_UI_Pvp_Panel_Main_Text_C_Name_Content = {Text = "結束"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Unclickable_Content = {Text = "結束"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Zongshanghai_Content = {Text = "總傷害"},
  PanelText_UI_Pvp_Panel_Match_Text_Name_Content = {
    Text = "開始匹配"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "結算獲得"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Integral_Content = {
    Text = "賽季積分"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Sync_Content = {
    Text = "喚醒體同調率提升"
  },
  PanelText_UI_Pvp_Panel_Playback_Text_C_Angle_Content = {
    Text = "切換視角"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_1_Content = {Text = "關注"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_2_Content = {Text = "關注"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_1_Content = {Text = "稱讚"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_2_Content = {Text = "已稱讚"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Enemy_Content = {Text = "敵方"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Fail_Content = {Text = "失敗"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Harm_Content = {Text = "傷害"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Outcome_Content = {Text = "勝利"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_OwnRespectable_Content = {
    Text = "可敬的對手！"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Respectable_Content = {
    Text = "可敬的對手！"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Shields_Content = {Text = "護盾"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Treat_Content = {Text = "治療"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Victory_Content = {Text = "勝利"},
  PanelText_UI_Pvp_Panel_Train_Text_C_KeeperSkills_Content = {
    Text = "添加鑰令"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_SelectRelic_Content = {
    Text = "選擇造物"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Weapons_Content = {
    Text = "添加命輪"
  },
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Breaking_Content = {
    Text = "與伺服器鏈接已斷開"
  },
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Quit_Content = {
    Text = "回到登錄介面"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Decks_Content = {Text = "牌組"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Maniac_Content = {Text = "狂氣"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Role_Wins_Content = {Text = "勝場"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Wins_Content = {Text = "勝場"},
  PanelText_UI_Pvp_Popup_Dan_Text_C_Bonus_Content = {
    Text = "賽季加成"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Continue_Content = {
    Text = "點擊繼續"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Streak_Content = {
    Text = "連勝加成"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Title_Content = {Text = "啟靈"},
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Use_Content = {
    Text = "當前使用中"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Tips_Text_C_Title_Content = {Text = "啟靈"},
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Use_Content = {
    Text = "對戰表情"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Close_Content = {
    Text = "點擊空白處繼續"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Continue_Content = {
    Text = "點擊繼續"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Fail_Content = {Text = "失敗"},
  PanelText_UI_Pvp_Popup_Fail_Text_C_Victory_Content = {
    Text = "戰鬥失敗"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_Reward_1_Content = {
    Text = "戰鬥風格獎勵"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Create_Content = {
    Text = "創建對戰"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Joinin_Content = {
    Text = "加入對戰"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_Title_Content = {
    Text = "密碼對戰"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Title_Content = {
    Text = "導入編隊"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Placeholder_Content = {
    Text = "輸入 6 位 <color=#5EF2FF>相位值</color>"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Pvp_Popup_PasswordCode_Text_Title_Content = {
    Text = "輸入相位值"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Copy_Content = {
    Text = "複製相位值"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_Title_Content = {
    Text = "密碼對戰"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Done_Content = {
    Text = "已關注我"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Mutual_Content = {
    Text = "互相關注"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Ready_Content = {Text = "準備"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Reject_Content = {Text = "拒絕"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Wait_Content = {
    Text = "等待對方準備…"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_C_Copy_Content = {Text = "複製"},
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Name_Content = {
    Text = "觀看回放"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Title_Content = {
    Text = "選擇視角"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Prompt_Content = {
    Text = "點擊替換不想要的手牌"
  },
  PanelText_UI_Pvp_Popup_Reward_Tips_Text_C_Title_Content = {
    Text = "段位獎勵"
  },
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Title_Content = {
    Text = "選擇1個造物"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Close_Content = {
    Text = "點擊空白處繼續"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Succeed_Content = {
    Text = "戰鬥勝利"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Highest_Content = {
    Text = "歷史最高對弈積分："
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Title_Content = {
    Text = "對弈紀錄"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity1_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity2_Content = {
    Text = "賽季排行"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity3_Content = {
    Text = "賽季排行"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity4_Content = {
    Text = "排行獎勵"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Award_Content = {Text = "獎勵"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Big_Content = {
    Text = "守密人資訊"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game1_Content = {
    Text = "本週排行"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game2_Content = {
    Text = "本週排行"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Hint_Content = {
    Text = "本賽季獲勝一場即可在賽季結束時獲得結算獎勵。"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_NoTask_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_RankTip_Content = {
    Text = "本賽季參與一場即可進入「賽季排行」。"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_Pvp_Content = {
    Text = "預組模式"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_RotationMode_Content = {
    Text = "輪選模式"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Reward_Content = {
    Text = "賽季最高積分"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Scope_Content = {
    Text = "排名範圍"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Small_Content = {
    Text = "對弈頭銜"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Title_2_Content = {
    Text = "對弈頭銜"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Fail_Content = {Text = "失敗"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Red_Content = {
    Text = "點擊繼續"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Victory_Content = {Text = "勝利"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Yellow_Content = {
    Text = "點擊繼續"
  },
  PanelText_UI_Pvp_Popup_list_Tips_Text_C_Uid_Title_Content = {Text = "UID ："},
  PanelText_UI_Pvp_Team_Main_Text_C_Name_10_Content = {
    Text = "裝備命輪"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_1_Content = {
    Text = "裝備鑰令"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_2_Content = {
    Text = "4號位喚醒體"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_3_Content = {
    Text = "3號位喚醒體"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_4_Content = {
    Text = "2號位喚醒體"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_5_Content = {
    Text = "1號位喚醒體"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_6_Content = {
    Text = "裝備鑰令"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_7_Content = {
    Text = "裝備命輪"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_8_Content = {
    Text = "裝備命輪"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_9_Content = {
    Text = "裝備命輪"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_Content = {
    Text = "快速編隊"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Realms_Content = {
    Text = "未啟動界域"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Title_Content = {
    Text = "預組編隊"
  },
  PanelText_UI_Pvp_Team_Main_Text_Name_Content = {
    Text = "快速編隊"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Copy_Content = {Text = "複製"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Done_Content = {
    Text = "已關注我"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Mutual_Content = {
    Text = "互相關注"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Proficiency_Content = {
    Text = "累計勝場"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Remove_Content = {Text = "編輯"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Save_Content = {Text = "刪除"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Title_Content = {
    Text = "評論詳情"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Additional_Content = {
    Text = "額外贈送"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Haved_Content = {Text = "已擁有"},
  PanelText_UI_Recharge_Exchange_Text_C_Buy_Title_Content = {
    Text = "兌換銀芯數量"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Redeemed_Content = {
    Text = "累計已兌換："
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Not_Content = {
    Text = "貨幣不足"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Title_Content = {
    Text = "確定兌換"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_illustrate_Content = {
    Text = "玩法規則"
  },
  PanelText_UI_Recharge_Instructions_Text_C_Title_Content = {
    Text = "學期課題"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Cost_Tips_Content = {
    Text = "總計消耗"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Tips_Content = {
    Text = "可以選擇移除無需購買的物品"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Title_Content = {
    Text = "購買確認"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Buttom_Content = {
    Text = "每檔首充額外贈送等額「源液」，僅限一次"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law2_Content = {
    Text = "資金結算法"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Refresh_Content = {
    Text = "聯繫客服"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_PayTip_Content = {
    Text = "當前展示價格為默認貨幣價格，僅供參考。支付時請以實際貨幣和價格為准。"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Desc_Content = {
    Text = "活動描述"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Slogan_Content = {
    Text = "僅限24小時！\n常駐喚醒體選擇其一！"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_SpecialTime_Content = {Text = "剩餘"},
  PanelText_UI_Recharge_Panel_GiftBag_Text_PayTip_Content = {
    Text = "當前展示價格為默認貨幣價格，僅供參考。支付時請以實際貨幣和價格為准。"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Bigitle_Content = {
    Text = "月相觀測"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Buttom_Tips_Content = {
    Text = "每檔首儲翻倍，僅限一次"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Expired_Content = {Text = "已過期"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get1_Title_Content = {
    Text = "立即獲得"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get2_Title_Content = {
    Text = "每日贈送"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Illustrate_Content = {
    Text = "可累計購買"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_OnekeyPurchase_Content = {
    Text = "一鍵購買"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Refresh_Content = {
    Text = "聯繫客服"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Tips_Content = {
    Text = "*累計可獲得300銀芯結晶+3000銀芯"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Today_Content = {
    Text = "今天已領取"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigitle_Content = {
    Text = "月相觀測"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigtitle_Content = {
    Text = "月相觀測"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buttom_Tips_Content = {
    Text = "每檔首充額外贈送等量「源液」、僅限一次"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buy_Content = {Text = "購買"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Double_Content = {Text = "額外"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Expired_Content = {Text = "已過期"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Extra_Content = {Text = "額外"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_Title_Content = {
    Text = "立即獲得"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_NumName_Content = {Text = "銀芯"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title_Content = {
    Text = "每日贈送"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Illustrate_Content = {
    Text = "可累計購買"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_OnekeyPurchase_Content = {
    Text = "一鍵購買"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Refresh_Content = {
    Text = "聯繫客服"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip1_Content = {
    Text = "每日登錄累計可得\n「銀芯」<color=#57F8FE><size=38>×6000</size></color>"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip2_Content = {
    Text = "每日登錄累計可得\n「靈啡肽」<color=#57F8FE><size=38>×6000</size></color> 和「追憶羽筆」<color=#57F8FE><size=38>×600</size></color>"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Get1_Title_Content = {
    Text = "立即獲得"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Illustrate_Content = {
    Text = "玩法規則"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Tips_Content = {
    Text = "每日隨郵件贈送（30天）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Title_Content = {
    Text = "鞘內補給"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Tips_Content = {
    Text = "*累積可獲得「銀芯」× 300 +「銀芯」× 6000"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Title_Content = {
    Text = "彌薩格商店"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Today_Content = {
    Text = "今天已領取"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Month_Content = {
    Text = "月相觀測"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Recharge_Content = {Text = "儲值"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Month_Content = {
    Text = "月相觀測"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Recharge_Content = {Text = "儲值"},
  PanelText_UI_Recharge_Panel_Main_Text_Name_Content = {Text = "購買"},
  PanelText_UI_Recharge_Panel_Main_Text_Tips_Content = {
    Text = "*累積可獲得「銀芯」× 300 +「銀芯」× 6000"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_Content = {
    Text = "月相觀測"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_Content = {Text = "儲值"},
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Month_Content = {
    Text = "月相觀測"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Recharge_Content = {Text = "儲值"},
  PanelText_UI_Recharge_Panel_Month_Tips_Text_C_Today_Content = {
    Text = "點擊領取月相觀測獎勵"
  },
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Disable_Content = {Text = "購買"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Normal_Content = {Text = "購買"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Title_Content = {
    Text = "彌薩格商店"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Confirm_Content = {Text = "購買"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_Content = {
    Text = "確認購買"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_En_Content = {Text = "Title"},
  PanelText_UI_Recharge_Reset_Item_Text_C_Double_Content = {Text = "首儲"},
  PanelText_UI_Recharge_Reset_Item_Text_C_Extra_Content = {Text = "額外"},
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_Activate_Content = {Text = "已啟動"},
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_NoeGet_Content = {
    Text = "未獲得該喚醒體"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_Name_Content = {
    Text = "啟動天賦"
  },
  PanelText_UI_Research_Panel_Ceri_Text_C_Activate_Content = {Text = "已啟動"},
  PanelText_UI_Research_Panel_Ceri_Text_C_Title_Content = {
    Text = "天賦總覽"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_PlanName_Content = {
    Text = "當前進展"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_ReachName_Content = {
    Text = "全部成就達成"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Count_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Extra_Content = {
    Text = "【額外】"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_NoTask_Content = {
    Text = "暫時沒有新的派遣任務"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special2_Content = {
    Text = "派遣總等級每超出20級，可獲得1份額外獎勵"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special_Content = {
    Text = "達成條件"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Tip_Content = {Text = "待領取"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Unclickable_Content = {Text = "未解鎖"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Underway_Content = {Text = "進行中"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Content = {Text = "剩餘"},
  PanelText_UI_Research_Popup_Dispatch_Text_Title_Content = {
    Text = "派遣加成總覽"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Dispatch_Content = {
    Text = "派遣喚醒體"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Reward_Content = {
    Text = "任務獎勵"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Title_Content = {
    Text = "派遣報告"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Close_Content = {Text = "關閉"},
  PanelText_UI_Research_Popup_Recall_Text_C_Award_Content = {
    Text = "任務獎勵"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Dispatch_Content = {
    Text = "當前總等級"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Extra_Content = {Text = "[額外]"},
  PanelText_UI_Research_Popup_Recall_Text_C_Level_Content = {
    Text = "已派遣總等級"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special2_Content = {
    Text = "派遣總等級每超出20級，可獲得1份額外獎勵"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special_Content = {
    Text = "達成條件"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Title_Content = {
    Text = "選擇喚醒體派遣"
  },
  PanelText_UI_Research_Popup_Report_Text_C_Title_Content = {
    Text = "調查報告"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_C_Tip_Content = {
    Text = "後續可在「設置-語言」中重新選擇"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_Name_Content = {Text = "確定"},
  PanelText_UI_Setting_Popup_ChooseLang_Text_Title_Content = {
    Text = "選擇語言"
  },
  PanelText_UI_Setting_Popup_Code_Text_C_Paste_Content = {Text = "粘貼"},
  PanelText_UI_Setting_Popup_Code_Text_C_Tips_Content = {
    Text = "輸入兌換碼"
  },
  PanelText_UI_Setting_Popup_Down_Text_C_Downing_Content = {
    Text = "資源下載中…"
  },
  PanelText_UI_Setting_Popup_Examine_Text_C_Examine_Content = {
    Text = "正在檢查遊戲資源的完整性"
  },
  PanelText_UI_Setting_Popup_Main_Text_C_Tips_Content = {Text = "內部GM"},
  PanelText_UI_Setting_Popup_Main_Text_C_Title_Content = {Text = "設置"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_1_Content = {Text = "領取"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_2_Content = {Text = "領取"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Title_Content = {
    Text = "登入獎勵"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_1_Content = {Text = "未達成"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_2_Content = {Text = "未達成"},
  PanelText_UI_Shop_Item_Commodity_Text_C_Head_Content = {Text = "頭像"},
  PanelText_UI_Shop_Item_Toggle_Text_C_Recommend_Content = {Text = "推薦"},
  PanelText_UI_Shop_Popup_Tips_Text_C_Tips_Content = {
    Text = "貨幣不足"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Assist_Content = {
    Text = "助戰次數"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Awaker_Content = {
    Text = "連結喚醒體"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Concern2_Content = {Text = "關注"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Conclude_Content = {
    Text = "達成成就"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Difficulty_Content = {
    Text = "調查行動"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Dream_Content = {
    Text = "幻夢深潛"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Fans_Content = {Text = "追隨者"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Highest_Content = {
    Text = "最高紀錄"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Indestructible_Content = {
    Text = "無光之境·輪轉間隙"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Pagoda_Content = {
    Text = "無光之境"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Privacy_Content = {
    Text = "守密人已設置調查狀況為隱私"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Register_Content = {
    Text = "登錄天數"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Society_Content = {
    Text = "所屬公會"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Survey_Content = {
    Text = "調查狀況"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Placeholder_Content = {
    Text = "請輸入個人簡介"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Abyss_Content = {
    Text = "融災禁區"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Assist_Content = {
    Text = "助戰次數"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Attention_Content = {Text = "關注"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Awaker_Content = {
    Text = "連結喚醒體"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Collection_Content = {
    Text = "典藏進度"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Concern2_Content = {Text = "關注"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Conclude_Content = {
    Text = "達成成就"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Difficulty_Content = {
    Text = "調查行動"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Dream_Content = {
    Text = "幻夢深潛"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Fans_Content = {Text = "追隨者"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Gender_Content = {Text = "性別"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Hard_Content = {Text = "困難"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Highest_Content = {
    Text = "最高紀錄"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Indestructible_Content = {
    Text = "無光之境·輪轉間隙"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Interrelated_Content = {
    Text = "互相關注"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Notset_Content = {Text = "未設置"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Pagoda_Content = {
    Text = "無光之境"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Privacy_Content = {
    Text = "守密人已設置調查狀況為隱私"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Register_Content = {
    Text = "登錄天數"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Society_Content = {
    Text = "所屬公會"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Survey_Content = {
    Text = "調查狀況"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_1_Content = {Text = "總計"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_2_Content = {
    Text = "最高記錄"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_NickNamePre_Content = {Text = "備註 ："},
  PanelText_UI_Social_Item_Data_Right_Text_C_Help_Content = {
    Text = "助戰喚醒體"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Not_Content = {
    Text = "未設置助戰喚醒體"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Null_1_Content = {
    Text = "未展示喚醒體"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Team_Content = {
    Text = "喚醒體展示"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Done_Content = {
    Text = "已關注我"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Mutual_Content = {
    Text = "互相關注"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse2_Content = {Text = "已拒絕"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse_Content = {Text = "拒絕"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Timeout_Content = {Text = "已超時"},
  PanelText_UI_Social_Item_PveRecord_Text_Fail_Content = {Text = "失敗"},
  PanelText_UI_Social_Item_PveRecord_Text_Victory_Content = {Text = "勝利"},
  PanelText_UI_Social_Item_PvpData_Text_Fail_Content = {Text = "失敗"},
  PanelText_UI_Social_Item_PvpData_Text_Victory_Content = {Text = "勝利"},
  PanelText_UI_Social_Item_PvpRecord_Text_Fail_Content = {Text = "失敗"},
  PanelText_UI_Social_Item_PvpRecord_Text_Victory_Content = {Text = "勝利"},
  PanelText_UI_Social_Item_Pvp_Text_C_Dispaly_Content = {
    Text = "開放戰鬥紀錄"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Input_Content = {
    Text = "輸入「戰鬥記錄」可查看回放"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_NoTask_Content = {
    Text = "暫無相位對弈記錄"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Nor_Content = {
    Text = "調查行動"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Sel_Content = {
    Text = "調查行動"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Nor_Content = {
    Text = "相位對弈"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Sel_Content = {
    Text = "相位對弈"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Search_Content = {
    Text = "觀看回放"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Attention_Content = {Text = "關注"},
  PanelText_UI_Social_Item_Rank_Text_C_Following_Content = {Text = "已關注"},
  PanelText_UI_Social_Item_Rank_Text_C_Interrelated_Content = {Text = "已互關"},
  PanelText_UI_Social_Item_Rank_Text_C_Uid_Content = {Text = "UID："},
  PanelText_UI_Social_Panel_Data_Text_C_Assist_Content = {
    Text = "助戰次數"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Awaker_Content = {
    Text = "連結喚醒體"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Concern2_Content = {Text = "關注"},
  PanelText_UI_Social_Panel_Data_Text_C_Conclude_Content = {
    Text = "達成成就"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Difficulty_Content = {Text = "困難"},
  PanelText_UI_Social_Panel_Data_Text_C_Dream_Content = {
    Text = "幻夢深潛"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Fans_Content = {Text = "追隨者"},
  PanelText_UI_Social_Panel_Data_Text_C_Help_Content = {
    Text = "助戰喚醒體"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Indestructible_Content = {
    Text = "不可名狀"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Not_Content = {
    Text = "未設置助戰喚醒體"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Null_1_Content = {
    Text = "未展示喚醒體"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Pagoda_Content = {
    Text = "無光之塔"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Privacy_Content = {
    Text = "守密人已設置調查狀況為隱私"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Register_Content = {
    Text = "登錄天數"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Society_Content = {
    Text = "所屬公會"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Survey_Content = {
    Text = "調查狀況"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Team_Content = {
    Text = "喚醒體展示"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Title_Content = {
    Text = "守密人檔案"
  },
  PanelText_UI_Social_Panel_HelpList_Filter_Text_C_Selected_Content = {Text = "已選"},
  ["PanelText_UI_Social_Panel_HelpList_Item_Text_C_ Interrelated_Content"] = {
    Text = "互相關注"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Attention_Content = {Text = "關注"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Commonly_Content = {
    Text = "常用助戰"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Conflict_Content = {
    Text = "界域衝突"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Fans_Content = {Text = "追隨者"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Following_Content = {Text = "已關注"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recent_Content = {
    Text = "最近助戰"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recommend_Content = {
    Text = "推薦關注"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_CommonlyAssist_Content = {
    Text = "常用助戰"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_Content = {Text = "上場"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_Content = {Text = "上場"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Mail_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_NoTask_Content = {
    Text = "暫無契合的助戰喚醒體，建議調整「篩選喚醒體」"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Time_Content = {
    Text = "可使用與你互相關注守密人的助戰喚醒體出戰"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Title_Content = {
    Text = "選擇助戰"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Attention_Content = {Text = "關注"},
  PanelText_UI_Social_Panel_Main_Item_Text_C_Done_Content = {
    Text = "已關注我"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Following_Content = {Text = "已關注"},
  PanelText_UI_Social_Panel_Main_Item_Text_C_Interrelated_Content = {
    Text = "互相關注"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Mutual_Content = {
    Text = "互相關注"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_Unfollow_Content = {
    Text = "取消關注"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_NoTask_Content = {
    Text = "暫無關注任何人"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_NoTask_Content = {
    Text = "暫無相關搜索"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_Name_Content = {
    Text = "全部關注"
  },
  PanelText_UI_Social_Panel_Main_Text_C_NoTask_Content = {
    Text = "暫無關注"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_1_Content = {
    Text = "輸入名稱搜索"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_2_Content = {
    Text = "輸入名稱搜索"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_NoTask_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_PlayerInfo_Content = {Text = "達人"},
  PanelText_UI_Social_Panel_RankList_Text_C_Uid_Title_Content = {Text = "UID ："},
  PanelText_UI_Social_Panel_Rank_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Friend_Content = {Text = "關注"},
  PanelText_UI_Social_Panel_Rank_Text_C_Interaction_Content = {Text = "互動"},
  PanelText_UI_Social_Panel_Rank_Text_C_NoTask_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_PlayerInfo_Content = {
    Text = "守密人資訊"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Sign_Content = {Text = "簡介"},
  PanelText_UI_Social_Panel_Rank_Text_C_Uid_Title_Content = {Text = "UID ："},
  PanelText_UI_Social_Popup_Awaker_Text_C_Owned_Content = {Text = "已擁有"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Title_Content = {
    Text = "編輯生日"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_En_Content = {
    Text = "Fdshsjfgjgf"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_NoTask_Content = {
    Text = "暫無助戰夥伴"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_SearchTip_Content = {
    Text = "輸入UID查找守密人"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Title_Content = {
    Text = "常用助戰"
  },
  PanelText_UI_Social_Popup_FriendlyInvite_Text_Title_Content = {
    Text = "友誼賽邀請"
  },
  PanelText_UI_Social_Popup_Introduction_Text_C_Placeholder_Content = {
    Text = "請輸入個人簡介"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Content = {Text = "選擇"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Desc_Content = {
    Text = "<size=25>相位對弈的基礎模式，雙方使用預先準備的隊伍進行對戰。</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Name_Content = {
    Text = "預組模式"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Content = {Text = "選擇"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Desc_Content = {
    Text = "<size=25>相位對弈的進階模式，雙方輪流在隨機卡池內選取卡牌，組成卡組進行對戰。</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Name_Content = {
    Text = "輪選模式"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_Title_Content = {
    Text = "選擇模式"
  },
  PanelText_UI_Social_Popup_Match_Text_Title_Content = {Text = "友誼賽"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Content = {Text = "頭像框"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Sel_Content = {Text = "頭像框"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Content = {Text = "頭像"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Sel_Content = {Text = "頭像"},
  PanelText_UI_Social_Popup_Situation_Tips_Text_C_AffixInfo_Content = {
    Text = "調查狀況"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Title_Content = {
    Text = "切換性別"
  },
  PanelText_UI_Social_Popup_WatchList_Text_C_NoTask_Content = {
    Text = "暫無新增追隨者"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Name_FollowAll_Content = {
    Text = "全部關注"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Tip_Content = {
    Text = "可查看近期新增的100名追隨者"
  },
  PanelText_UI_Social_Tips_InviteBubble_Text_Name_Content = {Text = "友誼賽"},
  PanelText_UI_Story_Panel_Main_Text_C_High_Content = {
    Text = "重置登入背景"
  },
  PanelText_UI_Story_Panel_Main_Text_C_Normal_Content = {
    Text = "設為登入背景"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Continue_Content = {
    Text = "繼續啟程"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Title_Content = {
    Text = "記憶歸檔"
  },
  PanelText_UI_Story_Portrait_Test_Text_C_Close_Content = {Text = "關閉"},
  PanelText_UI_Story_Portrait_Test_Text_C_Hide_Content = {Text = "隱藏"},
  PanelText_UI_Summon_Btn_Realms_Text_C_Difficulty_Content = {
    Text = "上手難度"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Directional_Content = {
    Text = "當前定向"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Name_Content = {Text = "選 擇"},
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Full_Content = {
    Text = "疊位已滿"
  },
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Have_Content = {Text = "已擁有"},
  PanelText_UI_Summon_Item_Probability_Text_C_Name_Content = {Text = "名稱"},
  PanelText_UI_Summon_Item_Probability_Text_C_Role_Content = {
    Text = "綜合機率"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Time_Content = {Text = "名稱"},
  PanelText_UI_Summon_Item_Probability_Text_C_Type_Content = {Text = "類型"},
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_GiftTitle_Content = {
    Text = "完成任務領取幻衣兌換券"
  },
  PanelText_UI_Summon_Panel_Main_Text_Award_Content = {
    Text = "額外獎勵"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Choose_Content = {
    Text = "開始選擇"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Difficult_Title_Content = {
    Text = "上手難度"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_FreeLimit_Content = {Text = "免費"},
  PanelText_UI_Summon_Panel_Main_Text_C_Hint_Content = {
    Text = "可點擊此處更換界域"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_LimitName_Content = {
    Text = "喚醒五次"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Realms_Content = {
    Text = "選定界域"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_RecAwaker_Content = {
    Text = "推薦的喚醒體"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Summon_Content = {Text = "喚醒5次"},
  PanelText_UI_Summon_Panel_Main_Text_C_System_Name_Content = {Text = "喚醒"},
  PanelText_UI_Summon_Panel_Main_Text_C_TryName_Content = {
    Text = "喚醒體試用"
  },
  PanelText_UI_Summon_Panel_Main_Text_FreeTen_Content = {Text = "免費"},
  PanelText_UI_Summon_Panel_Main_Text_Recommend_Content = {
    Text = "新生推薦喚醒"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Choose_Content = {
    Text = "開始選擇"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Title_Content = {
    Text = "已指定喚醒體"
  },
  PanelText_UI_Summon_Panel_Share_Role1_Text_C_Title_Content = {Text = "UID："},
  PanelText_UI_Summon_Panel_Share_Role2_Text_C_Title_Content = {Text = "UID："},
  PanelText_UI_Summon_Panel_Share_Weapon1_Text_C_Title_Content = {Text = "UID："},
  PanelText_UI_Summon_Panel_Share_Weapon2_Text_C_Title_Content = {Text = "UID："},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Detail_Content = {
    Text = "規則說明"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Inventory_Content = {
    Text = "物品清單"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Name_Content = {Text = "名稱"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Not_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Prompt_Content = {
    Text = "可在本頁面查詢近6個月的喚醒記錄，資料可能有1小時左右延誤。"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_REcording_Content = {
    Text = "歷史記錄"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Role_Content = {
    Text = "喚醒類型"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Time_Content = {
    Text = "喚醒時間"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_1_Content = {
    Text = "喚醒類型"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_Content = {Text = "類型"},
  PanelText_UI_Summon_Popup_Main_Text_C_Name_Content = {Text = "名稱"},
  PanelText_UI_Summon_Popup_Main_Text_C_Not_Content = {
    Text = "暫無記錄"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Prompt_Content = {
    Text = "可在本頁面查詢近6個月的喚醒記錄，資料可能有1小時左右延誤。"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Role_Content = {
    Text = "喚醒類型"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Time_Content = {
    Text = "喚醒時間"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Title_Content = {
    Text = "喚醒歷史記錄"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Type_Content = {Text = "類型"},
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Change_Content = {Text = "重選"},
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_ChooseTitle_Content = {
    Text = "選擇喚醒體"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Choose_Content = {
    Text = "開始選擇"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_InfoTitle_Content = {
    Text = "玩法說明"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_Title_Content = {
    Text = "選擇喚醒體"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Confirm_Content = {
    Text = "完成選擇"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Tip_Content = {
    Text = "長按喚醒體查看詳情"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Confirm_Content = {
    Text = "完成選擇"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Tip_Content = {
    Text = "長按喚醒體查看詳情"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Title_Content = {
    Text = "選擇喚醒體"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Activity_Content = {
    Text = "命輪贈送"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Game_Content = {
    Text = "喚醒體贈送"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Info_Content = {
    Text = "每進行150次【界域研習】喚醒後，可額外獲取以上任意一個喚醒體/命輪"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Plan_Content = {Text = "進度"},
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Check_Content = {
    Text = "查看詳情"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Git_Content = {Text = "領取"},
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Detail_Content = {
    Text = "詳情說明"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Inventory_Content = {
    Text = "物品清單"
  },
  PanelText_UI_Summon_Popup_Realms_Text_C_Introduce_Content = {
    Text = "選擇界域後，喚醒所獲角色必定為該界域的喚醒體，之後可隨時修改。"
  },
  PanelText_UI_Summon_Popup_Recording_Text_C_Prompt_Content = {
    Text = "可在本頁面查詢近6個月的喚醒記錄，資料可能有1小時左右延誤。"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_ChooseTitle_Content = {
    Text = "選擇喚醒體"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_Choose_Content = {
    Text = "開始選擇"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_InfoTitle_Content = {
    Text = "玩法說明"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_Title_Content = {
    Text = "選擇喚醒體"
  },
  PanelText_UI_Summon_Popup_Share_Text_C_Title_Content = {Text = "UID："},
  PanelText_UI_Summon_Popup_Show_Legend_Text_Autofine_Content = {
    Text = "自動疊位"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_C_Name_Content = {
    Text = "喚醒一次"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_Autofine_Content = {
    Text = "自動疊位"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_C_Name_Content = {
    Text = "喚醒一次"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_Autofine_Content = {
    Text = "自動疊位"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_C_Name_Content = {
    Text = "喚醒一次"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_C_Title_Content = {Text = "ID："},
  PanelText_UI_Summon_Popup_Total_Show_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Summon_Popup_Total_Show_Text_Name_Content = {
    Text = "重新喚醒"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_ReSummon_Content = {Text = "喚醒5次"},
  PanelText_UI_Summon_Popup_Total_Show_Text_Toggle_Content = {
    Text = "快速喚醒"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Name_Content = {
    Text = "喚醒一次"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Title_Content = {Text = "ID："},
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Auto_Content = {
    Text = "自動獲取推薦命輪"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_ChooseTitle_Content = {
    Text = "選擇喚醒體"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Choose_Content = {
    Text = "選擇喚醒體"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Confirm_Content = {
    Text = "確認選擇"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_InfoTitle_Content = {
    Text = "玩法說明"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_Title_Content = {
    Text = "選擇喚醒體"
  },
  PanelText_UI_Task_Item_Detail_List_New_Text_C_Get_Content = {Text = "領取"},
  PanelText_UI_Task_Panel_Main_New_Text_C_ActionReports_Content = {
    Text = "行動報告"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_GrowUp_Content = {
    Text = "成長記錄"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips_Content = {
    Text = "每日任務已完成"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Title_Content = {
    Text = "暫時沒有任務"
  },
  PanelText_UI_Task_Popup_Career_Item_Text_Name_Content = {Text = "領取"},
  PanelText_UI_Task_Popup_Career_New_Text_C_1_Content = {
    Text = "當前進度"
  },
  PanelText_UI_Task_Popup_Career_New_Text_C_Chapter_Award_Content = {
    Text = "完成獎勵"
  },
  PanelText_UI_Task_Popup_Career_Text_C_1_Content = {
    Text = "當前進度"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Award_Content = {
    Text = "完成獎勵"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Get_Content = {
    Text = "獎勵已領取"
  },
  PanelText_UI_Task_Popup_Career_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_Name_2_Content = {
    Text = "全部領取"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_ReachName_Content = {
    Text = "「全部」成就達成"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Info1_Content = {
    Text = "提升調查等級可獲得獎勵"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Level1_Content = {Text = "等級"},
  PanelText_UI_Task_Popup_Challenge_Item1_Text_Name_Content = {Text = "領取"},
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Info_Content = {
    Text = "提升調查等級可獲得獎勵"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Level_Content = {Text = "等級"},
  PanelText_UI_Task_Popup_Challenge_Item_Text_Name_Content = {Text = "領取"},
  PanelText_UI_Task_Popup_Challenge_New_Text_C_2_Content = {
    Text = "錄入時間"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_3_Content = {
    Text = "調查等級"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_Title_Content = {
    Text = "解鎖成就"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_2_Content = {
    Text = "錄入時間"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_3_Content = {
    Text = "調查等級"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_OneKey_Content = {
    Text = "一鍵領取"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Reach_Content = {
    Text = "願銀鑰指引我們"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Title_Content = {
    Text = "學員證書"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Special_Content = {
    Text = "派遣條件"
  },
  PanelText_UI_Team_Item_Awaker_List_Text_C_Help_Content = {
    Text = "助戰喚醒體"
  },
  PanelText_UI_Team_Item_MyTeam_List_Text_C_Current_Content = {
    Text = "當前出戰"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Guide_Content = {Text = "推薦"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Hint_Content = {
    Text = "*同個喚醒體只能裝備一個SSR命輪"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Recommend_Content = {Text = "推薦"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Remove_Content = {
    Text = "一鍵卸下"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Uninstall_Content = {
    Text = "一鍵卸下"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Foundation_Content = {Text = "屬性"},
  PanelText_UI_Team_Item_Secret_Props_Text_C_Lv_Content = {
    Text = "等級完成度"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Refining_Content = {
    Text = "轉錄完成度"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Null_Content = {
    Text = "暫無生效的套裝效果"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Title_Content = {
    Text = "套裝效果"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_3_Content = {Text = "強化"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_4_Content = {Text = "裝備"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Null_Content = {
    Text = "當前部位無可用密契"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Quantity_Content = {
    Text = "方案數量"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Suit_Content = {
    Text = "當前無可使用方案"
  },
  PanelText_UI_Team_Item_Suit_Text_C_Current_Content = {
    Text = "當前使用"
  },
  PanelText_UI_Team_Item_Talent_Text_C_Activate_Content = {Text = "已啟動"},
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Foundation_Content = {Text = "屬性"},
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Lv_Content = {
    Text = "等級完成度"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Refining_Content = {
    Text = "轉錄完成度"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Null_Content = {
    Text = "暫無生效的套裝效果"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Title_Content = {
    Text = "套裝效果"
  },
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Empty_Content = {
    Text = "左側選擇命輪裝備"
  },
  PanelText_UI_Team_Panel_Awaker_Main_Text_C_Zhanli_Content = {Text = "戰力"},
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Recommend_Content = {Text = "推薦"},
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Remove_Content = {
    Text = "一鍵卸下"
  },
  PanelText_UI_Team_Panel_Main_Popup_Team_Text_C_AffixInfo_Content = {
    Text = "隊伍資訊"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Activated_Content = {Text = "已啟動"},
  PanelText_UI_Team_Panel_Main_Text_C_Boundaries_Tips_Content = {
    Text = "界域推薦"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Cost_Tips_Content = {
    Text = "隊伍要求："
  },
  PanelText_UI_Team_Panel_Main_Text_C_Empty_Content = {
    Text = "未裝備鑰令"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Frequency_Content = {Text = "次數"},
  PanelText_UI_Team_Panel_Main_Text_C_Hint_Content = {
    Text = "*通關後，本次出戰的喚醒體、命輪和鑰令將無法在其他融災禁區中上場。"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Lives_Desc_Content = {
    Text = "應急靈知體剩餘次數："
  },
  PanelText_UI_Team_Panel_Main_Text_C_Name_2_Content = {Text = "助戰"},
  PanelText_UI_Team_Panel_Main_Text_C_NoActivate_Content = {Text = "未啟動"},
  PanelText_UI_Team_Panel_Main_Text_C_Prohibit_Content = {
    Text = "本關禁用鑰令"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Skill_Content = {Text = "鑰令"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips2_Content = {
    Text = "隊伍資訊"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_1_Content = {Text = "助戰"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips_2_Content = {Text = "助戰"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips_Content = {
    Text = "解除助戰"
  },
  PanelText_UI_Team_Panel_Main_Text_Madness_Content = {
    Text = "癲狂難度僅可獲得首通獎勵"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Delete_Content = {
    Text = "刪除方案"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Edit_Content = {
    Text = "編輯方案"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Recommend_Content = {
    Text = "推薦裝備"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Remove_Content = {
    Text = "一鍵卸下"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Save_Content = {
    Text = "保存為方案"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Guide_Content = {Text = "推薦"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Hint_Content = {
    Text = "*同個喚醒體只能裝備一個SSR命輪"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_3_Content = {Text = "疊位"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Null_Content = {
    Text = "當前暫無命輪"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Title_Content = {
    Text = "選擇命輪"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Uninstall_Content = {
    Text = "一鍵卸下"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Attribute_Content = {Text = "屬性"},
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Name_Content = {
    Text = "喚醒體詳情"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "選擇喚醒體"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Xx_Content = {
    Text = "詳細資訊"
  },
  PanelText_UI_Team_Popup_MyTeam_Awaker_List_Text_C_Name_Content = {Text = "選擇"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name04_Content = {Text = "超維"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "職業天賦"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_C_Task_Content = {
    Text = "首次完成事件後自動獲得"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_Title_Content = {
    Text = "首通獎勵"
  },
  PanelText_UI_Vx_Battle_Chaowei_Butter_Text_C_ExtraTurn_Content = {
    Text = "額外回合"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Normal_Content = {
    Text = "疊位排序"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Select_Content = {
    Text = "疊位排序"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Normal_Content = {Text = "順序"},
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Select_Content = {Text = "順序"},
  PanelText_UI_Weapon_Item_Select_List_Text_No_Weapon2_Content = {
    Text = "無可裝備命輪"
  },
  PanelText__Text_C_Dress_Content = {Text = "換裝"},
  PanelText__Text_C_Dressing_Content = {Text = "著裝中"},
  PanelText__Text_C_Goto_Content = {
    Text = "前往購買"
  },
  PanelText__Text_C_Have_Content = {Text = "已擁有"},
  PanelText__Text_C_Reveal_Content = {Text = "隱藏"}
})
return Text_PanelText
