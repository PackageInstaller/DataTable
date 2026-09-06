-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_god_long_yan.lua

module("logicconfig.config.t_timed_challenge_god_long_yan", package.seeall)

local title = {
	challengeId = 1,
	oneKeyPassPrize = 10,
	timedBuffEndTime = 8,
	buffUpgradeItem = 5,
	buffPlan = 3,
	monsterPlan = 2,
	gamePlanId = 4,
	consume = 11,
	goodsId = 9,
	timedBuffStartTime = 7,
	buffResetCost = 6
}
local dataList = {
	{
		38,
		1,
		1,
		1,
		"8:29:1",
		"105:202:50",
		"2022-04-29T05:00:00",
		"2022-06-03T05:00:00",
		"rmb_25",
		"4:126:10",
		"8:29:1"
	}
}
local t_timed_challenge_god_long_yan = {
	[38] = dataList[1]
}

t_timed_challenge_god_long_yan.dataList = dataList

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

return t_timed_challenge_god_long_yan
