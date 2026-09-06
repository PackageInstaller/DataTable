-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lucky_money_progress.lua

module("logicconfig.config.t_lucky_money_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		438001,
		1,
		150,
		"60:1:600"
	},
	{
		438001,
		2,
		300,
		"4:31:5"
	},
	{
		438001,
		3,
		450,
		"60:1:600"
	},
	{
		438001,
		4,
		600,
		"4:31:5"
	},
	{
		438001,
		5,
		750,
		"60:1:600"
	},
	{
		438001,
		6,
		900,
		"4:36:5"
	},
	{
		438001,
		7,
		1050,
		"60:1:600"
	},
	{
		438001,
		8,
		1200,
		"4:36:5"
	},
	{
		438001,
		9,
		1350,
		"60:1:600"
	},
	{
		438001,
		10,
		1500,
		"4:7008:100"
	}
}
local t_lucky_money_progress = {
	[438001] = {
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

t_lucky_money_progress.dataList = dataList

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

return t_lucky_money_progress
