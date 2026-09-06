-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_normal_clg_monster_type.lua

module("logicconfig.config.t_tun_tian_normal_clg_monster_type", package.seeall)

local title = {
	headName = 4,
	name = 5,
	incProgress = 3,
	monsterTypeId = 2,
	zdl = 6,
	activityId = 1
}
local dataList = {
	{
		289001,
		1,
		30,
		"btn_tuntian_07",
		"普通妖灵",
		100
	},
	{
		289001,
		2,
		40,
		"btn_tuntian_08",
		"高级妖灵",
		200
	},
	{
		289001,
		3,
		50,
		"btn_tuntian_09",
		"稀有妖灵",
		300
	},
	{
		289001,
		4,
		60,
		"btn_tuntian_10",
		"史诗妖灵",
		400
	},
	{
		289001,
		5,
		75,
		"btn_tuntian_11",
		"传说妖灵",
		500
	},
	{
		289002,
		1,
		30,
		"btn_tuntian_07",
		"普通妖灵",
		100
	},
	{
		289002,
		2,
		40,
		"btn_tuntian_08",
		"高级妖灵",
		200
	},
	{
		289002,
		3,
		50,
		"btn_tuntian_09",
		"稀有妖灵",
		300
	},
	{
		289002,
		4,
		60,
		"btn_tuntian_10",
		"史诗妖灵",
		400
	},
	{
		289002,
		5,
		75,
		"btn_tuntian_11",
		"传说妖灵",
		500
	}
}
local t_tun_tian_normal_clg_monster_type = {
	[289001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[289002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_tun_tian_normal_clg_monster_type.dataList = dataList

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

return t_tun_tian_normal_clg_monster_type
