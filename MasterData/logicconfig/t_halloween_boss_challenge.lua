-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_halloween_boss_challenge.lua

module("logicconfig.config.t_halloween_boss_challenge", package.seeall)

local title = {
	rankPrizePlanId = 7,
	rankTopShowNum = 6,
	dailyPrize = 3,
	viewDesc = 9,
	damagePrizePlanId = 4,
	buffPlanId = 5,
	funcId = 8,
	activityId = 1,
	challengePlanId = 2
}
local dataList = {
	{
		83001,
		1,
		"104:2:100",
		1,
		101,
		20,
		1,
		401,
		"1.活动开启期间，每天对boss造成的最高伤害总和，作为活动战绩\n2.使用当天的守护精灵，可对boss造成伤害加成\n3.每日只要对boss有造成伤害，即可获得每日奖励，累计伤害可领取阶段奖励"
	},
	{
		83002,
		2,
		"104:2:100",
		1,
		201,
		20,
		2,
		401,
		"1.活动开启期间，每天对boss造成的最高伤害总和，作为活动战绩\n2.使用当天的守护精灵，可对boss造成伤害加成\n3.每日只要对boss有造成伤害，即可获得每日奖励，累计伤害可领取阶段奖励"
	}
}
local t_halloween_boss_challenge = {
	[83001] = dataList[1],
	[83002] = dataList[2]
}

t_halloween_boss_challenge.dataList = dataList

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

return t_halloween_boss_challenge
