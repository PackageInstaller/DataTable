-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_holy_challenge_activity.lua

module("logicconfig.config.t_origin_holy_challenge_activity", package.seeall)

local title = {
	jumpToPrize = 5,
	jumpToRank = 4,
	jumpToPack = 7,
	jumpToShop = 6,
	raceId = 3,
	ruleKeyMain = 8,
	activityId = 1,
	prize = 2
}
local dataList = {
	{
		608001,
		"4:510829:100",
		14049,
		"func#618#14049",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"func#545#52",
		"originholychallenge_rule"
	}
}
local t_origin_holy_challenge_activity = {
	[608001] = dataList[1]
}

t_origin_holy_challenge_activity.dataList = dataList

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

return t_origin_holy_challenge_activity
