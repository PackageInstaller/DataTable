-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_empress_normal_clg_progress.lua

module("logicconfig.config.t_empress_normal_clg_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		342001,
		1,
		10,
		"4:90004:1"
	},
	{
		342001,
		2,
		20,
		"8:1:300000"
	},
	{
		342001,
		3,
		30,
		"4:228:5"
	},
	{
		342001,
		4,
		50,
		"8:1:300000"
	},
	{
		342001,
		5,
		70,
		"4:228:5"
	},
	{
		342001,
		6,
		90,
		"8:1:400000"
	},
	{
		342001,
		7,
		120,
		"4:228:5"
	},
	{
		342001,
		8,
		150,
		"4:228:5"
	},
	{
		342002,
		1,
		10,
		"8:1:1000"
	},
	{
		342002,
		2,
		20,
		"8:1:1000"
	},
	{
		342002,
		3,
		30,
		"8:1:1000"
	},
	{
		342002,
		4,
		50,
		"8:1:1000"
	},
	{
		342002,
		5,
		70,
		"8:1:1000"
	},
	{
		342002,
		6,
		90,
		"8:1:1000"
	},
	{
		342002,
		7,
		120,
		"8:1:1000"
	},
	{
		342002,
		8,
		150,
		"8:1:1000"
	}
}
local t_empress_normal_clg_progress = {
	[342001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[342002] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_empress_normal_clg_progress.dataList = dataList

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

return t_empress_normal_clg_progress
