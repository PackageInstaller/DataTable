-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_scene.lua

module("logic.config.t_scene", package.seeall)

local title = {
	amb = 11,
	volumeResPath = 7,
	confinerResPath = 8,
	code = 1,
	bgm = 10,
	normalLightCode = 5,
	extraParam = 9,
	sceneType = 2,
	cameraCode = 4,
	resPath = 3,
	performanceLightCode = 6
}
local dataList = {
	{
		2001,
		1,
		"sx-s310_shapan/scene_run/sx-s310_shapan_run",
		3,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		2002,
		1,
		"sx-map301_merchandise/scene_run/sx-map301_merchandise_run",
		5,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		3001,
		1,
		"sx-s201_spacestation/scene_run/sx-s201_spacestation_run",
		4,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		4001,
		6,
		"sx-s410_drawcard/scene_run/sx-s410_chouka_effect_run",
		1,
		0,
		0,
		"",
		"",
		"",
		120002,
		900020
	},
	{
		5001,
		5,
		"sx-s510_baindui/scene_run/sx-s510_baindui_run",
		8,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		6000,
		7,
		"sx-s602_paotuan/scene_run/sx-s602_paotuan_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		6001,
		7,
		"sx-s602_paotuan/scene_run/sx-s602_paotuan_00_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		6002,
		7,
		"sx-s601_paotuan/scene_run/sx-s601_paotuan_temp_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		6003,
		8,
		"sx-s606_paotuan/scene_run/sx-s606_paotuan_01_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		6004,
		8,
		"sx-s606_paotuan/scene_run/sx-s606_paotuan_02_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		6005,
		8,
		"sx-s607_fanzuixianchang/scene_run/sx-s607_fanzuixianchang_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.9}",
		0,
		0
	},
	{
		6006,
		8,
		"sx-s608_meishuguang/scene_run/sx-s608_meishuguang_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.9}",
		0,
		0
	},
	{
		6007,
		8,
		"sx-s609_diaochaju/scene_run/sx-s609_diaochaju_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.9}",
		0,
		0
	},
	{
		6008,
		8,
		"sx-s610_xianyirenroom/scene_run/sx-s610_xianyirenroom_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 1.1}",
		0,
		0
	},
	{
		6009,
		8,
		"sx-s608_meishuguang/scene_run/sx-s608_meishuguang_b_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.9}",
		0,
		0
	},
	{
		6010,
		8,
		"sx-s606_paotuan/scene_run/sx-s606_paotuan_03_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		6011,
		7,
		"sx-s606_paotuan/scene_run/sx-s606_paotuan_new_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		6201,
		8,
		"sx-s602_paotuan/scene_run/sx-s602_paotuan_01_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		6202,
		8,
		"sx-s602_paotuan/scene_run/sx-s602_paotuan_02_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		6203,
		8,
		"sx-s602_paotuan/scene_run/sx-s602_paotuan_03_run",
		9,
		0,
		0,
		"",
		"",
		"{exitTime = 0.6}",
		0,
		0
	},
	{
		9001,
		4,
		"sx-s001_mainscene/scene_run/sx-s001_mainscene_run",
		6,
		0,
		0,
		"",
		"",
		"",
		120013,
		900019
	},
	{
		11000,
		10,
		"sx-story_empty/scene_run/sx-story_empty_run",
		1,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		11001,
		10,
		"sx-s109_factoryscrap/scene_run/sx-s109_factoryscrap_jq_run",
		1,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		11002,
		10,
		"sx-s109_factoryscrap/scene_run/sx-s109_factoryscrap_jq_a_run",
		1,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		11003,
		10,
		"sx-s111_city/scene_run/sx-s111_city_juqing_a_run",
		1,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		5002,
		11,
		"sx-s410_drawcard/scene_run/sx-s410_chouka_selection_run",
		1,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		5003,
		13,
		"sx-s301_cranemac/scene_run/sx-s301_cranemac_run",
		1,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		5004,
		15,
		"sx-s001_mainscene/scene_run/sx-s001_mainscene_c_run",
		14,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		7001,
		16,
		"sx-s410_drawcard/scene_run/sx-s410_chouka_selection_a_run",
		15,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		7002,
		16,
		"sx-s410_drawcard/scene_run/sx-s410_chouka_selection_b_run",
		15,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	},
	{
		7003,
		16,
		"sx-s410_drawcard/scene_run/sx-s410_chouka_selection_c_run",
		15,
		0,
		0,
		"",
		"",
		"",
		0,
		0
	}
}
local t_scene = {}

t_scene.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_scene[v[1]] = v

	setmetatable(v, mt)
end

return t_scene
