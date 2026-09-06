-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_blocks.lua

module("logicconfig.config.t_three_matches_blocks", package.seeall)

local title = {
	score = 2,
	blockId = 1,
	cutStep = 4,
	stood = 6,
	rock = 5,
	addStep = 3
}
local dataList = {
	{
		1,
		0,
		0,
		0,
		true,
		true
	},
	{
		2,
		0,
		0,
		0,
		false,
		false
	},
	{
		3,
		0,
		0,
		0,
		false,
		false
	},
	{
		4,
		0,
		1,
		0,
		false,
		false
	},
	{
		5,
		0,
		0,
		1,
		false,
		false
	},
	{
		6,
		0,
		0,
		0,
		false,
		false
	},
	{
		7,
		0,
		0,
		0,
		false,
		false
	},
	{
		8,
		5,
		0,
		0,
		false,
		false
	},
	{
		9,
		5,
		0,
		0,
		false,
		false
	},
	{
		10,
		5,
		0,
		0,
		false,
		false
	},
	{
		11,
		5,
		0,
		0,
		false,
		false
	},
	{
		12,
		5,
		0,
		0,
		false,
		false
	}
}
local t_three_matches_blocks = {
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
	dataList[12]
}

t_three_matches_blocks.dataList = dataList

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

return t_three_matches_blocks
