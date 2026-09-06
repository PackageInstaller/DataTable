-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_level_info.lua

module("logicconfig.config.t_zoo_level_info", package.seeall)

local title = {
	loveMaxNum = 4,
	loveNum = 3,
	upLevel = 5,
	upLove = 6,
	animalNum = 2,
	level = 1
}
local dataList = {
	{
		1,
		2,
		55,
		55,
		0,
		0
	},
	{
		2,
		4,
		50,
		110,
		30,
		55
	},
	{
		3,
		5,
		45,
		165,
		40,
		330
	},
	{
		4,
		6,
		40,
		220,
		50,
		605
	},
	{
		5,
		6,
		35,
		275,
		60,
		880
	},
	{
		6,
		8,
		30,
		330,
		70,
		1155
	},
	{
		7,
		8,
		25,
		385,
		80,
		1430
	},
	{
		8,
		8,
		20,
		440,
		90,
		1705
	}
}
local t_zoo_level_info = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_zoo_level_info.dataList = dataList

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

return t_zoo_level_info
