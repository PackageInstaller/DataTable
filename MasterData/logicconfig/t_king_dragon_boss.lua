-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_dragon_boss.lua

module("logicconfig.config.t_king_dragon_boss", package.seeall)

local title = {
	damageScorePlan = 7,
	rankSize = 3,
	helpPlanId = 9,
	sweepTips = 10,
	maxDmg = 5,
	planId = 1,
	displayMaxRound = 6,
	buyTimesPlanId = 4,
	creepsMasterId = 8,
	dailyBuffPlanId = 11,
	freeDailyTimes = 2
}
local dataList = {
	{
		1,
		3,
		100,
		1,
		10000000,
		99,
		1,
		1101,
		0,
		"您已达到该试炼的伤害上限，开启扫荡模式，直接按照最高伤害扫荡本关。",
		0
	},
	{
		2,
		5,
		100,
		2,
		10000000,
		99,
		2,
		6101,
		0,
		"您已达到该试炼的伤害上限，开启扫荡模式，直接按照最高伤害扫荡本关。",
		1
	}
}
local t_king_dragon_boss = {
	dataList[1],
	dataList[2]
}

t_king_dragon_boss.dataList = dataList

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

return t_king_dragon_boss
