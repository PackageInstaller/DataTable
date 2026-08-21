-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/setting/setting_view.lua

local WindowShowType = WindowType.WindowShowType
local WindowResourceType = WindowType.WindowResourceType
local setting_view = {}

setting_view.battle_test = {
	isSupportBack = false,
	presentor = "BattleTestViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.AutoResourceType
}
setting_view.battle_record = {
	presentor = "BattleRecordViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.AutoResourceType
}
setting_view.battle_main = {
	presentor = "BattleMainViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.scene_picker = {
	isSupportBack = false,
	presentor = "ScenePickerViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.battle_round_report = {
	presentor = "BattleRoundReportViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.battle_side_hint = {
	presentor = "BattleSideHintViewPresentor",
	showType = WindowShowType.FullScreenHudShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.battle_tag_side_hint = {
	presentor = "BattleTagSideHintViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_calculate = {
	presentor = "BattleCalculateViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_calculate_new = {
	presentor = "BattleCalculateViewNewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_results_win_view = {
	presentor = "BattleResultWinViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_results_fail_view = {
	presentor = "BattleResultFailViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_play_animation = {
	presentor = "BattlePlayBossAnimationViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_vs = {
	presentor = "BattleVsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_calculate_editor = {
	presentor = "BattleCalculateEditorViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_camp_adjustment = {
	presentor = "BattleCampAdjustmentViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_boss_property = {
	presentor = "BattleBossPropertyViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_full_screen_warn = {
	presentor = "BattleFullScreenWarnViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_team_message = {
	presentor = "BattleTeamMessageViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.battle_setting_tips = {
	presentor = "BattleSettingViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_restrain_hint = {
	presentor = "BattleRestrainHintViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.battle_skill_hint = {
	presentor = "BattleSkillHintViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_conditions = {
	presentor = "BattleConditionsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_undo = {
	presentor = "BattleUndoViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.main_ui_view = {
	isPreClose = true,
	presentor = "MainUIViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.main_setting_view = {
	presentor = "MainSettingViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.player_upgrade_show_view2 = {
	isSupportBack = false,
	presentor = "PlayerUpgradeShowView2Presentor",
	showType = WindowShowType.ModalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.run_time_inspector = {
	presentor = "RunTimeInspectorViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.main_perform_editor_view = {
	isSupportBack = false,
	presentor = "MainPerformEditorViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.main_ui_detect = {
	isSupportBack = false,
	presentor = "MainUIDetectViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.secret_time_open_tips = {
	isSupportBack = false,
	presentor = "AirtightRoomTimeOpenTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.secret_time_show_tips = {
	isSupportBack = false,
	presentor = "AirtightRoomTimeShowTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.loading = {
	isSupportBack = false,
	presentor = "LoadingViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.loading_black = {
	isSupportBack = false,
	presentor = "LoadingBlackViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.waiting_view = {
	isSupportBack = false,
	presentor = "WaitingViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.login = {
	presentor = "LoginViewPresentor",
	showType = WindowShowType.FullScreenHudShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.login_simulation_sdk = {
	presentor = "LoginSimulationSDKViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.confidentiality_tip = {
	presentor = "ConfidentialityTipViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.selectserver = {
	presentor = "SelectServerViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.lotterygyroinfo = {
	presentor = "LotteryGyroInfoPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.adjust_team_tips = {
	presentor = "AdjustTeamTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.backpack_view = {
	isPreClose = true,
	presentor = "BackpackViewViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.backpack_echoitem_filter = {
	presentor = "BackpackEchoItemFilterViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.backpack_equip_filter = {
	presentor = "BackpackEquipFilterViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.common_equip_filter = {
	presentor = "CommonEquipFilterViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.backpack_d6_filter = {
	presentor = "BackpackD6FilterViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.backpack_recycle = {
	presentor = "BackpackRecycleViewPresentorNew",
	showType = WindowShowType.NormalShowType
}
setting_view.resolve_item_tips = {
	presentor = "ResolveItemTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.treasure_choose_view_new = {
	isSupportBack = false,
	presentor = "TreasureChooseViewNewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.buff_tips = {
	presentor = "ToolTipsBattleBuffViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.item_tips = {
	presentor = "ItemTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.bttleresult_tips = {
	presentor = "ToolTipsBattleResultViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.team_tips = {
	presentor = "TeamTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.skill_detail_tips = {
	presentor = "ToolTipsSkillDetailViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.skill_detail_tips_copy = {
	isSupportBack = false,
	presentor = "ToolTipsCharacterSkillDetailViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.skill_detail_tips_normal = {
	isSupportBack = false,
	presentor = "ToolTipsCharacterSkillNormalViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.skill_detail_tips_manual = {
	isSupportBack = false,
	presentor = "ManualSkillTipsPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.skill_buff_tag_tips = {
	isSupportBack = false,
	presentor = "ToolTipsSkillBuffTagTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.hack_tool_view = {
	presentor = "HackToolViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.hack_optimise_view = {
	presentor = "HackOptimiseViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_attr_modify_tool_view = {
	presentor = "BattleAttrModifyHackViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.entitas_demo_view = {
	presentor = "EntitasDemoViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.team_main_view = {
	presentor = "TeamMainViewViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.gain_item_view = {
	isSupportBack = false,
	presentor = "GainItemViewPresentor",
	showType = WindowShowType.ModalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.top_toast_reward_notice = {
	isSupportBack = false,
	presentor = "TopToastRewardItemNoticeViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.item_convert_view = {
	presentor = "ItemConvertViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.hero_filter_tips = {
	isSupportBack = false,
	presentor = "HeroFilterTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.equip_hero_detail_tips = {
	presentor = "EquipHeroDetailTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.battle_danger_tips = {
	isSupportBack = false,
	presentor = "BattleDangerTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.dungeon_entrance = {
	presentor = "DungeonEntranceViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.gameplay_entrance = {
	presentor = "GameplayEntranceViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.dungeon_chapter_main = {
	isPreClose = true,
	presentor = "DungeonChapterMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.dungeon_material_main = {
	presentor = "MaterialDungeonViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.stable_area_entry_view = {
	presentor = "StableAreaEntryViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.stable_area_chapter_view = {
	presentor = "StableAreaChapterViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.dungeon_teaching_chapter = {
	presentor = "TeachingChapterViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.dungeon_teaching_main = {
	presentor = "TeachingDungeonViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.mainline_chapter_select = {
	isSupportBack = false,
	presentor = "MainlineChapterSelectViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.mainline_dungeon = {
	presentor = "MainlineDungeonViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.branch_unlock_tips = {
	isSupportBack = false,
	presentor = "BranchUnlockTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.dungeon_enemy = {
	presentor = "DungeonEnemyViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.equip_explore_view = {
	presentor = "EquipExploreDungeonViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.equip_explore_multiplicity_fight_tips = {
	isSupportBack = false,
	presentor = "EquipExploreMultiplicityFightTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.red_mist_entry_view = {
	presentor = "RedMistEntryViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.red_mist_chapter_view = {
	presentor = "RedMistChapterViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.climbing_tower_entry_view = {
	presentor = "ClimbingTowerEntryViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.climbing_tower_explain_tips = {
	presentor = "ClimbingTowerExplainTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.doom_battle_forecast = {
	isSupportBack = false,
	presentor = "DoomBattleForecastViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.air_workshop_def_scene = {
	isPreClose = true,
	presentor = "AirWorkShopDefSceneMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.common_confirm_tips = {
	presentor = "CommonConfirmTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.common_exchange_tips = {
	isSupportBack = false,
	presentor = "CommonExchangeTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.common_use_prop_single_tips = {
	isSupportBack = false,
	presentor = "CommonUsePropSingleTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_main_view = {
	presentor = "AirWorkShopMainViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_dynamics_view = {
	presentor = "AirWorkShopDynMsgViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_player_info_tips = {
	isSupportBack = false,
	presentor = "ToolTipsAirWorkPlayerInfoTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.air_cup_item_tips_view = {
	isSupportBack = false,
	presentor = "ToolTipsAirCupItemPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.air_workshop_message_set_view = {
	presentor = "AirWorkShopMessageSetViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_building_tips_view = {
	presentor = "ToolTipsAirBuildingViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.air_workshop_ambush_set_view = {
	presentor = "AirWorkShopAmbushSetViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_trigger_condition_select_view = {
	presentor = "AirWorkShopTriggerConditionSelectViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_theme_scene_select_view = {
	presentor = "AirWorkThemeSceneSelectViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_protocol_view = {
	presentor = "AirWorkProtocolViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_template_scene_select_view = {
	presentor = "AirWorkTemplateSelectViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_explain_view = {
	presentor = "AirWorkShopExplainViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.video_player_view = {
	presentor = "VideoPlayViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_store_view = {
	isPreClose = true,
	presentor = "AirWorkShopStoreViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_sort_view = {
	isPreClose = true,
	presentor = "AirWorkshopSortViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_hot_recommend_view = {
	isPreClose = true,
	presentor = "AirWorkShopHotRecommendViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_free_mode_view = {
	isPreClose = true,
	presentor = "AirWorkshopFreeModeViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_free_level_select_view = {
	isPreClose = true,
	presentor = "AirWorkShopFreeLevelSelectViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_sports_check_record_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopRodeoCheckRecordTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_rodeo_finish_result_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopRodeoFinishResultTipsPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.air_workshop_rodeo_rank_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopRodeoRankTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_task_view = {
	presentor = "AirWorkShopTaskViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_sports_mode_view = {
	presentor = "AirWorkShopRodeoMainViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_sports_reward_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopRodeoRewardTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_save_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopSaveLevelTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_trophy_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopTrophyTopTipsPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.air_workshop_challenge_schema_statistics_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopChallengeStatisticsTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_sports_mode_level_select_view = {
	isPreClose = true,
	presentor = "AirWorkShopRodeoLevelSelectViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_challenge_schema_rank_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopFreeRankTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_message_log_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopMessageLogTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_message_log_view = {
	isSupportBack = false,
	presentor = "AirWorkShopMsgLogViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.air_workshop_personal_page_view = {
	isPreClose = true,
	presentor = "AirWorkShopPersonalViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.air_workshop_rodeo_week_reward_tips = {
	isSupportBack = false,
	presentor = "AirWorkShopRodeoWeekRewardTipsPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.air_workshop_battle_result_view = {
	isSupportBack = false,
	presentor = "AirWorkBattleResultViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_battle_result_tag = {
	isSupportBack = false,
	presentor = "AirWorkBattleCalculateTagViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_battle_calculate_view = {
	isSupportBack = false,
	presentor = "AirWorkBattleCalculatePresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.air_work_defend_main = {
	presentor = "AirWorkDefendMainViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.air_workshop_setting_view = {
	presentor = "AirWorkSettingViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.air_workshop_select_position_view = {
	presentor = "AirWorkSelectPositionViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_select_hero_view = {
	presentor = "AirWorkSelectHeroViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_layout_over_view = {
	presentor = "AirWorkLayoutOverViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_record_view = {
	presentor = "AirWorkRecordViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_statistic_view = {
	presentor = "AirWorkStatisticViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.air_workshop_show_kill_view = {
	presentor = "AirWorkShowKillViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.air_workshop_manager_view = {
	presentor = "AirWorkManageViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.dungeon_star_reward = {
	isSupportBack = false,
	presentor = "DungeonStarRewardViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.dungeon_reward_detail = {
	isSupportBack = false,
	presentor = "DungeonRewardDetailViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.reward_preview = {
	presentor = "RewardPreviewViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.tool_tips_simple = {
	isSupportBack = false,
	presentor = "ToolTipsSimpleViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.tool_tips_simple2 = {
	isSupportBack = false,
	presentor = "ToolTipsSimple2ViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.tool_tips_skill_item_show = {
	isSupportBack = false,
	presentor = "ToolTipsSkillShowItemViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.tool_tips_center = {
	isSupportBack = false,
	presentor = "ToolTipsCenterViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.tool_tips_currency = {
	isSupportBack = false,
	presentor = "ToolTipsCurrencyViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.authority_jurisoiction_detail_tips = {
	presentor = "AuthorityJurisoictionDetailTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.team_detail_tips = {
	presentor = "ToolTipsTeamDetailViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.authority_detail_tips = {
	presentor = "AuthorityDetailTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.authority_upgrade_result_tips = {
	isSupportBack = false,
	presentor = "CharacterAuthorityUpgradeResultTipsPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.authority_node_unlock_View = {
	isSupportBack = false,
	presentor = "CharacterAuthorityNodeUnlockViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.role_info_tips = {
	presentor = "ToolTipsRoleInfoViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.echo_gyros_test = {
	presentor = "EchoGyrosTestPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.character_lookover_system = {
	presentor = "CharacterLookoverViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.character_feature = {
	presentor = "CharacterFeaturePresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.equip_filter_tip = {
	presentor = "EquipFilterTipPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.change_equip = {
	isPreClose = true,
	presentor = "EquipChangeViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.equip_intensify_and_detail_view = {
	presentor = "EquipIntensifyAndDetailViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.equip_recycle = {
	isPreClose = true,
	presentor = "EquipRecycleViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.equip_dice_reveal_view = {
	isSupportBack = false,
	presentor = "EquipDiceRevealViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.equip_timing_ani = {
	presentor = "EquipTimingAnimationViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.equip_timing_tuowei = {
	presentor = "EquipTimingTuoweiViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.equip_timing_test = {
	presentor = "EquipTimingMockViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.equip_timing_review_test = {
	presentor = "EquipTimingMockReViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.echo_upgrade_show = {
	presentor = "EchoUpgradeShowViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.character_upgrade = {
	isSupportBack = false,
	presentor = "CharacterUpgradeViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.character_upgrade_result_tips = {
	isSupportBack = false,
	presentor = "CharacterUpgradeResultTipsViewPresentor",
	showType = WindowShowType.ModalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.character_top_toast_tips = {
	isSupportBack = false,
	presentor = "CharacterTopToastTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.character_preview = {
	presentor = "CharacterPreviewViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.character_3d_preview = {
	presentor = "Character3DPreviewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.character_detail_preview = {
	presentor = "CharacterDetailPreviewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.character_skill_preview = {
	presentor = "CharacterSkillPreviewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.equip_upgrade_view = {
	presentor = "EquipUpgradeViewPresentor",
	showType = WindowShowType.ModalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.character_information = {
	presentor = "CharacterInformationViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.character_spine_cut_test = {
	presentor = "CharacterSpineCutTestViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.character_intelligence_view = {
	presentor = "CharacterIntelligenceViewViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.character_skin_view = {
	isPreClose = true,
	presentor = "CharacterSkinViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.character_portrait = {
	presentor = "CharacterPotraitViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.character_portrait_preview = {
	presentor = "CharacterPotraitPreviewViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.virtual_joystick = {
	presentor = "VirtualJoystickViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.additem_hacktool_panel = {
	presentor = "AdditemHacktoolPanelViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.main_hack = {
	presentor = "MainHackViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_test_menu = {
	presentor = "RoguelikeTestMenuViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_test_monster = {
	presentor = "RoguelikeTestMonsterViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_meet_event = {
	presentor = "RogueMeetEventViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_event_select_role = {
	presentor = "RogueEventSelectRoleViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_meet_monster = {
	presentor = "RogueMeetMonsterViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_monster_judge = {
	presentor = "RogueMonsterJudgeViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_event_judge = {
	presentor = "RogueEventJudgeViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_encounter_main = {
	presentor = "RogueEncounterMainViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_select_role = {
	presentor = "RogueSelectRoleViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_entrance_select_role = {
	presentor = "RogueEntranceSelectRoleViewPresentor",
	showType = WindowShowType.FullScreenHudShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.roguelike_entrance = {
	presentor = "RogueEntranceViewPresentor",
	showType = WindowShowType.FullScreenShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.roguelike_first_entrance = {
	presentor = "RogueFirstEntranceViewPresentor",
	showType = WindowShowType.FullScreenShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.roguelike_map = {
	presentor = "RogueMapViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.roguelike_secondary_map = {
	presentor = "RogueSecondaryMapViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.roguelike_guess_dice_game = {
	presentor = "RogueGuessDiceGameViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.roguelike_moony_dice_game = {
	presentor = "RogueMoonyDiceGameViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.roguelike_test_effect = {
	presentor = "RogueTestEffectViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_select_role_prop = {
	presentor = "RogueSelectRolePropViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_select_role_prop2 = {
	presentor = "RogueSelectRoleProp2ViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_vending_machine = {
	presentor = "RogueVendingMachineViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.rogue_buy_prop_tips = {
	presentor = "RogueBuyPropTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.roguelike_monster_settlement = {
	presentor = "RogueMonsterSettlementViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_event_settlement = {
	presentor = "RogueEventSettlementViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.roguelike_event_review = {
	presentor = "RogueEventReviewViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.rogue_gain_item = {
	presentor = "RogueGainItemViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.rogue_equip_main = {
	presentor = "RogueEquipMainViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.rogue_equip_main2 = {
	presentor = "RogueEquipMain2ViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.rogue_task_main = {
	presentor = "RogueTaskViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.rogue_prop_select = {
	presentor = "RoguePropSelectViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_memory_entry = {
	presentor = "RogueHandBookMemoryEntryViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.rogue_memory_main = {
	presentor = "RogueHandBookMemoryViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.rogue_memory_thread = {
	presentor = "RogueHandBookMemoryThreadViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_hand_book_prop_tips = {
	presentor = "RogueHandBookPropTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_hand_book_monster = {
	presentor = "RogueHandBookMonsterViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_camp_affect_tips = {
	presentor = "RogueCampAffectTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_survey = {
	presentor = "RogueSurveyViewPresentor",
	showType = WindowShowType.ModalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.rogue_surface_tips = {
	presentor = "RogueAdditionalSurfaceTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_team_info = {
	presentor = "RogueTeamInfoViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_hackTool_select_role = {
	presentor = "RogueHackToolSelectRoleViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.rogue_hackTool_role_list = {
	presentor = "RogueHackToolRoleListViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.rogue_hackTool_equip = {
	presentor = "RogueHackToolEquipViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.rogue_hackTool_dice = {
	presentor = "RogueHackToolDiceMockViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_hackTool_dice_multiple = {
	presentor = "RogueHackToolDiceMultipleTestViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_hackTool_map = {
	presentor = "RogueHackToolMapViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.rogue_thread_tips = {
	presentor = "RogueThreadTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_prop_tips = {
	presentor = "RoguePropTipsViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.rogue_role_card = {
	presentor = "RogueRoleCardViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.rogue_plot = {
	presentor = "RoguePlotViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.rogue_monster_card = {
	presentor = "RogueMonsterCardViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.rogue_role_select = {
	presentor = "RogueRoleSelectViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.rogue_select_tips = {
	presentor = "RogueSelectTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.rogue_attr_upgrade = {
	presentor = "RogueAttrUpgradeViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rogue_dice_unlock = {
	presentor = "RogueDiceUnlockViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.house_worker = {
	presentor = "HouseWorkerViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.house_work_main = {
	presentor = "NewHouseWorkerMainViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.house_job_adjust = {
	presentor = "HouseJobAdjustViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.job_work_select = {
	presentor = "JobWorkerSelectViewPrenstor",
	showType = WindowShowType.NormalShowType
}
setting_view.job_detail = {
	presentor = "HouseJobDetailViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.job_adjust_schedule = {
	presentor = "JobAdjustScheduleViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.job_schedule_adjust_tips = {
	presentor = "JobScheduleAdjustTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.job_holiday_adjust_tips = {
	presentor = "JobHolidayAdjustTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.imageguideview = {
	presentor = "ImageGuideViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.poaching_pay_tips = {
	presentor = "PoachingPayTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.guideview = {
	presentor = "GuideViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.compose_item_tips = {
	presentor = "ComposeItemTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.composeitem = {
	presentor = "ComposeItemViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.change_names_tips = {
	presentor = "ChangeNameTipsViewsPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.mailbox_view = {
	isPreClose = true,
	presentor = "MailViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.top_hint_tips = {
	presentor = "TopHintTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.lotterycard_one_view = {
	presentor = "LotteryCardOneViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.lotterycard_keyword_view = {
	presentor = "LotteryCardKeyWordViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.lottery_cutline_view = {
	presentor = "LotteryCutlineViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.lottery_history_view = {
	presentor = "LotteryHistoryViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.lottery_entry_view = {
	presentor = "LotteryEntryViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.lottery_main_view = {
	presentor = "LotteryMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.lottery_ten_view = {
	presentor = "LotteryCardTenViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.lottery_finger_print = {
	presentor = "LotteryCardFingerPrintViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.lottery_select_up_tips = {
	presentor = "LotterySelectUpTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.lottery_jump_mgr = {
	isSupportBack = false,
	presentor = "LotteryJumpMgrViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.lottery_hacktool_select = {
	presentor = "LotteryHacktoolSelectViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.store_main_view = {
	isPreClose = true,
	presentor = "StoreMainViewViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.store_permanent_recharge_view = {
	isSupportBack = false,
	presentor = "StoreRechargeViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.store_permanent_recharge_explain_view = {
	isSupportBack = false,
	presentor = "StoreRechargeExplainViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.store_shopping_tips = {
	presentor = "StoreShoppingTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.trading_entrance = {
	isSupportBack = false,
	presentor = "TradingEntranceViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.trading_device_management = {
	presentor = "TradingDeviceManagementViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.trading_device_upgrade = {
	presentor = "TradingDeviceUpgradeViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.trading_centre = {
	presentor = "TradingCentreViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.trading_order = {
	presentor = "TradingOrderViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.trading_order_refresh = {
	presentor = "TradingOrderRefreshViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.trading_order_info = {
	presentor = "TradingOrderInfoViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.trading_order_speed_up_tips = {
	isSupportBack = false,
	presentor = "TradingOrderSpeedUpTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.trading_product_detail = {
	presentor = "TradingProductDetailsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.health_exchange_tips = {
	isSupportBack = false,
	presentor = "HealthExchangeTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.health_tips = {
	presentor = "HealthTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.health_get_action_time_view = {
	isSupportBack = false,
	presentor = "HealthGetActionTimeTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.currency_exchange_tips = {
	presentor = "CurrencyExchangeTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.item_exchange_tips = {
	presentor = "ItemExchangeTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.thinking_main_view = {
	isPreClose = true,
	presentor = "ThinkingMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.thinking_info_view = {
	isPreClose = true,
	presentor = "ThinkingInfoViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.thinking_unlock_view = {
	isSupportBack = false,
	presentor = "ThinkingUnlockViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.thinking_upgrade_view = {
	presentor = "ThinkingUpgradeViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.thinking_upgrade_success_view = {
	presentor = "ThinkingUpgradeSuccessViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.thinking_active_success_view = {
	presentor = "ThinkingActiveSuccessPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.equip_detail_tips_copy = {
	isSupportBack = false,
	presentor = "ToolTipsEquipViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.equip_detail_tips_copy_fack = {
	isSupportBack = false,
	presentor = "ToolTipsFackEquipViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.equip_intensify_item_tips = {
	isSupportBack = false,
	presentor = "EquipIntensifyItemTipsPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.echo_detail_tips_copy = {
	isSupportBack = false,
	presentor = "ToolTipsEchoViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.d6_detail_tips = {
	isSupportBack = false,
	presentor = "ToolTipsD6ViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.furniture_detail_tips = {
	isSupportBack = false,
	presentor = "ToolTipsFurnitureDetailViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.furniture_info_tips = {
	isSupportBack = false,
	presentor = "ToolTipsFurnitureSimpleInfoViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.chamber_detail_tips = {
	isSupportBack = false,
	presentor = "ToolTipsChamberViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.tool_tips_anchor_break_view = {
	isSupportBack = false,
	presentor = "ToolTipsAnchorBreakPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.hero_selected = {
	presentor = "HeroSelectedViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.facility_holding_main_view = {
	isSupportBack = false,
	presentor = "FacilityHoldingMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.facility_holding_manage_view = {
	presentor = "FacilityHoldingManageViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.facility_holding_change_view = {
	presentor = "FacilityHoldingChangeViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.facility_holding_information_tips = {
	isSupportBack = false,
	presentor = "FacilityHoldingInformationTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.facility_holding_upgrade_view = {
	presentor = "FacilityHoldingUpgradeViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.facility_holding_billboard_tips = {
	isSupportBack = false,
	presentor = "FacilityHoldingBillboardTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.facility_holding_prototype_info_view = {
	presentor = "FacilityHoldingPrototypeInfoViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.facility_holding_module_tips = {
	isSupportBack = false,
	presentor = "FacilityHoldingModuleTipsViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.facility_holding_report_details_view = {
	isSupportBack = false,
	presentor = "FacilityHoldingReportDetailsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.facility_holding_report_settlement_view = {
	isSupportBack = false,
	presentor = "FacilityHoldingReportSettlementViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.facility_holding_report_speedup_tips = {
	isSupportBack = false,
	presentor = "FacilityHoldingReportSpeedupTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.facility_holding_report_view = {
	presentor = "FacilityHoldingReportViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.facility_holding_unlock_condition_tips = {
	isSupportBack = false,
	presentor = "FacilityHoldingUnlockConditionTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.facility_holding_preview_view = {
	isSupportBack = false,
	presentor = "FacilityHoldingPreviewViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.house_gm_schedule = {
	presentor = "HouseGMScheduleViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.house_gm_behavior = {
	presentor = "HouseGMBehaviorViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.new_notice = {
	presentor = "NewNoticeViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.task_main_view = {
	presentor = "TaskMainViewViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.room_main_view = {
	presentor = "RoomMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.room_gain_view = {
	isSupportBack = false,
	presentor = "RoomGainViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.room_build_task_view = {
	presentor = "RoomBuildTaskViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.room_backlog_view = {
	isSupportBack = false,
	presentor = "RoomBacklogViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.room_main_atmos_value = {
	presentor = "RoomMainAtmosValuePresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.room_active_dialog_tips_view = {
	presentor = "RoomActiveDialogTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.room_backpack = {
	presentor = "RoomBackpackViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.room_backpack_furniture_filter_view = {
	presentor = "RoomBackPackFurnitureFilterPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_info_main = {
	isPreClose = true,
	presentor = "PlayerInfoMainViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.player_create = {
	isSupportBack = false,
	presentor = "PlayerCreateMainViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.achievement_skill = {
	presentor = "AchievementSkillDetailViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.achievement_skill_upgrade = {
	presentor = "AchievementSkillUpgradePresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.achievement_skill_small_tips = {
	presentor = "SkillSmallTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.monument_main_view = {
	presentor = "MonumentMainViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.monument_lookover_view = {
	presentor = "MonumentLookoverViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.monument_upgrade_view = {
	presentor = "MonumentUpgradeViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.hint_float_tips = {
	isSupportBack = false,
	presentor = "HintFloatTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.house_hero_tips = {
	presentor = "HouseHeroTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.friend_main = {
	presentor = "FriendMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.friend_tips = {
	presentor = "FriendTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.friend_change_alias = {
	presentor = "FriendChangeAliasViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.chat_main = {
	presentor = "ChatMainViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.living_facilities_main = {
	isSupportBack = false,
	presentor = "LivingFacilitiesMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.living_exchange_facility_tips = {
	presentor = "LivingExchangeFacilityTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.living_exchange_facility_ensure = {
	presentor = "LivingExchangeFacilityEnsureViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.living_facilities_adjust_schedule = {
	presentor = "LivingFacilitiesAdjustScheduleViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.living_facilities_atmos_value_tip = {
	presentor = "LivingFacilitiesAtmosValueTipViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.living_facilities_furniture_theme_tips = {
	presentor = "LivingFacilitiesFurnitureThemeTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.living_facilities_statics_tips = {
	presentor = "LivingFacilitiesStatisticsTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.living_moudle_collect_tips = {
	presentor = "LivingMoudleCollectTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.living_facilities_room_manage = {
	presentor = "LivingFacilitiesRoomManageViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.living_adjust_schedule_tips = {
	presentor = "LivingAdjustScheduleTipViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.living_facilities_product = {
	presentor = "LivingFacilitiesProductViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.house_dorm_adjust = {
	presentor = "HouseDormAdjustViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.report_view = {
	presentor = "ReportViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.supervisor_main = {
	isSupportBack = false,
	presentor = "SupervisorMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.supervisor_detail = {
	presentor = "SupervisorDetailViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.supervisor_material = {
	presentor = "SupervisorMaterialViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.supervisor_upgrade = {
	presentor = "SupervisorUpgradeViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.manufacture_main = {
	isSupportBack = false,
	presentor = "ManufactureMainViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.manufacture_detail = {
	presentor = "ManufactureDetailViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.manufacture_upgrade = {
	presentor = "ManufactureUpgradeViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.manufacture_material = {
	presentor = "ManufactureMaterialViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.manufacture_speed_up = {
	presentor = "ManufactureSpeedUpViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.manufacture_scheme = {
	presentor = "ManufactureSchemeViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.manufacture_scheme_ensure = {
	presentor = "ManufactureSchemeEnsureViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.welfare_main_view = {
	isPreClose = true,
	isSupportBack = true,
	presentor = "WelfareMainViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.daily_signin_tips = {
	isSupportBack = false,
	presentor = "DailySigninTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.seven_signin_tips = {
	isSupportBack = false,
	presentor = "SevenSigninTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.welfare_detail_tips = {
	isSupportBack = false,
	presentor = "WelfareTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.edit_common_tip = {
	presentor = "EditCommonTipPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.right_age_tip = {
	presentor = "RightAgeTipPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.card_pool_role_info = {
	presentor = "CardPoolRoleInfoViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_info_tips = {
	presentor = "PlayerInfoTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_info_show_view = {
	presentor = "PlayerInfoShowViewViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_select_character = {
	presentor = "PlayerSelectCharacterViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.player_select_skin = {
	presentor = "PlayerSelectSkinViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.house_hero_mood_record = {
	presentor = "HouseHeroMoodRecordViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.house_room_manage = {
	presentor = "HouseRoomManageViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.house_gm_view = {
	isSupportBack = false,
	presentor = "HouseGMViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.marquee_view = {
	isSupportBack = false,
	presentor = "MarqueeViewViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.handbook_cg_entry_view = {
	presentor = "HandbookCGEntryViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_cg_preview_view = {
	presentor = "HandbookCGPreviewViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_mosterdata_entry_view = {
	presentor = "HandbookMonsterDataEntryViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.handbook_monsterdata_evaluate_tips = {
	presentor = "HandbookMonsterdataEvaluateTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.handbook_monsterdata_view = {
	presentor = "HandbookMonsterdataViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_monster_compare = {
	presentor = "HandbookMonsterCompareViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_plot_entry_view = {
	presentor = "HandbookPlotEntryViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_plotlst_view = {
	presentor = "HandbookPlotLstViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_record_entry_view = {
	presentor = "HandbookRecordEntryViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_record_entries_view = {
	presentor = "HandbookRecordEntriesViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_record_event_view = {
	presentor = "HandbookRecordEventViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_record_transcendency_view = {
	presentor = "HandbookRecordTranscendencyViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_alienation_entry_view = {
	presentor = "HandbookAlienationEntryViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_echo_detail_view = {
	presentor = "HandbookEchoDetailViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_relation_entry_view = {
	presentor = "HandbookRelationshipEntryViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_relation_camp_view = {
	presentor = "HandbookRelationInCampViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_relationship_camp_tips = {
	presentor = "HandbookRelationCampTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.handbook_relationship_view = {
	presentor = "HandbookRelationshipViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_hero_info_view = {
	presentor = "HandbookHeroInfoViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_hero_intelligence_view = {
	presentor = "HandbookHeroIntelligenceViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.handbook_music_entry_view = {
	presentor = "HandbookMusicEntryViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.tacit_skill_upgrade_tips = {
	presentor = "TacitSkillUpgradeTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.device_upgrade_succeed = {
	presentor = "DeviceUpgradeSucceedViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.time_limit_activity_entrance = {
	presentor = "TimeLimitActivityEntranceViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.football = {
	presentor = "FootballViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.football_rank = {
	presentor = "FootballRankViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.football_record = {
	presentor = "FootballRecordViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.football_qte_game = {
	presentor = "FootballQTEViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.football_score_board = {
	presentor = "FootballScoreBoardViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.football_round_report = {
	presentor = "FootballRoundReportViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.newhand_task_view = {
	isPreClose = true,
	presentor = "NewbieTaskViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.furniture_product = {
	presentor = "FurnitureProductViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.tacit_plot_promote_tips = {
	presentor = "TacitPlotPromoteTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.share_view = {
	presentor = "ShareViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.addequipment_hacktool_panel = {
	presentor = "AddequipmentHacktoolPanelViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.story_preview_dialog = {
	presentor = "StoryPreviewDialogViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_info_attribute_use_tips = {
	presentor = "PlayerInfoUpgradeViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.guide_hacktool_panel = {
	presentor = "HacktoolGuideViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.house_perform_editor = {
	presentor = "HousePerformEditorViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.open_functions_hint_tips = {
	isSupportBack = false,
	presentor = "OpenFunctionsHintTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.chapter_open_tips_view = {
	isSupportBack = false,
	presentor = "ChapterOpenTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_course_hero_editor = {
	presentor = "PlayerCourseHeroEditViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_course_cup_editor = {
	presentor = "PlayerCourseCupEditViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_course_house_editor = {
	presentor = "PlayerCourseHouseEditViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_course_roguelike_view = {
	presentor = "PlayerCourseRoguelikeViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.player_course_diary_view = {
	presentor = "PlayerCourseDiaryViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.player_gain_attribute_tips = {
	presentor = "PlayerAttributeTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.player_course_house_view = {
	presentor = "PlayerCourseHouseViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.common_summon_card_view = {
	presentor = "GetRoleViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.survey_tips = {
	presentor = "SurveyViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.summon_one_echo_view = {
	isSupportBack = false,
	presentor = "LotteryEchoShowViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.feedback_tips = {
	presentor = "FeedbackViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.season_buy_vip = {
	presentor = "SeasonBuyVipViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.season_top_tips = {
	isSupportBack = false,
	presentor = "SeasonTopTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.season_new_main = {
	presentor = "SeasonNewMainViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.season_new_promote = {
	presentor = "SeasonNewPromoteViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.season_new_report = {
	presentor = "SeasonNewReportViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.chamber_exchange = {
	isPreClose = true,
	presentor = "ChamberExchangeViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.chamber_effect_tips = {
	presentor = "ChamberEntryEffectTipsViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.chamber_gain = {
	presentor = "ChamberGainViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.secret_tips = {
	isSupportBack = false,
	presentor = "SecretViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.use_item_tips = {
	presentor = "ToolTipsUseItemViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.click_feedback = {
	isSupportBack = false,
	presentor = "ClickViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ResidentResourceType
}
setting_view.supervisor_training_tips = {
	isSupportBack = false,
	presentor = "MasterTrainingTaskViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.bounty_tips = {
	presentor = "BountyTipsViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.character_depot_main_view_new = {
	isPreClose = true,
	presentor = "CharacterDepotMainViewNewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.character_system_main_view_new = {
	isPreClose = true,
	presentor = "CharacterMainSystemViewNewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.echo_item_main_view_new = {
	isPreClose = true,
	presentor = "EchoItemMainViewNewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.echo_compound_preview = {
	isPreClose = true,
	presentor = "EchoItemPreviewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.echo_fullscreen_view = {
	presentor = "EchoFullScreenPreviewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.character_heart_anchor_break_view = {
	presentor = "CharacterHeartAnchorBreakViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.character_heart_anchor_view = {
	isPreClose = true,
	presentor = "CharacterHeartAnchorViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.character_voice_tips_view = {
	isSupportBack = false,
	presentor = "CharacterVoiceTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.character_heart_anchor_impression_upgrade_result_tips = {
	isSupportBack = false,
	presentor = "CharacterHeartAnchorImpressionUpgradeResultTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.character_heart_anchor_carry_item_info_tips = {
	isSupportBack = false,
	presentor = "CharacterHeartAnchorCarryItemInfoTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.character_heart_anchor_break_result_tips = {
	isSupportBack = false,
	presentor = "CharacterHeartAnchorBreakResultTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.character_file_tips = {
	isSupportBack = false,
	presentor = "CharacterFileTipsPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.storyloadingview = {
	isSupportBack = false,
	presentor = "StoryloadingviewViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.story_view = {
	isPreClose = true,
	presentor = "StoryViewViewPresentor",
	isSupportBack = false,
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.story_unlock_tip_view = {
	isSupportBack = false,
	presentor = "StoryUnlockTipViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.filter_tips = {
	presentor = "FilterTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.chamber_test = {
	presentor = "ChamberTestViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.control_action_login = {
	isSupportBack = false,
	isPreClose = true,
	presentor = "ControlActionLoginViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.control_action = {
	isSupportBack = true,
	isPreClose = true,
	presentor = "ControlActionViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.control_action_monitor = {
	isSupportBack = true,
	presentor = "MonitorViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.control_action_monitor_useitem = {
	isSupportBack = true,
	presentor = "MonitorUseItemViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.control_action_forum = {
	isSupportBack = true,
	presentor = "ForumViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.control_action_manual = {
	isSupportBack = true,
	presentor = "ManualMainViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.control_action_quicktake = {
	isSupportBack = true,
	presentor = "QuickTakeViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.control_action_label_view = {
	presentor = "ControlActionLabelViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.control_action_lv_limit_view = {
	presentor = "ControlActionLvLimitViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.playerinfo_rename_tips = {
	presentor = "RenameTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.playerinfo_birth_tips = {
	presentor = "BirthdayEditTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.brithday_confirm_tips = {
	presentor = "BirthdayConfirmTipsPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.playerinfo_mask_view = {
	presentor = "ChangeMaskViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.player_info_leave_msg_view = {
	isSupportBack = false,
	isPreClose = true,
	presentor = "PlayerInfoLeaveMsgViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.player_business_card_view = {
	isSupportBack = false,
	isPreClose = false,
	presentor = "PlayerBusinessCardViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.special_training = {
	isSupportBack = true,
	isPreClose = true,
	presentor = "SpecialtrainingViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.special_training_banner = {
	isSupportBack = true,
	isPreClose = true,
	presentor = "SpecialtrainingBannerPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.unlock_mask_view = {
	presentor = "GainMaskViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.character_presets_tips = {
	presentor = "CharacterPreinstallViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.preset_notice_tips = {
	presentor = "ToolNoticeViewPresentor",
	showType = WindowShowType.NormalShowType,
	resourceType = WindowResourceType.ImmediateDestoryResourceType
}
setting_view.activity_integral_drop = {
	presentor = "ActivityIntegralDropViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.leave_message_subject_tips = {
	isSupportBack = false,
	presentor = "LeaveMsgSubjectTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.leave_message_word_tips = {
	isSupportBack = false,
	presentor = "LeaveMsgWordTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.leave_message_conjunction_tips = {
	isSupportBack = false,
	presentor = "LeaveMsgConjunctionTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.leave_message_emoji_tips = {
	isSupportBack = false,
	presentor = "LeaveMsgEmojiTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.leave_message_voice_hero_tips = {
	isSupportBack = false,
	presentor = "LeaveMsgVoiceHeroTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.leave_message_voice_res_tips = {
	isSupportBack = false,
	presentor = "LeaveMsgVoiceResTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.clip_doll_view = {
	isSupportBack = false,
	isPreClose = false,
	presentor = "ClawDollOperationViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.starting_currency_tips = {
	isSupportBack = false,
	presentor = "ClawDollTaskViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.reward_exchange_tips = {
	isSupportBack = false,
	presentor = "ClawDollExchangeViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.prize_claw_main_view = {
	isSupportBack = true,
	presentor = "ClawDollDetailViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.store_buy_confirm = {
	isSupportBack = false,
	presentor = "StoreBuyConfirmViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.store_get_month_card = {
	isSupportBack = false,
	presentor = "StoreGetMonthCardViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.multi_funtion_view = {
	isSupportBack = false,
	presentor = "MultiFunctionViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.airtightRoom_time_view = {
	isPreClose = false,
	presentor = "AirtightRoomTimeViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.career_introduction_tips = {
	presentor = "CharacterCareerIntroductionViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.battle_explain_tips = {
	presentor = "BattleExplainTipsPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.word_view = {
	isSupportBack = false,
	presentor = "WordViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.mainline_editor_view = {
	isSupportBack = false,
	presentor = "MainlineEditorViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.custom_character = {
	presentor = "CustomCharacterViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.back_door_tool_view = {
	presentor = "BackDoorToolViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.retrieve_main_view = {
	presentor = "RetrieveMainViewViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.retrieve_role_show_view = {
	isSupportBack = false,
	presentor = "RetrieveRoleShowViewViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.retrieve_log_tips = {
	presentor = "RetrieveHistoryViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.retrieve_cutline_view = {
	presentor = "RetrieveCutlineViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.power_challenge_battle_view = {
	presentor = "PowerChallengeBattleViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.power_challenge_reward_tips = {
	presentor = "PowerChallengeRewardPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.month_signin = {
	presentor = "MonthSigninViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.first_charge_view = {
	isSupportBack = false,
	presentor = "FirstChargeViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.push_gift_package_tips = {
	presentor = "PushGiftPackageTipsViewPresentor",
	showType = WindowShowType.ModalShowType
}
setting_view.rank_view = {
	presentor = "RankViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.retrieve_ten_card_show_view = {
	presentor = "RetrieveTenCardShowViewViewPresentor",
	showType = WindowShowType.FullScreenHudShowType
}
setting_view.retrieve_jump_view = {
	isSupportBack = false,
	presentor = "RetrieveJumpViewViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.echo_card_pack_view = {
	isSupportBack = false,
	presentor = "EchoCardPackViewPresentor",
	showType = WindowShowType.NoneShowType
}
setting_view.echo_card_unpack_view = {
	isSupportBack = false,
	presentor = "EchoCardUnpackViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.echo_card_unpack_result_view = {
	isSupportBack = false,
	presentor = "EchoCardUnpackResultViewPresentor",
	showType = WindowShowType.FullScreenShowType
}
setting_view.battle_teach_pass_tips = {
	presentor = "TeachPassHintViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.battle_total_hurt_hint = {
	presentor = "BattleDamageHintViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.comm_reward_view = {
	isSupportBack = false,
	presentor = "CommRewardViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.tool_tips_fix = {
	isSupportBack = false,
	presentor = "ToolTipsFixViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.retrieve_dial_view = {
	isSupportBack = false,
	presentor = "RetrieveDialViewViewPresentor",
	showType = WindowShowType.NormalShowType
}
setting_view.enemy_first_appearance_tips = {
	isSupportBack = false,
	presentor = "ToolTipsEnemyFirstHintViewPresentor",
	showType = WindowShowType.ModalShowType
}

return setting_view
