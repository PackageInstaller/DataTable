-- chunkname: @modules/logic/versionactivity1_6/common/AudioEnum1_6.lua

module("modules.logic.versionactivity1_6.common.AudioEnum1_6", package.seeall)

local AudioEnum = AudioEnum
local bgm = {
	role_activity_quniang = 3200093,
	role_activity_getian = 3200094,
	Act1_6DungeonBgm2 = 3200097,
	Act1_6DungeonBgm1 = 3200095,
	CachotMainScene = 3200099
}
local UI = {
	play_ui_dungeon_1_6_entrance_light = 20161012,
	Act1_6DungeonSkillViewLvUp = 20161049,
	play_ui_dungeon_1_6_newendings_enter = 20161030,
	play_ui_dungeon_1_6_room_interaction = 20161018,
	play_ui_dungeon_1_6_preparation_open = 20161014,
	play_ui_dungeon_1_6_finale_get = 20161027,
	play_ui_dungeon_1_6_load_open = 20161015,
	play_ui_dungeon_1_6_clearing_unfold = 20161025,
	play_ui_dungeon_1_6_room_open = 20161016,
	play_ui_dungeon_1_6_clearing_open = 20161019,
	play_ui_dungeon_1_6_floor_load = 20161023,
	play_ui_dungeon_1_6_easter_success = 20161032,
	play_ui_dungeon_1_6_award_charge = 20161020,
	FurnaceTreasureBuyViewFinish = 20161037,
	play_ui_dungeon_1_6_collection_get = 20161029,
	Act1_6DungeonSkillViewReset = 20161048,
	stop_ui_checkpoint_chain = 20161046,
	play_ui_dungeon_1_6_room_lit = 20161017,
	Act1_6DungeonSkillViewUnlock = 20161051,
	Act1_6DungeonSkillViewLvDown = 20161050,
	Act1_6DungeonHardModeUnlock = 20161052,
	play_ui_shuori_story_click = 20161044,
	Act1_6DungeonBossViewGetScore = 20161056,
	play_ui_dungeon_1_6_victory_open = 20161026,
	Act1_6DungeonEnterTaskView = 20161061,
	play_ui_dungeon_1_6_store_open = 20161028,
	Act1_6EnterViewVideo = 20161038,
	Act1_6DungeonEnterSkillView = 20161062,
	play_ui_shuori_story_star = 20161042,
	Act1_6DungeonBossEnterClick = 20161053,
	Act1_6DungeonBossFightResultScore = 20161055,
	play_ui_dungeon_1_6_entrance_teleport = 20161013,
	play_ui_checkpoint_chain = 20161045,
	FurnaceTreasureBuyViewGreatSpine = 20161036,
	play_ui_mane_post_1_6_appraise = 20166003,
	Act1_6EnterViewTabSelect = 20161040,
	play_ui_mane_post_1_6_level = 20166004,
	FurnaceTreasureBuyViewNormalSpine = 20161035,
	Act1_6EnterViewMainActTabSelect = 20161039,
	play_ui_dungeon_1_6_popups_prompt = 20161033,
	play_ui_dungeon_1_6_fail_open = 20161024,
	Act1_6DungeonBossViewStopAmbient = 3200999,
	play_ui_dungeon_1_6_choices_open_1 = 20161021,
	play_ui_dungeon_1_6_choices_open_2 = 20161022,
	GoldenMilletMainBtnClick = 20161003,
	GoldenMilletDisplayViewOpen = 20161001,
	play_ui_dungeon_1_6_columns_update = 20161031,
	play_ui_shuori_story_switch = 20161041,
	play_ui_mane_post_1_6_score = 20166002,
	GoldenMilletReceiveViewOpen = 20161002,
	play_ui_shuori_story_open = 20161047,
	Act1_6DungeonBossViewAmbient = 20161054,
	play_ui_mane_post_1_6_survey = 20166001,
	play_ui_dungeon_1_6_interface_open = 20161011
}

for key, value in pairs(bgm) do
	if isDebugBuild and AudioEnum.Bgm[key] then
		logError("AudioEnum.Bgm重复定义" .. key)
	end

	AudioEnum.Bgm[key] = value
end

for key, value in pairs(UI) do
	if isDebugBuild and AudioEnum.UI[key] then
		logError("AudioEnum.UI重复定义" .. key)
	end

	AudioEnum.UI[key] = value
end

function AudioEnum.activate()
	return
end

return AudioEnum
