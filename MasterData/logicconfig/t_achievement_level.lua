-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_achievement_level.lua

module("logicconfig.config.t_achievement_level", package.seeall)

local title = {
	needPoint = 2,
	prize = 3,
	level = 1
}
local dataList = {
	{
		1,
		20,
		"104:2:100"
	},
	{
		2,
		40,
		"104:2:100"
	},
	{
		3,
		60,
		"104:2:100"
	},
	{
		4,
		80,
		"104:2:100"
	},
	{
		5,
		100,
		"104:2:100"
	},
	{
		6,
		120,
		"104:2:100"
	},
	{
		7,
		140,
		"104:2:100"
	},
	{
		8,
		160,
		"104:2:100"
	},
	{
		9,
		180,
		"104:2:100"
	},
	{
		10,
		200,
		"104:2:100"
	},
	{
		11,
		220,
		"104:2:100"
	},
	{
		12,
		240,
		"104:2:100"
	},
	{
		13,
		260,
		"104:2:100"
	},
	{
		14,
		280,
		"104:2:100"
	},
	{
		15,
		300,
		"104:2:100"
	}
}
local t_achievement_level = {
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

t_achievement_level.dataList = dataList

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

return t_achievement_level
