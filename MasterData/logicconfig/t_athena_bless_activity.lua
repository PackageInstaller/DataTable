-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_athena_bless_activity.lua

module("logicconfig.config.t_athena_bless_activity", package.seeall)

local title = {
	worldBossPlanId = 6,
	redPointId = 2,
	taskPlanId = 5,
	prizePlanId = 4,
	scoreLvPlanId = 3,
	dailyBuff = 9,
	showScoreLv = 8,
	activityId = 1,
	weeklyScoreLimit = 7
}
local dataList = {
	{
		89001,
		172,
		1,
		1,
		1,
		1,
		3000,
		true,
		"8:1:1"
	},
	{
		89002,
		173,
		2,
		2,
		2,
		2,
		1500,
		false,
		"8:1:1"
	},
	{
		89003,
		186,
		2,
		3,
		3,
		3,
		1500,
		false,
		""
	},
	{
		89004,
		191,
		2,
		4,
		4,
		3,
		1500,
		false,
		""
	},
	{
		89005,
		203,
		2,
		5,
		5,
		4,
		1500,
		false,
		""
	},
	{
		89006,
		211,
		2,
		6,
		6,
		4,
		1250,
		false,
		"8:1:1"
	},
	{
		89007,
		211,
		2,
		6,
		6,
		4,
		1250,
		false,
		""
	},
	{
		89008,
		211,
		2,
		7,
		7,
		4,
		1250,
		false,
		""
	},
	{
		89009,
		211,
		2,
		8,
		8,
		4,
		1600,
		false,
		""
	}
}
local t_athena_bless_activity = {
	[89001] = dataList[1],
	[89002] = dataList[2],
	[89003] = dataList[3],
	[89004] = dataList[4],
	[89005] = dataList[5],
	[89006] = dataList[6],
	[89007] = dataList[7],
	[89008] = dataList[8],
	[89009] = dataList[9]
}

t_athena_bless_activity.dataList = dataList

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

return t_athena_bless_activity
