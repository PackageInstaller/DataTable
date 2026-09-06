-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_longhuang_game.lua

module("logicconfig.config.t_longhuang_game", package.seeall)

local title = {
	frequency = 3,
	velocityRatio = 6,
	time = 2,
	id = 1,
	numberWeights = 4,
	directionWeights = 5
}
local dataList = {
	{
		1,
		0.5,
		0.25,
		"5,50#6,30#7,20",
		"1,100",
		0.8
	},
	{
		2,
		1,
		0.25,
		"6,50#7,30#8,20",
		"1,100",
		0.9
	},
	{
		3,
		2,
		0.2,
		"6,50#7,30#8,20",
		"1,100",
		1
	},
	{
		4,
		3,
		0.15,
		"6,50#7,30#8,20",
		"1,50#2,50",
		1.1
	},
	{
		5,
		4,
		0.15,
		"6,50#7,30#8,20",
		"1,50#2,50",
		1.2
	},
	{
		6,
		5,
		0.1,
		"6,50#7,30#8,20",
		"1,50#2,50",
		1.2
	},
	{
		7,
		6,
		0.05,
		"6,50#7,30#8,20",
		"1,50#2,50",
		1.2
	},
	{
		8,
		7,
		0.05,
		"6,50#7,30#8,20",
		"1,50#2,50",
		1.2
	},
	{
		9,
		8,
		0.05,
		"6,50#7,30#8,20",
		"1,50#2,50",
		1.2
	}
}
local t_longhuang_game = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_longhuang_game.dataList = dataList

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

return t_longhuang_game
