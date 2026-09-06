-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_roguelike_phase.lua

module("logicconfig.config.t_roguelike_phase", package.seeall)

local title = {
	extMinKillCount2Rank = 11,
	name = 3,
	phaseId = 2,
	normalResetDropBuffCost = 5,
	extResetDropBuffCost = 6,
	extRaces = 9,
	extRerandomPlanId = 8,
	extKillCounterBuff = 10,
	normalRerandomPlanId = 7,
	mailTemplateId4KillRank = 12,
	mailTemplateId4PassRank = 13,
	activityId = 1,
	releaseTime = 4
}
local dataList = {
	{
		393001,
		1,
		"解神试炼",
		"2024-07-26T05:00:00",
		"10:393001:1000",
		"10:393001:3000",
		1,
		2,
		{
			16026
		},
		20057802,
		10,
		261,
		264
	},
	{
		393001,
		2,
		"究试炼",
		"2024-08-09T05:00:00",
		"10:393001:1000",
		"10:393001:3000",
		1,
		2,
		{
			17018
		},
		20057802,
		10,
		262,
		265
	},
	{
		393002,
		1,
		"梵天试炼",
		"2024-11-29T05:00:00",
		"10:393002:1000",
		"10:393002:3000",
		1,
		2,
		{
			16029
		},
		20057802,
		10,
		261,
		264
	},
	{
		393002,
		2,
		"无序试炼",
		"2024-12-06T05:00:00",
		"10:393002:1000",
		"10:393002:3000",
		1,
		2,
		{
			16030
		},
		20057802,
		10,
		262,
		265
	},
	{
		393003,
		1,
		"龙脉诺试炼",
		"2026-01-02T05:00:00",
		"10:393003:1000",
		"10:393003:3000",
		1,
		2,
		{
			16044
		},
		20057802,
		10,
		261,
		264
	},
	{
		393003,
		2,
		"超神试炼",
		"2026-01-09T05:00:00",
		"10:393003:1000",
		"10:393003:3000",
		1,
		2,
		{
			16045
		},
		20057802,
		10,
		262,
		265
	}
}
local t_roguelike_phase = {
	[393001] = {
		dataList[1],
		dataList[2]
	},
	[393002] = {
		dataList[3],
		dataList[4]
	},
	[393003] = {
		dataList[5],
		dataList[6]
	}
}

t_roguelike_phase.dataList = dataList

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

return t_roguelike_phase
