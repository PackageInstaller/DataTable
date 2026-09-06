-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_tian_clg_progress.lua

module("logicconfig.config.t_fan_tian_clg_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		313001,
		1,
		2,
		"4:382:10"
	},
	{
		313001,
		2,
		4,
		"4:382:10"
	},
	{
		313001,
		3,
		8,
		"4:382:10"
	},
	{
		313001,
		4,
		12,
		"4:382:10"
	},
	{
		313001,
		5,
		16,
		"4:382:20"
	},
	{
		313001,
		6,
		20,
		"4:382:20"
	},
	{
		313001,
		7,
		25,
		"4:382:20"
	},
	{
		313001,
		8,
		30,
		"4:382:20"
	},
	{
		313002,
		1,
		2,
		"8:1:100000"
	},
	{
		313002,
		2,
		4,
		"8:1:100000"
	},
	{
		313002,
		3,
		8,
		"8:1:100000"
	},
	{
		313002,
		4,
		12,
		"8:1:100000"
	},
	{
		313002,
		5,
		16,
		"8:1:100000"
	},
	{
		313002,
		6,
		20,
		"8:1:100000"
	},
	{
		313002,
		7,
		25,
		"8:1:100000"
	},
	{
		313002,
		8,
		30,
		"4:387:100"
	},
	{
		313003,
		1,
		2,
		"8:1:100000"
	},
	{
		313003,
		2,
		4,
		"8:1:100000"
	},
	{
		313003,
		3,
		8,
		"8:1:100000"
	},
	{
		313003,
		4,
		12,
		"8:1:100000"
	},
	{
		313003,
		5,
		16,
		"8:1:100000"
	},
	{
		313003,
		6,
		20,
		"8:1:100000"
	},
	{
		313003,
		7,
		25,
		"8:1:100000"
	},
	{
		313003,
		8,
		30,
		"4:510701:100"
	}
}
local t_fan_tian_clg_progress = {
	[313001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[313002] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	[313003] = {
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_fan_tian_clg_progress.dataList = dataList

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

return t_fan_tian_clg_progress
