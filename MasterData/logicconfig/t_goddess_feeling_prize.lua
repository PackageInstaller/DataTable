-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_feeling_prize.lua

module("logicconfig.config.t_goddess_feeling_prize", package.seeall)

local title = {
	id = 2,
	prize = 4,
	planId = 1,
	level = 3
}
local dataList = {
	{
		1,
		1,
		2,
		"4:41003:1"
	},
	{
		1,
		2,
		3,
		"4:41003:1"
	},
	{
		1,
		3,
		4,
		"4:41004:1#4:503:20"
	},
	{
		1,
		4,
		5,
		"4:41003:2"
	},
	{
		1,
		5,
		6,
		"4:41003:2"
	},
	{
		1,
		6,
		7,
		"4:41003:3"
	},
	{
		1,
		7,
		8,
		"4:41003:3#4:503:50"
	},
	{
		1,
		8,
		9,
		"4:41003:3"
	},
	{
		1,
		9,
		10,
		"4:41003:5"
	},
	{
		1,
		10,
		11,
		"4:41004:1#4:503:80"
	}
}
local t_goddess_feeling_prize = {
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

t_goddess_feeling_prize.dataList = dataList

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

return t_goddess_feeling_prize
