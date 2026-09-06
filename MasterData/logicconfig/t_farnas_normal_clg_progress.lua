-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_farnas_normal_clg_progress.lua

module("logicconfig.config.t_farnas_normal_clg_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	notShowPrize = 5,
	progress = 3,
	activityId = 1
}
local dataList = {
	{
		333001,
		1,
		50,
		"4:218:5",
		0
	},
	{
		333001,
		2,
		100,
		"8:1:250000",
		0
	},
	{
		333001,
		3,
		150,
		"4:218:5",
		0
	},
	{
		333001,
		4,
		200,
		"8:1:250000",
		0
	},
	{
		333001,
		5,
		250,
		"4:218:5",
		0
	},
	{
		333001,
		6,
		300,
		"8:1:250000",
		0
	},
	{
		333001,
		7,
		350,
		"4:218:5",
		0
	},
	{
		333001,
		8,
		400,
		"8:1:250000",
		0
	},
	{
		333001,
		9,
		450,
		"4:90004:1",
		0
	},
	{
		333001,
		10,
		9999999,
		"",
		1
	},
	{
		333002,
		1,
		50,
		"4:218:5",
		0
	},
	{
		333002,
		2,
		100,
		"8:1:250000",
		0
	},
	{
		333002,
		3,
		150,
		"4:218:5",
		0
	},
	{
		333002,
		4,
		200,
		"8:1:250000",
		0
	},
	{
		333002,
		5,
		250,
		"4:218:5",
		0
	},
	{
		333002,
		6,
		300,
		"8:1:250000",
		0
	},
	{
		333002,
		7,
		350,
		"4:218:5",
		0
	},
	{
		333002,
		8,
		400,
		"8:1:250000",
		0
	},
	{
		333002,
		9,
		450,
		"4:90004:1",
		0
	},
	{
		333002,
		10,
		9999999,
		"",
		1
	}
}
local t_farnas_normal_clg_progress = {
	[333001] = {
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
	},
	[333002] = {
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
}

t_farnas_normal_clg_progress.dataList = dataList

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

return t_farnas_normal_clg_progress
