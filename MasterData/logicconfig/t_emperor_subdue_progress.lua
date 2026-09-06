-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_emperor_subdue_progress.lua

module("logicconfig.config.t_emperor_subdue_progress", package.seeall)

local title = {
	progressId = 2,
	totalDamage = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		547001,
		1,
		"1000000",
		"10:553001:20"
	},
	{
		547001,
		2,
		"5000000",
		"8:1:1000000"
	},
	{
		547001,
		3,
		"10000000",
		"10:553001:20"
	},
	{
		547001,
		4,
		"50000000",
		"4:510022:5"
	},
	{
		547001,
		5,
		"100000000",
		"10:553001:40"
	},
	{
		547001,
		6,
		"300000000",
		"4:400002:100"
	},
	{
		547001,
		7,
		"500000000",
		"10:553001:40"
	},
	{
		547001,
		8,
		"800000000",
		"4:90097:1"
	},
	{
		547001,
		9,
		"1000000000",
		"10:553001:40"
	},
	{
		547001,
		10,
		"1500000000",
		"4:400002:100"
	},
	{
		547001,
		11,
		"2000000000",
		"10:553001:40"
	},
	{
		547001,
		12,
		"2500000000",
		"4:400002:100"
	},
	{
		547001,
		13,
		"3000000000",
		"18:601:14043:1"
	}
}
local t_emperor_subdue_progress = {
	[547001] = {
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
		dataList[13]
	}
}

t_emperor_subdue_progress.dataList = dataList

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

return t_emperor_subdue_progress
