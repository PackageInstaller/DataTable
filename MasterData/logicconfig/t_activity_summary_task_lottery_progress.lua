-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_summary_task_lottery_progress.lua

module("logicconfig.config.t_activity_summary_task_lottery_progress", package.seeall)

local title = {
	id = 2,
	needTimes = 3,
	prize = 4,
	lotteryProgressPlanId = 1
}
local dataList = {
	{
		1,
		1,
		12,
		"4:90015:30"
	},
	{
		1,
		2,
		25,
		"100:10100:100:1"
	},
	{
		1,
		3,
		35,
		"104:2:1000"
	},
	{
		1,
		4,
		45,
		"4:36:10"
	},
	{
		1,
		5,
		60,
		"4:90015:30"
	},
	{
		1,
		6,
		75,
		"104:2:1000"
	},
	{
		1,
		7,
		90,
		"4:36:10"
	},
	{
		1,
		8,
		105,
		"100:10165:100:1"
	},
	{
		1,
		9,
		130,
		"4:31:10"
	},
	{
		1,
		10,
		140,
		"4:90015:30"
	},
	{
		1,
		11,
		150,
		"104:2:1000"
	},
	{
		1,
		12,
		160,
		"4:36:10"
	},
	{
		2,
		1,
		5,
		"4:5101:32"
	},
	{
		2,
		2,
		10,
		"100:10325:100:1"
	},
	{
		2,
		3,
		15,
		"4:5202:16"
	},
	{
		2,
		4,
		25,
		"4:36:10"
	},
	{
		2,
		5,
		35,
		"4:5101:32"
	},
	{
		2,
		6,
		45,
		"4:5202:16"
	},
	{
		2,
		7,
		55,
		"4:36:10"
	},
	{
		2,
		8,
		60,
		"18:402:1"
	},
	{
		2,
		9,
		70,
		"4:5101:32"
	},
	{
		2,
		10,
		75,
		"4:5202:16"
	},
	{
		2,
		11,
		80,
		"4:36:10"
	},
	{
		2,
		12,
		90,
		"18:410:1"
	}
}
local t_activity_summary_task_lottery_progress = {
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
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
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

t_activity_summary_task_lottery_progress.dataList = dataList

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

return t_activity_summary_task_lottery_progress
