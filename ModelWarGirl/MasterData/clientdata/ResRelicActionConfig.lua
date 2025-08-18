-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResRelicActionConfig.lua

local RT = {}

RT[1] = {
	10000075
}

local Data = {
	[720001] = {
		[0] = {
			battle_weather_eff = "Effects/Scene/efx_Scene_Christmas02.prefab",
			bgm_hero_dlg = 118,
			bgm_battle = 119,
			bgm_victory = 120,
			id = 720001,
			level = 0,
			hero_cue = RT[1]
		},
		{
			battle_weather_eff = "Effects/Scene/efx_Scene_Christmas02.prefab",
			bgm_hero_dlg = 118,
			bgm_battle = 119,
			bgm_victory = 120,
			id = 720001,
			level = 1,
			battle_cue = {
				10000076
			},
			hero_cue = RT[1]
		}
	},
	[720002] = {
		[0] = {
			id = 720002,
			bgm_battle = 130,
			bgm_hero_dlg = 131,
			level = 0
		}
	}
}

return Data
