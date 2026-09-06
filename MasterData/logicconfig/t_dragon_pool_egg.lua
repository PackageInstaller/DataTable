-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_pool_egg.lua

module("logicconfig.config.t_dragon_pool_egg", package.seeall)

local title = {
	eggId = 2,
	initialGrowth = 4,
	initialMood = 5,
	eggIcon = 6,
	dragonIcon = 7,
	maxGrowth = 3,
	actId = 1
}
local dataList = {
	{
		300001,
		1,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_05",
		"ui/bigbg/dragonpool/board_longdantianchi_06"
	},
	{
		300001,
		2,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_13",
		"ui/bigbg/dragonpool/board_longdantianchi_07"
	},
	{
		300001,
		3,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_14",
		"ui/bigbg/dragonpool/board_longdantianchi_08"
	},
	{
		300001,
		4,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_15",
		"ui/bigbg/dragonpool/board_longdantianchi_09"
	},
	{
		300001,
		5,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_16",
		"ui/bigbg/dragonpool/board_longdantianchi_10"
	},
	{
		300001,
		6,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_17",
		"ui/bigbg/dragonpool/board_longdantianchi_11"
	},
	{
		300001,
		7,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_18",
		"ui/bigbg/dragonpool/board_longdantianchi_12"
	},
	{
		300001,
		8,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_05",
		"ui/bigbg/dragonpool/board_longdantianchi_06"
	},
	{
		300001,
		9,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_13",
		"ui/bigbg/dragonpool/board_longdantianchi_07"
	},
	{
		300001,
		10,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_14",
		"ui/bigbg/dragonpool/board_longdantianchi_08"
	},
	{
		300001,
		11,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_15",
		"ui/bigbg/dragonpool/board_longdantianchi_09"
	},
	{
		300001,
		12,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_16",
		"ui/bigbg/dragonpool/board_longdantianchi_10"
	},
	{
		300001,
		13,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_17",
		"ui/bigbg/dragonpool/board_longdantianchi_11"
	},
	{
		300001,
		14,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_18",
		"ui/bigbg/dragonpool/board_longdantianchi_12"
	},
	{
		300001,
		15,
		100,
		0,
		0,
		"ui/bigbg/dragonpool/board_longdantianchi_05",
		"ui/bigbg/dragonpool/board_longdantianchi_06"
	}
}
local t_dragon_pool_egg = {
	[300001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_dragon_pool_egg.dataList = dataList

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

return t_dragon_pool_egg
