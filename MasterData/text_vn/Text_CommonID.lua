__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {
    Text = "Tài khoản"
  },
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "Thương cao nhất"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "Tầng cao nhất"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Thời gian hoàn thành"
  },
  CommonID_AchieveType0_Desc = {
    Text = "Tất cả thành tựu"
  },
  CommonID_AchieveType1_Desc = {
    Text = "Câu chuyện phát triển"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Khám phá dấu ấn"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Nhật ký chiến đấu"
  },
  CommonID_AchieveType4_Desc = {
    Text = "Sự nghiệp giữ bí mật"
  },
  CommonID_Add_State_Desc = {
    Text = "Thêm trạng thái"
  },
  CommonID_All_Desc = {Text = "Tất cả"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Điều kiện hoàn thành nhiệm vụ: Đã kích hoạt ít nhất một điểm cốt truyện"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Điều kiện hoàn thành nhiệm vụ: Mở khóa bất kỳ mục nào trong nhóm hình ảnh"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Điều kiện hoàn thành nhiệm vụ: Kích hoạt ít nhất một sự kiện"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Điều kiện hoàn thành nhiệm vụ: Nhận được ít nhất một đạo cụ"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Điều kiện hoàn thành nhiệm vụ: Kích hoạt bất kỳ loại nút nào"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Điều kiện hoàn thành nhiệm vụ: Đã nhận được ít nhất một sáng tạo"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Điều kiện hoàn thành nhiệm vụ: Hoàn thành lần đầu một mức độ bất kỳ trong danh sách"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Tăng phần thưởng khi được giao nhiệm vụ"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Nâng thuộc tính"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Người đánh thức đã chết"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Thủ lĩnh của thân thể được thức tỉnh"
  },
  CommonID_BN_Desc = {
    Text = "Tiếng Bengal (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "Không thể ra trận"
  },
  CommonID_Battle_Desc = {
    Text = "Trận chiến"
  },
  CommonID_Blue_Desc = {
    Text = "Xanh dương"
  },
  CommonID_Boss_Desc = {
    Text = "Lãnh đạo"
  },
  CommonID_BundleShortcutKey_Desc = {
    Text = "Phím tắt"
  },
  CommonID_CN_Desc = {
    Text = "Tiếng Việt"
  },
  CommonID_CardBorder_Desc = {
    Text = "Ngoại hình thẻ bài"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Khe nâng cấp"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "Imageri cao cấp"
  },
  CommonID_Card_AttachPost_Desc = {
    Text = "Truy đuổi"
  },
  CommonID_Card_Awake_Desc = {
    Text = "Khai mở linh trí"
  },
  CommonID_Card_Curse_Desc = {
    Text = "Lá bài triệu chứng"
  },
  CommonID_Card_Defend_Desc = {
    Text = "Thẻ phòng thủ"
  },
  CommonID_Card_Developing_Desc = {
    Text = "Đang phát triển"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Thẻ nguồn"
  },
  CommonID_Card_Fraud_Desc = {
    Text = "Lừa đảo"
  },
  CommonID_Card_Imagery_Desc = {
    Text = "Hình tượng"
  },
  CommonID_Card_KeeperSkill_Desc = {
    Text = "Lệnh khóa"
  },
  CommonID_Card_Potion_Desc = {
    Text = "Thẻ dung dịch"
  },
  CommonID_Card_Skill_Desc = {
    Text = "Thẻ kỹ năng"
  },
  CommonID_Card_State_Desc = {
    Text = "Lá bài trạng thái"
  },
  CommonID_Card_Strike_Desc = {
    Text = "Thẻ Đánh"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Vòng mệnh"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Cấp độ kỹ năng"
  },
  CommonID_Challenge_Desc = {
    Text = "Điều tra"
  },
  CommonID_Change_Skill_Desc = {
    Text = "Kỹ năng thay thế"
  },
  CommonID_Chinese_Desc = {
    Text = "Tiếng Hán"
  },
  CommonID_ChooseHandCard_Desc = {
    Text = "Chọn thẻ"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Bấm để thoát"
  },
  CommonID_ClickToView_Desc = {
    Text = "Nhấn để xem"
  },
  CommonID_Click_Desc = {
    Text = "Nhấp vào để chuyển hướng"
  },
  CommonID_Close_Desc = {Text = "Tắt"},
  CommonID_ComingSoon_Desc = {
    Text = "Xin hãy mong chờ"
  },
  CommonID_CommonAttr_Desc = {
    Text = "Thuộc tính chung phụ gia"
  },
  CommonID_Common_Desc = {
    Text = "Bình thường"
  },
  CommonID_ContinuousSound_Desc = {
    Text = "Phát liên tục"
  },
  CommonID_CopperAchieve_Desc = {Text = "Đồng"},
  CommonID_CountingStart_Desc = {
    Text = "Thời gian đếm ngược của lượt của chúng tôi bắt đầu"
  },
  CommonID_Custom_Desc = {
    Text = "Tùy chỉnh"
  },
  CommonID_DE_Desc = {
    Text = "Tiếng Đức (alpha)"
  },
  CommonID_DPS_Desc = {
    Text = "Đột kích"
  },
  CommonID_DepressionHit_Desc = {
    Text = "Trầm cảm sau khi bị tấn công"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Tắt kỹ năng nhân vật chính"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Cấm sử dụng giao ước"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Cấm sử dụng bánh xe định mệnh"
  },
  CommonID_Display_Desc = {
    Text = "Hình ảnh"
  },
  CommonID_DropdownList_Desc = {
    Text = "Danh sách thả xuống"
  },
  CommonID_EN_Desc = {
    Text = "Tiếng Anh (GPT beta)"
  },
  CommonID_ES_Desc = {
    Text = "Tiếng Tây Ban Nha (alpha)"
  },
  CommonID_Elite_Desc = {Text = "Élite"},
  CommonID_EmojiType_10_Desc = {
    Text = "Bé bé Misaque"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "Đảo ngược lượt"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "Misaque hoạt động hàng ngày"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "Vui Misaque"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "Buồn bã Misaque"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "Cuộc sống học đường"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "Một ngày hòa bình"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "Thời gian rỗi sau giờ học"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "So với trái tim Misaque"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "Kỳ nghỉ Misaque"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Mềm Misaque"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Misaque Lễ Hội Đông Độ"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Bữa tiệc bánh gừng"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Chuyện vui ở trường"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Điều tra viên Misaque"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Misaque kịch giữa màn"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "Bài hát của Sa Ya"
  },
  CommonID_EmojiType_2_Desc = {
    Text = "Đoàn Đoàn's đêm trước"
  },
  CommonID_EmojiType_3_Desc = {
    Text = "Hình thái của thế gian"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Quên \"Q\" Trước Đêm"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Giao tiếp pha"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Rực rỡ Misaque"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "Điên cuồng Misaque"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "Thoải mái Misaque"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Trí tuệ Misaque"
  },
  CommonID_Enchant_Desc = {
    Text = "Khắc ấn"
  },
  CommonID_Entrance_Desc = {
    Text = "Lối vào cửa sổ"
  },
  CommonID_FALSE_Desc = {Text = "Không"},
  CommonID_FR_Desc = {
    Text = "Tiếng Pháp (alpha)"
  },
  CommonID_Forged_Desc = {
    Text = "tăng cường"
  },
  CommonID_FreeBattlePos_Desc = {
    Text = "Tùy ý xuất trận"
  },
  CommonID_FullScreen_Desc = {
    Text = "Toàn màn hình"
  },
  CommonID_Gender_Boy_Desc = {Text = "Nam"},
  CommonID_Gender_Girl_Desc = {Text = "Nữ"},
  CommonID_GetLikeLevel_Desc = {Text = "Hàm số"},
  CommonID_GmaeVoice_Desc = {
    Text = "Âm thanh trong game"
  },
  CommonID_GoldAchieve_Desc = {Text = "Vàng"},
  CommonID_Hall_Desc = {
    Text = "Đại sảnh"
  },
  CommonID_HarvestAdd_Desc = {
    Text = "Ngôi nhà tăng phần thưởng"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Điều kiện hoàn thành nhiệm vụ: Sở hữu một trong các thân thể được đánh thức"
  },
  CommonID_HeadType_1_Desc = {
    Text = "Nhân Danh Chìa Khóa Bạc"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Hồ sơ ngốc nghếch"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Ngày hôm qua không bao giờ phai nhạt"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Tem lưu giữ"
  },
  CommonID_High_Desc = {Text = "Cao"},
  CommonID_Holy_Desc = {
    Text = "Thánh hóa"
  },
  CommonID_ID_Desc = {
    Text = "Tiếng Indonesia (alpha)"
  },
  CommonID_IT_Desc = {
    Text = "Tiếng Ý (alpha)"
  },
  CommonID_Image_Desc = {
    Text = "Hình ảnh"
  },
  CommonID_Intent_AttackBuff_Desc = {
    Text = "Quái vật sẽ tấn công và tăng cường"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "Quái vật có ý định tấn công và suy yếu"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "Quái vật có ý định tấn công và suy yếu"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Ý định của quái vật là tấn công và phòng thủ"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "Quái vật có ý định tấn công"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "Quái vật ý định tăng cường"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Quái vật ý đồ điên cuồng không tấn công"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Quái vật ý định cuồng nộ cực độ"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "Quái vật định tung ra đòn tấn công cuối cùng"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Ý định điên cuồng của quái vật"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "Quái vật ý định tăng cường"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "Quái vật ý định tăng cường"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "Ý định suy yếu của quái vật"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "Quái vật có ý định phòng thủ và tăng cường"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Quái vật có ý định phòng thủ và làm suy yếu"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Quái vật có ý định phòng thủ"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Quái vật có ý định gây choáng"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "Quái vật có ý định thực hiện đòn tấn công mạnh"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "Quái vật có ý định thực hiện đòn tấn công mạnh"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "Ý định của quái vật là tăng cường cực mạnh"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "Ý định của quái vật là suy yếu mạnh"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "Ý định quái vật không rõ"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "Ý định quái vật không rõ"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "Ý định quái vật không rõ"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "Ý định quái vật không rõ"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "Ý định quái vật không rõ"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "Ý định quái vật không rõ"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "Ý định quái vật không rõ"
  },
  CommonID_ItemManagement_Desc = {
    Text = "Vật phẩm"
  },
  CommonID_JP_Desc = {
    Text = "Nhật ngữ (alpha)"
  },
  CommonID_KR_Desc = {
    Text = "Tiếng Hàn (alpha)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Kỹ năng nhân vật chính"
  },
  CommonID_KeyType_1_Desc = {Text = "Bài Quên"},
  CommonID_KeyType_2_Desc = {
    Text = "Cõi hỗn mang"
  },
  CommonID_KeyType_3_Desc = {
    Text = "Vùng biển sâu"
  },
  CommonID_KeyType_4_Desc = {
    Text = "Cõi huyết nhục"
  },
  CommonID_KeyType_5_Desc = {
    Text = "Vương quốc siêu cấp"
  },
  CommonID_Key_Desc = {Text = "Phím"},
  CommonID_Language_Desc = {
    Text = "Ngôn ngữ"
  },
  CommonID_LevelLimit_Promote_Desc = {
    Text = "Cấp độ tối đa được tăng lên"
  },
  CommonID_Low_Desc = {Text = "Thấp"},
  CommonID_Management_Desc = {
    Text = "Vào quản lý"
  },
  CommonID_ManiaHit_Desc = {
    Text = "Cuồng nộ khi bị đánh"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Kiểm soát toàn bộ"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Trả lại tài nguyên tiêu thụ"
  },
  CommonID_MessagePush_Desc = {
    Text = "Thông báo đẩy tin"
  },
  CommonID_Middle_Desc = {Text = "Trung"},
  CommonID_Modify_Desc = {
    Text = "Nhấn để chỉnh sửa"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "Một nhóm quái nhỏ"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Quái cấp hai"
  },
  CommonID_MotherTreeMonster_Desc = {Text = "Cây mẹ"},
  CommonID_MultiplierXP_Desc = {
    Text = "Tăng cường kinh nghiệm bội số"
  },
  CommonID_Mute_Desc = {
    Text = "Tắt tiếng"
  },
  CommonID_NotAwakerMonster_Desc = {
    Text = "Trùm không phải thân thể được đánh thức"
  },
  CommonID_Open_Desc = {Text = "Mở"},
  CommonID_OperationImpossible_Desc = {
    Text = "Người chơi thao tác không thành công vì nhiều lý do (thiếu sức mạnh toán học, không phải lượt của mình, bị phong ấn hoặc bị hóa đá, v.v.) (ra thẻ, bùng nổ điên cuồng)"
  },
  CommonID_OperationStop_Desc = {
    Text = "Thời gian suy nghĩ trong lượt của chúng tôi đã đạt đến giới hạn tối đa (được cấu hình trong bảng hằng số)"
  },
  CommonID_Orange_Desc = {Text = "Vàng"},
  CommonID_PT_Desc = {
    Text = "Tiếng Bồ Đào Nha (alpha)"
  },
  CommonID_PVP_Desc = {
    Text = "đối đầu pha"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "Kỹ năng thụ động"
  },
  CommonID_PersonalProfile_Desc = {
    Text = "Hồ sơ cá nhân"
  },
  CommonID_PlayerEnter_Desc = {
    Text = "Trò chơi bắt đầu, người chơi chọn xong bài"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Hồ sơ Người giữ bí mật"
  },
  CommonID_Potency_Desc = {
    Text = "khởi linh"
  },
  CommonID_Privacy_Desc = {Text = "Riêng tư"},
  CommonID_Purple_Desc = {
    Text = "Con lắc thời gian"
  },
  CommonID_RU_Desc = {
    Text = "Tiếng Nga (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Hiệu ứng ánh sáng đỏ"
  },
  CommonID_Red_Desc = {
    Text = "lời nguyền"
  },
  CommonID_Redeem_Desc = {
    Text = "Đổi phần thưởng"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Đối thoại có liên quan giữa những người đánh thức trong phe đối phương và phe ta"
  },
  CommonID_Relic_Desc = {Text = "Di vật"},
  CommonID_Repair_Desc = {
    Text = "Tới sửa"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Yêu cầu tài nguyên giảm bớt"
  },
  CommonID_SUP_Desc = {Text = "Hỗ trợ"},
  CommonID_SellCard_Desc = {Text = "Bán thẻ"},
  CommonID_ShortcutKey_Desc = {
    Text = "Phím tắt"
  },
  CommonID_SilverAchieve_Desc = {Text = "Bạc"},
  CommonID_Sin_Desc = {
    Text = "Tội lỗi nguyên thủy"
  },
  CommonID_SkillReady_Desc = {
    Text = "Khi thanh điên cuồng đầy và có thể nhấp vào để bùng nổ điên cuồng"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Nâng cấp kỹ năng"
  },
  CommonID_Slider_Desc = {
    Text = "Thanh trượt số"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "Cấp độ khe gốc"
  },
  CommonID_SoundBalance_Desc = {
    Text = "Cân bằng âm thanh"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Điều kiện hoàn thành nhiệm vụ: Đã kích hoạt đối thoại chỉ định của thiết bị liên lạc"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Bản sao tăng số lượng phần thưởng"
  },
  CommonID_Switch_Desc = {
    Text = "Công tắc"
  },
  CommonID_System_Desc = {
    Text = "Hệ thống"
  },
  CommonID_TH_Desc = {
    Text = "Tiếng Thái (alpha)"
  },
  CommonID_TRUE_Desc = {
    Text = "Đúng vậy"
  },
  CommonID_TR_Desc = {
    Text = "Tiếng Thổ Nhĩ Kỳ (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "Chữ Trung Quốc phồn thể"
  },
  CommonID_T_Desc = {
    Text = "Phòng thủ"
  },
  CommonID_TaskCount_Desc = {Text = "Đếm"},
  CommonID_TaskInProgress_Desc = {
    Text = "Đang tiến hành"
  },
  CommonID_TaweiMonster_Desc = {Text = "Tà Vy"},
  CommonID_Through1_Desc = {
    Text = "Kỹ năng bị động 1"
  },
  CommonID_Through2_Desc = {
    Text = "Kỹ năng Bị động 2"
  },
  CommonID_Tips_Desc = {Text = "Gợi ý"},
  CommonID_TranslationLabel_Desc = {
    Text = "Nhãn bản dịch chính thức"
  },
  CommonID_Ulti_Skill_Desc = {Text = "Bùng nổ"},
  CommonID_UtlSkill_Promote_Desc = {
    Text = "Siêu Cuồng Nộ"
  },
  CommonID_VN_Desc = {
    Text = "Tiếng Việt (alpha)"
  },
  CommonID_VeryHigh_Desc = {Text = "Rất cao"},
  CommonID_VeryLow_Desc = {
    Text = "Rất thấp"
  },
  CommonID_View_Desc = {
    Text = "Đi kiểm tra xem sao"
  },
  CommonID_Voice_Desc = {Text = "Âm thanh"},
  CommonID_Web_Desc = {
    Text = "Chuyển trang"
  },
  CommonID_White_Desc = {Text = "Bạc"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Hiệu ứng âm thanh khi cửa sổ không được tập trung"
  },
  CommonID_Window_Desc = {Text = "Cửa sổ"},
  CommonID_YellowGlow_Desc = {
    Text = "Ánh sáng vàng"
  }
})
return Text_CommonID
