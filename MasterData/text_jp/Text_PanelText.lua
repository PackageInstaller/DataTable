__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_PanelText = readonly({
  PanelText_Battle_UltiSkill_Painting_EX_Text_C_UltiSkill_Content = {
    Text = "極限解放"
  },
  PanelText_Btn_Block_Window_Text_C_Display_Content = {
    Text = "カードを表示"
  },
  PanelText_Btn_Block_Window_Text_C_Hide_Content = {
    Text = "カードを隠す"
  },
  PanelText_Btn_Get_Text_Name_Content = {
    Text = "受け取る"
  },
  PanelText_Com_RedDot_Text_C_GroupNew_Content = {Text = "New"},
  PanelText_Com_RedDot_Text_C_New_Content = {Text = "New"},
  PanelText_Com_Text_New_Text_C_New_Content = {Text = "New"},
  ["PanelText_GmPanel_Text_C_Battle_Test (1)_Content"] = {Text = "戦闘2.0"},
  PanelText_GmPanel_Text_C_Battle_Test2_Content = {Text = "PvP戦闘"},
  PanelText_GmPanel_Text_C_Battle_Test_Content = {
    Text = "PvPマッチング"
  },
  PanelText_GmPanel_Text_C_Gb_Content = {Text = "閉じる"},
  PanelText_GmPanel_Text_C_Hm_Content = {
    Text = "画面効果の高/低設定を切り替え"
  },
  PanelText_GmPanel_Text_C_Placeholder_Content = {
    Text = "検索を入力"
  },
  PanelText_GmPanel_Text_C_Xy_Content = {
    Text = "テストプロトコル"
  },
  PanelText_GmPanel_Text_C_Yc_Content = {
    Text = "GMパネルを隠す"
  },
  PanelText_GmParamEquipPanel_Text_C_Fs_Content = {Text = "送信"},
  PanelText_GmParamEquipPanel_Text_C_Tc_Content = {Text = "退出"},
  PanelText_GmParamPanel_Text_C_Fs_Content = {Text = "送信"},
  PanelText_GmParamPanel_Text_C_Param_Content = {Text = "設定"},
  PanelText_GmParamPanel_Text_C_Tc_Content = {Text = "退出"},
  PanelText_Icon_Common_Text_C_New_Content = {Text = "New"},
  PanelText_Icon_Common_Text_C_NoEquip_Content = {
    Text = "装備不可"
  },
  PanelText_Item_Battle_AwakerSkill_1_Text_C_CD_Content = {
    Text = "クールダウン中"
  },
  PanelText_Item_Battle_AwakerSkill_1_Text_C_Ready_Content = {
    Text = "狂気解放"
  },
  PanelText_Panel_Battle_Monster_Information_Text_C_Monster_Content = {
    Text = "敵の行動予測"
  },
  PanelText_Panel_Battle_Monster_Information_Text_C_Story_Content = {
    Text = "敵の物語"
  },
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Canel_Content = {
    Text = "キャンセル"
  },
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Confirm_Content = {Text = "確認"},
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Canel_Content = {
    Text = "キャンセル"
  },
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Enter_Content = {Text = "挑戦"},
  PanelText_Panel_Gm_PVP_Text_C_Canel_Content = {
    Text = "キャンセル"
  },
  PanelText_Panel_Gm_PVP_Text_C_Confirm_Content = {Text = "確認"},
  PanelText_Popup_Gm_Effect_Side_Text_Content = {
    Text = "編集効果"
  },
  PanelText_Popup_Gm_Effect_Text_Cancel_Content = {Text = "閉じる"},
  PanelText_Popup_Gm_Effect_Text_Confirm_Content = {Text = "確認"},
  PanelText_RedPoint_New_Text_C_New_Content = {Text = "New"},
  PanelText_Simple_List_Panel_Text_Content = {Text = "閉じる"},
  PanelText_Text_C_Activate_Text_C_Activate_Content = {Text = "触媒"},
  PanelText_UI_Address_Panel_Main_Text_C_NoTask1_Content = {
    Text = "連絡人を選択"
  },
  PanelText_UI_Address_Panel_Main_Text_C_Title_Content = {Text = "通信機"},
  PanelText_UI_Address_Panel_Main_Text_Time_Content = {
    Text = "リストを選択して選択"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_C_NoTask_Content = {
    Text = "新しいメッセージなし"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Title_Content = {Text = "通信機"},
  PanelText_UI_Alchemy_Panel_Main_Text_C_Achievement_Content = {
    Text = "密約分解"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Permute_Content = {
    Text = "材料変換"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Recast_Content = {
    Text = "密約再版"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveItem_Content = {
    Text = "素材分解"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveWeapon_Content = {
    Text = "運命の札分解"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_Title_Content = {Text = "精錬室"},
  PanelText_UI_Alchemy_Popup_Break_Down_Placeholder_Content = {
    Text = "答えを入力"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Name_Content = {Text = "変換"},
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Possess_Tips_Content = {
    Text = "変換結果"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Tips_Content = {
    Text = "現在分解できるアイテムはありません"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Title_Content = {
    Text = "変換に必要な素材"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Whole_Content = {Text = "全選択"},
  PanelText_UI_Alchemy_Popup_Recast_Text_C_Name_Content = {Text = "転写"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_All_Content = {Text = "全選択"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Cap_Content = {
    Text = "現在のレベル上限に強化済み"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Mail_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_MaterialsNull_Content = {
    Text = "関連する密約はまだない"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "強化上限に達した"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Null_Content = {
    Text = "分解するアイテムを選択してください"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Resolve_Content = {
    Text = "分解で獲得"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Sel_Content = {
    Text = "選択済み"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Screen_Content = {
    Text = "フィルタ"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Confirm_Content = {Text = "確認"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Reset_Content = {
    Text = "リセット"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle1_Content = {Text = "セット"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle3_Content = {
    Text = "メイン能力"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle4_Content = {
    Text = "サブ能力"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_SiftTitle_Text_C_Tips_Content = {Text = "選択"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_All_Content = {Text = "全選択"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Cap_Content = {
    Text = "現在のレベル上限に強化済み"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_MaterialsNull_Content = {
    Text = "関連する密約はまだない"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_NormotopiaCap_Content = {
    Text = "強化が上限に達した"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Null_Content = {
    Text = "分解するアイテムを選択してください"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Resolve_Content = {
    Text = "分解で獲得"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Sel_Content = {
    Text = "選択済み"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_All_Content = {Text = "全選択"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Cap_Content = {
    Text = "現在のレベル上限に強化済み"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Mail_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "強化上限に達した"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Null_Content = {
    Text = "分解するアイテムを選択してください"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Resolve_Content = {
    Text = "分解で獲得"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Sel_Content = {
    Text = "選択済み"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_WeaponNull_Content = {
    Text = "関連する運命の札はまだない"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_All_Content = {Text = "全選択"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Cap_Content = {
    Text = "現在のレベル上限に強化済み"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_NormotopiaCap_Content = {
    Text = "強化が上限に達した"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Null_Content = {
    Text = "分解するアイテムを選択してください"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Resolve_Content = {
    Text = "分解で獲得"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Sel_Content = {
    Text = "選択済み"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_WeaponNull_Content = {
    Text = "関連する運命の札はまだない"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Whole_Content = {Text = "全選択"},
  PanelText_UI_Alchemy_Popup_Resolve_Text_Need_Content = {Text = "必要"},
  PanelText_UI_Alchemy_Popup_Resolve_Text_None_Tips_Content = {
    Text = "左側から分解する素材を選んでください"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Possess_Tips_Content = {
    Text = "分解結果"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Slider_Tips_Content = {
    Text = "分解回数"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Tips_Content = {
    Text = "分解できる素材はまだ持っていない"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Title_Content = {
    Text = "分解で材料を獲得"
  },
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Not_Content = {Text = "無"},
  PanelText_UI_Announcement_Item_Title_Text_New_Info_Content = {Text = "New"},
  PanelText_UI_Awaker_Button_Addition_Text_C_Tips_Content = {
    Text = "ボーナス"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Attribute_Content = {Text = "能力"},
  PanelText_UI_Awaker_Item_Info_Text_C_Configuration_Content = {
    Text = "チーム編成"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Grade_Content = {Text = "レベル"},
  PanelText_UI_Awaker_Item_Info_Text_C_High_Content = {
    Text = "現在表示"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Content = {Text = "同調率"},
  PanelText_UI_Awaker_Item_Info_Text_C_No_Content = {Text = "未取得"},
  PanelText_UI_Awaker_Item_Info_Text_C_Normal_Content = {
    Text = "Lv.60表示"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Potential_Content = {
    Text = "霊知深化"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Score_Force_Content = {Text = "戦力"},
  PanelText_UI_Awaker_Item_Info_Text_C_Xx_Content = {
    Text = "詳細情報"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Full_Content = {
    Text = "霊知啓発完了"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Got_Content = {
    Text = "召喚済み"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Already_Content = {
    Text = "所有済み"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Disable_Content = {
    Text = "変更不可"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Full_Content = {
    Text = "人格深化完了"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Click_Content = {
    Text = "リセット"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Content = {
    Text = "リセット"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Click_Content = {
    Text = "霊知啓発"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Content = {
    Text = "霊知啓発"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Click_Content = {
    Text = "ヒストリー"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Content = {
    Text = "ヒストリー"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Click_Content = {Text = "密約"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Content = {Text = "密約"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Click_Content = {Text = "スキル"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Content = {Text = "スキル"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Click_Content = {
    Text = "ステータス"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Content = {
    Text = "ステータス"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_TalentSelected_Content = {Text = "才能"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Talent_Content = {Text = "才能"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Click_Content = {
    Text = "運命の札"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Content = {
    Text = "運命の札"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Consume_Content = {
    Text = "真貌形態の解放には以下のアイテムが必要です。確定しますか？"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_1_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_2_Content = {Text = "確定"},
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Title_Content = {
    Text = "真貌の解放確認"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Click_Content = {Text = "汎用"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Content = {Text = "汎用"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Click_Content = {
    Text = "課題モード"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Content = {
    Text = "課題モード"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Current_Content = {Text = "現在"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Lower_Content = {
    Text = "次のレベル"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Mad_Content = {
    Text = "極限解放の解除"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Solved_Content = {
    Text = "解放済み"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Unsolved_Content = {Text = "未解放"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_WillSolved_Content = {
    Text = "今回解放"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Ranking_Content = {
    Text = "強化情報"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Skill_Story_Content = {
    Text = "起動素材"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Solved_Content = {
    Text = "解放済み"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Click_Content = {
    Text = "調査モード"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Content = {
    Text = "調査モード"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Unsolved_Content = {Text = "未解放"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_CN_Content = {
    Text = "起動完了"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_WillSolved_Content = {
    Text = "今回解放"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Solved_Content = {
    Text = "解放済み"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Unsolved_Content = {Text = "未解放"},
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_1_Content = {
    Text = "昏き海への帰還"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_2_Content = {
    Text = "育成リセット"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_1_Content = {
    Text = "情報に戻る"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_2_Content = {
    Text = "情報に戻る"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_3_Content = {
    Text = "情報に戻る"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_TipDesc_Content = {
    Text = "「育成リセット」または「霊知啓発リセット」後は、再度「昏き海の返還」を行うことはできません。"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Click_Content = {
    Text = "課題モード"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Content = {
    Text = "課題モード"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Click_Content = {
    Text = "調査モード"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Content = {
    Text = "調査モード"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Warning_CN_Content = {
    Text = "発動済み"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Attribute_Content = {Text = "能力"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Full_Content = {
    Text = "レベル上限に到達"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_High_Content = {
    Text = "現在表示"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Insufficient_Content = {
    Text = "覚醒体の昇格レベルが不足"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Maniac_Content = {
    Text = "狂気解放"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Material_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_1_Content = {Text = "現在"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_2_Content = {Text = "現在"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_3_Content = {
    Text = "次のレベル"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_4_Content = {
    Text = "次のレベル"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Normal_Content = {
    Text = "最大表示"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_PressTip_Content = {
    Text = "手札を長押しで拡大表示"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Skill_Tag_Content = {
    Text = "狂気解放"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Tale_Content = {Text = "物語"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Text_Need_Content = {Text = "必要"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Attribute_Content = {Text = "能力"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Maniac_Content = {
    Text = "狂気解放"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Material_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_1_Content = {Text = "現在"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_2_Content = {Text = "現在"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_3_Content = {
    Text = "次のレベル"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_4_Content = {
    Text = "次のレベル"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Tale_Content = {Text = "物語"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Text_Content = {Text = "必要"},
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Material_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Tips_Content = {
    Text = "自動投入"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_Confirm_Content = {Text = "昇級"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_2_Content = {
    Text = "オプション2"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_3_Content = {
    Text = "オプション3"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_Content = {
    Text = "昇格条件"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Material_Content = {
    Text = "昇格素材"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_New_Content = {
    Text = "新スキルを解放可能"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Title_Content = {
    Text = "昇格条件<WordSize20:（いずれか一つ）>"
  },
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Prop_Title_Content = {Text = "能力"},
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Tips_Content = {
    Text = "詳細情報"
  },
  PanelText_UI_Awaker_Item_Trinket_Detail_Text_C_Empty_Content = {
    Text = "密約を選択してください"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Deplete_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Fast_Content = {
    Text = "オート選択"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_1_Content = {Text = "昇級"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_2_Content = {Text = "転写"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_3_Content = {Text = "昇級"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Refinement_Content = {
    Text = "密約詳細"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Normal_Content = {Text = "戦闘"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Select_Content = {Text = "戦闘"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Normal_Content = {Text = "対人戦"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Select_Content = {Text = "対人戦"},
  PanelText_UI_Awaker_Item_Weapon_Refine_Text_C_Coin_Need_Content = {Text = "必要"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Blackpool_Content = {
    Text = "情報に戻る"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_3_Content = {
    Text = "昏き海への帰還"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_4_Content = {
    Text = "強化リセット"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Cost_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Current_Content = {
    Text = "現在の効果"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Expend_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Fast_Content = {
    Text = "オート選択"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Full_Content = {
    Text = "最大レベル"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_1_Content = {Text = "現在"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_2_Content = {Text = "現在"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_3_Content = {Text = "強化後"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_4_Content = {Text = "強化後"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_5_Content = {
    Text = "次の階段"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_6_Content = {
    Text = "次の階段"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Next_Content = {
    Text = "<Blue:次の効果>"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Overlay_Content = {
    Text = "情報に戻る"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Level_Content = {
    Text = "運命の札強化"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Name_Content = {Text = "強化"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Title_Content = {
    Text = "強化素材を選択"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Warning_Content = {
    Text = "強化レベル上限に到達"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_BackTraceTip_Content = {
    Text = "「強化リセット」使用後は、「昏き海への帰還」を行うことはできません。"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_Title_Content = {
    Text = "運命の札詳細"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Click_Content = {
    Text = "リセット"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Content = {
    Text = "リセット"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Breakthrough_Content = {Text = "昇格"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Enhance_Content = {Text = "強化"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Equip_Content = {Text = "装備中"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Fast_Content = {
    Text = "クイック配置"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_1_Content = {Text = "必要"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Refine_Content = {Text = "強化"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Click_Content = {Text = "強化"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Content = {Text = "強化"},
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Story_Content = {Text = "物語"},
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Title_Content = {
    Text = "基本情報"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_1_Content = {
    Text = "通常形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_2_Content = {
    Text = "通常形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_3_Content = {
    Text = "通常形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_1_Content = {
    Text = "真貌形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_2_Content = {
    Text = "真貌形態"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_3_Content = {
    Text = "真貌形態"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Null_Content = {
    Text = "現在の部位には使用可能な密約がありません"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Strengthen_Content = {Text = "強化"},
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Title_Content = {
    Text = "密契結合"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_UnBindAll_Content = {
    Text = "一括析離"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Contrast_Content = {Text = "対比"},
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty1_Content = {
    Text = "左側の運命の札を選択"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty_Content = {
    Text = "左側の運命の札を選択"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Unlock_Content = {
    Text = "昇格覚醒体\n第二運命の札を解放"
  },
  PanelText_UI_Awaker_Popup_Attribute_Detail_Text_C_Title_Content = {
    Text = "能力詳細"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_1_Content = {
    Text = "詳細を確認する"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_2_Content = {Text = "確認"},
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_NoTask_Content = {
    Text = "リセット可能なアイテムなし"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Title_Content = {
    Text = "リセット対象を選択"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_1_Content = {
    Text = "常設覚醒体"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_2_Content = {
    Text = "特殊覚醒体"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_3_Content = {
    Text = "運命の札"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_Time_Content = {
    Text = "他の場所を見てみよう"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_BindTip_Content = {
    Text = "他の覚醒体に装備されているか、編隊/方案/助っ人に存在する密契は自動的に取り外されます"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Tip_Content = {
    Text = "以下の密契を結合しますか？"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Title_Content = {
    Text = "結合確認"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Cancel_Name_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Tip_Content = {
    Text = "必要な素材が不足しています。\n以下の素材を消費して補充しますか？"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Title_Content = {
    Text = "補充の確認"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Expired_Content = {
    Text = "以下のアイテムは期限切れで使用できません"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Title_Content = {
    Text = "アイテム期限切れ"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_No_Trinket_Content = {
    Text = "選択可能な素材なし"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_Title_Content = {
    Text = "密約を選択"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Content_Content = {
    Text = "上限までアップグレード"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Title_Content = {
    Text = "レベルアップ"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Xuyao_Content = {Text = "必要"},
  PanelText_UI_Awaker_Popup_MyTeam_List_Text_C_William_Content = {
    Text = "アップグレード素材なし"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Coin_Count_Content = {Text = "必要"},
  PanelText_UI_Awaker_Popup_Potential_Text_C_Material_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Name_Content = {
    Text = "霊知深化"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Title_Content = {
    Text = "レベル上限アップ"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Preview_Content = {
    Text = "リセット後、以下の素材を獲得。"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Title_Content = {
    Text = "情報に戻る"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Content_Content = {
    Text = "レベル上限"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Title_Content = {
    Text = "スキルアップ"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Xuyao_Content = {Text = "必要"},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Condition_Content = {
    Text = "解放条件"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Current_Content = {Text = "現在"},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_High_Content = {
    Text = "現在表示"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Lower_Content = {
    Text = "次のレベル"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Normal_Content = {
    Text = "最大表示"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_Require_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Popup_Tip_Preview_Text_C_Title_Content = {
    Text = "昇格素材情報"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Info_Content = {
    Text = "タップで閉じる"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_New_Content = {
    Text = "新スキルを解放可能"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Succeed_Content = {
    Text = "昇格成功"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Breakthrough_Content = {
    Text = "同調要件"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Now_Content = {Text = "現在"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Reward_Content = {
    Text = "レベル報酬"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Screening_Content = {
    Text = "報酬を受け取りました"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Tips_Content = {Text = "確認"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Title_Content = {Text = "同調率"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Unlock_Content = {
    Text = "ヒストリー解放"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Activation_Content = {
    Text = "起動完了"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Lv_Content = {
    Text = "レベル上限アップ"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Content = {
    Text = "レベル上限アップ"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Name_Content = {
    Text = "極限解放"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Activation_Content = {
    Text = "起動完了"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Name_Content = {
    Text = "最終法則"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_Activation_Content = {Text = "未起動"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_MaxMad_Activation_Content = {Text = "未起動"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Solved_Content = {
    Text = "解放済み"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unlock_Content = {
    Text = "能力向上"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unsolved_Content = {Text = "未解放"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_WillSolved_Content = {
    Text = "今回解放"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Material_Content = {
    Text = "昇格素材"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Reward_Content = {
    Text = "昇格報酬"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Title_Content = {
    Text = "昇格情報"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_Screening_Content = {
    Text = "報酬を受け取りました"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_BindTip_Content = {
    Text = "結合後、密契のメイン属性が追加で50%上昇！"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Bind_Content = {
    Text = "密契を結合"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Empty_Suit_Content = {
    Text = "有効なセット効果なし"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Foundation_Content = {Text = "能力"},
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Rule_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Suit_Content = {
    Text = "セット効果"
  },
  PanelText_UI_Awaker_Popup_Trinket_Change_Text_C_Equipped_Content = {
    Text = "装備済み"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_AutoRefinement_Content = {
    Text = "自動転写"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Empty_Content = {
    Text = "転写して新しいサブ能力を獲得。"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Exchange_Content = {
    Text = "変換設定"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Foundation_Content = {
    Text = "元のサブ能力"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Hoist_Content = {
    Text = "新しいサブ能力"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_1_Content = {Text = "転写"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_2_Content = {
    Text = "置き換え"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_No_Entries_Content = {
    Text = "能力なし"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Skip_Content = {
    Text = "アニメをスキップ"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Text_Content = {Text = "必要"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_illustrate_Content = {
    Text = "転写説明"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Filtrate_Content = {
    Text = "SSR以下の素材"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Shortcut_Content = {
    Text = "自動挿入"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Upper_Limit_Content = {
    Text = "レベル上限に達しました"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_List_Text_C_None_Content = {
    Text = "未装備の運命の札はありません"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_1_Content = {
    Text = "密約を選択してください"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_2_Content = {
    Text = "セット効果なし"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Foundation_Content = {Text = "能力"},
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Suit_Content = {
    Text = "セット効果"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Contrast_Content = {Text = "対比"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Empty_Content = {
    Text = "密約を選択してください"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_None_Content = {
    Text = "現在の部位には使用可能な密約がありません"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Notselected_Content = {
    Text = "密約を選択してください"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Suit_Content = {
    Text = "セット効果"
  },
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_None_Content = {
    Text = "未装備の密約はありません"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Consume_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Deplete_Content = {
    Text = "材料を消費"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Exchange_Content = {
    Text = "変換設定"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Content = {
    Text = "オート選択"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_High_Content = {
    Text = "1レベルアップ"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Normal_Content = {
    Text = "1レベルアップ"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_MaxLevel_Content = {Text = "強化"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_High_Content = {
    Text = "レベル最大"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_Normal_Content = {
    Text = "レベル最大"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Name_3_Content = {Text = "昇級"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Title_Content = {Text = "レベル"},
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_AutoSelect_Content = {
    Text = "自動選択"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Cancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Confirm_Content = {
    Text = "密契を析離"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_NeedTrinket_Content = {
    Text = "必要な密契"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Title_Content = {
    Text = "密契を析離"
  },
  PanelText_UI_Awaker_Popup_Whole_Body_Text_C_Reveal_Content = {Text = "秘密"},
  PanelText_UI_Awaker_Popup_illustrate_Tips_Text_C_Title_Content = {
    Text = "追加効果説明"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Tips_Content = {Text = "一覧"},
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Title_Content = {
    Text = "覚醒体才能"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Type_Content = {Text = "タイプ"},
  PanelText_UI_Awaker_Weapon_Enhance_Success_Text_C_Succeed_Content = {
    Text = "強化成功"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Info_Content = {
    Text = "タップで閉じる"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Succeed_Content = {
    Text = "強化成功"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Attribute_Content = {Text = "能力"},
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Choose_Content = {
    Text = "・覚醒体を選択"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Helicopter_Content = {
    Text = "・プレビュー"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Skill_Content = {Text = "スキル"},
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Title_Content = {
    Text = "覚醒体増幅"
  },
  PanelText_UI_Bag_Item_Appearance_Text_C_Got_Content = {
    Text = "取得済み"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_AavtarName_Content = {
    Text = "アイコンとスタンプ"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Avatar_Info_Content = {
    Text = "詳細情報"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Source_Content = {Text = "出所"},
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Time_Content = {
    Text = "残りの有効時間："
  },
  PanelText_UI_Bag_Item_Detail_Text_C_AavtarName_Content = {
    Text = "アイコンとスタンプ"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "詳細情報"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "キーオーダー効果："
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Source_Content = {Text = "入手元"},
  PanelText_UI_Bag_Item_Detail_Text_C_Time_Content = {
    Text = "残り有効時間"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Attack_Content = {
    Text = "基礎攻撃"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Defense_Content = {
    Text = "基礎防御"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Physique_Content = {
    Text = "基本体力"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Full_Content = {
    Text = "霊知啓発完了"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Title_Content = {
    Text = "覚醒体の欠片を選択"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Yes_Content = {
    Text = "所有済み"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Cancel_Name_Content = {
    Text = "詳細を確認する"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_BtnName_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Emoji_Content = {
    Text = "スタンプ"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Head_Content = {
    Text = "アイコン"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_NoTask_Content = {
    Text = "すべての外観を獲得しました"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_RatePreview_Content = {
    Text = "確率情報"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Title_Content = {
    Text = "外観情報"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_2_Select_Content = {Text = "順序"},
  PanelText_UI_Bag_Panel_Main_Text_C_Cap_Content = {
    Text = "現在のレベル上限に強化済み"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_NormotopiaCap_Content = {
    Text = "強化が上限に達した"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Replacement_Content = {Text = "変換"},
  PanelText_UI_Bag_Panel_Main_Text_C_recast_Content = {Text = "再鍛造"},
  PanelText_UI_Bag_Panel_Main_Text_Intensify_Content = {Text = "強化"},
  PanelText_UI_Bag_Panel_Main_Text_Normotopia_Content = {Text = "強化"},
  PanelText_UI_Bag_Panel_Main_Text_Title_Content = {Text = "所持品"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_BtnName_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Emoji_Content = {
    Text = "スタンプ"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Head_Content = {
    Text = "アイコン"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_NoTask_Content = {
    Text = "データがありません"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Title_Content = {
    Text = "外観情報"
  },
  PanelText_UI_Battle_Item_CounterAwaker_Text_C_CounterAwaker_Content = {
    Text = "特攻覚醒体"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Disabled_CN_Content = {Text = "確 認"},
  PanelText_UI_Battle_Panel_CardStack_Text_C_Display_Content = {
    Text = "カードを表示"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Hide_Content = {
    Text = "カードを隠す"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_High_CN_Content = {Text = "確 認"},
  PanelText_UI_Battle_Panel_CardStack_Text_C_Normal_CN_Content = {Text = "確 認"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Count_Content = {
    Text = "融災の黒潮"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_End_EN_No_Content = {Text = "終了"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Insufficient_Content = {
    Text = "スペース不足"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Name_Content = {Text = "終了"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Setting_Content = {Text = "設定"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Unclickable_Content = {Text = "終了"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Zongshanghai_Content = {
    Text = "総ダメージ"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_insufficient_Content = {
    Text = "スペース不足"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_CD_Content = {
    Text = "クールダウン中"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Cooling_Content = {
    Text = "クールダウン中、次のターンで再使用可能"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Title_Content = {
    Text = "極限解放"
  },
  PanelText_UI_Battle_Popup_Anger_Text_C_CD_Content = {
    Text = "クールダウン中"
  },
  PanelText_UI_Battle_Popup_Anger_Text_C_Cooling_Content = {
    Text = "クールダウン中、次のターンで再使用可能"
  },
  PanelText_UI_Battle_Popup_Anger_Text_Title_Content = {
    Text = "狂気解放"
  },
  PanelText_UI_Battle_Popup_AttachPost_Text_C_AttachPost_Content = {Text = "追撃"},
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Confirm_Content = {Text = "確認"},
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Title_Content = {
    Text = "カードグループを選択"
  },
  PanelText_UI_Battle_Popup_Elite_Text_C_Victory_Content = {
    Text = "危険警報"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Title_Content = {
    Text = "緊急警報"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Continue_Content = {Text = "続行"},
  PanelText_UI_Battle_Popup_Fail_Text_C_Victory_Content = {
    Text = "戦闘失敗"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_1_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_2_Content = {Text = "確認"},
  PanelText_UI_Battle_Popup_Furnace_Text_C_Title_Content = {
    Text = "腥紅の炉"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Awaker_School_Content = {Text = "守秘者"},
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Nature_Content = {
    Text = "チーム情報"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Property_Content = {
    Text = "緊急物資"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill2_Content = {
    Text = "キーエネルギー"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill_Tag_Content = {
    Text = "キーオーダー"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeeperSkill_Content = {Text = "発動"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenAwaken_Content = {Text = "発動"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenNewChaos_Content = {Text = "発動"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_Title_Content = {
    Text = "キーオーダーを選択してください"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_AwakenTitle_Content = {
    Text = "シルバーキー覚醒"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_NewChaosTitle_Content = {
    Text = "複合キーオーダー"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Title_Content = {
    Text = "戦闘開始"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips2_Content = {
    Text = "と交換しますか？"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips_Content = {
    Text = "復活の魂魄がありません。"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Cost_Content = {Text = "消費"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Tips_Content = {
    Text = "（交換するとすぐに消費されて復活します。撤退した場合は、復活の魂魄が返還されます）"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Cancel_Name_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_Title_Content = {
    Text = "致命的な危機を感知"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_AffixInfo_Content = {
    Text = "追加効果説明"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Arousal_Content = {Text = "覚醒"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Destiny_Content = {
    Text = "運命の札"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Gnosisi_Content = {
    Text = "霊知覚醒"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Maniac_Content = {Text = "狂気値"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Property_Content = {
    Text = "能力詳細"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Secret_Content = {Text = "密約"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Skill_Tag_Content = {
    Text = "狂気解放"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Talent_Content = {Text = "才能"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Awakening_Content = {
    Text = "霊知覚醒"
  },
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Trinket_Content = {Text = "密約"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Weapon_Content = {
    Text = "運命の札"
  },
  PanelText_UI_Battle_Popup_Round_Enemy_Text_C_Our_Content = {
    Text = "敵のターン"
  },
  PanelText_UI_Battle_Popup_Round_Mine_Text_C_Our_Content = {
    Text = "仲間のターン"
  },
  PanelText_UI_Battle_Popup_SelectAwaker_Text_C_Title_Content = {
    Text = "覚醒体を選択してください"
  },
  PanelText_UI_Battle_Popup_Settle_Text_C_Succeed_Content = {
    Text = "戦闘勝利"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Activate_Content = {
    Text = "現在の指令"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_1_Content = {
    Text = "選択不可"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_2_Content = {
    Text = "選択不可"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Frantic_Content = {Text = "発狂"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Name_Content = {Text = "戦闘"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Title_Content = {
    Text = "触腕モードを選択してください"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Cancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Lock_Content = {
    Text = "時序逆行で戦闘を過去のターンに巻き戻すことができます"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Sure_Content = {Text = "確定"},
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Title_Content = {
    Text = "時序逆行"
  },
  PanelText_UI_Battle_Tip_CounterAwaker_Text_C_Title_Content = {
    Text = "敵の特性"
  },
  PanelText_UI_Card_Panel_Discard_Text_C_Title_Content = {Text = "手札"},
  PanelText_UI_Chaper_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_Content = {
    Text = "累積報酬"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Confirm_Content = {
    Text = "調査を続ける"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Joinin_Content = {
    Text = "以下の調査ステージのクリアを推奨"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Screening_Content = {
    Text = "24時間再表示しない"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Begone_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Creation_Content = {Text = "遺物"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkgame_Content = {Text = "遺物"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Demon_Content = {
    Text = "刻印なし"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Bright_Content = {Text = "遺物"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Content = {Text = "遺物"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Not_Content = {
    Text = "遺物なし"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Walk_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Chaper_Popup_Level_Success_Text_C_Title_Content = {
    Text = "ステージ実績"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Achievement_Content = {
    Text = "敵の情報"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Cost_Tips_Content = {
    Text = "チーム要求："
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Grade_Content = {
    Text = "推奨レベル"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Monster_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Recommend_Content = {
    Text = "推薦界域"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Reward_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Suppress_Content = {
    Text = "融災の黒潮"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Title_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Monster_Content = {Text = "敵"},
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Title_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Chaper_Popup_Particulars_View_Text_C_Replay_Content = {Text = "記録"},
  PanelText_UI_Chaper_Popup_StageAchieve_View_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Difficulty_Content = {Text = "高難度"},
  PanelText_UI_Chapter_Dream_View_Text_C_Nightmare_Content = {Text = "超難度"},
  PanelText_UI_Chapter_Dream_View_Text_C_Remember_Content = {
    Text = "夢を遡る"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Simple_Content = {Text = "通常"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Difficulty_Content = {Text = "高難度"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Nightmare_Content = {Text = "悪夢"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Remember_Content = {
    Text = "夢を遡る"
  },
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Simple_Content = {Text = "簡単"},
  PanelText_UI_Chapter_Item_Achievement_List_Text_C_Lost_Content = {Text = "未達成"},
  PanelText_UI_Chapter_Item_Achievement_List_Text_Lost_Content = {Text = "未達成"},
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Expect_Content = {
    Text = "乞うご期待"
  },
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Tips_Content = {
    Text = "ステージ進行"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect1_Content = {
    Text = "未解放です"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect2_Content = {
    Text = "未解放です"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect_Content = {
    Text = "乞うご期待"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Tips_Content = {
    Text = "ステージ進行"
  },
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Chapter_Item_Dream_02_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Chapter_Item_Dream_03_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Chapter_Item_Dream_04_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Chaoter_Content = {
    Text = "<Yellow:ドリームビュー>"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Chapter_Item_Skill_Text_C_Level_Content = {
    Text = "ステータス"
  },
  PanelText_UI_Chapter_Item_Special_01_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Chapter_Item_Special_02_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Chapter_Item_Special_03_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Chapter_Item_StageAchieve_Text_C_Lost_Content = {Text = "未達成"},
  PanelText_UI_Chapter_Item_Success_List_Text_Lost_Content = {Text = "未達成"},
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Award_Content = {
    Text = "すべての報酬条件を達成した"
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Award_Content = {
    Text = "達成済み"
  },
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Difficulty_Content = {Text = "高難度"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_Nightmare_Content = {Text = "超難度"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_NoTask_Content = {
    Text = "特務記録なし"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Simple_Content = {Text = "通常"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_Time_Content = {
    Text = "2023/12/21 05:00新登場、お楽しみに"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Title_Content = {Text = "調査"},
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_2_Content = {
    Text = "ステージ実績"
  },
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_Content = {
    Text = "ステージ評価"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_01_Content = {Text = "高難度"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Content = {Text = "高難度"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Now_Content = {Text = "高難度"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_01_Content = {Text = "超難度"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Content = {Text = "超難度"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Now_Content = {Text = "超難度"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Progress_Content = {
    Text = "調査進捗"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_01_Content = {Text = "通常"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Content = {Text = "通常"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Now_Content = {Text = "通常"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tab_Special_Content = {
    Text = "期間限定イベント"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tishi_Content = {
    Text = "ステージ実績"
  },
  PanelText_UI_Chapter_Popup_Achievement_Text_C_Title_Content = {Text = "実績"},
  PanelText_UI_Chapter_Popup_Chapter_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Chapter_Popup_Monster_Details_Text_C_Title_Content = {
    Text = "敵の詳細"
  },
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Effect_Content = {Text = "効果"},
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Story_Content = {Text = "物語"},
  PanelText_UI_Chapter_Popup_Yuanxing_Text_Title_Content = {
    Text = "調査評価"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Difficulty_Content = {Text = "高難度"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Nightmare_Content = {Text = "超難度"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Progress_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Remember_Content = {
    Text = "夢を遡る"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Simple_Content = {Text = "通常"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Tab_Special_Content = {
    Text = "限定イベント"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Difficulty_Content = {Text = "高難度"},
  PanelText_UI_Chapter_Spur_View_Text_C_Nightmare_Content = {Text = "超難度"},
  PanelText_UI_Chapter_Spur_View_Text_C_Progress_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Remember_Content = {
    Text = "夢を遡る"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Chapter_Spur_View_Text_C_Review_Content = {
    Text = "プロローグ"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Simple_Content = {Text = "通常"},
  PanelText_UI_Chapter_Spur_View_Text_C_Tab_Special_Content = {
    Text = "期間限定イベント"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Condition_Content = {
    Text = "解放条件未達成"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Name_Content = {
    Text = "ストーリーに入る"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Chapter_Vindicate_View_Text_C_NoTask_Content = {
    Text = "繁栄狂宴は未解放"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_StoryDesc_Content = {
    Text = "「欲望の波」の持続に伴い、覚醒体たちは神秘的な力の影響を受け、「繁栄狂宴」状態に陥っています……守秘者は十分に注意してください！"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Tip_Content = {
    Text = "「欲望の波」イベント期間中、期間限定の割引解放。同調率要求を無視して「起点装置」×1で対応イベントを解放可能！"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Title_Content = {
    Text = "チーム招待状"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Collection_History_Details_Text_C_Lock_Content = {
    Text = "画像資料はまだ取得していません"
  },
  PanelText_UI_Collection_History_Details_Text_Title_Content = {Text = "記録"},
  PanelText_UI_Collection_Item_Comprehensive_Text_C_Placeholder_Content = {
    Text = "名前検索"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_High_Content = {
    Text = "BGMをリセット"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Label_Content = {Text = "蓄音機"},
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Mail_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Normal_Content = {
    Text = "BGMに設定"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Label_Content = {Text = "蓄音機"},
  PanelText_UI_Collection_Item_Music_Text_C_Mail_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_UnLock_Content = {Text = "解放"},
  PanelText_UI_Collection_Item_Video_Text_C_UnLock_Content = {Text = "解放"},
  PanelText_UI_Collection_Panel_EquipDetail_Text_C_Title_Content = {Text = "物語"},
  PanelText_UI_Collection_Panel_Equip_Text_C_None_Content = {
    Text = "関連コレクションなし"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Collection_Panel_Event_Text_C_Placeholder_Content = {
    Text = "名前検索"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Label_Content = {Text = "年代記"},
  PanelText_UI_Collection_Panel_History_Text_C_Mail_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_LoginPV_Text_Title_Content = {
    Text = "ログイン背景の変更"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Creation_Content = {Text = "遺物"},
  PanelText_UI_Collection_Panel_Main_Text_C_Image_Content = {Text = "映像"},
  PanelText_UI_Collection_Panel_Main_Text_C_Music_Content = {Text = "蓄音機"},
  PanelText_UI_Collection_Panel_Main_Text_C_Progress_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Role_Content = {
    Text = "キャラクター"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Weapon_Content = {Text = "命輪"},
  PanelText_UI_Collection_Panel_Main_Text_C_World_Content = {Text = "世界史"},
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Mail_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_Organize_Text_C_Mail_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Collection_Panel_Organize_Text_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_Relic_Text_C_Mail_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Collection_Panel_Relic_Text_C_Title_Content = {Text = "物語"},
  PanelText_UI_Collection_Panel_Relic_Text_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Cancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Display_Content = {
    Text = "覚醒体を表示"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_DownLoadCG_Content = {
    Text = "オリジナル画像をダウンロード"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_HideAwaker_Content = {
    Text = "この画像を寮の背景に設定すると、来客の姿は隠れます"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Hide_Content = {
    Text = "覚醒体を隠す"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_High_Content = {
    Text = "寮の背景をリセット"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Normal_Content = {
    Text = "寮の背景に設定"
  },
  PanelText_UI_Collection_Panel_Unlock_Text_C_Cost_Content = {Text = "消費"},
  PanelText_UI_Collection_Panel_World_Text_C_Chronicle_Content = {Text = "年代記"},
  PanelText_UI_Collection_Panel_World_Text_C_Comprehensive_Content = {
    Text = "世界禁書"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Label_Content = {Text = "世界史"},
  PanelText_UI_Collection_Panel_World_Text_C_Organize_Content = {
    Text = "組織勢力"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Title_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Collection_Panel_World_Text_Progress_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Common_Awaker_Favor_Text_C_Sync_Content = {
    Text = "覚醒体の同調率が増加"
  },
  PanelText_UI_Common_Btn_Receive_Small_Text_C_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Common_Btn_Share_Text_C_Across_Content = {
    Text = "初回シェアで"
  },
  PanelText_UI_Common_Btn_Share_Text_C_Share_Content = {
    Text = "初回シェアで"
  },
  PanelText_UI_Common_Btn_Small_240x90_Text_Name_Content = {
    Text = "才能を起動"
  },
  PanelText_UI_Common_Group_Coin_Text_C_Text_Content = {Text = "必要"},
  PanelText_UI_Common_Item_Detail_Text_C_AavtarName_Content = {
    Text = "アイコンとスタンプ"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "詳細情報"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Close_Content = {Text = "しまう"},
  PanelText_UI_Common_Item_Detail_Text_C_Equipped_Content = {
    Text = "装備済み"
  },
  PanelText_UI_Common_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "キーオーダー効果："
  },
  PanelText_UI_Common_Item_Detail_Text_C_Source_Content = {Text = "入手元"},
  PanelText_UI_Common_Item_Hint_Text_C_Recommend_Content = {
    Text = "今日のおすすめ"
  },
  PanelText_UI_Common_Item_Potency_Text_C_Max_Content = {Text = "Max"},
  PanelText_UI_Common_Item_Tip_Bg_Text_C_Name_Content = {Text = "ソート"},
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Expired_Content = {
    Text = "期限切れ"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NoEquip_Content = {
    Text = "装備不可"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NotActive_Content = {Text = "未発効"},
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_UpperLimit_Content = {
    Text = "上限に達しました"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Full_Content = {
    Text = "霊知啓発完了"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Double_Content = {Text = "ダブル"},
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Nor_Content = {Text = "追加"},
  PanelText_UI_Common_Melt_Disaster_Text_C_Suppress_Content = {
    Text = "融災の黒潮"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_AbandonCard_Content = {Text = "捨て札"},
  PanelText_UI_Common_Popup_Card_List_Text_C_DrawCard_Content = {Text = "山札"},
  PanelText_UI_Common_Popup_Card_List_Text_C_Empty_Content = {
    Text = "現在山札が空です"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_NoTask_Content = {
    Text = "カードなし"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Cancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Common_Popup_Consume_Text_C_Title_Content = {
    Text = "アイテム使用確認"
  },
  PanelText_UI_Common_Popup_Tip_01_Text_C_Screening_Content = {
    Text = "本日の通知はこれ以上表示しない"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_Screening_Content = {
    Text = "本日の通知はこれ以上表示しない"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_ShopNeed_Content = {
    Text = "現在の商品券数"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_Screening_Content = {
    Text = "本日の通知はこれ以上表示しない"
  },
  PanelText_UI_Common_Popup_Tip_4_Text_C_Info_Content = {
    Text = "<WhiteQuality:タップで閉じる>"
  },
  PanelText_UI_Common_Popup_Tip_5_Text_C_Info_Content = {
    Text = "タップで閉じる"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_C_Tips_Content = {
    Text = "名前を変更すると、72時間以内に再度変更することはできません"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_NameCancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_NameConfirm_Content = {Text = "確認"},
  PanelText_UI_Common_Popup_Tip_6_Text_Placeholder_Content = {
    Text = "名前を入力してください"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_Title_Content = {
    Text = "名前を変更"
  },
  PanelText_UI_Common_Popup_Tips_6_Text_null_Content = {
    Text = "（破損済み）"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Material_Content = {
    Text = "昇格素材"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Reward_Content = {
    Text = "昇格報酬"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Title_Content = {
    Text = "昇格情報"
  },
  PanelText_UI_Common_Popup_Tips_Small_Text_C_Scroll_Tips_Content = {
    Text = "上下にスワイプして報酬をもっと見る"
  },
  PanelText_UI_Community_Acclaim_Tips_Text_C_Name_1_Content = {Text = "評価へ"},
  PanelText_UI_Community_Steer_Tips_Text_Thanks_Name_Content = {
    Text = "スペシャルサンクス"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_LetterTitle_Content = {
    Text = "ローカライズに協力いただいた有志の皆さまへ"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Name_Content = {
    Text = "ローカライズに協力いただいた有志の皆さま"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Signature_Content = {
    Text = "ミサゴ大学委員会"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Sincerely_Content = {
    Text = "深く感謝申し上げます"
  },
  PanelText_UI_Community_ThanksLetter_Text_Prefix_Content = {
    Text = "皆様の優れた言語感覚とゲームへの深い愛情が、無機質だった機械翻訳のテキストに命を吹き込みました。\nその無私のご尽力により、世界中の守秘者たちが『忘却前夜』の持つ本来の魅力に触れることができています。\nミサゴ大学は、多大なる貢献を果たしてくださった以下の守秘者の皆様へ敬意を表すとともに、心より感謝申し上げます。"
  },
  PanelText_UI_Community_ThanksLetter_Text_Suffix_Content = {
    Text = "銀の鍵の導きがあらんことを。"
  },
  PanelText_UI_Community_ThanksLetter_Text_Title_Content = {
    Text = "スペシャルサンクス"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Award_Content = {
    Text = "アーカイブ済み"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Free_Unlock_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Lock_Content = {
    Text = "まだ解放されていません。"
  },
  PanelText_UI_Copy_Story_View_Text_C_ReadTip_Content = {
    Text = "推奨順序は推奨閲覧順序を示すものであり、厳密な時系列順序を示すものではありません。"
  },
  PanelText_UI_Course_Panel_Main_Text_C_NoTask_Content = {
    Text = "このタイプのヘルプはありません"
  },
  PanelText_UI_Course_Panel_Main_Text_C_Placeholder_Content = {
    Text = "ヘルプを検索"
  },
  PanelText_UI_Course_Panel_Text_Title_Content = {
    Text = "ヘルプを検索"
  },
  PanelText_UI_Dbgcopy_Item_Select_Goods_Text_C_Sellout_Content = {
    Text = "売り切れ"
  },
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Achievement_Content = {
    Text = "ステージ実績"
  },
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Star_Content = {Text = "星評価"},
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Arousal_Sellout_Content = {
    Text = "売り切れ"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Curse_Content = {
    Text = "呪いの間"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Sell_Sellout_Content = {
    Text = "売り切れ"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Spend_Content = {Text = "費用"},
  PanelText_UI_Dbgcopy_Panel_Main_New_Text_C_Count_Content = {
    Text = "融災の黒潮"
  },
  PanelText_UI_Dbgcopy_Panel_RelicPreview_Text_Name_Content = {Text = "戻る"},
  PanelText_UI_Dbgcopy_Panel_RelicStrength_Text_C_Title_Content = {
    Text = "強化遺物"
  },
  PanelText_UI_Dbgcopy_Panel_Select_Arousal_Text_C_Name_Content = {Text = "選択"},
  PanelText_UI_Dbgcopy_Panel_Select_Extra_Text_C_Name_Content = {Text = "放棄"},
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Display_Content = {Text = "表示"},
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Hide_Content = {Text = "非表示"},
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Monster_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Tip_Content = {
    Text = "守秘者の皆さん、ご注意ください。\n異なるステージレベルでは、それぞれ異なる環境の特徴や初期遺物がもたらされます。"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Title_Content = {
    Text = "ステージレベル効果説明"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Replace_Content = {
    Text = "覚醒体を変更"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_TeamAwaker_Content = {
    Text = "現在のチーム内の覚醒体"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Title_Content = {
    Text = "変更する覚醒体を選択"
  },
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Suppress_Content = {Text = "繁殖"},
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Title_Content = {
    Text = "「融災の黒潮」効果説明"
  },
  PanelText_UI_Dbgcopy_Popup_ydbj_yty_01_Text_C_Dcks_Content = {
    Text = "調査開始"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_BtnName_Content = {
    Text = "訓練開始"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Item_Common_Element_Text_C_Award_Content = {
    Text = "報酬+100%"
  },
  PanelText_UI_Dungeons_Item_Common_Tier2_Text_C_Current_Content = {
    Text = "現在のクリア状況"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Extra_Content = {
    Text = "追加のクリア"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Content = {
    Text = "リセット"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Extra_Content = {
    Text = "リセット"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Undone_Content = {
    Text = "挑戦未達成"
  },
  PanelText_UI_Dungeons_Item_RailWayRank_Text_C_Null_Content = {
    Text = "編成なし"
  },
  PanelText_UI_Dungeons_Material_View_Text_C_ActivityAchievement_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_All_Content = {Text = "すべて"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Awaker_Content = {Text = "出撃"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_BattleStatistics_Content = {
    Text = "戦闘データ"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Damage_Content = {
    Text = "与えたダメージ量"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Heal_Content = {
    Text = "与えたライフ回復量"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_BattleStatistics_Content = {
    Text = "データがありません"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_RoundStatistics_Content = {
    Text = "データがありません"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_RoundStatistics_Content = {
    Text = "ターン統計"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Shield_Content = {
    Text = "与えたシールド量"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_BattleStatistics_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_RoundStatistics_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Experience_Content = {
    Text = "深奥レベル"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Highest_Content = {
    Text = "今シーズンの最高得点"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Rank_Content = {
    Text = "ランキングボード"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Record_Content = {
    Text = "今週の成績"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Store_Content = {
    Text = "商店で交換"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Title_Content = {
    Text = "調査レベル称号"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Diving_Record_Content = {
    Text = "潜行記録"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Main_Title_Content = {
    Text = "幻夢の深奥"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Highest_Content = {
    Text = "今シーズンの最高得点"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record2_Content = {
    Text = "今週の戦績"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record_Content = {
    Text = "今週の戦績"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Reward2_Content = {
    Text = "潜行記録"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Store_Content = {
    Text = "商店で交換"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Title_Content = {
    Text = "調査レベル称号"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_list_Content = {
    Text = "シーズンランキング"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Appraise_Content = {
    Text = "スコア統計"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Finish_Content = {
    Text = "調査成功"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_High_Content = {
    Text = "新記録！"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Remind_Content = {
    Text = "覚醒体の能力を上げてから強敵に挑もう！"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Score_Content = {
    Text = "総合スコア"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Synthesis_Content = {
    Text = "（総合スコアは以下の合計×3）"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Award_Content = {
    Text = "クリア報酬"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Highest_Content = {
    Text = "最高記録"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Record_Content = {
    Text = "本日の成績"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Reward_Content = {
    Text = "今週の試練"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Score_Content = {
    Text = "今週の累計スコア"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Store_Content = {
    Text = "商店で交換"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Title_Content = {
    Text = "調査称号"
  },
  PanelText_UI_Dungeons_Panel_Material_Text_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Appraise_Content = {
    Text = "評価統計"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_BattleData_Content = {
    Text = "調査データ"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Finish_Content = {
    Text = "調査完了"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_High_Content = {
    Text = "新記録！"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "清算報酬"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Integral_Content = {
    Text = "調査評価"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Limit_Content = {
    Text = "※アイテムが上限に達しました"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Score_Content = {
    Text = "総合スコア"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Statistics_Content = {
    Text = "戦闘データ"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Sync_Content = {
    Text = "覚醒体の同調率が増加"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Synthesis_Content = {
    Text = "（総合スコアは以下の合計×3）"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_TeamInfo_Content = {
    Text = "チーム情報"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval1_Content = {Text = "隙間"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval2_Content = {
    Text = "輪転の隙間"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_1_Content = {
    Text = "混沌の領域"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_2_Content = {
    Text = "血月の塔"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_3_Content = {
    Text = "暗海の淵"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_4_Content = {
    Text = "超次元の旅"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_1_Content = {Text = "未解放"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_2_Content = {Text = "未解放"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_3_Content = {Text = "未解放"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_4_Content = {Text = "未解放"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Tips_Content = {
    Text = "黒い供物交換"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card2_Content = {
    Text = "（刻印あり）"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card_Content = {
    Text = "カード統計"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_KeyToken_Content = {
    Text = "キーオーダー"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_NoTask_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Null_Content = {
    Text = "造物なし"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_PlayerLevel_Content = {
    Text = "調査レベル"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Relic_Content = {Text = "遺物"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Reset_Content = {
    Text = "リセット"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamData_Content = {
    Text = "チームデータ"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamProperty_Content = {
    Text = "チーム能力"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Team_Content = {
    Text = "調査チーム"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Uid_Content = {
    Text = "守秘者ID:"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Dungeons_Panel_Trinket_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Award_Content = {
    Text = "完了報酬"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Emoji_Content = {
    Text = "スタンプ"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Introduce_Content = {
    Text = "能力紹介"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_1_Content = {Text = "受取"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_Content = {
    Text = "試遊を開始"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Normal_Awaker_Content = {Text = "常設"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Undone_Content = {Text = "未完了"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Wake_Content = {Text = "召喚へ"},
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_ActivityAchievement_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_AwardText_Content = {
    Text = "今週の報酬受取回数"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_AwardText_Content = {
    Text = "今週の報酬受取回数"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Info_Content = {
    Text = "守秘者情報"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_More_Content = {
    Text = "詳細を確認する"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_NoTask_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Rank_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Replay_Content = {
    Text = "記録再生"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Value_Content = {Text = "特訓値"},
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_Title_Content = {
    Text = "ランキングボード"
  },
  PanelText_UI_Dungeons_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Dungeons_Popup_Award_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Awaker_Content = {Text = "出撃"},
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Damage_Content = {
    Text = "与えたダメージ量"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Heal_Content = {
    Text = "与えたライフ回復量"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Shield_Content = {
    Text = "与えたシールド量"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Title_Content = {
    Text = "戦闘データ"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_FilterAwaker_Content = {
    Text = "覚醒体の絞り込み"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_No_Records_Content = {
    Text = "調査記録はありません"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Refresh_Content = {
    Text = "他から選ぶ"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Title_Content = {
    Text = "クリア記録"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_Fliter_Type_Content = {
    Text = "総ターン数"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Award_Content = {
    Text = "高得点ランキング"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Big_Content = {
    Text = "ランキング範囲"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Current_Content = {
    Text = "今の報酬"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Empty_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_FilterAwaker_Content = {
    Text = "覚醒体の絞り込み"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Grade_Content = {
    Text = "調査称号"
  },
  ["PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Haven't_Content"] = {
    Text = "報酬なし"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Highest_Content = {
    Text = "最高記録"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_1_Content = {
    Text = "守秘者情報"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_2_Content = {
    Text = "調査称号"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_3_Content = {
    Text = "最高記録"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_4_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_5_Content = {Text = "編成"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_6_Content = {Text = "記録"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Me_Content = {
    Text = "自身のランキング"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_NoTask_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Prompt_Content = {
    Text = "毎週月曜日の9:00に調査称号に基づいた報酬メールが送信されます"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward1_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward2_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Ranking_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Reward_Content = {Text = "報酬"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season1_Content = {
    Text = "シーズンランキング"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season2_Content = {
    Text = "シーズンランキング"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Small_Content = {
    Text = "小さいか等しい"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking1_Content = {
    Text = "シーズンランキング"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking2_Content = {
    Text = "シーズンランキング"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Title_Content = {
    Text = "調査ランキング"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_illustrate_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Big_Content = {
    Text = "ランキング範囲"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_DivingTitle_Content = {
    Text = "調査称号"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Exp_Content = {
    Text = "最高進捗"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Grade_Content = {
    Text = "調査称号"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Info_Content = {
    Text = "守秘者情報"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_NoTask_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Nor_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Sel_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Nor_Content = {
    Text = "シーズンランキング"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Sel_Content = {
    Text = "シーズンランキング"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Replay_Content = {Text = "記録"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Reward_Content = {Text = "報酬"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Round_Content = {
    Text = "ターン数"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Team_Content = {Text = "編成"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Title_Content = {Text = "VIP名簿"},
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Big_Content = {Text = "大きい"},
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Reward_Content = {Text = "報酬"},
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Small_Content = {
    Text = "小さいか等しい"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Title_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_Dungeons_Popup_Rules_Tip_Text_C_Title_Content = {
    Text = "プレイ説明"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Award_Content = {
    Text = "報酬プレビュー"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_2_Content = {Text = "共鳴"},
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Title_Content = {
    Text = "尖塔の肉鳩"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Award_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Challenge_Content = {
    Text = "スタンダードモード"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Daily_Content = {
    Text = "毎日のチャレンジ"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Name_Content = {
    Text = "タワーの肉鳩"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_NoTask_Content = {
    Text = "空席を待つ"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_EnergyCost_Content = {Text = "行動力"},
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Extra_Content = {
    Text = "追加ボーナス"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_KeeperSkill_Content = {
    Text = "キーエネルギー"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Manual_Content = {
    Text = "手動戦闘"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UltiEnergy_Content = {Text = "狂気"},
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UseCard_Content = {
    Text = "カードを出す"
  },
  PanelText_UI_Dungeons_Trinket_View_Text_C_ActivityAchievement_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Lost_Content = {Text = "未達成"},
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title2_Content = {
    Text = "スコア累計"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title_Content = {
    Text = "このステージの星評価"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Lost_Content = {Text = "未達成"},
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Title_Content = {
    Text = "このステージの星評価"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Null_Content = {
    Text = "編成なし"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Underway_Content = {
    Text = "戦闘データ通信中"
  },
  PanelText_UI_Dungeous_Item_Reward_Text_C_Present_Content = {Text = "現在"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Additional_Content = {
    Text = "今日の報酬は追加で+50% 無制限"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardNum_Content = {
    Text = "今日の2倍報酬受取回数"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardText_Content = {
    Text = "今週の報酬受取回数"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Boundaries_Tips_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Name_Content = {
    Text = "リプレイ"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Recommend_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_2_Content = {Text = "超次元"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Special_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_AwardText_Content = {
    Text = "今週の報酬受取回数"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Award_Content = {
    Text = "敵の情報"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Boundaries_Tips_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Reward_Content = {
    Text = "クリア報酬"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Special_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_Title_Content = {
    Text = "超越存在"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Award_Content = {
    Text = "ボス情報"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Boundaries_Tips_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Difficulty_Content = {
    Text = "沈降深度"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Reward_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Score_Content = {
    Text = "今シーズンの最高得点"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Special_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_RewardShow_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_StrongAwakers_Content = {
    Text = "強化覚醒体"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Suppress_Content = {
    Text = "融災の黒潮"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Remuneration_Content = {
    Text = "キャラクター報酬"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Special_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Hint_Content = {
    Text = "※一度出撃した覚醒体と運命の札は他の融災禁区で再出撃できない。"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Rank_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Title_Content = {
    Text = "融災禁区"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Train_Content = {
    Text = "現在の特訓値"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly_Content = {
    Text = "特訓報酬"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Hint_Content = {
    Text = "※クリア後、出撃済みの覚醒体、運命の札、キーオーダーは他の融災禁区で使用できません。"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Title_Content = {
    Text = "融災禁区"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Train_Content = {
    Text = "現在の特訓値"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Weekly_Content = {
    Text = "特訓報酬"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Extra_Content = {
    Text = "追加クリア編成"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Integral_Content = {
    Text = "クリアポイント"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_LineUp_Content = {
    Text = "クリア編成"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Monster_Content = {Text = "敵情報"},
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Content = {
    Text = "リセット"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Extra_Content = {
    Text = "リセット"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_None_Content = {
    Text = "編成メンバーなし"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Replay_Content = {Text = "記録"},
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Special_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_Extra_None_Content = {
    Text = "挑戦未達成"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Integral_Content = {
    Text = "クリア特訓値"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_LineUp_Content = {
    Text = "クリア編成"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Monster_Content = {
    Text = "怪物情報"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Name_Content = {
    Text = "リセット"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_None_Content = {
    Text = "挑戦未達成"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Special_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Suppress_Content = {
    Text = "融災の黒潮"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Challenge_Content = {Text = "挑戦"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Choose_Content = {
    Text = "選択難易度"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Experience_Content = {
    Text = "優雅室の仕様"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Hard_Content = {Text = "高難度"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Madness_Content = {Text = "狂気"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Normal_Content = {Text = "通常"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Rank_Content = {Text = "VIP名簿"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Record_Content = {
    Text = "沿途の記憶"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "小さな「N」の協力"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Title_Content = {
    Text = "疾走する歓楽特急"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award2_Content = {
    Text = "密境ルール"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award_Content = {
    Text = "敵の詳細"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Boundaries_Tips_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Cost_Tips_Content = {
    Text = "チーム要求："
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Replay_Content = {Text = "記録"},
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Reward_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Special_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Tishi_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award2_Content = {
    Text = "密境ルール"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award_Content = {
    Text = "敵の情報"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Boundaries_Tips_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Cost_Tips_Content = {
    Text = "チーム要求"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Reward_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Special_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Tishi_Content = {
    Text = "星評価進捗："
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Additional_Content = {
    Text = "今日の報酬は追加で+50% 無制限"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_AwardNum_Content = {
    Text = "今日の2倍報酬受取回数"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Boundaries_Tips_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Cw_Content = {Text = "超次元"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Recommend_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Special_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_Name_Content = {
    Text = "リプレイ"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_1_Content = {
    Text = "運命の札未選択"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_2_Content = {
    Text = "左側を押して選択"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_Content = {
    Text = "※同一覚醒体に装備できるSSR運命の札は一つ"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "運命の札を選択"
  },
  PanelText_UI_Dungeous_Popup_FailTip_Text_C_Title_Content = {
    Text = "強化方法"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "星評価報酬"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Title_Content = {
    Text = "スコア統計"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Total_Content = {
    Text = "現在の総合スコア"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Coin_Content = {
    Text = "通貨不足"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Explain_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_RewardPreview_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Swept_Content = {
    Text = "リプレイ回数"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Text_Content = {Text = "必要"},
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Tips_Content = {
    Text = "調査評価が三つ星に達すると解放されます"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_Title_Content = {
    Text = "リプレイ確認"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Deplete_Content = {
    Text = "リプレイ消費"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Swept_Content = {
    Text = "リプレイ回数"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Team_Content = {
    Text = "調査チーム"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Title_Content = {
    Text = "リプレイ確認"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Difficulty_Content = {
    Text = "リセット"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_NoTask_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Prohibit_Content = {
    Text = "このステージでキーオーダー使用禁止"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Skill_Content = {
    Text = "守秘者のスキル"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Title_Content = {
    Text = "挑戦チーム"
  },
  PanelText_UI_Dungeous_Popup_Tips_New_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity2_Content = {
    Text = "初クリア報酬"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity_Content = {
    Text = "初クリア報酬"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game2_Content = {
    Text = "累積報酬"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game_Content = {
    Text = "累積報酬"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Again_Content = {
    Text = "挑戦をリセット"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Boundaries_Tips_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Cw_Content = {Text = "超次元"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Monster_Content = {Text = "敵情報"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Title_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Again_Content = {
    Text = "挑戦をリセット"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Tips_Content = {
    Text = "報酬の詳細"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Title_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Dungeous_illustrate_Tip_Text_C_Title_Content = {
    Text = "闇の境界"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Finish_Content = {
    Text = "イベント終了、保存停止"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Full_Content = {
    Text = "保存上限に達しました"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Reward_Content = {
    Text = "物資を獲得"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_SpeedTitle_Content = {
    Text = "保存速度："
  },
  PanelText_UI_Event_Activity_Castor_Text_None_Content = {
    Text = "物資なし"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Finish_Content = {
    Text = "イベント終了"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Full_Content = {
    Text = "所持量が上限に達しました"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_None_Content = {
    Text = "寄付アイテムなし"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Reward_Content = {
    Text = "アイテム"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "取得速度："
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Finish_Content = {
    Text = "イベント終了"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Full_Content = {
    Text = "現在の保存が上限に達しました"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Reward_Content = {
    Text = "保存情報"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_SpeedTitle_Content = {
    Text = "保存速度"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Finish_Content = {
    Text = "イベント終了、保存停止"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Full_Content = {
    Text = "保存上限に達しました"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Reward_Content = {
    Text = "物資を獲得"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_SpeedTitle_Content = {
    Text = "保存速度："
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_None_Content = {
    Text = "物資なし"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Label_Content = {
    Text = "グレイおばさんの店"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Mail_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Title_Content = {
    Text = "聖堂チャリティ会場"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Finish_Content = {
    Text = "イベント終了、取得停止"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Full_Content = {
    Text = "現在は所持上限に達しています"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Reward_Content = {
    Text = "物資を獲得"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_SpeedTitle_Content = {
    Text = "取得速度"
  },
  PanelText_UI_Event_Activity_Miriam_Text_None_Content = {
    Text = "物資なし"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Finish_Content = {
    Text = "イベント終了、保存停止"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Full_Content = {
    Text = "保存上限に達しました"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Reward_Content = {
    Text = "物資を獲得"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_SpeedTitle_Content = {
    Text = "保存速度："
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_None_Content = {
    Text = "物資なし"
  },
  PanelText_UI_Event_Activity_Pollux_Text_None_Content = {
    Text = "物資なし"
  },
  PanelText_UI_Event_Activity_RewardList_Text_C_Reward_Content = {
    Text = "チャリティリスト"
  },
  PanelText_UI_Event_Activity_RewardPool_Text_C_Name_Content = {
    Text = "リセット"
  },
  PanelText_UI_Event_Activity_RewardPool_Text_Name_Content = {
    Text = "全部交換"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Close_Content = {
    Text = "空白タップで戻る"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_CoreReward_Content = {
    Text = "特殊種子"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Result_Content = {
    Text = "交換結果"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_C_Desc_Content = {
    Text = "主人も今日、ガレンと一緒に掃除を手伝ってくれるの？素晴らしい、これはガレンのほんの小さな気持ちですので、どうか主人には受け取ってもらいたい！"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_1_Content = {
    Text = "受け取り済み"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_2_Content = {
    Text = "受け取り済み"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_3_Content = {
    Text = "受け取り済み"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_4_Content = {
    Text = "受け取り済み"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_5_Content = {
    Text = "受け取り済み"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_6_Content = {
    Text = "受け取り済み"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_7_Content = {
    Text = "受け取り済み"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Title_Content = {
    Text = "ガレンの謝礼"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_C_Desc_Content = {
    Text = "太陽、砂浜、波、そしてあふれる笑顔。ひと夏の夢の中で、元気いっぱいビーチバレーボール大会を楽しもう！"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_Title_Content = {
    Text = "夏の狂宴"
  },
  PanelText_UI_Event_Activity_SummonBenefits_Text_C_Summon_Content = {
    Text = "無料召喚"
  },
  PanelText_UI_Event_Activity_Thing_Item_Text_C_Sold_Out_Content = {
    Text = "売り切れ"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Finish_Content = {
    Text = "イベント終了、保存停止"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Full_Content = {
    Text = "貯蔵物質が上限に達しました"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Reward_Content = {
    Text = "貯蔵物質"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_SpeedTitle_Content = {
    Text = "貯蔵速度:"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "大脳辺縁系"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_None_Content = {
    Text = "物資なし"
  },
  PanelText_UI_Event_Activity_XiaomaoGift_Text_C_Receive_Content = {
    Text = "残り召喚回数："
  },
  PanelText_UI_Event_Challenge_Item_Text_C_Finish_Content = {
    Text = "前回クリア"
  },
  PanelText_UI_Event_Item_Return_Text_C_Close_Content = {
    Text = "画面を押して閉じる"
  },
  PanelText_UI_Event_Item_Return_Text_C_Finish_Content = {
    Text = "受領済み"
  },
  PanelText_UI_Event_Item_SignDay_Text_C_CanReceive_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Event_Item_SignDay_Text_C_Got_Content = {
    Text = "受け取り済み"
  },
  PanelText_UI_Event_Item_SignDay_Text_C_Nor_Content = {
    Text = "受け取り待ち"
  },
  PanelText_UI_Event_Item_WeaponOptional_Text_C_Got_Content = {
    Text = "所有済み"
  },
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Title_Content = {
    Text = "聖堂エリア"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Introduction_Content = {
    Text = "ふぅ……深呼吸で触手をリラックスさせて。今から「24」の意識の奥深くに潜り、隠された記憶を探る……"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "記憶の収集"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Awaker_Content = {
    Text = "試用覚醒体"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_FristCreation_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Leader_Content = {
    Text = "ボス情報"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Record_Content = {Text = "挑戦"},
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_StarTitle_Content = {
    Text = "星評価目標"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Title_Content = {
    Text = "脚本の謎"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Creation_Content = {
    Text = "特殊アイテム"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Double_Content = {
    Text = "ダブルチャレンジ"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_FristCreation_Content = {
    Text = "初期遺物"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Leader_Content = {
    Text = "ボス情報<WordSize20:>"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_MeltErosion_Content = {
    Text = "融災の黒潮"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Monster_Content = {
    Text = "怪物情報"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Record_Content = {Text = "挑戦"},
  PanelText_UI_Event_Panel_Challenge_Text_C_RemainNum_Content = {
    Text = "残存分身の数"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Replay_Content = {Text = "記録"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Event_Panel_Challenge_Text_C_RewardTitle_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_SweepName_Content = {Text = "掃討"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Title_Content = {
    Text = "脚本の謎"
  },
  PanelText_UI_Event_Panel_Challenge_Text_Career_Content = {
    Text = "界域1を要求"
  },
  PanelText_UI_Event_RewardGroup_Text_C_Reset_Content = {
    Text = "残りリセット回数："
  },
  PanelText_UI_Event_Reward_Item_Text_C_Not_Content = {Text = "未達成"},
  PanelText_UI_Event_Reward_Item_Text_C_Receive_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Event_Task_Item_Text_C_Not_Content = {Text = "未達成"},
  PanelText_UI_Event_Task_Item_Text_C_Receive_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Event_WeaponOptional_Text_C_Receive_Content = {
    Text = "残り召喚回数："
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Introduction_Content = {
    Text = "来、狂気、殺戮、痛みを音符にし、この星々の間で輝くレクイエムを奏でよう。\nその愚かな混沌の至高存在は、目覚めるべきではない、今も、未来も。"
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Title_Content = {
    Text = "辰星レクイエム"
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Introduction_Content = {
    Text = "神の約束がもうすぐ近づいている。\n数千年の待機が歓喜の終局を迎え、約束の地が海から浮かび上がるだろう。\n神は神母の胸腔から蘇生し、七日の終結の時、新しい世界が降臨するだろう。"
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Title_Content = {
    Text = "創生の七日間"
  },
  PanelText_UI_Events_Item_Castor_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Castor_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_Free_Content = {Text = "無料"},
  PanelText_UI_Events_Item_GiftBag_Text_C_High_Content = {Text = "無料"},
  PanelText_UI_Events_Item_GiftBag_Text_C_Noraml_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_Soldout_Content = {
    Text = "受領済み"
  },
  PanelText_UI_Events_Item_Hamline_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Hamline_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Fall_Content = {
    Text = "ドロッププレビュー"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Killed_Content = {
    Text = "キルした！"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Progress_Content = {
    Text = "チャレンジ可能"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Full_Content = {
    Text = "霊知啓発完了"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Have_Content = {
    Text = "所有済み"
  },
  PanelText_UI_Events_Item_OriDoll_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_OriDoll_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_PreOrderGift_Text_C_Lock_Content = {
    Text = "購入後、受け取ることができます"
  },
  PanelText_UI_Events_Item_RAIDProgressGroup_Text_C_Kill_Content = {
    Text = "捕獲総数"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Career_Content = {
    Text = "チーム要求"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Finish_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Kill_Content = {
    Text = "捕獲済み"
  },
  PanelText_UI_Events_Item_RAID_Text_CareerLimit_Content = {
    Text = "制限なし"
  },
  PanelText_UI_Events_Item_RAID_Text_Lock_Content = {Text = "未開放"},
  PanelText_UI_Events_Item_Rome_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Rome_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_SignDiamond_Text_C_Receive_Content = {
    Text = "受領済み"
  },
  PanelText_UI_Events_Item_Sorel_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Sorel_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_NormalTip_Content = {
    Text = "普通難易度未クリア"
  },
  PanelText_UI_Events_Item_SurveyDiary_Text_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Events_Item_Tab_Text_C_Return_Content = {
    Text = "復帰イベント"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Career_Content = {
    Text = "チーム要求"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Finish_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_CareerLimit_Content = {
    Text = "制限なし"
  },
  PanelText_UI_Events_Item_Tulu_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_Tulu_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_LockTips_Content = {
    Text = "特務記録の前提ステージを完了して解放"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_Fall_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Killed_Content = {
    Text = "排除されました！"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Progress_Content = {
    Text = "残存分身の数"
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "身体を捨て、理性を捨て、この純粋な意志の世界において、彼の存在を感じなさい。\n彼はあなたの唯一の存在です。彼はあなたの全てです。"
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Title_Content = {
    Text = "異動の海潮"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Introduction_Content = {
    Text = "大きく口を開け、貪るように噛み砕く。\n喰うか、喰われるか。\nこれが戦いの掟であり、獣の定めだ。"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Title_Content = {
    Text = "獣の本能"
  },
  PanelText_UI_Events_OriHelot_Text_C_Fall_Content = {
    Text = "ドロップ情報"
  },
  PanelText_UI_Events_OriHelot_Text_C_LockTips_Content = {
    Text = "ステージ解放のヒント"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_Challenge_Content = {
    Text = "辰星レクイエム"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_ProgressTitle_Content = {
    Text = "世界キル進行"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Ordinary_Content = {
    Text = "通常紀行"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_PassportUp_Content = {
    Text = "上級紀行解放"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Senior_Content = {
    Text = "上級紀行"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_illustrate_Content = {
    Text = "イベント説明"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_PayTip_Content = {
    Text = "現在の表示されている価格はデフォルト通貨での参考価格です。お支払いの際は、実際の通貨と価格をご確認ください。"
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Introduction_Content = {
    Text = "照明が灯る。拍手が静まる。観客たちが待ち望んでいる。\n舞台に上がる時が来た、我が愛しき子どもたちよ。登壇せよ、演じよ、己の肺腑を引き裂き、最も深い秘密を売り渡せ。最も凄惨な傷口を、人々を悦ばせる甘美なデザートに仕立て上げよ。舞台の上でお前だけのために灯されたあの光を貪欲に味わい尽くせ、幕がお前と観客もろとも葬り去るその時まで。\nこれはお前たちに定められた舞台だ、上がるがいい！恐れるな、怯むことなかれ。"
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Title_Content = {
    Text = "人形の舞台"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Challenge_Content = {
    Text = "人形の舞台"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Shop_Content = {
    Text = "劇場ギフトショップ"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Topic_Content = {
    Text = "織者自縛"
  },
  PanelText_UI_Events_Panel_Attendance_Text_C_GiftTitle_Content = {
    Text = "任務を完了して幻衣交換券を受け取る"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_1_Content = {
    Text = "幻夢の深奥"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_2_Content = {Text = "対人戦"},
  PanelText_UI_Events_Panel_Award_Text_C_Award_Content = {
    Text = "幻夢の深奥"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Over_Content = {
    Text = "守秘者経験値を獲得："
  },
  PanelText_UI_Events_Panel_Award_Text_C_Title_Content = {
    Text = "守秘者経験値を獲得："
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Not_Unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Shop_Content = {
    Text = "復帰商店"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Challenge_Content = {
    Text = "聖堂の道"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Finish_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Fundraising_Content = {
    Text = "市民の善意"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Not_unlocked_Content = {
    Text = "<Gray:未解放>"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Pv_Content = {
    Text = "夢を遡る"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Record_Content = {Text = "血の色"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Resonance_Content = {
    Text = "共鳴：魂の分岐点"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Shop_Content = {
    Text = "聖堂チャリティ会場"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Topic_Content = {
    Text = "霊魂の牧人・復刻"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Award_Content = {
    Text = "期間限定報酬"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Limit_Content = {
    Text = "調査報酬"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Over_Content = {
    Text = "すべての報酬を受け取りました"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Pass_Content = {
    Text = "クリア報酬"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Title_Content = {
    Text = "報酬情報"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Introduction_Content = {
    Text = "♪~~♫~~♪~~♫~~♪~~♫~~\n雪山のふもとで、すべての案内人が覚えており、すべての子供たちが歌い継いでいる。それは雄大な雪山の意志の化身、慈悲深き神女ウマーパティ。\n彼女の神力は人の世に散り、彼女の宝物はどこにも見つからず、それらは手の届くところにあり、それらは跡形もなく消えている。何かを諦め、何かを貫け。\n神女の真の姿に誠意なき者は、死した雪山とともに、永遠に雪山に葬られるだろう。"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Title_Content = {
    Text = "ウマーパティの宝物"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Challenge_Content = {
    Text = "ウマーパティの宝物"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Shop_Content = {
    Text = "仙女典礼"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Topic_Content = {
    Text = "新月と深雪"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Introduction_Content = {
    Text = "鳥の生涯は、自由であることを運命づけられている。見よ、殻を破るその瞬間を。それは、死の手から「生」という自由を奪い返す姿だ。見よ、飛翔を学ぶその時を。それは、温かな巣の安らぎから、独り生き抜く力を取り戻す姿だ。もし今、自由の鍵が死の淵へと投げ入れられたなら、鳥は迷うことなくその身を投じるだろう。窮屈な生よりも無限の自由を選び、死という名の暴風に真っ向から立ち向かうのだ。"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Title_Content = {
    Text = "青空を越えて"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定改正"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Challenge_Content = {
    Text = "青空を越えて"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Finished_Content = {Text = "終了"},
  PanelText_UI_Events_Panel_Castor_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Castor_Text_C_Receive_Content = {
    Text = "受け取り可能まで："
  },
  PanelText_UI_Events_Panel_Castor_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Resonance_Content = {
    Text = "共鳴：山脈の呑み込み"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Shop_Content = {
    Text = "求知の願い"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Topic_Content = {
    Text = "鏡に映る囚人"
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Introduction_Content = {
    Text = "あれ以来、彼女が涙を流すことは二度となかった。\n異形の者たちがあふれる世界を、たった一人、あてもなく彷徨い続ける。\n壮大な計画がまもなく始まる。それは、彼女にとっての終幕であり、最後の別れ。\n彼女は最高の精神科医であり、そしてこれは、彼女が成し遂げた最も偉大なる「治療」であった。"
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Title_Content = {
    Text = "不安の緩和"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Challenge_Content = {
    Text = "不安の緩和"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Finished_Content = {Text = "終了"},
  PanelText_UI_Events_Panel_Clementine_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Clementine_Text_C_Receive_Content = {
    Text = "受け取り可能まで："
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Record_Content = {
    Text = "意識潜行"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Resonance_Content = {
    Text = "共鳴：なし"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Shop_Content = {
    Text = "神経診療室"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Topic_Content = {
    Text = "記憶の底に埋もれて"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Empty_Content = {
    Text = "全報酬を獲得済み"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Lottery_Content = {Text = "1回抽選"},
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Rate_Content = {
    Text = "確率説明"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Tip_Content = {
    Text = "<color=#e3c96e>銀枢幻衣</color>は<color=#e3c96e>5</color>回目の抽選から獲得するチャンス！"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Topic_Content = {
    Text = "魂の羊飼い"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_Free_Content = {Text = "無料"},
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Introduction_Content = {
    Text = "この海辺の小さな町には、賑やかな商店街があります。\n\n海上貿易のおかげで、ここには最新の百貨が集まっており、十分な金銭を支払えば、必ず満足のいく商品が手に入ります。\n\nただし、街角の小さな店だけは例外で、そこは不思議な骨董品でいっぱいの小さな店です。\n\n煙管から吐き出される煙の中で、つば広帽子をかぶった女主人が、ゆっくりと微笑みを浮かべます。\n\n「ようこそ、解憂商店へ。ここではあなたの、すべての要望をなんでも満たすことができますよ。……十分な報酬を支払えばですが」\n\n「もちろん、公正な価格で誰にでも公平ですわ」"
  },
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Title_Content = {
    Text = "魔女の店"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Challenge_Content = {
    Text = "魔女の店"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Resonance_Content = {
    Text = "共鳴：白銀の顎"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Shop_Content = {
    Text = "魔女の宝庫"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Topic_Content = {
    Text = "雨の町に潜む影"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Introduction_Content = {
    Text = "弦楽器は天上に昇り、第十三の鐘の音が鳴り響いた。\n今夜、詩人のナイフが私たちのために賛美を奏でるだろう。\n今夜、母の喉が私たちを抱きしめてくれる。"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Title_Content = {
    Text = "霊の饗宴"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Challenge_Content = {
    Text = "霊の饗宴"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Finished_Content = {Text = "終了"},
  PanelText_UI_Events_Panel_Doresain_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Doresain_Text_C_Receive_Content = {
    Text = "受け取り可能まで："
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Record_Content = {
    Text = "派遣記録"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Resonance_Content = {
    Text = "共鳴：山脈の呑み込み"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Shop_Content = {
    Text = "王邸レストラン"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Topic_Content = {
    Text = "死霊の美学"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Ordinary_Content = {
    Text = "通常紀行"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_PassportUp_Content = {
    Text = "上級紀行解放"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Senior_Content = {
    Text = "上級紀行"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_illustrate_Content = {
    Text = "イベント説明"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Introduction_Content = {
    Text = "宙を舞う指揮棒の先から、轟音が響く。\n長き夢に沈め……破滅の終章まで。"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Title_Content = {
    Text = "轟音の響き"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Challenge_Content = {
    Text = "轟音の響き"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Hamline_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Resonance_Content = {
    Text = "共鳴：なし"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Shop_Content = {
    Text = "安眠宮殿"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Topic_Content = {
    Text = "無形の交響曲"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Introduction_Content = {
    Text = "荒れ果てた温室。\n孤独な薔薇が囚われている。"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Title_Content = {
    Text = "花園の記憶"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Challenge_Content = {
    Text = "花園の記憶"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Horla_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Resonance_Content = {
    Text = "共鳴：花園の挽歌"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Shop_Content = {
    Text = "コレットの温室"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Topic_Content = {
    Text = "春が散る前に"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Reward_Content = {
    Text = "埃払い手当"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Sign_Content = {
    Text = "ガレンの謝礼"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Task_Content = {
    Text = "掃除進捗"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Topic_Content = {
    Text = "掃除の奇旅"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Introduction_Content = {
    Text = "彼女は再び大地に立ち、すべてを焼き尽くす復讐が訪れた。\n\nそれは終わることのない追跡、それは爆燃の主の灼熱である。\n\n彼女はすべての隅々を渡り歩き、死神と契約を交わした者を狩る。\n\n逃げろ、逃げろ、より深い闇へ逃げろ、自分が見つからないと思っている場所へ逃げろ。\n\nそれは無意味だが、彼は必ずすべての世界を踏み越えるだろう。\n\n彼はすべてを狩り尽くし、すべてが灰燼と化すまで。"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Title_Content = {
    Text = "灰燼の追跡"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Challenge_Content = {
    Text = "灰燼の追跡"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Finished_Content = {Text = "終了"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Record_Content = {
    Text = "意識潜行"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Resonance_Content = {
    Text = "共鳴：山脈の呑み込み"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Shop_Content = {
    Text = "隠れた拠点"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Topic_Content = {
    Text = "降り注ぐ無数の輝き"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Describe_Content = {
    Text = "あなたが目にしたのは、魂の選択だけではない。それは、揺れ動く人生そのものだ。"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Lake_City_Text_C_Title_Content = {
    Text = "聖堂の道"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Introduction_Content = {
    Text = "ドールの任務は簡単にはいかない。\n彼女が何度も「楽しんで」と、念を押しても、初めて集団の覚醒体達を連れて外出するのは、守秘者にとっては緊張の連続だ。\nでも「楽しんで」を忘れないで。"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Title_Content = {
    Text = "脚本の謎"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Challenge_Content = {
    Text = "脚本の謎"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Pv_Content = {
    Text = "映像を再生"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Resonance_Content = {
    Text = "共鳴：監督の演出指示"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Shop_Content = {
    Text = "魔法の脚本屋"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Topic_Content = {
    Text = "物語の魔法・復刻"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Introduction_Content = {
    Text = "力、権力、金、自由……リヴァイアサンの大地において、祂はあなたが望むすべてを与えるだろう。\nさえすれば、最後まで立っていられる者になれる。"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Title_Content = {
    Text = "貪戮の角逐"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Challenge_Content = {
    Text = "貪戮の角逐"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Record_Content = {
    Text = "意識潜行"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Shop_Content = {
    Text = "闘技場の祭壇"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Topic_Content = {
    Text = "リヴァイアサンの遊戯"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Challenge_Content = {
    Text = "脚本の謎"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Desc_Content = {
    Text = "ドールの任務は簡単にはいかない。\n彼女が何度も「楽しんで」と、念を押しても、初めて集団の覚醒体達を連れて外出するのは、守秘者にとっては緊張の連続だ。\nでも「楽しんで」を忘れないで。"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Own_Content = {
    Text = "現在所持"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Resonance_Content = {
    Text = "共鳴：監督の演出指示"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Shop_Content = {
    Text = "魔法の脚本屋"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Topic_Content = {
    Text = "物語の魔法"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentActivity_Content = {
    Text = "記憶の回廊"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentRule_Content = {
    Text = "記憶の回廊"
  },
  PanelText_UI_Events_Panel_Main_Text_C_Pv_Content = {
    Text = "映像を再生"
  },
  PanelText_UI_Events_Panel_Main_Text_C_SevenDays_Content = {
    Text = "7日間サインイン"
  },
  PanelText_UI_Events_Panel_Main_Text_C_illustrate_Content = {
    Text = "イベント説明"
  },
  PanelText_UI_Events_Panel_Main_Text_Title_Content = {
    Text = "イベント"
  },
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Introduction_Content = {
    Text = "この困難で神聖な道を進め。道の終わりで、最後の扉が開かれるだろう。"
  },
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Title_Content = {
    Text = "神国の降臨"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Challenge_Content = {
    Text = "神国の降臨"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Miriam_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Resonance_Content = {
    Text = "共鳴：海淵の祭儀"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Shop_Content = {
    Text = "深淵の応答"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Topic_Content = {
    Text = "深淵の祀り"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Introduction_Content = {
    Text = "空は〜晴れ渡り〜海は〜穏やか〜\nモスク〜友達〜小さな石炭球〜出航！\n嵐、怖くない、雷、怖くない、モスク、友達、小さな石炭球〜\n自由のために、出·発·しよう"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Title_Content = {
    Text = "モスクと海"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Challenge_Content = {
    Text = "モスクと海"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Record_Content = {
    Text = "溺れ沈む"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Shop_Content = {
    Text = "モスクの宝庫"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Topic_Content = {
    Text = "メスクスの呼び声"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Introduction_Content = {
    Text = "突然ある日、あなたは自分が変わったことに気づいた。\n誰もそのことに気づいていない。なぜなら、あなたは同じ行動、同じ美しい容姿を持っているから。\nしかし、あなたはよくわかっている。その鮮やかな赤い心は、霧でできた仮面に覆われてしまった。\n「もし私がずっと偽装し続けられたら、私は以前の私であり続けるのだろうか？」\n嬉しいことに、この疑問はあなたの脳内に一秒以上留まることはなかった。結局、その仮面を剥がす前に、誰もあなたの本当の考えを知らない。\n「じゃあ、出発しよう〜」"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Title_Content = {
    Text = "迷子の自分"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Challenge_Content = {
    Text = "迷子の自分"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Record_Content = {
    Text = "多次元接続"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Resonance_Content = {
    Text = "共鳴：白銀の顎"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Shop_Content = {
    Text = "茉夏の小屋"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Topic_Content = {
    Text = "霧境の燔礼"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Introduction_Content = {
    Text = "神は@1暗闇の@2の中、偉大な@3世界に降臨する。"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Title_Content = {
    Text = "暗き胎内"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Challenge_Content = {
    Text = "暗き胎内"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Homology_Content = {
    Text = "イベント期間中、すべての方法で獲得する同調率が2倍！"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Pv_Content = {
    Text = "映像を再生"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Record_Content = {
    Text = "薔薇の讃歌"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Shop_Content = {
    Text = "聖胎孵化"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Topic_Content = {
    Text = "星辰の正位置・復刻"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Challenge_Content = {
    Text = "異動の海潮"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_GiftTitle_Content = {
    Text = "任務を完了して幻衣交換券を受け取る"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_ProgressTitle_Content = {
    Text = "異動海潮の撃破進捗"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Topic_Content = {
    Text = "神国が浮上する"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Introduction_Content = {
    Text = "彼女は世界の果ての大きな扉を見つめ、ためらうことなく一歩を踏み出した。\nカチッ、彼女はドアノブを回し、急いでドアの向こうを覗いた。\nしかし、ドアの向こうには何もなく、彼女は空間を踏み外し、虚無に落ちていった。\n彼女は早くに気づくべきだった、贈り物はあまりにも直接であれば、必ず高い代価が伴うのだから。"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Title_Content = {
    Text = "虚無の扉"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Challenge_Content = {
    Text = "虚無の扉"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_OriDoll_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Record_Content = {
    Text = "意識潜行"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Resonance_Content = {
    Text = "共鳴：なし"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Shop_Content = {
    Text = "師の教え"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Topic_Content = {
    Text = "一歩の隔たり"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Challenge_Content = {
    Text = "獣の本能"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_OriHelot_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Resonance_Content = {
    Text = "共鳴：白銀の顎"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Shop_Content = {
    Text = "山嶺の大穴"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Topic_Content = {
    Text = "雪解けの刻・復刻"
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Introduction_Content = {
    Text = "神の約束がもうすぐ近づいている。\n数千年の待機が歓喜の終局を迎え、約束の地が海から浮かび上がるだろう。\n神は神母の胸腔から蘇生し、七日の終結の時、新しい世界が降臨するだろう。"
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Title_Content = {
    Text = "創生の七日間"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Challenge_Content = {
    Text = "創生の七日間"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Receive_Content = {
    Text = "受け取り可能まで："
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Shop_Content = {
    Text = "神母の寝殿"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Topic_Content = {
    Text = "神の誕生の儀式"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_ChallengeTip_Content = {
    Text = "期間限定コラボ"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Challenge_Content = {Text = "対人戦"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Record_Content = {
    Text = "逆転回合"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Resonance_Content = {
    Text = "共鳴：白銀の顎"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Shop_Content = {
    Text = "ショップ名"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Topic_Content = {
    Text = "雨の町に潜む影"
  },
  PanelText_UI_Events_Panel_PermanentActivity_Text_C_Reward_Content = {
    Text = "残りの報酬"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Introduction_Content = {
    Text = "理性と崩壊の間で、奇怪な絵巻が静かに紐解かれていく。あなたが軽蔑する幻覚は、絢爛たる色彩を描き出し、あなたが恐れる暴走は、忠実なる形を成す。ここでは、狂気こそが芸術の本能であり、世界の根源であり、唯一、嘘をつかぬ真実そのものなのだ。"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Title_Content = {
    Text = "異界図巻"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Challenge_Content = {
    Text = "異界図巻"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Record_Content = {
    Text = "意識潜行"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Resonance_Content = {
    Text = "共鳴：山脈の呑み込み"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Shop_Content = {
    Text = "ピックマンのアトリエ"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Topic_Content = {
    Text = "キャンバスの暗面"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Introduction_Content = {
    Text = "あの恨みと愛情、温かさと傷つけ、持っていたものと逃したものは、もう絡み合い解けない。\n同じ骨肉を流しましょう、それらは一つに集まって、私たちの切り離せない運命を形成します。"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Title_Content = {
    Text = "交わる苦き血"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Challenge_Content = {
    Text = "交わる苦き血"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Receive_Content = {
    Text = "受け取り可能まで："
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Record_Content = {
    Text = "空の彼方・下"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Resonance_Content = {
    Text = "共鳴：山脈の呑み込み"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Shop_Content = {
    Text = "祝福の儀式"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Topic_Content = {
    Text = "白夜の終わり"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Introduction_Content = {
    Text = "不吉な白い光が再び高所の窓を貫くとき、彼はすでにあなたへの招待を送り出している。\n包容、飲み込み、巻き込み、押し合い…………\n海の深みからの呼びかけに応え、この果てなき高所巡狩に加われ、あなたの過去、あなた自身、すべてはもはや関係ない。"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Title_Content = {
    Text = "高所巡狩"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Challenge_Content = {
    Text = "高所巡狩"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Record_Content = {
    Text = "意識潜行"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Shop_Content = {
    Text = "無辺の狩場"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Topic_Content = {
    Text = "永遠のエポヤンス"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Challenge_Content = {
    Text = "猫海淘銀"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Rank_Content = {
    Text = "捕獲ランキング"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Reward_Content = {
    Text = "黒猫捕獲記録"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Topic_Content = {
    Text = "猫の「恩返し」"
  },
  PanelText_UI_Events_Panel_RailWay_StageGroup_Text_C_Title_Content = {
    Text = "列車出発"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Challenge_Content = {
    Text = "列車出発"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Rank_Content = {Text = "VIP名簿"},
  PanelText_UI_Events_Panel_RailWay_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "小さな「N」の協力"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Reward_Content = {
    Text = "専用列車軌跡"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Topic_Content = {
    Text = "疾走する歓楽特急"
  },
  PanelText_UI_Events_Panel_Reward_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Events_Panel_Reward_Text_Title_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Introduction_Content = {
    Text = "我らは肉を食らう者、狼の末裔だ。あの美味なる、鮮血滴る肉塊は、いずれ我らの胃袋に収まる定めにある。"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Title_Content = {
    Text = "神聖な狩り"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Challenge_Content = {
    Text = "神聖な狩り"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Finished_Content = {Text = "終了"},
  PanelText_UI_Events_Panel_Rome_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Rome_Text_C_Receive_Content = {
    Text = "受け取り可能まで："
  },
  PanelText_UI_Events_Panel_Rome_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Resonance_Content = {
    Text = "共鳴：山脈の呑み込み"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Shop_Content = {
    Text = "貢物の献上"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Topic_Content = {
    Text = "ローマ！特別イベント"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Introduction_Content = {
    Text = "今どき普通の探偵じゃダメだ。\n空を飛び、地に潜る！\n天才科学者が君の助手だ！\nもし、どれも無いのなら……\n転職するよりほかないね。"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Title_Content = {
    Text = "月夜の伝説"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Challenge_Content = {
    Text = "月夜の伝説"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Homology_Content = {
    Text = "イベント期間中、すべての方法で獲得する同調率が2倍！"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Pv_Content = {
    Text = "映像を再生"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Record_Content = {
    Text = "良き狩りを！"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Shop_Content = {
    Text = "幸運倶楽部"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Topic_Content = {
    Text = "名探偵マニュアル・復刻"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Introduction_Content = {
    Text = "科学は、取るに足らない。\n倫理は、取るに足らない。\n道徳は、取るに足らない。\n生命、死、希望、絶望……すべての結論として、地下室のノートには、2つの筆跡で同じ結論が記されていた。\n\nそれらは言っている——\n「見よ、愛こそが唯一にして永遠のテーマである」と。"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Title_Content = {
    Text = "隠し部屋の手記"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定オープン"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Challenge_Content = {
    Text = "隠し部屋の手記"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Record_Content = {
    Text = "忘れられた愛の種子"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Reward_Content = {
    Text = "実績報酬"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Shop_Content = {
    Text = "タンポポの苗床"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Topic_Content = {
    Text = "流転の新生"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Introduction_Content = {
    Text = "あの時から幾年も経ったある黄昏、伝記作家が彼女の家を訪ねた。\n\nその日、二人は多くを語り合った。\n瑪瑙の石のこと、薔薇が散った邸宅のこと……\n\nそして今、作家はこれらの断片的な言葉を本にまとめ、皆様に捧げる。"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Title_Content = {
    Text = "薔薇の記憶"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Challenge_Content = {
    Text = "薔薇の記憶"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Homology_Content = {
    Text = "イベント期間中、すべての方法で獲得する同調率が2倍！"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Pv_Content = {
    Text = "映像を再生"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Record_Content = {
    Text = "薔薇の讃歌"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Shop_Content = {
    Text = "金紅祭典"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Topic_Content = {
    Text = "薔薇の書"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Limit_Content = {
    Text = "調査報酬"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Over_Content = {
    Text = "すべての報酬条件を達成した"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Pass_Content = {
    Text = "クリア報酬"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Title_Content = {
    Text = "この覚醒体の試遊完了で報酬獲得"
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Introduction_Content = {
    Text = "古い六分儀は星の角度を測り、古びた海図は航路を描き、ボロボロのコンパスが進むべき方向を示す……\nたとえ深く、凍てつく黒い海の中にあろうとも、探索者たちはそのありふれた銅と鉄の道具で、人々のために道を指し示す。\nどうか、すべての導き手が迷いに囚われませんように。"
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Title_Content = {
    Text = "深海漂流"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Challenge_Content = {
    Text = "深海漂流"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Finished_Content = {Text = "終了"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Record_Content = {
    Text = "最後の誘導"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Resonance_Content = {
    Text = "共鳴：山脈の呑み込み"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Shop_Content = {
    Text = "船員の秘宝"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Topic_Content = {
    Text = "暴雨の中で揺れ動く"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Introduction_Content = {
    Text = "友情第一、勝負は二の次——なんてね！\n灼熱の太陽の下で汗を流し、優勝を目指せ！"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Title_Content = {
    Text = "ビーチバレーボール大会"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Challenge_Content = {
    Text = "ビーチバレーボール大会"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Finished_Content = {Text = "終了"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Receive_Content = {
    Text = "受け取り可能まで："
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Resonance_Content = {
    Text = "共鳴：山脈の呑み込み"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Shop_Content = {
    Text = "海辺の旅館"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Sign_Content = {
    Text = "夏の狂宴"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Topic_Content = {
    Text = "夏の特別イベント·上"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Introduction_Content = {
    Text = "暖かい日差しの下、すべてがとても温かく幸せです。\nあなたは、おとぎ話の本のように青い空を見上げて、キャンバスを手で引き裂き、虚偽の世界から這い出すことを決意しました。"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Progress_Content = {
    Text = "星評価進捗："
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Title_Content = {
    Text = "日差しの下の新しい出来事"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Challenge_Content = {
    Text = "日差しの下の新しい出来事"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Record_Content = {
    Text = "異夢視界"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Resonance_Content = {
    Text = "共鳴：山脈の呑み込み"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Shop_Content = {
    Text = "学生会館"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Topic_Content = {
    Text = "すべてがいつも通りなら"
  },
  PanelText_UI_Events_Panel_SurveyDiary_Text_C_Return_Content = {
    Text = "帰校報酬"
  },
  PanelText_UI_Events_Panel_Task_Text_C_OneKeyName_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Events_Panel_Task_Text_Title_Content = {
    Text = "掃除進捗"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Introduction_Content = {
    Text = "窮地の門を越え、無限の知恵の領域に到達する。\n冒涜の者に直面し、「自分」とは何かを悟る。\nそれは彼があなたに授ける《最終試験》だ。"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Title_Content = {
    Text = "最終テスト"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Challenge_Content = {
    Text = "最終テスト"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Resonance_Content = {
    Text = "共鳴：白銀の顎"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Topic_Content = {
    Text = "万象の門"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Challenge_Content = {
    Text = "群猫の乱舞"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Tip_Content = {
    Text = "毎日異なる校猫ステージが開放され、挑戦に成功すると豊富な報酬を獲得できます！"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Topic_Content = {
    Text = "ウサネコのルール"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Describe_Content = {
    Text = "時間は巡り、枯れた花は再び咲く。"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Title_Content = {
    Text = "波乱の情欲"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Challenge_Content = {
    Text = "波乱の情欲"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Homology_Content = {
    Text = "イベント期間中、すべての方法で獲得する同調率が2倍！"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Pv_Content = {
    Text = "映像を再生"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_RecordTip_Content = {
    Text = "期間限定割引解放"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Record_Content = {
    Text = "繁栄狂宴"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Shop_Content = {
    Text = "業の芽生え"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Topic_Content = {
    Text = "欲望の波"
  },
  PanelText_UI_Events_Panel_Try_Text_C_Fail_Content = {Text = "未完了"},
  PanelText_UI_Events_Panel_Try_Text_C_Summon_Content = {Text = "召喚へ"},
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Introduction_Content = {
    Text = "祈り、奉献、犠牲、人類の深遠さは、彼にとってただの騒がしい茶番に過ぎない。\nしかしその茶番は、時折神王の瞳や心に痕跡を残すこともある。"
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Title_Content = {
    Text = "深海凝視"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Challenge_Content = {
    Text = "深海凝視"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Tulu_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Record_Content = {
    Text = "戴冠の日"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Resonance_Content = {
    Text = "共鳴：白銀の顎"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Shop_Content = {
    Text = "意識の深淵"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Topic_Content = {
    Text = "神王の復活"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Challenge_Content = {
    Text = "記憶の収集"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Fill_Up_Content = {
    Text = "(保存上限まで："
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finish_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Not_unlocked_Content = {
    Text = "<Gray:未解放>"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Pv_Content = {
    Text = "映像を再生"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Record_Content = {
    Text = "静かな分裂"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Resonance_Content = {
    Text = "共鳴：解離性症候群"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Topic_Content = {
    Text = "多重治療・復刻"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Describe_Content = {
    Text = "イサラウ、湖中の城……その場所はワンダの故郷と言い伝えられている。\n今、あなたは夢の門をくぐり抜け、無数の鐘が鳴り響く、古の塔群へと辿りつく……"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Resonance_Content = {Text = "共鳴"},
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Title_Content = {
    Text = "湖中の城"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Can_Unlockable_Content = {
    Text = "受け取り可能"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Challenge_Content = {
    Text = "湖中の城"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Fill_Up_Content = {
    Text = "(補充まで："
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Finished_Content = {
    Text = "終了済み"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Not_unlocked_Content = {Text = "未解放"},
  PanelText_UI_Events_Panel_Wanda_Text_C_Pv_Content = {
    Text = "映像を再生"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Receive_Content = {
    Text = "受け取り可能まで"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_RecordTip_Content = {
    Text = "期間限定無料解放"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Record_Content = {
    Text = "燃える饗宴"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Resonance_Content = {
    Text = "共鳴：代行の密令"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Shop_Content = {
    Text = "ワンダの秘宝箱"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Topic_Content = {
    Text = "燃える饗宴"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Challenge_Content = {
    Text = "辰星レクイエム"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_ProgressTitle_Content = {
    Text = "再戦原初の進捗"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Rank_Content = {
    Text = "栄誉名簿"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Record_Content = {
    Text = "特務記録"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Topic_Content = {
    Text = "決戦：原初の影"
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Introduction_Content = {
    Text = "愛から生まれる恨み、恨みから生まれる憎しみ、粘り気があり、連綿として、陰鬱な…………\n天に求めても応えず、地に逃げ道はなく、だからこそ夜霧に隠れた笑い声があなたの呼びかけに応えた。あなたは何の代償も支払う必要がない。\n彼女を見つめ、彼女に従い、彼女と溶け合い、彼女になる。"
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Title_Content = {
    Text = "玄女無相"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_ChallengeTip_Content = {
    Text = "プレイ期間限定開催"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Challenge_Content = {
    Text = "玄女無相"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_RecordTip_Content = {
    Text = "期間限定無料開放"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Record_Content = {
    Text = "意識潜行"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Reward_Content = {
    Text = "達成報酬"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Shop_Content = {
    Text = "荒れた屋敷の野奉"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Topic_Content = {
    Text = "海城旧聞"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Awards_Content = {Text = "賞"},
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_CurRate_Content = {
    Text = "現在の確率"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_InitRate_Content = {
    Text = "基本確率配分"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Item_Content = {
    Text = "報酬アイテム"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Rate_Content = {Text = "確率"},
  PanelText_UI_Events_Popup_GiftBag_Text_C_Desc_Content = {
    Text = "イベント説明"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_InfoTitle_Content = {
    Text = "イベント概要"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_OptionWeapon_Content = {
    Text = "すべての選択可能な運命の札を確認"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_Slogan_Content = {
    Text = "24時間限定！\n常設覚醒体から1体選べる！"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_SpecialTime_Content = {Text = "残り"},
  PanelText_UI_Events_Popup_GiftBag_Text_PayTip_Content = {
    Text = "現在の表示されている価格はデフォルト通貨での参考価格です。お支払いの際は、実際の通貨と価格をご確認ください。"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_1_Content = {
    Text = "詳細を確認する"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_2_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Title_Content = {
    Text = "選択運命の札"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistAwaker_Content = {
    Text = "救援キャラクター"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistCount_Content = {
    Text = "救援回数"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Assist_Content = {
    Text = "協力回数ランキング"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Assist_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Kill_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Assist_Content = {
    Text = "守秘者情報"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Kill_Content = {
    Text = "守秘者情報"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_KillCount_Content = {
    Text = "総捕獲数"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Kill_Content = {
    Text = "捕獲回数ランキング"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Assist_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Kill_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Title_Content = {
    Text = "栄誉名簿"
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Introduction_Content = {
    Text = "黒、黒、黒…………\n漆黒の怪物が嘶き、咆哮し、狂い踊りながら、潮のようにあなたに押し寄せる。\n 「ぷっ――」\n「この銀芯、少なすぎるんだけど。次はもっと持ってきてよね。」"
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Title_Content = {
    Text = "猫海淘銀"
  },
  PanelText_UI_Events_Stage_Tip_Text_C_Title_Content = {
    Text = "調査報酬"
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Introduction_Content = {
    Text = "黒、黒の波が絶えず押し寄せる。\n狂乱した猫たちが君を取り囲み、無数の次元から君に向かって来る。"
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Title_Content = {
    Text = "群猫の乱舞"
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "あなたたちの最も原初の絶望に直面せよ。あなたたちの最も原初の恐れに直面せよ。\n見えない互いの側に立ち、そして彼を打ち勝つ。"
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Title_Content = {
    Text = "辰星レクイエム"
  },
  PanelText_UI_Events_illustrate_Tip_Text_C_Title_Content = {
    Text = "覚醒体説明"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Full_Content = {
    Text = "素材が揃いました"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Goto_Content = {Text = "移動"},
  PanelText_UI_GuideNote_Item_Material_Text_C_Source_Content = {Text = "入手元"},
  PanelText_UI_GuideNote_Item_Material_Text_C_Sweep_Content = {
    Text = "リプレイ"
  },
  PanelText_UI_GuideNote_Item_Task_Text_C_Recieve_Content = {
    Text = "受け取る"
  },
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Goto_Content = {Text = "移動"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Source_Content = {Text = "入手元"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Sweep_Content = {
    Text = "リプレイ"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Change_Content = {Text = "交換"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Choose_Content = {
    Text = "タップして覚醒体を選択"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Detail_Content = {Text = "詳細"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_ExcludeTalent_Content = {Text = "才能"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Level_Content = {Text = "レベル"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_More_Content = {
    Text = "さらなる強化"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_NoTask_Content = {
    Text = "覚醒体を一人選択"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Skill_Content = {Text = "スキル"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Talent_Content = {Text = "才能"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Abyss_Content = {Text = "移動"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_DailyChallenge_Content = {Text = "移動"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Pvp_Content = {Text = "移動"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RailyWay_Content = {Text = "移動"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RotationMode_Content = {Text = "移動"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Rank_Abyss_Content = {
    Text = "ランキング"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Abyss_Content = {
    Text = "残りの報酬"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_DailyChallenge_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Pvp_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RailyWay_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RotationMode_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_DailyChallenge_Content = {
    Text = "ポイント"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_Pvp_Content = {
    Text = "ポイント"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RailyWay_Content = {
    Text = "シーズン進捗"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RotationMode_Content = {
    Text = "ポイント"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Abyss_Content = {
    Text = "融災禁区"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_DailyChallenge_Content = {
    Text = "幻夢の深奥"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Pvp_Content = {
    Text = "対人戦・プリセットモード"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RailyWay_Content = {
    Text = "疾走する歓楽特急"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RotationMode_Content = {
    Text = "対人戦・ドラフトモード"
  },
  PanelText_UI_GuideNote_PermTrainBase_Text_C_Goto_Content = {Text = "移動"},
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Goto_Content = {Text = "移動"},
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ItemsPreview_Content = {
    Text = "残り資源予告"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Null_Content = {
    Text = "残り資源なし"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ProgressTitle_Content = {
    Text = "プレイ進捗"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Title_Content = {Text = "調査"},
  PanelText_UI_Guide_ChangeName_Image_Confim_Dis_Bg_Content = {Text = "刻印"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Dis_Content = {Text = "署名"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Nor_Content = {Text = "署名"},
  PanelText_UI_Guide_ChangeName_Text_C_Myself_Content = {
    Text = "あなたの名前"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Return_Content = {
    Text = "性別選択に戻る"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Tips_Content = {
    Text = "名前を入力してください"
  },
  PanelText_UI_Guide_ChangeName_Text_Confim_Nor_Content = {Text = "刻印"},
  PanelText_UI_Home_Panel_Main_Text_C_Title_Content = {
    Text = "研究センター"
  },
  PanelText_UI_Homeland_Item_Building_Text_C_Done_Content = {Text = "満員"},
  PanelText_UI_Homeland_Panel_Main_Text_C_Tips_Content = {
    Text = "ボーナス概要"
  },
  PanelText_UI_InvitationCode_Item_Player_Text_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_BindingTip_Content = {
    Text = "案内役の守秘者との結びつきは、無数のシルバーキーが輝く宇宙でも、あなたを孤独にさせない。"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_High_Content = {
    Text = "招待の紐付け"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_Nor_Content = {
    Text = "招待の紐付け"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Clean_Content = {Text = "消去"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Condition_Content = {
    Text = "招かれた守秘者がレベル5/10/15/20に達すると、\n「銀の鍵の輝き」を獲得できます。"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Copy_Content = {Text = "コピー"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Desc_Content = {
    Text = "招待コードをコピーして、無限宇宙の魂を、融蝕の旅へご案内。"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InputTip_Content = {
    Text = "友達専用の招待コードを入力すると、すぐに獲得。"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InviteCount_Content = {
    Text = "招待済み人数"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_High_Content = {
    Text = "招待イベント"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_Nor_Content = {
    Text = "招待イベント"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_MyCode_Content = {
    Text = "自身の招待コード"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Paste_Content = {
    Text = "貼り付け"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Share_Content = {Text = "共有"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Tips_Content = {
    Text = "招待コードを入力"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Value_Content = {
    Text = "銀の鍵の輝き"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_illustrate_Content = {
    Text = "イベント説明"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_Title_Content = {
    Text = "招待イベント"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Null_Content = {
    Text = "Lv.5に達した招待守秘者はいません"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title2_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title_Content = {
    Text = "招待リスト"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Acquire_Content = {
    Text = "新しいキーオーダーを獲得"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Tips_Content = {
    Text = "画面を閉じる"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Current_Content = {
    Text = "現在使用中"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Disable_Content = {
    Text = "使用不可"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_1_Content = {Text = "選択"},
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_2_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_NoTask_Content = {
    Text = "キーオーダーはありません"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Title_Content = {
    Text = "キーオーダー"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Login_Panel_ServerSelect_Text_Panel_Title_Content = {
    Text = "サーバー選択"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Activity_Content = {
    Text = "イベント告知"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_BugFix_Content = {
    Text = "不具合情報"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Game_Content = {
    Text = "お知らせ"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title2_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title_Content = {
    Text = "お知らせはありません"
  },
  PanelText_UI_Login_Popup_Tips_Text_Title_Content = {
    Text = "お知らせ"
  },
  PanelText_UI_Login_Text_C_Announcement_Content = {
    Text = "お知らせ"
  },
  PanelText_UI_Login_Text_C_Deal_Content = {Text = "規約"},
  PanelText_UI_Login_Text_C_Enter_Content = {
    Text = "TAP TO START"
  },
  PanelText_UI_Login_Text_C_Fight_Content = {Text = "戦闘2.0"},
  PanelText_UI_Login_Text_C_Plot_Content = {
    Text = "Avgストーリーテスト"
  },
  PanelText_UI_Login_Text_C_Repair_Content = {Text = "修復"},
  PanelText_UI_Login_Text_C_Service_Content = {
    Text = "カスタマーサポート"
  },
  PanelText_UI_Login_Text_C_Set_Content = {Text = "設定"},
  PanelText_UI_Login_Text_C_Setting_Content = {Text = "設定"},
  PanelText_UI_Login_Text_C_Sweep_Content = {
    Text = "スキャン"
  },
  PanelText_UI_Login_Text_C_User_Content = {
    Text = "アカウント管理"
  },
  PanelText_UI_Mail_Text_C_All_Content = {
    Text = "すべて受け取る"
  },
  PanelText_UI_Mail_Text_C_Collection_Content = {
    Text = "お気に入りボックス"
  },
  PanelText_UI_Mail_Text_C_Delete01_Content = {Text = "削除"},
  PanelText_UI_Mail_Text_C_Delete_Content = {
    Text = "既読を削除"
  },
  PanelText_UI_Mail_Text_C_Empty_Content = {
    Text = "新しいメールはありません"
  },
  PanelText_UI_Mail_Text_C_Mail_Content = {Text = "件数"},
  PanelText_UI_Mail_Text_C_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Mail_Text_C_NoTask1_Content = {
    Text = "手紙なし"
  },
  PanelText_UI_Mail_Text_C_Select_Letter_Content = {
    Text = "メールを1通選ぶ"
  },
  PanelText_UI_Mail_Text_C_Time_Content = {Text = "時間："},
  PanelText_UI_Mail_Text_C_Tips_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Mail_Text_C_Title_Content = {
    Text = "メールボックス"
  },
  PanelText_UI_Mail_Text_Time2_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Mail_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Close_Content = {
    Text = "画面を閉じる"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Daily_Content = {
    Text = "日々の訓練"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Finish_Content = {
    Text = "今日の任務は完了しました"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Receive_Content = {
    Text = "受け取り済み"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Reward_Content = {
    Text = "完了報酬"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Skill_Tag_Content = {
    Text = "達成手段"
  },
  PanelText_UI_Main_Favor_Tip_Text_C_Name_Content = {Text = "同調率"},
  PanelText_UI_Main_Helicopter_Tips_Text_C_Awaken_Content = {
    Text = "召喚日時"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Favor_Content = {
    Text = "現在の同調率"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Tip_Content = {
    Text = "覚醒体を招待すると、一定時間ごとに同調率が増加する"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Title_Content = {Text = "宿舎"},
  PanelText_UI_Main_Helicopter_Tips_Text_Name_1_Content = {
    Text = "来客を招待"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_Name_2_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_ResetBg_Content = {
    Text = "デフォルトに戻す"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Not_Content = {Text = "未達成"},
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Proxy_Content = {
    Text = "代理証明"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Receive_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Main_Panel_1_Text_Abyss_Content = {
    Text = "融災禁区"
  },
  PanelText_UI_Main_Panel_1_Text_C_Acclaim_Content = {Text = "好評"},
  PanelText_UI_Main_Panel_1_Text_C_Activity_Content = {
    Text = "イベント"
  },
  PanelText_UI_Main_Panel_1_Text_C_Awaker_Content = {Text = "覚醒体"},
  PanelText_UI_Main_Panel_1_Text_C_Bag_Content = {Text = "所持品"},
  PanelText_UI_Main_Panel_1_Text_C_Close_1_Content = {
    Text = "閉じています"
  },
  PanelText_UI_Main_Panel_1_Text_C_Close_Content = {Text = "終了中"},
  PanelText_UI_Main_Panel_1_Text_C_Collection_Content = {
    Text = "秘典書庫"
  },
  PanelText_UI_Main_Panel_1_Text_C_Community_Content = {
    Text = "コミュニティ"
  },
  PanelText_UI_Main_Panel_1_Text_C_Daily_Content = {
    Text = "日々の訓練"
  },
  PanelText_UI_Main_Panel_1_Text_C_Dbg_Content = {
    Text = "強化演習"
  },
  PanelText_UI_Main_Panel_1_Text_C_DungeonNote_Content = {
    Text = "秘境教室"
  },
  PanelText_UI_Main_Panel_1_Text_C_Formation_Content = {Text = "編成"},
  PanelText_UI_Main_Panel_1_Text_C_Full_Content = {
    Text = "完了済み"
  },
  PanelText_UI_Main_Panel_1_Text_C_GamePassport_Content = {
    Text = "守密紀行"
  },
  PanelText_UI_Main_Panel_1_Text_C_Lesson_Content = {
    Text = "学期課題"
  },
  PanelText_UI_Main_Panel_1_Text_C_Main_Content = {Text = "調査"},
  PanelText_UI_Main_Panel_1_Text_C_Mission_Content = {
    Text = "任務手帳"
  },
  PanelText_UI_Main_Panel_1_Text_C_Pvp_Content = {Text = "対人戦"},
  PanelText_UI_Main_Panel_1_Text_C_Recall_Content = {
    Text = "記憶の回廊"
  },
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Content = {Text = "召喚"},
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Nor_Content = {Text = "召喚"},
  PanelText_UI_Main_Panel_1_Text_C_Store_Content = {
    Text = "ミサゴ商店"
  },
  PanelText_UI_Main_Panel_1_Text_C_Welfare_Content = {
    Text = "大量イベント、期間限定受け取り"
  },
  PanelText_UI_Main_Panel_1_Text_Diving_Content = {
    Text = "幻夢の深奥"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_Title_Content = {
    Text = "通常任務"
  },
  PanelText_UI_Michi_Popup_Strengthen_Succeed_Text_C_Info_Content = {
    Text = "タップで閉じる"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Consume_Content = {Text = "消費"},
  PanelText_UI_Other_Donate_Tips_Text_C_Donated_Content = {
    Text = "寄付総額"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Fund_Content = {
    Text = "同窓生寄付基金"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Title_Content = {
    Text = "プラチナジェルの寄付"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Describe_Content = {
    Text = "「源液」を寄付して貢献を積むことで、あなたの善行には報いが与えられます。\n「総貢献値」は、累積した寄付の「源液」の合計です。"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Donated_Content = {
    Text = "現在の総貢献"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Title_Content = {
    Text = "同窓生寄付基金"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_All_Content = {
    Text = "全回復："
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Auto_Content = {
    Text = "自動回復"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_1_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_2_Content = {Text = "確定"},
  PanelText_UI_Other_Physical_Tips_Text_C_Name_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Next_Content = {
    Text = "次の回復："
  },
  PanelText_UI_Other_Physical_Tips_Text_Name_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Energy_Content = {
    Text = "エネルギーを消耗："
  },
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Info_Content = {
    Text = "タップで閉じる"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Next_Content = {
    Text = "シルバーコアを消費"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Now_Content = {
    Text = "現在のシルバーコア"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Question_Content = {
    Text = "キーを取得しますか？"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Next_Content = {
    Text = "消費キー"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Now_Content = {
    Text = "キーを持つ"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Title_Content = {
    Text = "キーの取得"
  },
  PanelText_UI_Other_Popup_Trinket_LevelUp_Text_C_Success_Content = {
    Text = "強化成功"
  },
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_HP_Content = {Text = "体力"},
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_Wait_Content = {
    Text = "ドラフト結果の反映を待機中"
  },
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Defend_Content = {Text = "後手"},
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Adjust_Content = {
    Text = "タップして覚醒体の位置を変更"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_My_Content = {
    Text = "準備完了！"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_Other_Content = {
    Text = "準備完了！"
  },
  PanelText_UI_PVP_Panel_TeamRotation_Text_BtnName_Content = {Text = "選択"},
  PanelText_UI_Passport_Choose_Tip_Text_C_Title_Content = {
    Text = "報酬を選択してください"
  },
  PanelText_UI_Passport_Exchange_Text_C_Buy_Title_Content = {
    Text = "レベルアップ"
  },
  PanelText_UI_Passport_Exchange_Text_C_Cost_Tips_Content = {Text = "必要"},
  PanelText_UI_Passport_Exchange_Text_C_Title_Content = {
    Text = "課題レベルアップ"
  },
  PanelText_UI_Passport_Instructions_Text_C_Remainder_Content = {
    Text = "残り時間"
  },
  PanelText_UI_Passport_Instructions_Text_C_Title_Content = {
    Text = "学期課題"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Additional_Content = {
    Text = "解放で獲得"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Condition_Content = {
    Text = "全課題クリア時の累計報酬"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_1_Content = {
    Text = "即座に増加"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_3_Content = {Text = "級"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_4_Content = {
    Text = "課題レベル"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_Content = {
    Text = "課題レベルを<color=#5EF2FF><size=32>10</size>レベル</color>今すぐ向上させる"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Introduce_Content = {
    Text = "上位課題を解放し、40レベルに達すると、課題ギフトから運命の札1つまたは「流明の芯」×5を選んで報酬として受け取ることができます"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Name_Content = {
    Text = "指導表彰"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_1_Content = {
    Text = "基本アクティビティ\n報酬3倍"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_2_Content = {
    Text = "戦闘ターン\nリセット"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_3_Content = {
    Text = "対人戦\n全カード\n使い放題"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_Content = {
    Text = "・今期課題期間中の特権"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Prompt_Content = {
    Text = "核心課題の購入で上位課題も解放。\n180プラチナジェル分お得となります"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_1_Content = {
    Text = "購入済み"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_2_Content = {
    Text = "購入済み"
  },
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Senior (1)_Content"] = {Text = "高級"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Senior_Content = {
    Text = "上位課題"
  },
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Super (1)_Content"] = {Text = "特級"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Super_Content = {
    Text = "核心課題"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_TempUnlock_Content = {
    Text = "核心課題の限定報酬を即座に獲得"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_ThisIssue_Content = {
    Text = "全課題クリア時の累計報酬"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Condition_Content = {
    Text = "昇級後に受け取り可能"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_1_Content = {
    Text = "今すぐ強化"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_3_Content = {Text = "レベル"},
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_4_Content = {
    Text = "課題レベルでの獲得"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Introduce_Content = {
    Text = "貴重な運命の札を封入した精巧なギフトボックス、手作り。\n上位課題をアンロックし40レベルに到達すると、課題ギフトから運命の札1つまたは「流明の芯」×5を報酬として選択可能。"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Name_Content = {
    Text = "課題ギフト"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Prompt_Content = {
    Text = "核心課題の購入で上位課題も解放！\n180プラチナジェル分お得！"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_1_Content = {
    Text = "購入済み"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_2_Content = {
    Text = "購入済み"
  },
  ["PanelText_UI_Passport_Money_Item_Text_C_Senior (1)_Content"] = {Text = "高級"},
  PanelText_UI_Passport_Money_Item_Text_C_Senior_Content = {
    Text = "上位課題"
  },
  ["PanelText_UI_Passport_Money_Item_Text_C_Super (1)_Content"] = {Text = "特級"},
  PanelText_UI_Passport_Money_Item_Text_C_Super_Content = {
    Text = "核心課題"
  },
  PanelText_UI_Passport_Money_Item_Text_C_ThisIssue_Content = {
    Text = "今期の上位課題の全内容を含む"
  },
  PanelText_UI_Passport_Panel_Main_New_Text_C_Mail_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Passport_Panel_Main_New_Text_C_Title_Content = {
    Text = "学期課題"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Experience_Content = {
    Text = "課題経験値"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Full_Content = {
    Text = "最大レベル"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Instructions_Grade_Content = {
    Text = "課題レベル"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Mail_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Name_Content = {
    Text = "レベルアップ"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Online_Content = {
    Text = "今週の経験値上限"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Title_Content = {
    Text = "学期課題"
  },
  PanelText_UI_Passport_Popup_Player_LevelUp_Text_C_Title_Content = {
    Text = "課題ランクアップ"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Cancel_Name_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Passport_Popup_Recharge_Text_Title_Content = {
    Text = "購入確認"
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Content_Content = {
    Text = "貴重な運命の札を封入した精巧なギフトボックス、手作り。\n上位課題をアンロックし40レベルに到達すると、課題ギフトから運命の札1つまたは「流明の芯」×5を報酬として選択可能。"
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Title_Content = {
    Text = "課題ギフト"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Experience_Content = {
    Text = "課題経験値"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Full_Content = {
    Text = "最大レベル"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_GainExperience_Content = {
    Text = "経験値獲得"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_2_Content = {
    Text = "レベル購入"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Online_Content = {
    Text = "今週の上限"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Ordinary_Title_Content = {
    Text = "基本課題"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Content = {
    Text = "課題購入"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Title_Content = {
    Text = "上位課題"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Timing_Content = {Text = "今期"},
  PanelText_UI_Passport_Reward_Item_New_Text_C_Unlock_Content = {
    Text = "解放で獲得"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Experience_Content = {
    Text = "課題経験値"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Full_Content = {
    Text = "最大レベル"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_2_Content = {
    Text = "レベル購入"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Online_Content = {
    Text = "今週の上限"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Ordinary_Title_Content = {
    Text = "基本課題"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Content = {
    Text = "課題購入"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Title_Content = {
    Text = "上位課題"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Tab_Special_Content = {Text = "上級"},
  PanelText_UI_Passport_Reward_Item_Text_C_Timing_Content = {
    Text = "残り時間"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Introduce_Content = {
    Text = "上位課題を解放し、40レベルに達すると、課題ギフトから運命の札1つまたは「流明の芯」×5を選んで報酬として受け取ることができます"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Reward_Content = {
    Text = "ギフト情報"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Time_1_Content = {
    Text = "イベントの残り時間"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Double_Content = {
    Text = "経験値2倍"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Tab_Special_Content = {
    Text = "イベント"
  },
  PanelText_UI_Passport_Task_Description_Text_C_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Passport_Task_Description_Text_C_Tab_Special_Content = {
    Text = "イベント"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Experience_Content = {
    Text = "課題経験値"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Full_Content = {
    Text = "最大レベル"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_3_Content = {
    Text = "レベル購入"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Online_Content = {
    Text = "今週の上限"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Time_Content = {
    Text = "残り時間"
  },
  PanelText_UI_Passport_illustrate_Tip_Text_C_Title_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Pocket_Mail_Text_C_Del_Content = {Text = "削除"},
  PanelText_UI_Pocket_Mail_Text_C_Time_Content = {Text = "時間："},
  PanelText_UI_Pocket_Mail_Text_C_Tips_Content = {Text = "所持数"},
  PanelText_UI_Pocket_Mail_Text_C_Title2_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Pocket_Mail_Text_C_Title_Content = {
    Text = "手紙なし"
  },
  PanelText_UI_Pocket_Mail_Text_C_select_Title_Content = {
    Text = "手紙を選択"
  },
  PanelText_UI_Popup_DonationBox_Text_C_Reward_Content = {Text = "所持品"},
  PanelText_UI_Popup_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "取得速度："
  },
  PanelText_UI_Protagonist_Item_Skill_Text_C_Current_Content = {Text = "現在"},
  PanelText_UI_Protagonist_Item_Skill_Text_C_No_Content = {Text = "未取得"},
  PanelText_UI_Pvp_Blood_Share_Text_C_Release_Content = {Text = "解放"},
  PanelText_UI_Pvp_Item_Card_Text_C_Replace_Content = {
    Text = "置き換え"
  },
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Done_Content = {
    Text = "私をフォロー済み"
  },
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Mutual_Content = {
    Text = "相互フォロー"
  },
  PanelText_UI_Pvp_Item_Dan_Text_C_Current_Content = {
    Text = "現在の段位"
  },
  PanelText_UI_Pvp_Item_Formation_Text_C_Conflict_Content = {
    Text = "界域競合"
  },
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Double_Content = {
    Text = "イベント倍増"
  },
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Topic_Content = {
    Text = "課題特権"
  },
  PanelText_UI_Pvp_Item_Ranking_Text_C_Current_Content = {
    Text = "今の報酬"
  },
  PanelText_UI_Pvp_Item_Ranking_Text_C_Over_Content = {Text = "～"},
  PanelText_UI_Pvp_Item_Role_Text_C_Decks_Content = {Text = "デッキ"},
  PanelText_UI_Pvp_Item_Role_Text_C_Maniac_Content = {Text = "狂気"},
  PanelText_UI_Pvp_Item_Role_Text_C_Role_Wins_Content = {Text = "勝利数"},
  PanelText_UI_Pvp_Panel_Battle_Text_High_Content = {Text = "降伏"},
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_C_NoTask_Content = {
    Text = "コメントはまだありません"
  },
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_Time_Content = {
    Text = "最初のコメントを投稿しよう"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Decks_Content = {Text = "デッキ"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Effect_Content = {Text = "効果"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Hoist_Content = {
    Text = "行動力消費"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Maniac_Content = {Text = "狂気"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_TotalWins_Content = {
    Text = "総勝利数"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_Wins_Content = {
    Text = "今月の勝利数"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Skill_Tag_Content = {
    Text = "狂気解放"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Source_Content = {Text = "出所"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_TotalWins_Content = {
    Text = "総勝利数"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Wins_Content = {
    Text = "今シーズン勝利数"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_None_Content = {
    Text = "関連コレクションなし"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_Time_Content = {
    Text = "この界域は対人戦では未開放です。"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Awaker_Name_Content = {Text = "覚醒体"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_KeeperSkill_Name_Content = {
    Text = "キーオーダー"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_1_Content = {Text = "詳細"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_2_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_3_Content = {
    Text = "コメント"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Train_Name_Content = {
    Text = "覚醒体試用"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Weapon_Name_Content = {
    Text = "運命の札"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_NoTask_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_SeasonWins_Content = {
    Text = "今月の勝利数"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_TotalWins_Content = {
    Text = "総勝利数"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Decks_Content = {Text = "デッキ"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Effect_Content = {Text = "効果"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Maniac_Content = {Text = "狂気"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Role_Wins_Content = {Text = "勝利数"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Wins_Content = {Text = "勝利数"},
  PanelText_UI_Pvp_Panel_Formation_Text_C_Detail_Content = {
    Text = "左側から出場を選んでください"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_1_Content = {
    Text = "左側から出場を選んでください"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_Content = {
    Text = "左側から出場を選んでください"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Name_Content = {Text = "詳細"},
  PanelText_UI_Pvp_Panel_Formation_Text_C_None_Content = {
    Text = "関連するフィルタ結果なし"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Time_Content = {
    Text = "特定の方法で入手可能"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Award_Content = {
    Text = "勝利数報酬"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_CardEdit_Content = {
    Text = "プリセット編成"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Robot_Content = {Text = "閉じる"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Speed_Content = {Text = "閉じる"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Collection_Content = {
    Text = "コレクション"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_DraftPick_Content = {
    Text = "ドラフトレベル"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Expression_Content = {
    Text = "スタンプ"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Integral_Content = {
    Text = "シーズンポイント"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Matching_Content = {
    Text = "対人戦準備"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Robot_Content = {Text = "ON"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Speed_Content = {Text = "ON"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Password_Content = {
    Text = "パスワード対戦"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Precon_Content = {
    Text = "プリセットレベル"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Progress_Content = {
    Text = "ランク報酬"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Content = {
    Text = "プリセットモード"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Score_Content = {
    Text = "ポイント"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Ranking_Content = {
    Text = "ランキングボード"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Record_Content = {
    Text = "対人戦記録"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Reward_Content = {
    Text = "高段位に到達してもっと報酬を獲得。"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Robot_Content = {
    Text = "模擬対戦相手"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Content = {
    Text = "ドラフトモード"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Score_Content = {
    Text = "ポイント"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Rule_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Speed_Content = {
    Text = "精密マッチング"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Time_Content = {
    Text = "現在のシーズン残り"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Title_Content = {Text = "対人戦"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Victory_Content = {
    Text = "累計勝利数："
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Weekly_Content = {
    Text = "毎週の報酬"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_list_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Pvp_Panel_Main_Text_C_Name_Content = {Text = "終了"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Unclickable_Content = {Text = "終了"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Zongshanghai_Content = {
    Text = "総ダメージ"
  },
  PanelText_UI_Pvp_Panel_Match_Text_C_Win_Content = {
    Text = "マッチング完了"
  },
  PanelText_UI_Pvp_Panel_Match_Text_Name_Content = {
    Text = "対人戦準備"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "清算報酬"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Integral_Content = {
    Text = "シーズンポイント"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Show_Content = {Text = "次へ"},
  PanelText_UI_Pvp_Panel_Out_Text_C_Sync_Content = {
    Text = "覚醒体の同調率が増加"
  },
  PanelText_UI_Pvp_Panel_Playback_Text_C_Angle_Content = {
    Text = "視点を切り替え"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_1_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_2_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_1_Content = {Text = "いいね"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_2_Content = {Text = "いいね"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Enemy_Content = {Text = "敵"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Fail_Content = {Text = "失敗"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Harm_Content = {
    Text = "ダメージ"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Ourside_Content = {Text = "味方"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Outcome_Content = {Text = "勝利"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_OwnRespectable_Content = {
    Text = "対人戦ありがとう！"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_01_Content = {
    Text = "ポイント"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_02_Content = {
    Text = "ポイント"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Respectable_Content = {
    Text = "対人戦ありがとう！"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Shields_Content = {
    Text = "シールド"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Treat_Content = {Text = "治癒"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Victory_Content = {Text = "勝利"},
  PanelText_UI_Pvp_Panel_Train_Text_C_KeeperSkills_Content = {
    Text = "キーオーダー追加"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Position_Content = {Text = "移動"},
  PanelText_UI_Pvp_Panel_Train_Text_C_Reset_Content = {
    Text = "リセット"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_SelectRelic_Content = {
    Text = "遺物を選択"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Weapons_Content = {
    Text = "運命の札追加"
  },
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_01_Content = {
    Text = "ポイント"
  },
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_02_Content = {
    Text = "ポイント"
  },
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Breaking_Content = {
    Text = "サーバー接続が切断されました"
  },
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Quit_Content = {
    Text = "ログイン画面に戻る"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Decks_Content = {Text = "デッキ"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Effect_Content = {Text = "効果"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Maniac_Content = {Text = "狂気"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Role_Wins_Content = {Text = "勝利数"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Wins_Content = {Text = "勝利数"},
  PanelText_UI_Pvp_Popup_Dan_Text_C_Bonus_Content = {
    Text = "シーズンボーナス"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Continue_Content = {Text = "続行"},
  PanelText_UI_Pvp_Popup_Dan_Text_C_Streak_Content = {
    Text = "連勝ボーナス"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Title_Content = {
    Text = "霊知啓発"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Use_Content = {
    Text = "現在使用中"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Tips_Text_C_Title_Content = {
    Text = "霊知啓発"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Content = {Text = "管理"},
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Content = {
    Text = "ストーリー"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Sel_Content = {
    Text = "ストーリー"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Sel_Content = {Text = "管理"},
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Title_Content = {Text = "管理"},
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Use_Content = {
    Text = "スタンプ"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Close_Content = {
    Text = "タップで続行"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Continue_Content = {Text = "続行"},
  PanelText_UI_Pvp_Popup_Fail_Text_C_Fail_Content = {Text = "失敗"},
  PanelText_UI_Pvp_Popup_Fail_Text_C_Victory_Content = {
    Text = "戦闘失敗"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_Reward_1_Content = {
    Text = "戦闘スタイルボーナス"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Create_Content = {
    Text = "対戦を作成"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Joinin_Content = {
    Text = "対戦に参加"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_Title_Content = {
    Text = "パスワード対戦"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Cancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Title_Content = {
    Text = "編成をインポート"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Placeholder_Content = {
    Text = "6桁の<color=#5EF2FF>パスワード</color>を入力"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Cancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Pvp_Popup_PasswordCode_Text_Title_Content = {
    Text = "パスワードを入力"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Cancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Copy_Content = {
    Text = "パスワードをコピー"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Wait_Content = {
    Text = "待機中…"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_Title_Content = {
    Text = "パスワード対戦"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Cancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Done_Content = {
    Text = "私をフォロー済み"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Mutual_Content = {
    Text = "相互フォロー"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Ready_Content = {Text = "準備"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Reject_Content = {Text = "拒否"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Wait_Content = {
    Text = "相手の準備を待っています…"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_C_Copy_Content = {Text = "コピー"},
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Name_Content = {
    Text = "再生する"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Title_Content = {
    Text = "視点選択"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Initial_Content = {
    Text = "初期手札"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Prompt_Content = {
    Text = "不要な手札を選択して交換"
  },
  PanelText_UI_Pvp_Popup_Reward_Tips_Text_C_Title_Content = {
    Text = "ランク報酬"
  },
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Confirm_Content = {Text = "確定"},
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Title_Content = {
    Text = "低級遺物を1つ選択"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Close_Content = {
    Text = "タップで続行"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Succeed_Content = {
    Text = "戦闘勝利"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Highest_Content = {
    Text = "過去最高対人戦ポイント："
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Title_Content = {
    Text = "対人戦記録"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity1_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity2_Content = {
    Text = "シーズンランキング"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity3_Content = {
    Text = "シーズンランキング"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity4_Content = {
    Text = "ランキング報酬"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Award_Content = {Text = "報酬"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Big_Content = {
    Text = "守秘者情報"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game1_Content = {
    Text = "今週のランキング"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game2_Content = {
    Text = "今週のランキング"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Grade_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Hint_Content = {
    Text = "本シーズンで1勝以上すると、シーズン終了時に精算報酬が配布されます。"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_NoTask_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_RankTip_Content = {
    Text = "本シーズンに一回参加すると「シーズンランキング」に入れます。"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_Pvp_Content = {
    Text = "プリセットモード"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_RotationMode_Content = {
    Text = "ドラフトモード"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Reward_Content = {
    Text = "シーズン最高ポイント"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Scope_Content = {
    Text = "ランキング範囲"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Small_Content = {
    Text = "対人戦称号"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Title_2_Content = {
    Text = "対人戦称号"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Fail_Content = {Text = "失敗"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Red_Content = {Text = "続行"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Victory_Content = {Text = "勝利"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Yellow_Content = {Text = "続行"},
  PanelText_UI_Pvp_Popup_list_Tips_Text_C_Title_Content = {
    Text = "ランキングボード"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_10_Content = {
    Text = "命輪の装備"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_1_Content = {
    Text = "装備キーオーダー"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_2_Content = {
    Text = "4番目の覚醒体"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_3_Content = {
    Text = "3番目の覚醒体"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_4_Content = {
    Text = "2番目の覚醒体"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_5_Content = {
    Text = "1番目の覚醒体"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_6_Content = {
    Text = "キーオーダーの装備"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_7_Content = {
    Text = "命輪の装備"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_8_Content = {
    Text = "命輪の装備"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_9_Content = {
    Text = "命輪の装備"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_Content = {
    Text = "全体編成"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Realms_Content = {
    Text = "界域は未起動"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Title_Content = {
    Text = "プリセット編成"
  },
  PanelText_UI_Pvp_Team_Main_Text_Name_Content = {
    Text = "一括編成"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Copy_Content = {Text = "コピー"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Done_Content = {
    Text = "私をフォロー済み"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Mutual_Content = {
    Text = "相互フォロー"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Proficiency_Content = {
    Text = "累計勝利数"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Remove_Content = {Text = "編集"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Save_Content = {Text = "削除"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Title_Content = {
    Text = "コメント詳細"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Additional_Content = {Text = "特典"},
  PanelText_UI_Recharge_Courtesy_Item_Text_C_DiscountMultipleTitle_Content = {Text = "お得"},
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Haved_Content = {
    Text = "所有済み"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Sellout_Content = {
    Text = "売り切れ"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Buy_Title_Content = {
    Text = "シルバーコア交換数"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Cost_Tips_Content = {Text = "消費"},
  PanelText_UI_Recharge_Exchange_Text_C_Redeemed_Content = {
    Text = "累積交換済み:"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Not_Content = {
    Text = "通貨不足"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Title_Content = {
    Text = "交換を確定"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Recharge_Instructions_Text_C_Title_Content = {
    Text = "学期課題"
  },
  PanelText_UI_Recharge_Instructions_Text_Name_Content = {Text = "向かう"},
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Cost_Tips_Content = {Text = "合計"},
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Tips_Content = {
    Text = "購入不要なアイテムを削除できる"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Title_Content = {
    Text = "購入確認"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Buttom_Content = {
    Text = "初回購入に限り、同量の「源液」をプレゼント！！"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law1_Content = {
    Text = "特定商取引法"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law2_Content = {
    Text = "資金決済法"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Refresh_Content = {
    Text = "カスタマーサポート"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Title_Content = {
    Text = "プラチナジェルの抽出"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_PayTip_Content = {
    Text = "現在の表示されている価格はデフォルト通貨での参考価格です。お支払いの際は、実際の通貨と価格をご確認ください。"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Desc_Content = {
    Text = "イベント説明"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Slogan_Content = {
    Text = "24時間限定！\n常設覚醒体から1体選べる！"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_SpecialTime_Content = {Text = "残り"},
  PanelText_UI_Recharge_Panel_GiftBag_Text_PayTip_Content = {
    Text = "現在の表示されている価格はデフォルト通貨での参考価格です。お支払いの際は、実際の通貨と価格をご確認ください。"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Bigitle_Content = {
    Text = "マンスリーパス"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Buttom_Tips_Content = {
    Text = "各初回購入で2倍、1回限り"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Cost_Tips_Content = {Text = "消費"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Expired_Content = {
    Text = "期限切れ"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Flushed_Content = {Text = "更新"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get1_Title_Content = {
    Text = "今すぐ入手"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get2_Title_Content = {
    Text = "毎日プレゼント"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Illustrate_Content = {Text = "説明"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_OnekeyPurchase_Content = {
    Text = "一括購入"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Refresh_Content = {
    Text = "カスタマーサポート"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Tips_Content = {
    Text = "※累計で300シルバーコア+3000シルバーコアを獲得可能"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Today_Content = {
    Text = "本日受け取り済"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_Get2_Title2_Content = {
    Text = "（30日）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigitle_Content = {
    Text = "月相観測"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigtitle_Content = {
    Text = "マンスリーパス"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buttom_Tips_Content = {
    Text = "各初回購入で同量の「源液」を追加で獲得、一度限り"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buy_Content = {Text = "購入"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Cost_Tips_Content = {Text = "消費"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Double_Content = {Text = "追加"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Expired_Content = {
    Text = "期限切れ"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Extra_Content = {Text = "追加"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Flushed_Content = {Text = "更新"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_NumName_Content = {
    Text = "プラチナジェル"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_Title_Content = {
    Text = "今すぐ入手"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_NumName_Content = {
    Text = "シルバーコア"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title2_Content = {
    Text = "（30日間）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title_Content = {
    Text = "毎日プレゼント"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Illustrate_Content = {Text = "説明"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Need_Content = {Text = "必要"},
  PanelText_UI_Recharge_Panel_Main_Text_C_OnekeyPurchase_Content = {
    Text = "一括購入"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Refresh_Content = {
    Text = "カスタマーサポート"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip1_Content = {
    Text = "毎日のログインで累計\n「シルバーコア」<color=#57F8FE><size=38>×6000</size></color>が入手できます！"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip2_Content = {
    Text = "毎日のログインで累計\n「エンフェリン」<color=#57F8FE><size=38>×6000</size></color> と「追憶の羽ペン」<color=#57F8FE><size=38>×600</size></color>が獲得できます！"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Get1_Title_Content = {
    Text = "今すぐ入手"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Illustrate_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Need_Content = {Text = "必要"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Tips_Content = {
    Text = "毎日プレゼント（30日間）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Title_Content = {
    Text = "エンフェリン\nパス"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Tips_Content = {
    Text = "※累計で「シルバーコア」×300+「シルバーコア」×6000を獲得可能"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Title_Content = {
    Text = "ミサゴ商店"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Today_Content = {
    Text = "本日受け取り済"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Month_Content = {
    Text = "マンスリーパス"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Recharge_Content = {
    Text = "チャージ"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Root_Content = {
    Text = "根源の泡"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Month_Content = {
    Text = "月相観測"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Recharge_Content = {
    Text = "チャージ"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Root_Content = {
    Text = "根源の泡"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Get2_Title2_Content = {
    Text = "（30日）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Name_Content = {Text = "購入"},
  PanelText_UI_Recharge_Panel_Main_Text_Tips_Content = {
    Text = "※累計で「シルバーコア」×300+「シルバーコア」×6000を獲得可能"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_Content = {
    Text = "マンスリーパス"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_Content = {
    Text = "チャージ"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Root_Content = {
    Text = "根源の泡"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Month_Content = {
    Text = "マンスリーパス"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Recharge_Content = {
    Text = "チャージ"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Root_Content = {
    Text = "根源の泡"
  },
  PanelText_UI_Recharge_Panel_Month_Tips_Text_C_Today_Content = {
    Text = "マンスリーパスの報酬を受け取る"
  },
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Disable_Content = {Text = "購入"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Normal_Content = {Text = "購入"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Title_Content = {
    Text = "ミサゴ商店"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cancel_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Confirm_Content = {Text = "購入"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cost_Tips_Content = {Text = "消費"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_Content = {
    Text = "購入を確定"
  },
  PanelText_UI_Recharge_Reset_Item_Text_C_Double_Content = {
    Text = "初回購入"
  },
  PanelText_UI_Recharge_Reset_Item_Text_C_Extra_Content = {Text = "追加"},
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_Activate_Content = {
    Text = "起動完了"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_NoeGet_Content = {
    Text = "その覚醒体を未取得"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_Name_Content = {
    Text = "才能を起動"
  },
  PanelText_UI_Research_Panel_Ceri_Text_C_Activate_Content = {
    Text = "起動完了"
  },
  PanelText_UI_Research_Panel_Ceri_Text_C_Title_Content = {
    Text = "才能の概要"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_PlanName_Content = {
    Text = "現在の状況"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_ReachName_Content = {
    Text = "すべての実績達成"
  },
  PanelText_UI_Research_Panel_Challenge_Text_Title_Content = {Text = "実績"},
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Count_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Extra_Content = {
    Text = "【追加】"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_NoTask_Content = {
    Text = "新しい派遣任務なし"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special2_Content = {
    Text = "派遣総レベル20毎に1つ報酬追加"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special_Content = {
    Text = "達成条件"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_Underway_Content = {Text = "派遣中"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Tip_Content = {
    Text = "受け取り待ち"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Unclickable_Content = {Text = "未解放"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Underway_Content = {Text = "進行中"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Content = {Text = "残り"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Normal_Content = {Text = "消費"},
  PanelText_UI_Research_Popup_Dispatch_Text_Title_Content = {
    Text = "派遣ボーナス概要"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Agin_Content = {Text = "再派遣"},
  PanelText_UI_Research_Popup_Recall2_Text_C_Dispatch_Content = {
    Text = "派遣覚醒体"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Reward_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Title_Content = {
    Text = "派遣報告"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Close_Content = {Text = "閉じる"},
  PanelText_UI_Research_Popup_Recall_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Dispatch_Content = {
    Text = "現在の総レベル"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Extra_Content = {Text = "[追加]"},
  PanelText_UI_Research_Popup_Recall_Text_C_Level_Content = {
    Text = "派遣総レベル"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special2_Content = {
    Text = "派遣総レベル20毎に1つ報酬追加"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special_Content = {
    Text = "派遣に必要な条件"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Title_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Research_Popup_Report_Text_C_Title_Content = {
    Text = "調査レポート"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_C_Tip_Content = {
    Text = "後に「設定-言語」で再び選択可能"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_Name_Content = {Text = "確定"},
  PanelText_UI_Setting_Popup_ChooseLang_Text_Title_Content = {
    Text = "言語を選択する"
  },
  PanelText_UI_Setting_Popup_Code_Text_C_Clean_Content = {Text = "消去"},
  PanelText_UI_Setting_Popup_Code_Text_C_Paste_Content = {Text = "貼る"},
  PanelText_UI_Setting_Popup_Code_Text_C_Tips_Content = {
    Text = "ギフトコードを入力"
  },
  PanelText_UI_Setting_Popup_Down_Text_C_Downing_Content = {
    Text = "リソースをダウンロード中"
  },
  PanelText_UI_Setting_Popup_Examine_Text_C_Examine_Content = {
    Text = "ゲームリソースの整合性をチェック中"
  },
  PanelText_UI_Setting_Popup_Main_Text_C_Title_Content = {Text = "設定"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_1_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_2_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Title_Content = {
    Text = "アカウント連携報酬"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_1_Content = {Text = "未達成"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_2_Content = {Text = "未達成"},
  PanelText_UI_Shop_Item_Commodity_Text_C_Head_Content = {
    Text = "アイコン"
  },
  PanelText_UI_Shop_Item_Commodity_Text_C_Value_Content = {Text = "お得"},
  PanelText_UI_Shop_Item_Toggle_Text_C_Recommend_Content = {
    Text = "おすすめ"
  },
  PanelText_UI_Shop_Popup_Tips_Text_C_Tips_Content = {
    Text = "通貨不足"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Assist_Content = {
    Text = "救援回数"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Awaker_Content = {
    Text = "リンク覚醒体"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Birthday_Content = {Text = "誕生日"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Concern2_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Conclude_Content = {
    Text = "実績を達成"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Difficulty_Content = {Text = "調査"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Dream_Content = {
    Text = "幻夢の深奥"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Fans_Content = {
    Text = "フォロワー"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Highest_Content = {
    Text = "最高記録"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Indestructible_Content = {
    Text = "闇の境界・輪転の隙間"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Pagoda_Content = {
    Text = "闇の境界"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Privacy_Content = {
    Text = "守秘者は調査状況をプライバシーに設定した"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Register_Content = {
    Text = "ログイン日数"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Society_Content = {
    Text = "所属同好会"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Survey_Content = {
    Text = "調査状況"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Placeholder_Content = {
    Text = "自己紹介を入力してください"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Abyss_Content = {
    Text = "融災禁区"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Assist_Content = {
    Text = "救援回数"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Attention_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Awaker_Content = {
    Text = "リンク覚醒体"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Ban_Content = {
    Text = "ブロック"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Birthday_Content = {Text = "誕生日"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Collection_Content = {
    Text = "収集進捗"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Concern2_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Conclude_Content = {
    Text = "実績を達成"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Difficulty_Content = {Text = "調査"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Dream_Content = {
    Text = "幻夢の深奥"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Fans_Content = {
    Text = "フォロワー"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Gender_Content = {Text = "性別"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Hard_Content = {Text = "高難度"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Highest_Content = {
    Text = "最高記録"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Indestructible_Content = {
    Text = "闇の境界・輪転の隙間"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Interrelated_Content = {
    Text = "相互フォロー"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Normal_Content = {Text = "通常"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Notset_Content = {Text = "未設定"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Pagoda_Content = {
    Text = "闇の境界"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Privacy_Content = {
    Text = "守秘者は調査状況をプライバシーに設定した"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Register_Content = {
    Text = "ログイン日数"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Society_Content = {
    Text = "所属同好会"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Survey_Content = {
    Text = "調査状況"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_1_Content = {Text = "総計"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_2_Content = {
    Text = "最高記録"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_NickNamePre_Content = {Text = "備考 :"},
  PanelText_UI_Social_Item_Data_Right_Text_C_Help_Content = {
    Text = "救援覚醒体"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Not_Content = {
    Text = "救援覚醒体未設定"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Null_1_Content = {
    Text = "未展示の覚醒体"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Team_Content = {
    Text = "覚醒体展示"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Accept_Content = {
    Text = "受け入れる"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Cancel_Content = {
    Text = "キャンセル済み"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Done_Content = {
    Text = "私をフォロー済み"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Mutual_Content = {
    Text = "相互フォロー"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse2_Content = {
    Text = "拒否済み"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse_Content = {Text = "拒否"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Timeout_Content = {
    Text = "タイムアウト"
  },
  PanelText_UI_Social_Item_PveRecord_Text_Fail_Content = {Text = "失敗"},
  PanelText_UI_Social_Item_PveRecord_Text_Victory_Content = {Text = "勝利"},
  PanelText_UI_Social_Item_PvpData_Text_Fail_Content = {Text = "失敗"},
  PanelText_UI_Social_Item_PvpData_Text_Victory_Content = {Text = "勝利"},
  PanelText_UI_Social_Item_PvpRecord_Text_Fail_Content = {Text = "失敗"},
  PanelText_UI_Social_Item_PvpRecord_Text_Victory_Content = {Text = "勝利"},
  PanelText_UI_Social_Item_Pvp_Text_C_Dispaly_Content = {
    Text = "戦闘記録を開放"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Input_Content = {
    Text = "「戦闘記録」を入力"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_NoTask_Content = {
    Text = "対人戦記録なし"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Nor_Content = {Text = "調査"},
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Sel_Content = {Text = "調査"},
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Nor_Content = {Text = "対人戦"},
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Sel_Content = {Text = "対人戦"},
  PanelText_UI_Social_Item_Pvp_Text_C_Search_Content = {
    Text = "再生する"
  },
  PanelText_UI_Social_Item_Pvp_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Attention_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Following_Content = {
    Text = "フォロー済み"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Interrelated_Content = {
    Text = "相互フォロー済み"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Assist_Content = {
    Text = "救援回数"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Awaker_Content = {
    Text = "リンク覚醒体"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Birthday_Content = {Text = "誕生日"},
  PanelText_UI_Social_Panel_Data_Text_C_Concern2_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Conclude_Content = {
    Text = "実績を達成"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Difficulty_Content = {Text = "高難度"},
  PanelText_UI_Social_Panel_Data_Text_C_Dream_Content = {
    Text = "幻夢の深奥"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Fans_Content = {
    Text = "フォロワー"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Help_Content = {
    Text = "救援覚醒体"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Indestructible_Content = {
    Text = "名状しがたい"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Not_Content = {
    Text = "救援覚醒体未設定"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Null_1_Content = {
    Text = "未公開の覚醒体"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Pagoda_Content = {
    Text = "無光の塔"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Privacy_Content = {
    Text = "守秘者は調査状況をプライバシーに設定した"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Register_Content = {
    Text = "ログイン日数"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Society_Content = {
    Text = "所属同好会"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Survey_Content = {
    Text = "調査状況"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Team_Content = {
    Text = "覚醒体公開"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Title_Content = {
    Text = "守秘者ファイル"
  },
  PanelText_UI_Social_Panel_HelpList_Filter_Text_C_Selected_Content = {
    Text = "選択済み"
  },
  ["PanelText_UI_Social_Panel_HelpList_Item_Text_C_ Interrelated_Content"] = {
    Text = "相互フォロー"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Attention_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Commonly_Content = {
    Text = "常用救援"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Conflict_Content = {
    Text = "界域競合"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Fans_Content = {
    Text = "フォロワー"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Following_Content = {
    Text = "フォロー済み"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recent_Content = {
    Text = "最近の救援"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recommend_Content = {
    Text = "未フォロー"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_CommonlyAssist_Content = {
    Text = "常用救援"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_1_Content = {Text = "更新"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_Content = {Text = "出場"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_1_Content = {Text = "更新"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_Content = {Text = "出場"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Mail_Content = {
    Text = "救援説明"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_NoTask_Content = {
    Text = "救援覚醒体なし\n※「覚醒体の絞り込み」を調整してください"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Time_Content = {
    Text = "相互フォローしている守秘者の救援覚醒体で出撃可能"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Title_Content = {
    Text = "救援を選択"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Attention_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Done_Content = {
    Text = "私をフォロー済み"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Following_Content = {
    Text = "フォロー済み"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Interrelated_Content = {
    Text = "相互フォロー"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Mutual_Content = {
    Text = "相互フォロー"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Unblock_Content = {
    Text = "ブロック解放"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_Unfollow_Content = {
    Text = "フォロー解除"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Concern_Content = {Text = "追加"},
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_NoTask_Content = {
    Text = "誰もフォローしていない"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_NoTask_Content = {
    Text = "関連検索なし"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_Name_Content = {
    Text = "すべてフォロー"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Concern_Content = {Text = "追加"},
  PanelText_UI_Social_Panel_Main_Text_C_NoTask_Content = {
    Text = "フォローなし"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Stranger_Content = {
    Text = "見知らぬ人"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_1_Content = {
    Text = "名前を入力して検索"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_2_Content = {
    Text = "名前を入力して検索"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_Interaction_Content = {
    Text = "インタラクション"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_NoTask_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_PlayerInfo_Content = {Text = "達人"},
  PanelText_UI_Social_Panel_RankList_Text_C_Rank_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_All_Content = {Text = "すべて"},
  PanelText_UI_Social_Panel_Rank_Text_C_Friend_Content = {
    Text = "フォロー"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Interaction_Content = {
    Text = "インタラクション"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_NoTask_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_PlayerInfo_Content = {
    Text = "守秘者情報"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Rank_Content = {
    Text = "ランキング"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Sign_Content = {Text = "紹介"},
  PanelText_UI_Social_Popup_Awaker_Text_C_Owned_Content = {
    Text = "所有済み"
  },
  PanelText_UI_Social_Popup_Birthday_Text_C_Title_Content = {
    Text = "誕生日を編集"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_NoTask_Content = {
    Text = "常用救援が設定されていません"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_SearchTip_Content = {
    Text = "UIDを入力して守秘者を検索"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Search_Content = {Text = "検索"},
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Title_Content = {
    Text = "常用救援"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_Time_Content = {
    Text = "他の場所を見てみましょう"
  },
  PanelText_UI_Social_Popup_FriendlyInvite_Text_Title_Content = {
    Text = "親善試合の招待"
  },
  PanelText_UI_Social_Popup_Introduction_Text_C_Placeholder_Content = {
    Text = "自己紹介を入力してください"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Content = {Text = "選択"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Desc_Content = {
    Text = "<size=25>対人戦の基本モード、双方が事前に準備したチームで対戦。</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Name_Content = {
    Text = "プリセットモード"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Content = {Text = "選択"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Desc_Content = {
    Text = "<size=25>対人戦の上級モード、双方がランダムカード群からカードを選び、デッキを編成して対戦。</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Name_Content = {
    Text = "ドラフトモード"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_Title_Content = {
    Text = "モード選択"
  },
  PanelText_UI_Social_Popup_Match_Text_C_Waiting_Content = {Text = "待機中"},
  PanelText_UI_Social_Popup_Match_Text_Name_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Social_Popup_Match_Text_Title_Content = {
    Text = "親善試合"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Content = {
    Text = "アイコンフレーム"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Sel_Content = {
    Text = "アイコンフレーム"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Content = {
    Text = "アイコン"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Sel_Content = {
    Text = "アイコン"
  },
  PanelText_UI_Social_Popup_Situation_Tips_Text_C_AffixInfo_Content = {
    Text = "調査状況"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_C_Cost_Content = {Text = "消費"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Cancel_Name_Content = {
    Text = "キャンセル"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Title_Content = {
    Text = "性別を切り替える"
  },
  PanelText_UI_Social_Popup_WatchList_Text_C_NoTask_Content = {
    Text = "新しいフォロワーなし"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Name_FollowAll_Content = {
    Text = "すべてフォロー"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Tip_Content = {
    Text = "最近追加された100人のフォロワーを確認できます"
  },
  PanelText_UI_Social_Tips_InviteBubble_Text_Name_Content = {
    Text = "親善試合"
  },
  PanelText_UI_Story_Panel_Main_Text_C_High_Content = {
    Text = "ログイン背景をリセット"
  },
  PanelText_UI_Story_Panel_Main_Text_C_Normal_Content = {
    Text = "ログイン背景に設定"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Continue_Content = {
    Text = "旅を続ける"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Title_Content = {
    Text = "記憶アーカイブ"
  },
  PanelText_UI_Story_Portrait_Test_Text_C_Close_Content = {Text = "閉じる"},
  PanelText_UI_Story_Portrait_Test_Text_C_Hide_Content = {Text = "秘密"},
  PanelText_UI_Summon_Btn_Jump_Text_C_Look_Content = {Text = "確認"},
  PanelText_UI_Summon_Btn_Realms_Text_C_Difficulty_Content = {Text = "難易度"},
  PanelText_UI_Summon_Btn_Realms_Text_C_Directional_Content = {
    Text = "現在の界域"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Name_Content = {Text = "選 択"},
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Full_Content = {
    Text = "霊知啓発完了"
  },
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Have_Content = {
    Text = "所有済み"
  },
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Max_Content = {Text = "Max"},
  PanelText_UI_Summon_Item_Probability_Text_C_Role_Content = {
    Text = "総合確率"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Type_Content = {Text = "タイプ"},
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_GiftTitle_Content = {
    Text = "任務を完了して幻衣交換券を受け取る"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_1_Content = {
    Text = "限定覚醒体×2確定"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_2_Content = {
    Text = "限定運命の札×3確定"
  },
  PanelText_UI_Summon_Panel_Main_Text_Award_Content = {
    Text = "追加報酬"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Choose_Content = {
    Text = "選択を始める"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Difficult_Title_Content = {Text = "難易度"},
  PanelText_UI_Summon_Panel_Main_Text_C_FreeLimit_Content = {Text = "無料"},
  PanelText_UI_Summon_Panel_Main_Text_C_Hint_Content = {
    Text = "でもこちらで界域を変更できる"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_LimitName_Content = {Text = "5回召喚"},
  PanelText_UI_Summon_Panel_Main_Text_C_Look_Content = {Text = "確認"},
  PanelText_UI_Summon_Panel_Main_Text_C_Realms_Content = {
    Text = "界域を選定"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_RecAwaker_Content = {
    Text = "推奨の覚醒体"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Summon_Content = {Text = "5回召喚"},
  PanelText_UI_Summon_Panel_Main_Text_C_System_Name_Content = {Text = "召喚"},
  PanelText_UI_Summon_Panel_Main_Text_C_TryName_Content = {
    Text = "覚醒体試用"
  },
  PanelText_UI_Summon_Panel_Main_Text_Desc_2_Content = {Text = "説明"},
  PanelText_UI_Summon_Panel_Main_Text_FreeTen_Content = {Text = "無料"},
  PanelText_UI_Summon_Panel_Main_Text_Recommend_Content = {
    Text = "新生推薦の覚醒"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Choose_Content = {
    Text = "選択を開始"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Title_Content = {
    Text = "選択済み覚醒体"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Detail_Content = {
    Text = "ルール説明"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Inventory_Content = {
    Text = "アイテムリスト"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Not_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Prompt_Content = {
    Text = "このページで過去6ヶ月の起動記録を確認できます。データには約1時間の遅延がある場合があります。"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_REcording_Content = {
    Text = "召喚記録"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Role_Content = {
    Text = "召喚タイプ"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Time_Content = {
    Text = "召喚時間"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_1_Content = {
    Text = "召喚タイプ"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_Content = {Text = "タイプ"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Up_Content = {
    Text = "UPアイテム"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Not_Content = {
    Text = "記録なし"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Prompt_Content = {
    Text = "このページで過去6ヶ月の召喚記録を確認できます。データには約1時間の遅延がある場合があります。"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Role_Content = {
    Text = "召喚タイプ"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Time_Content = {
    Text = "召喚時間"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Title_Content = {
    Text = "召喚履歴"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Type_Content = {Text = "タイプ"},
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Change_Content = {Text = "再選択"},
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_ChooseTitle_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Choose_Content = {
    Text = "選択を開始"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_InfoTitle_Content = {
    Text = "プレイ説明"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_Title_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Confirm_Content = {
    Text = "選択を完了"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Tip_Content = {
    Text = "覚醒体を長押しで詳細表示"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Confirm_Content = {
    Text = "選択を完了"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Tip_Content = {
    Text = "覚醒体を長押しで詳細表示"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Title_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Activity_Content = {
    Text = "運命の札贈呈"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Game_Content = {
    Text = "覚醒体贈呈"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Info_Content = {
    Text = "150回【界域研究】召喚ごとに、上記の任意の覚醒体/運命の札を追加取得可能"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Plan_Content = {Text = "進捗"},
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Check_Content = {
    Text = "詳細を確認する"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Git_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Detail_Content = {
    Text = "詳細説明"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Inventory_Content = {
    Text = "アイテムリスト"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Up_Content = {
    Text = "UPアイテム"
  },
  PanelText_UI_Summon_Popup_Realms_Text_C_Introduce_Content = {
    Text = "界域を選択後、覚醒体はその界域のキャラとなる。後で変更可能。"
  },
  PanelText_UI_Summon_Popup_Recording_Text_C_Prompt_Content = {
    Text = "このページで過去6ヶ月の召喚記録を確認できます。データには約1時間の遅延がある場合があります。"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_ChooseTitle_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_Choose_Content = {
    Text = "選択を開始"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_InfoTitle_Content = {
    Text = "プレイ説明"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_Title_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Summon_Popup_Share_Text_C_Share_Content = {
    Text = "共有先："
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_Autofine_Content = {
    Text = "自動強化"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_C_Name_Content = {Text = "1回召喚"},
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_Autofine_Content = {
    Text = "自動強化"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_C_Name_Content = {Text = "1回召喚"},
  PanelText_UI_Summon_Popup_Show_Rare_Text_Autofine_Content = {
    Text = "自動強化"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_C_Name_Content = {Text = "1回召喚"},
  PanelText_UI_Summon_Popup_Total_Show_Text_C_Share_Content = {
    Text = "初回シェアで"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Confirm_Name_Content = {Text = "確定"},
  PanelText_UI_Summon_Popup_Total_Show_Text_Name_Content = {Text = "再召喚"},
  PanelText_UI_Summon_Popup_Total_Show_Text_ReSummon_Content = {Text = "5回召喚"},
  PanelText_UI_Summon_Popup_Total_Show_Text_Toggle_Content = {
    Text = "演出スキップ"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Name_Content = {Text = "1回召喚"},
  PanelText_UI_Summon_Result_Panel_Text_C_Share_Content = {
    Text = "初回シェアで"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Auto_Content = {
    Text = "推奨の運命の札を自動選択"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_ChooseTitle_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Choose_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Confirm_Content = {
    Text = "選択を確認"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_InfoTitle_Content = {
    Text = "プレイ説明"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_Title_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Task_Item_Detail_List_New_Text_C_Get_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Achievement_Content = {Text = "実績"},
  PanelText_UI_Task_Panel_Main_New_Text_C_ActionReports_Content = {
    Text = "行動報告"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_GrowUp_Content = {
    Text = "成長記録"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Master_Content = {
    Text = "界域知識"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips_Content = {
    Text = "日毎の任務完了"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Title_Content = {
    Text = "任務なし"
  },
  PanelText_UI_Task_Popup_Career_Item_Text_C_Undone_Content = {Text = "未達成"},
  PanelText_UI_Task_Popup_Career_Item_Text_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Task_Popup_Career_New_Text_C_1_Content = {
    Text = "現在の進行状況"
  },
  PanelText_UI_Task_Popup_Career_New_Text_C_Chapter_Award_Content = {
    Text = "完了報酬"
  },
  PanelText_UI_Task_Popup_Career_Text_C_1_Content = {
    Text = "現在の進行状況"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Award_Content = {
    Text = "完了報酬"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Get_Content = {
    Text = "報酬を受け取りました"
  },
  PanelText_UI_Task_Popup_Career_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_Name_2_Content = {
    Text = "すべて受け取る"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_ReachName_Content = {
    Text = "「すべて」達成"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Info1_Content = {
    Text = "調査レベルを上げて報酬を獲得"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Level1_Content = {Text = "レベル"},
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Undone1_Content = {Text = "未達成"},
  PanelText_UI_Task_Popup_Challenge_Item1_Text_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Info_Content = {
    Text = "調査レベルを上げて報酬を獲得"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Level_Content = {Text = "レベル"},
  PanelText_UI_Task_Popup_Challenge_Item_Text_Name_Content = {
    Text = "受け取る"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_1_Content = {Text = "守秘者"},
  PanelText_UI_Task_Popup_Challenge_New_Text_C_2_Content = {
    Text = "録音時間"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_3_Content = {
    Text = "調査レベル"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_Title_Content = {
    Text = "実績解放"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_1_Content = {Text = "守秘者"},
  PanelText_UI_Task_Popup_Challenge_Text_C_2_Content = {
    Text = "録音時間"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_3_Content = {
    Text = "調査レベル"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_OneKey_Content = {
    Text = "一括受取"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Reach_Content = {
    Text = "銀の鍵の導きがあらんことを"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Title_Content = {Text = "学生証"},
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Award_Content = {
    Text = "任務報酬"
  },
  PanelText_UI_Team_Item_Awaker_List_Text_C_Disable_Content = {Text = "禁止"},
  PanelText_UI_Team_Item_Awaker_List_Text_C_Help_Content = {
    Text = "救援覚醒体"
  },
  PanelText_UI_Team_Item_MyTeam_List_Text_C_Current_Content = {
    Text = "現在出撃中"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Guide_Content = {Text = "推奨"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Hint_Content = {
    Text = "※同一覚醒体に装備できるSSR運命の札は一つ"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Recommend_Content = {Text = "推奨"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Remove_Content = {
    Text = "一括解除"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Uninstall_Content = {
    Text = "一括解除"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Foundation_Content = {Text = "能力"},
  PanelText_UI_Team_Item_Secret_Props_Text_C_Lv_Content = {
    Text = "レベル達成度"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Refining_Content = {
    Text = "転写完了度"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Null_Content = {
    Text = "有効なセット効果なし"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Title_Content = {
    Text = "セット効果"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Added_Content = {
    Text = "新たな密約セット"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_2_Content = {Text = "外す"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_3_Content = {Text = "強化"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_4_Content = {Text = "装備"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Null_Content = {
    Text = "現在の部位には使用可能な密約がありません"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Quantity_Content = {
    Text = "セット数量"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Save_Content = {
    Text = "新たな密約セット"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Suit_Content = {
    Text = "現在使用可能なセットはありません"
  },
  PanelText_UI_Team_Item_Suit_Text_C_Current_Content = {
    Text = "現在使用中"
  },
  PanelText_UI_Team_Item_Talent_Text_C_Activate_Content = {
    Text = "起動完了"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Foundation_Content = {Text = "能力"},
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Lv_Content = {
    Text = "レベル達成度"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Refining_Content = {
    Text = "転写完了度"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Null_Content = {
    Text = "有効なセット効果なし"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Title_Content = {
    Text = "セット効果"
  },
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Empty_Content = {
    Text = "左側の運命の札を選択"
  },
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Not_Content = {Text = "未発効"},
  PanelText_UI_Team_Panel_Awaker_Main_Text_C_Zhanli_Content = {Text = "戦力"},
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Recommend_Content = {
    Text = "おすすめ"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Remove_Content = {
    Text = "一括解除"
  },
  PanelText_UI_Team_Panel_Main_Popup_Team_Text_C_AffixInfo_Content = {
    Text = "チーム情報"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Activated_Content = {
    Text = "発動完了"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Boundaries_Tips_Content = {
    Text = "推奨界域"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Cost_Tips_Content = {
    Text = "チーム要求："
  },
  PanelText_UI_Team_Panel_Main_Text_C_Empty_Content = {
    Text = "キーオーダー未装備"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Frequency_Content = {Text = "回数"},
  PanelText_UI_Team_Panel_Main_Text_C_Hint_Content = {
    Text = "※クリア後、出撃済みの覚醒体、運命の札、キーオーダーは他の融災禁区で使用できません。"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Lives_Desc_Content = {
    Text = "復活の魂魄残り回数："
  },
  PanelText_UI_Team_Panel_Main_Text_C_Name_1_Content = {Text = "解放"},
  PanelText_UI_Team_Panel_Main_Text_C_Name_2_Content = {Text = "救援"},
  PanelText_UI_Team_Panel_Main_Text_C_NoActivate_Content = {Text = "未発動"},
  PanelText_UI_Team_Panel_Main_Text_C_Prohibit_Content = {
    Text = "このステージでキーオーダー使用禁止"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Skill_Content = {
    Text = "キーオーダー"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips2_Content = {
    Text = "チーム情報"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_1_Content = {Text = "救援"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips_2_Content = {Text = "救援"},
  PanelText_UI_Team_Panel_Main_Text_C_Tips_Content = {
    Text = "救援解放"
  },
  PanelText_UI_Team_Panel_Main_Text_Madness_Content = {
    Text = "超難度は初回クリア報酬のみ"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Delete_Content = {
    Text = "セットを削除"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Edit_Content = {
    Text = "セット編集"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Recommend_Content = {
    Text = "推奨装備"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Remove_Content = {
    Text = "一括解除"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Save_Content = {
    Text = "セットとして保存"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Guide_Content = {Text = "推奨"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Hint_Content = {
    Text = "※同一覚醒体に装備できるSSR運命の札は一つ"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_2_Content = {Text = "外す"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_3_Content = {Text = "強化"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Null_Content = {
    Text = "現在、運命の札はありません"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Title_Content = {
    Text = "運命の札を選択"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Uninstall_Content = {
    Text = "一括解除"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Attribute_Content = {Text = "能力"},
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Name_Content = {
    Text = "覚醒体詳細"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "覚醒体を選択"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Xx_Content = {
    Text = "詳細情報"
  },
  PanelText_UI_Team_Popup_MyTeam_Awaker_List_Text_C_Name_Content = {Text = "選択"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name04_Content = {Text = "超次元"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "職業特性"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_C_Task_Content = {
    Text = "初回の事件完了後、自動取得"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_Title_Content = {
    Text = "初クリア報酬"
  },
  PanelText_UI_Vx_Battle_Chaowei_Butter_Text_C_ExtraTurn_Content = {
    Text = "追加\nターン"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Normal_Content = {
    Text = "強化順序"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Select_Content = {
    Text = "強化順序"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Normal_Content = {Text = "順序"},
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Select_Content = {Text = "順序"},
  PanelText_UI_Weapon_Item_Select_List_Text_No_Weapon2_Content = {
    Text = "装備不可の運命の札"
  },
  PanelText__Text_C_Dress_Content = {Text = "着替え"},
  PanelText__Text_C_Dressing_Content = {Text = "装着中"},
  PanelText__Text_C_Empty_Content = {
    Text = "販売終了"
  },
  PanelText__Text_C_Goto_Content = {
    Text = "購入へ進む"
  },
  PanelText__Text_C_Have_Content = {
    Text = "所有済み"
  },
  PanelText__Text_C_Reveal_Content = {Text = "秘密"}
})
return Text_PanelText
