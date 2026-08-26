-- chunkname: @modules/common/others/SDKDataTrackExt.lua

module("modules.common.others.SDKDataTrackExt", package.seeall)

local SDKDataTrackMgr = SDKDataTrackMgr

function SDKDataTrackMgr.activateExtend()
	SDKDataTrackMgr.EventName.voice_pack_UI_manager = "voice_pack_UI_manager"
	SDKDataTrackMgr.EventName.voice_pack_download_confirm = "voice_pack_download_confirm"
	SDKDataTrackMgr.EventName.voice_pack_downloading = "voice_pack_downloading"
	SDKDataTrackMgr.EventName.voice_pack_switch = "voice_pack_switch"
	SDKDataTrackMgr.EventName.voice_pack_delete = "voice_pack_delete"
	SDKDataTrackMgr.EventName.resources_downloading = "resources_downloading"
	SDKDataTrackMgr.EventName.main_hero_interaction = "main_hero_interaction"
	SDKDataTrackMgr.EventName.act210_operation = "act210_operation"
	SDKDataTrackMgr.EventName.resource_fixup = "resource_fixup"
	SDKDataTrackMgr.EventName.click_activity_jump_button = "click_activity_jump_button"
	SDKDataTrackMgr.EventName.act_chengheguang_operation = "act_chengheguang_operation"
	SDKDataTrackMgr.EventName.act_WMZ_operation = "act_WMZ_operation"
	SDKDataTrackMgr.EventProperties.current_language = "current_language"
	SDKDataTrackMgr.EventProperties.entrance = "entrance"
	SDKDataTrackMgr.EventProperties.current_voice_pack_list = "current_voice_pack_list"
	SDKDataTrackMgr.EventProperties.current_voice_pack_used = "current_voice_pack_used"
	SDKDataTrackMgr.EventProperties.download_voice_pack_list = "download_voice_pack_list"
	SDKDataTrackMgr.EventProperties.update_amount = "update_amount"
	SDKDataTrackMgr.EventProperties.step = "step"
	SDKDataTrackMgr.EventProperties.voice_pack_before = "voice_pack_before"
	SDKDataTrackMgr.EventProperties.voice_pack_delete = "voice_pack_delete"
	SDKDataTrackMgr.EventProperties.resource_type = "resource_type"
	SDKDataTrackMgr.EventProperties.main_hero_interaction_skin_id = "skinid"
	SDKDataTrackMgr.EventProperties.main_hero_interaction_area_id = "area_id"
	SDKDataTrackMgr.EventProperties.main_hero_interaction_voice_id = "voiceid"
	SDKDataTrackMgr.EventProperties.resource_fixup_status = "status"
	SDKDataTrackMgr.EventProperties.resource_fixup_count = "resource_count"
	SDKDataTrackMgr.EventProperties.act210_grid_info = "act210_grid_info"
	SDKDataTrackMgr.EventProperties.used_times = "used_times"
	SDKDataTrackMgr.EventProperties.reset_times = "reset_times"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.current_language] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.entrance] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = "list"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.download_voice_pack_list] = "list"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.update_amount] = "number"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.step] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.voice_pack_before] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.voice_pack_delete] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.resource_type] = "list"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.main_hero_interaction_skin_id] = "number"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.main_hero_interaction_area_id] = "number"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.main_hero_interaction_voice_id] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.resource_fixup_status] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.resource_fixup_count] = "number"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.act210_grid_info] = "array"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.used_times] = "number"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.reset_times] = "number"
end

function SDKDataTrackMgr:trackVoicePackDownloadConfirm(data)
	local var_2_0 = {
		[SDKDataTrackMgr.EventProperties.current_language] = GameConfig:GetCurLangShortcut(),
		[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = GameConfig:GetCurVoiceShortcut()
	}

	var_2_0[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = data.current_voice_pack_list or {}
	var_2_0[SDKDataTrackMgr.EventProperties.download_voice_pack_list] = data.download_voice_pack_list or {}
	var_2_0[SDKDataTrackMgr.EventProperties.entrance] = data.entrance
	var_2_0[SDKDataTrackMgr.EventProperties.update_amount] = data.update_amount or 0

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, var_2_0)
end

function SDKDataTrackMgr:trackVoicePackDownloading(data)
	local var_3_0 = {
		[SDKDataTrackMgr.EventProperties.step] = data.step
	}

	var_3_0[SDKDataTrackMgr.EventProperties.download_voice_pack_list] = data.download_voice_pack_list or {}
	var_3_0[SDKDataTrackMgr.EventProperties.update_amount] = data.update_amount or 0
	var_3_0[SDKDataTrackMgr.EventProperties.spend_time] = data.spend_time or 0
	var_3_0[SDKDataTrackMgr.EventProperties.result_msg] = data.result_msg or ""

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, var_3_0)
end

