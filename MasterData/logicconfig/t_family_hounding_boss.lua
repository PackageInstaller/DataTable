-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_hounding_boss.lua

module("logicconfig.config.t_family_hounding_boss", package.seeall)

local title = {
	dayIndex = 2,
	name = 5,
	lihuiPos = 9,
	skinId = 7,
	rukouPos = 8,
	damagePrizePlanId = 4,
	iconPath = 10,
	desc = 11,
	bossPlanId = 1,
	lockTips = 6,
	creepsMasterId = 3
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		"水之试炼",
		"周五开启",
		91002,
		{
			-179,
			116
		},
		{
			0,
			-338,
			0.5
		},
		"ui/icon/character/icon_11002_zhixushenglong",
		"10个回合内对BOSS造成尽量多的伤害"
	},
	{
		1,
		2,
		2,
		1,
		"火之试炼",
		"周六开启",
		90314,
		{
			-210,
			-135
		},
		{
			0,
			-280,
			0.5
		},
		"ui/icon/character/icon_10314_wujinshenglong",
		"10个回合内对BOSS造成尽量多的伤害"
	},
	{
		1,
		3,
		3,
		1,
		"草之试炼",
		"周日开启",
		93008,
		{
			62,
			-115
		},
		{
			116,
			-266,
			0.6
		},
		"ui/icon/character/icon_13008_yonghengshenglong",
		"10个回合内对BOSS造成尽量多的伤害"
	},
	{
		1,
		4,
		4,
		1,
		"光之试炼",
		"周一开启",
		90313,
		{
			106,
			123
		},
		{
			0,
			-340,
			0.6
		},
		"ui/icon/character/icon_10313_ciyuanshenglong",
		"10个回合内对BOSS造成尽量多的伤害"
	},
	{
		1,
		5,
		5,
		1,
		"暗之试炼",
		"周二开启",
		95006,
		{
			461,
			102
		},
		{
			0,
			-304,
			0.6
		},
		"ui/icon/character/icon_15006_longzun",
		"10个回合内对BOSS造成尽量多的伤害"
	},
	{
		1,
		6,
		6,
		1,
		"空之试炼",
		"周三开启",
		96004,
		{
			312,
			-78
		},
		{
			0,
			-300,
			0.5
		},
		"ui/icon/character/icon_16004_chaoshenshenglong",
		"10个回合内对BOSS造成尽量多的伤害"
	},
	{
		1,
		7,
		7,
		1,
		"创之试炼",
		"周四开启",
		97002,
		{
			559,
			-118
		},
		{
			0,
			-400,
			0.6
		},
		"ui/icon/character/icon_17002_longzunshengzhu",
		"10个回合内对BOSS造成尽量多的伤害"
	}
}
local t_family_hounding_boss = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_family_hounding_boss.dataList = dataList

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

return t_family_hounding_boss
