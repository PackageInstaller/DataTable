-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_trial_monster.lua

module("logicconfig.config.t_dragon_trial_monster", package.seeall)

local title = {
	firstPassPrize = 7,
	name = 4,
	showName = 5,
	skipTime = 9,
	retreatMsgType = 13,
	formCondition = 10,
	planId = 1,
	btlMode = 11,
	popupPic = 14,
	damagePrizePlan = 8,
	winId = 12,
	creepsMasterId = 3,
	stage = 2,
	iconName = 6
}
local dataList = {
	{
		1,
		1,
		1001,
		"第1关",
		"赤焰龙皇试炼",
		"btn_lssl_ciyanlonghuang",
		"10:108002:180",
		0,
		15,
		66,
		"",
		0,
		0,
		"board_jqfb_sm9"
	},
	{
		1,
		2,
		1002,
		"第2关",
		"真龙试炼",
		"btn_lssl_ciyuanshenglong",
		"10:108002:180",
		0,
		15,
		66,
		"",
		0,
		0,
		"board_jqfb_sm8"
	},
	{
		1,
		3,
		1003,
		"第3关",
		"青龙试炼",
		"btn_lssl_huangjinshenglong",
		"10:108002:180",
		0,
		15,
		66,
		"",
		0,
		0,
		"board_jqfb_sm7"
	},
	{
		1,
		4,
		1004,
		"第4关",
		"圣光飞龙试炼",
		"btn_lssl_shenguangfeilong",
		"10:108002:180",
		0,
		15,
		66,
		"",
		0,
		0,
		"board_jqfb_sm10"
	},
	{
		1,
		5,
		1005,
		"第5关",
		"星蓝龙试炼",
		"btn_lssl_xinglanlong",
		"10:108002:180",
		0,
		15,
		66,
		"",
		0,
		0,
		"board_jqfb_sm11"
	},
	{
		2,
		1,
		2001,
		"第1关",
		"赤焰龙皇试炼",
		"btn_lssl_ciyanlonghuang",
		"",
		2,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm9"
	},
	{
		2,
		2,
		2002,
		"第2关",
		"真龙试炼",
		"btn_lssl_ciyuanshenglong",
		"",
		2,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm8"
	},
	{
		2,
		3,
		2003,
		"第3关",
		"青龙试炼",
		"btn_lssl_huangjinshenglong",
		"",
		2,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm7"
	},
	{
		2,
		4,
		2004,
		"第4关",
		"圣光飞龙试炼",
		"btn_lssl_shenguangfeilong",
		"",
		2,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm10"
	},
	{
		2,
		5,
		2005,
		"第5关",
		"星蓝龙试炼",
		"btn_lssl_xinglanlong",
		"",
		2,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm11"
	},
	{
		3,
		1,
		3001,
		"第1关",
		"赤焰龙皇试炼",
		"btn_lssl_ciyanlonghuang",
		"",
		3,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm9"
	},
	{
		3,
		2,
		3002,
		"第2关",
		"真龙试炼",
		"btn_lssl_ciyuanshenglong",
		"",
		3,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm8"
	},
	{
		3,
		3,
		3003,
		"第3关",
		"青龙试炼",
		"btn_lssl_huangjinshenglong",
		"",
		3,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm7"
	},
	{
		3,
		4,
		3004,
		"第4关",
		"圣光飞龙试炼",
		"btn_lssl_shenguangfeilong",
		"",
		3,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm10"
	},
	{
		3,
		5,
		3005,
		"第5关",
		"星蓝龙试炼",
		"btn_lssl_xinglanlong",
		"",
		3,
		15,
		0,
		"",
		72,
		0,
		"board_jqfb_sm11"
	}
}
local t_dragon_trial_monster = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_dragon_trial_monster.dataList = dataList

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

return t_dragon_trial_monster
