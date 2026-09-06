-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_throne_achievement_config.lua

module("logicconfig.config.t_throne_achievement_config", package.seeall)

local title = {
	id = 1,
	num = 3,
	prize = 4,
	desc = 2
}
local dataList = {
	{
		1,
		"获得5种收藏品",
		5,
		"104:2:10"
	},
	{
		2,
		"获得10种收藏品",
		10,
		"104:2:10"
	},
	{
		3,
		"获得15种收藏品",
		15,
		"104:2:10"
	},
	{
		4,
		"获得20种收藏品",
		20,
		"104:2:10"
	},
	{
		5,
		"获得25种收藏品",
		25,
		"104:2:10"
	},
	{
		6,
		"获得30种收藏品",
		30,
		"104:2:10"
	},
	{
		7,
		"获得35种收藏品",
		35,
		"104:2:10"
	},
	{
		8,
		"获得40种收藏品",
		40,
		"104:2:10"
	},
	{
		9,
		"获得45种收藏品",
		45,
		"104:2:10"
	},
	{
		10,
		"获得50种收藏品",
		50,
		"104:2:10"
	},
	{
		11,
		"获得55种收藏品",
		55,
		"104:2:10"
	},
	{
		12,
		"获得60种收藏品",
		60,
		"104:2:10"
	},
	{
		13,
		"获得65种收藏品",
		65,
		"104:2:10"
	},
	{
		14,
		"获得70种收藏品",
		70,
		"104:2:10"
	},
	{
		15,
		"获得75种收藏品",
		75,
		"104:2:10"
	},
	{
		16,
		"获得80种收藏品",
		80,
		"104:2:10"
	},
	{
		17,
		"获得85种收藏品",
		85,
		"104:2:10"
	},
	{
		18,
		"获得90种收藏品",
		90,
		"104:2:10"
	},
	{
		19,
		"获得95种收藏品",
		95,
		"104:2:10"
	},
	{
		20,
		"获得100种收藏品",
		100,
		"104:2:10"
	}
}
local t_throne_achievement_config = {
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
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20]
}

t_throne_achievement_config.dataList = dataList

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

return t_throne_achievement_config