function SDKDataTrackMgr:trackVoicePackSwitch(data)
	local var_4_0 = {
		[SDKDataTrackMgr.EventProperties.current_language] = data.current_language
	}

	var_4_0[SDKDataTrackMgr.EventProperties.entrance] = data.entrance or ""
	var_4_0[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = data.current_voice_pack_list or {}
	var_4_0[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = data.current_voice_pack_used or ""
	var_4_0[SDKDataTrackMgr.EventProperties.voice_pack_before] = data.voice_pack_before or ""

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_switch, var_4_0)
end

function SDKDataTrackMgr:trackVoicePackDelete(data)
	local var_5_0 = {
		[SDKDataTrackMgr.EventProperties.current_language] = data.current_language
	}

	var_5_0[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = data.current_voice_pack_list or {}
	var_5_0[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = data.current_voice_pack_used or ""
	var_5_0[SDKDataTrackMgr.EventProperties.voice_pack_delete] = data.voice_pack_delete or ""

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_delete, var_5_0)
end

function SDKDataTrackMgr:trackOptionPackDownloading(data)
	local var_6_0 = {
		[SDKDataTrackMgr.EventProperties.step] = data.step
	}

	var_6_0[SDKDataTrackMgr.EventProperties.resource_type] = data.resource_type or {}
	var_6_0[SDKDataTrackMgr.EventProperties.update_amount] = data.update_amount or 0
	var_6_0[SDKDataTrackMgr.EventProperties.spend_time] = data.spend_time or 0
	var_6_0[SDKDataTrackMgr.EventProperties.result_msg] = data.result_msg or ""

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resources_downloading, var_6_0)
end

function SDKDataTrackMgr:trackOptionPackConfirmDownload(data)
	local var_7_0 = {}

	var_7_0[SDKDataTrackMgr.EventProperties.resource_type] = data.resource_type or {}

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.confirm_download_resources, var_7_0)
end

function SDKDataTrackMgr:trackMainHeroInteraction(data)
	local var_8_0 = {}

	var_8_0[SDKDataTrackMgr.EventProperties.main_hero_interaction_skin_id] = data.main_hero_interaction_skin_id or -1
	var_8_0[SDKDataTrackMgr.EventProperties.main_hero_interaction_area_id] = data.main_hero_interaction_area_id or -1
	var_8_0[SDKDataTrackMgr.EventProperties.main_hero_interaction_voice_id] = data.main_hero_interaction_voice_id or ""

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.main_hero_interaction, var_8_0)
end

function SDKDataTrackMgr:trackResourceFixup(data)
	local var_9_0 = {}

	var_9_0[SDKDataTrackMgr.EventProperties.resource_fixup_status] = data.status or ""
	var_9_0[SDKDataTrackMgr.EventProperties.resource_fixup_count] = data.count or 0
	var_9_0[SDKDataTrackMgr.EventProperties.entrance] = data.entrance or ""

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resource_fixup, var_9_0)
end

function SDKDataTrackMgr:trackClickActivityJumpButton()
	StatController.instance:track(SDKDataTrackMgr.EventName.click_activity_jump_button, {})
end

function SDKDataTrackMgr:trackClickEnterActivityButton(viewName, buttonName)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = viewName or "",
		[StatEnum.EventProperties.ButtonName] = buttonName or ""
	})
end

function SDKDataTrackMgr:track_act210_operation(map_id, operation_type, act210_grid_info, used_times, usetime)
	local var_12_0 = {}

	var_12_0[StatEnum.EventProperties.MapId] = tostring(map_id) or ""
	var_12_0[StatEnum.EventProperties.OperationType] = operation_type or ""
	var_12_0[SDKDataTrackMgr.EventProperties.act210_grid_info] = act210_grid_info or {}
	var_12_0[SDKDataTrackMgr.EventProperties.used_times] = used_times or 0
	var_12_0[StatEnum.EventProperties.UseTime] = usetime or -1

	StatController.instance:track(SDKDataTrackMgr.EventName.act210_operation, var_12_0)
end

function SDKDataTrackMgr:track_act_chengheguang_operation(OperationType, EpisodeId, MapId, UseTime, Time, IsWin, IsFirst)
	local var_13_0 = {
		[StatEnum.EventProperties.OperationType] = OperationType or ""
	}

	var_13_0[StatEnum.EventProperties.EpisodeId] = tostring(EpisodeId) or "0"
	var_13_0[StatEnum.EventProperties.MapId] = tostring(MapId) or "0"
	var_13_0[StatEnum.EventProperties.UseTime] = UseTime or -1
	var_13_0[StatEnum.EventProperties.Time] = Time or -1
	var_13_0[StatEnum.EventProperties.IsWin] = IsWin or false
	var_13_0[StatEnum.EventProperties.IsFirst] = IsFirst or false

	StatController.instance:track(SDKDataTrackMgr.EventName.act_chengheguang_operation, var_13_0)
end

function SDKDataTrackMgr:track_act_WMZ_operation(OperationType, MapId, UseTime, reset_times, RoundNum, CompletedLayers)
	local var_14_0 = {
		[StatEnum.EventProperties.OperationType] = OperationType or ""
	}

	var_14_0[StatEnum.EventProperties.MapId] = tostring(MapId) or "0"
	var_14_0[StatEnum.EventProperties.UseTime] = UseTime or -1
	var_14_0[SDKDataTrackMgr.EventProperties.reset_times] = reset_times or -1
	var_14_0[StatEnum.EventProperties.RoundNum] = RoundNum or -1
	var_14_0[StatEnum.EventProperties.CompletedLayers] = CompletedLayers or -1

	StatController.instance:track(SDKDataTrackMgr.EventName.act_WMZ_operation, var_14_0)
end

return SDKDataTrackMgr
