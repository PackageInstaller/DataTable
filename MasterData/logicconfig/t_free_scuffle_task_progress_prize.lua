-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_task_progress_prize.lua

module("logicconfig.config.t_free_scuffle_task_progress_prize", package.seeall)

local title = {
	progressId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		489001,
		1,
		10,
		"10:489001:400"
	},
	{
		489001,
		2,
		20,
		"10:489001:600"
	},
	{
		489001,
		3,
		30,
		"10:489001:800"
	},
	{
		489001,
		4,
		50,
		"10:489001:1000"
	},
	{
		489001,
		5,
		70,
		"10:489001:1200"
	},
	{
		489001,
		6,
		100,
		"10:489001:1400"
	},
	{
		489001,
		7,
		150,
		"10:489001:1600"
	},
	{
		489001,
		8,
		200,
		"10:489001:1800"
	},
	{
		489001,
		9,
		300,
		"10:489001:2000"
	},
	{
		489002,
		1,
		10,
		"10:489003:400"
	},
	{
		489002,
		2,
		20,
		"10:489003:600"
	},
	{
		489002,
		3,
		30,
		"10:489003:800"
	},
	{
		489002,
		4,
		50,
		"10:489003:1000"
	},
	{
		489002,
		5,
		70,
		"10:489003:1200"
	},
	{
		489002,
		6,
		100,
		"10:489003:1400"
	},
	{
		489002,
		7,
		150,
		"10:489003:1600"
	},
	{
		489002,
		8,
		200,
		"10:489003:1800"
	},
	{
		489002,
		9,
		300,
		"10:489003:2000"
	},
	{
		489003,
		1,
		10,
		"10:489005:400"
	},
	{
		489003,
		2,
		20,
		"10:489005:600"
	},
	{
		489003,
		3,
		30,
		"10:489005:800"
	},
	{
		489003,
		4,
		50,
		"10:489005:1000"
	},
	{
		489003,
		5,
		70,
		"10:489005:1200"
	},
	{
		489003,
		6,
		100,
		"10:489005:1400"
	},
	{
		489003,
		7,
		150,
		"10:489005:1600"
	},
	{
		489003,
		8,
		200,
		"10:489005:1800"
	},
	{
		489003,
		9,
		300,
		"10:489005:2000"
	}
}
local t_free_scuffle_task_progress_prize = {
	[489001] = {
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
	[489002] = {
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	[489003] = {
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27]
	}
}

t_free_scuffle_task_progress_prize.dataList = dataList

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

return t_free_scuffle_task_progress_prize
