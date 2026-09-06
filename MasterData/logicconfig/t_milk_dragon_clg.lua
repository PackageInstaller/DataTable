-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_milk_dragon_clg.lua

module("logicconfig.config.t_milk_dragon_clg", package.seeall)

local title = {
	skinId = 5,
	jumpStrOne = 6,
	dailySignInGainScore = 2,
	jumpStrThree = 8,
	maxSignInDays = 3,
	ruleKeyChallenge = 10,
	jumpStrTwo = 7,
	scoreIcon = 4,
	ruleKeyMain = 9,
	activityId = 1,
	ruleKeyEvolve = 11
}
local dataList = {
	{
		451001,
		4,
		8,
		"1004:1434",
		14031,
		"func#1198",
		"mibao#ZhounianShop2",
		"func#618#14031",
		"nailongevolvemainview_rule",
		"nailongevolvemainview_rule",
		"nailongevolvemainview_rule"
	}
}
local t_milk_dragon_clg = {
	[451001] = dataList[1]
}

t_milk_dragon_clg.dataList = dataList

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

return t_milk_dragon_clg
