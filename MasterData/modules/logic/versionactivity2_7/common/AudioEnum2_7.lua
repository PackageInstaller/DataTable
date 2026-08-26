-- chunkname: @modules/logic/versionactivity2_7/common/AudioEnum2_7.lua

module("modules.logic.versionactivity2_7.common.AudioEnum2_7", package.seeall)

local AudioEnum2_7 = _M

AudioEnum2_7.VersionActivity2_7Enter = {
	play_ui_yuzhou_open = 20270002,
	play_ui_qiutu_revelation_open = 20270003
}
AudioEnum2_7.VersionActivity2_7SpaceBGM = {
	play_2_7_yuzhou_ui_checkinspace = 3270033,
	play_2_7_yuzhou_ui_checkoutspace = 3270034,
	play_2_7_yuzhou_ui_checkpoint_amb_space = 3270031,
	stop_2_7_yuzhou_ui_checkpoint_amb_space = 3270032
}
AudioEnum2_7.CooperGarlandBallRTPC = "ball_speed"
AudioEnum2_7.CooperGarland = {
	play_ui_yuzhou_cube_turn = 20270016,
	stop_ui_yuzhou_ball_loop = 20270015,
	play_ui_yuzhou_ball_trap = 20270018,
	play_ui_yuzhou_trap_choose = 20270021,
	stop_ui_yuzhou_ball_fire_loop = 20270030,
	play_ui_yuzhou_ball_fall = 20270017,
	play_ui_pkls_star_light = 20270023,
	play_ui_yuzhou_ball_star = 20270027,
	play_ui_yuzhou_ball_fire = 20270028,
	play_ui_yuzhou_ball_spikes = 20270026,
	play_ui_yuzhou_level_next = 20270019,
	play_ui_pkls_endpoint_arrival = 20270025,
	play_ui_yuzhou_ball_fire_loop = 20270029,
	play_ui_pkls_challenge_fail = 20270024,
	play_ui_yuzhou_ball_loop = 20270014,
	play_ui_yuzhou_trap_dispel = 20270022,
	play_ui_yuzhou_level_lit = 20270013,
	play_ui_yuzhou_level_unlock = 20270012,
	play_ui_yuzhou_ball_reset = 20270020
}
AudioEnum2_7.LengZhou6 = {
	play_ui_yuzhou_lzl_explosion = 20270040,
	play_ui_yuzhou_lzl_fail = 20270039,
	play_ui_yuzhou_lzl_loading = 20270033,
	play_ui_yuzhou_lzl_open = 20270031,
	play_ui_yuzhou_lzl_click = 20270034,
	play_ui_yuzhou_lzl_level_open = 20270032,
	play_ui_yuzhou_lzl_hp = 20260106,
	play_ui_yuzhou_lzl_result = 20270036,
	play_ui_yuzhou_lzl_combustion = 20270041,
	play_ui_yuzhou_lzl_success = 20270038,
	play_ui_yuzhou_lzl_refresh = 20270037,
	play_ui_yuzhou_lzl_boom = 20270035
}
AudioEnum2_7.Act191 = {
	play_ui_yuzhou_dqq_earn_gold = 20270046,
	play_ui_yuzhou_dqq_pmgressbar_02 = 20270043,
	play_ui_yuzhou_dqq_panel_close = 20270047,
	play_ui_yuzhou_dqq_fire_interface = 20270044,
	play_ui_yuzhou_dqq_reward_increase = 20270048,
	play_ui_yuzhou_dqq_pmgressbar_unfold = 20270045,
	play_ui_yuzhou_dqq_pmgressbar_01 = 20270042,
	play_ui_yuzhou_dqq_equip_creation = 20270049
}
AudioEnum2_7.WarmUp = {
	play_ui_yuzhou_fax_print = 20270060,
	play_ui_min_day_night = 20220210,
	play_ui_yuzhou_fax_beep = 20270059,
	play_ui_yuzhou_fax_earcap = 20270058
}

local bgm = {
	Act2_7DungeonBgm = 3270003,
	LengZhou6Bgm = 3270001,
	CooperGarlandBgm = 3270002
}

for key, value in pairs(bgm) do
	if isDebugBuild and AudioEnum.Bgm[key] then
		logError("AudioEnum.Bgm重复定义" .. key)
	end

	AudioEnum.Bgm[key] = value
end

return AudioEnum2_7
