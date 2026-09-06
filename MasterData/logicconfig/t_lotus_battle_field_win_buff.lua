-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_win_buff.lua

module("logicconfig.config.t_lotus_battle_field_win_buff", package.seeall)

local title = {
	name = 3,
	buffDesc = 5,
	winBuffPlanId = 1,
	iconPath = 4,
	winTimes = 2
}
local dataList = {
	{
		1,
		1,
		"暴走Ⅰ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+5%"
	},
	{
		1,
		2,
		"暴走Ⅱ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+10%"
	},
	{
		1,
		3,
		"暴走Ⅲ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+15%"
	},
	{
		1,
		4,
		"暴走Ⅳ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+20%"
	},
	{
		1,
		5,
		"暴走Ⅴ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+25%"
	},
	{
		1,
		6,
		"暴走Ⅵ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+30%"
	},
	{
		1,
		7,
		"暴走Ⅶ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+35%"
	},
	{
		1,
		8,
		"暴走Ⅷ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+40%"
	},
	{
		1,
		9,
		"暴走Ⅸ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+45%"
	},
	{
		1,
		10,
		"暴走Ⅹ",
		"icon_expedition_baojilv1",
		"己方所有精灵暴击率+50%"
	}
}
local t_lotus_battle_field_win_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_lotus_battle_field_win_buff.dataList = dataList

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

return t_lotus_battle_field_win_buff
