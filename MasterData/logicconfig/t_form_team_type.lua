-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_team_type.lua

module("logicconfig.config.t_form_team_type", package.seeall)

local title = {
	endHandle = 7,
	name = 2,
	isForcePipe = 9,
	funId = 3,
	openPeriodLimit = 4,
	typeId = 1,
	countDownSec = 6,
	onlineTime = 5,
	buffPlanId = 8,
	isNotAutoReady = 10
}
local dataList = {
	{
		1,
		"强攻幻境",
		0,
		"每周|1@00:00-23:59#5-7@00:00-23:59",
		"2020-04-01 05:00:00#2040-12-30 05:00:00",
		90,
		1,
		1,
		false,
		false
	},
	{
		2,
		"御守幻境",
		0,
		"每周|2@00:00-23:59#5-7@00:00-23:59",
		"2020-04-01 05:00:00#2040-12-30 05:00:00",
		90,
		1,
		1,
		false,
		false
	},
	{
		3,
		"制衡幻境",
		0,
		"每周|3@00:00-23:59#5-7@00:00-23:59",
		"2020-04-01 05:00:00#2040-12-30 05:00:00",
		90,
		1,
		1,
		false,
		false
	},
	{
		4,
		"通感幻境",
		0,
		"每周|4@00:00-23:59#5-7@00:00-23:59",
		"2020-04-01 05:00:00#2040-12-30 05:00:00",
		90,
		1,
		1,
		false,
		false
	},
	{
		5,
		"星神幻境",
		0,
		"全天",
		"2020-04-01 05:00:00#2030-12-30 05:00:00",
		90,
		1,
		2,
		false,
		false
	},
	{
		6,
		"决战领神",
		0,
		"全天",
		"2024-05-31 05:00:00#2024-06-07 05:00:00",
		90,
		1,
		2,
		false,
		false
	},
	{
		7,
		"决战领神",
		0,
		"全天",
		"2024-06-07 05:00:00#2024-06-14 05:00:00",
		90,
		1,
		2,
		false,
		false
	},
	{
		8,
		"决战领神",
		0,
		"全天",
		"2024-06-14 05:00:00#2024-06-21 05:00:00",
		90,
		1,
		2,
		false,
		false
	},
	{
		9,
		"决战领神",
		0,
		"全天",
		"2024-06-21 05:00:00#2024-06-28 05:00:00",
		90,
		1,
		2,
		false,
		false
	},
	{
		10,
		"决战魔君",
		0,
		"全天",
		"2024-11-08 05:00:00#2024-11-22 05:00:00",
		90,
		1,
		2,
		false,
		false
	},
	{
		11,
		"决战魔君",
		0,
		"全天",
		"2025-01-17 05:00:00#2025-01-31 05:00:00",
		90,
		1,
		2,
		false,
		false
	},
	{
		12,
		"决战瑞兽",
		0,
		"全天",
		"2025-01-24 05:00:00#2025-02-28 05:00:00",
		90,
		1,
		2,
		false,
		false
	},
	{
		13,
		"终焉魔阵",
		0,
		"全天",
		"2025-09-26 05:00:00#2025-10-10 05:00:00",
		90,
		1,
		0,
		true,
		true
	},
	{
		14,
		"你画我猜",
		0,
		"全天",
		"2025-11-28 05:00:00#2025-12-19 05:00:00",
		90,
		1,
		0,
		false,
		false
	}
}
local t_form_team_type = {
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
	dataList[13],
	dataList[14]
}

t_form_team_type.dataList = dataList

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

return t_form_team_type
