-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_di_normal_clg_progress.lua

module("logicconfig.config.t_wu_di_normal_clg_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		317001,
		1,
		70,
		"8:1:250000"
	},
	{
		317001,
		2,
		140,
		"4:208:5"
	},
	{
		317001,
		3,
		150,
		"4:208:5"
	},
	{
		317001,
		4,
		160,
		"8:1:250000"
	},
	{
		317001,
		5,
		170,
		"4:90004:1"
	},
	{
		317001,
		6,
		180,
		"8:1:250000"
	},
	{
		317001,
		7,
		190,
		"8:1:250000"
	},
	{
		317001,
		8,
		200,
		"4:208:5"
	},
	{
		317001,
		9,
		210,
		"4:208:5"
	},
	{
		317002,
		1,
		70,
		"8:1:1"
	},
	{
		317002,
		2,
		140,
		"8:1:1"
	},
	{
		317002,
		3,
		150,
		"8:1:1"
	},
	{
		317002,
		4,
		160,
		"8:1:1"
	},
	{
		317002,
		5,
		170,
		"8:1:1"
	},
	{
		317002,
		6,
		180,
		"8:1:1"
	},
	{
		317002,
		7,
		190,
		"8:1:1"
	},
	{
		317002,
		8,
		200,
		"8:1:1"
	},
	{
		317002,
		9,
		210,
		"8:1:1"
	}
}
local t_wu_di_normal_clg_progress = {
	[317001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[317002] = {
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_wu_di_normal_clg_progress.dataList = dataList

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

return t_wu_di_normal_clg_progress
