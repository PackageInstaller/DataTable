-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_power_contest_activity.lua

module("logicconfig.config.t_fire_power_contest_activity", package.seeall)

local title = {
	stagePlanId = 3,
	raceId_1 = 12,
	winScore = 6,
	prizePlanId = 2,
	bgPath_2 = 15,
	hangUpScore = 8,
	raceId_2 = 13,
	scoreExtra = 7,
	bgPath_1 = 14,
	activityId = 1,
	bulletSpeed = 18,
	iconPath_2 = 11,
	rulesKey = 9,
	iconPath_1 = 10,
	times = 5,
	bulletPath = 16,
	gameName = 4,
	bulletEffectPath = 17
}
local dataList = {
	{
		158001,
		1,
		1,
		"火焰力量",
		3,
		50,
		{
			"2:5",
			"3:15"
		},
		50,
		"firerule",
		"board_hyll_21",
		"board_hyll_22",
		12003,
		"12006",
		"bg_hyll_04",
		"bg_hyll_05",
		"fx_ui_hyll_dandao",
		"fx_ui_hyll_dashe",
		100
	},
	{
		158002,
		1,
		1,
		"火焰力量2期",
		3,
		50,
		{
			"2:5",
			"3:15"
		},
		50,
		"firerule",
		"board_hyll_21",
		"board_hyll_22",
		12003,
		"12006",
		"bg_hyll_04",
		"bg_hyll_05",
		"fx_ui_hyll_dandao",
		"fx_ui_hyll_dashe",
		100
	},
	{
		158003,
		2,
		1,
		"秩序对抗",
		3,
		50,
		{
			"2:5",
			"3:15"
		},
		50,
		"firerule",
		"btn_hyll_blw02",
		"btn_hyll_blw03",
		12003,
		"12006",
		"bg_hyll_blw04",
		"bg_hyll_blw05",
		"fx_ui_hyll_dandao",
		"fx_ui_hyll_dashe",
		100
	},
	{
		158004,
		3,
		1,
		"星辰对决",
		3,
		50,
		{
			"2:5",
			"3:15"
		},
		50,
		"firerule",
		"board_hyll_21",
		"board_hyll_22",
		12003,
		"12006",
		"bg_hyll_04",
		"bg_hyll_05",
		"fx_ui_hyll_dandao",
		"fx_ui_hyll_dashe",
		100
	},
	{
		158005,
		4,
		1,
		"奇迹对决",
		3,
		50,
		{
			"2:5",
			"3:15"
		},
		50,
		"firerule",
		"board_hyll_qiji_01",
		"board_hyll_qiji_02",
		12022,
		"11024",
		"bg_hyll_ty_02",
		"bg_hyll_ty_02",
		"fx_ui_hyll_dandao",
		"fx_ui_hyll_dashe",
		100
	},
	{
		158006,
		4,
		1,
		"奇迹对决",
		3,
		50,
		{
			"2:5",
			"3:15"
		},
		50,
		"firerule",
		"board_hyll_qiji_01",
		"board_hyll_qiji_02",
		12022,
		"11024",
		"bg_hyll_ty_02",
		"bg_hyll_ty_02",
		"fx_ui_hyll_dandao",
		"fx_ui_hyll_dashe",
		100
	},
	{
		158007,
		5,
		1,
		"秩序对抗",
		3,
		50,
		{
			"2:5",
			"3:15"
		},
		50,
		"firerule",
		"btn_hyll_wuxizhixulong01",
		"btn_hyll_blw03",
		11011,
		"11024",
		"bg_hyll_ty_02",
		"bg_hyll_ty_02",
		"fx_ui_hyll_dandao",
		"fx_ui_hyll_dashe",
		100
	},
	{
		158008,
		6,
		1,
		"击碎暗蚀",
		3,
		50,
		{
			"2:5",
			"3:15"
		},
		50,
		"firerule",
		"btn_hyll_wuxizhixulong01",
		"btn_hyll_blw03",
		12023,
		"11025",
		"bg_hyll_ty_02",
		"bg_hyll_ty_02",
		"fx_ui_hyll_dandao",
		"fx_ui_hyll_dashe",
		100
	},
	{
		158009,
		7,
		1,
		"宿命对决",
		3,
		50,
		{
			"2:5",
			"3:15"
		},
		50,
		"firerule",
		"board_hyll_shooting_01",
		"board_hyll_shooting_02",
		10130,
		"10131",
		"bg_hyll_xl_04",
		"bg_hyll_xl_05",
		"fx_ui_hyll_dandao",
		"fx_ui_hyll_dashe",
		100
	}
}
local t_fire_power_contest_activity = {
	[158001] = dataList[1],
	[158002] = dataList[2],
	[158003] = dataList[3],
	[158004] = dataList[4],
	[158005] = dataList[5],
	[158006] = dataList[6],
	[158007] = dataList[7],
	[158008] = dataList[8],
	[158009] = dataList[9]
}

t_fire_power_contest_activity.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_fire_power_contest_activity
