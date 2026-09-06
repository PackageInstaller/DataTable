-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_red_lotus_gala_progress.lua

module("logicconfig.config.t_red_lotus_gala_progress", package.seeall)

local title = {
	prizeId = 2,
	gain = 3,
	gamePrizePlan = 1,
	score = 4
}
local dataList = {
	{
		1,
		1,
		"8:1:100000",
		200
	},
	{
		1,
		2,
		"4:31:1",
		400
	},
	{
		1,
		3,
		"8:1:100000",
		600
	},
	{
		1,
		4,
		"10:17073:100",
		800
	},
	{
		1,
		5,
		"8:1:100000",
		1000
	},
	{
		1,
		6,
		"4:31:1",
		1200
	},
	{
		1,
		7,
		"8:1:100000",
		1400
	},
	{
		1,
		8,
		"10:17073:100",
		1600
	},
	{
		1,
		9,
		"4:40008:1",
		1800
	}
}
local t_red_lotus_gala_progress = {
	{
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
}

t_red_lotus_gala_progress.dataList = dataList

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

return t_red_lotus_gala_progress
