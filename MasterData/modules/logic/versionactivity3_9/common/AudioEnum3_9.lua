-- chunkname: @modules/logic/versionactivity3_9/common/AudioEnum3_9.lua

module("modules.logic.versionactivity3_9.common.AudioEnum3_9", package.seeall)

local AudioEnum3_9 = _M

AudioEnum3_9.BDuck = {
	play_ui_chongran3_9_bduck_bp = 390011
}
AudioEnum3_9.Hedone = {
	play_ui_pkls_endpoint_arrival = 25001204,
	play_ui_heduonie3_9_opennext = 390025,
	play_ui_heduonie3_9_blessing2 = 390014,
	play_ui_heduonie3_9_ballfly = 390017,
	play_ui_settleaccounts_lose = 20005002,
	play_ui_heduonie3_9_blessing3 = 390015,
	play_ui_heduonie3_9_ballfall = 390016,
	play_ui_heduonie3_9_blessing1 = 390013,
	play_ui_heduonie3_9_complete = 390024,
	play_ui_dungeon3_2_choose_1 = 20320637
}
AudioEnum3_9.Bird = {
	play_ui_wangshi_argus_level_over = 20211502,
	play_ui_langchao_tv_close = 3852020,
	play_ui_diqiu_unlock = 20240051,
	play_ui_chongran_fly_up = 390033,
	play_ui_beiai_water_absorb = 370402,
	play_ui_langchao_tv_unfold = 3852019,
	play_ui_bulaochuan_bubble_burst = 340082,
	play_ui_beiai_wave_appear = 370408,
	play_ui_chongran_seagull = 390052,
	play_ui_bulaochuan_win = 340066,
	play_ui_chongran_fly_coin = 390034,
	play_ui_diqiu_count_down = 340017,
	play_ui_bulaochuan_floor_shiny = 340153
}
AudioEnum3_9.Naxisuosi = {
	play_ui_heduonie3_9_complete = 390046,
	play_ui_shiji_route_connect_loop = 390044,
	play_ui_diqiu_complete = 390045
}
AudioEnum3_9.EnterView = {
	play_ui_chongran_3_9_open = 390053
}
AudioEnum3_9.TurnBack = {
	play_ui_shuori_qiyuan_down = 20161050
}

local bgm = {
	play_lianji_playcards_music = 3340003
}

for key, value in pairs(bgm) do
	if isDebugBuild and AudioEnum.Bgm[key] then
		logError("AudioEnum.Bgm重复定义" .. key)
	end

	AudioEnum.Bgm[key] = value
end

return AudioEnum3_9
