-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_expedition_sweepSkip.lua

module("logicconfig.config.t_expedition_sweepSkip", package.seeall)

local title = {
	buffTimes = 4,
	skipPrize = 3,
	petTimes = 5,
	skipToLevel = 2,
	level = 1
}
local dataList = {
	{
		1,
		0,
		"4:3:1",
		3,
		1
	},
	{
		2,
		0,
		"4:3:2",
		3,
		1
	},
	{
		3,
		0,
		"4:3:3",
		3,
		1
	},
	{
		4,
		1,
		"4:3:4",
		3,
		1
	},
	{
		5,
		1,
		"4:3:5",
		3,
		1
	},
	{
		6,
		2,
		"4:3:6",
		3,
		1
	},
	{
		7,
		2,
		"4:3:7",
		3,
		1
	}
}
local t_expedition_sweepSkip = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_expedition_sweepSkip.dataList = dataList

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

return t_expedition_sweepSkip
