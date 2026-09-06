-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_heart_of_ao_jiu_clg_activity.lua

module("logicconfig.config.t_heart_of_ao_jiu_clg_activity", package.seeall)

local title = {
	jumpStrOne = 6,
	skinId = 5,
	dailyRankPrize = 3,
	jumpStrThree = 8,
	jumpRedIdThree = 12,
	jumpRank = 14,
	jumpStrTwo = 7,
	jumpRedIdTwo = 11,
	jumpRedIdFour = 13,
	jumpRedIdOne = 10,
	challengeClosedTimeRange = 2,
	jumpStrFour = 9,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		505001,
		"00:00:00-09:00:00",
		"4:425:1",
		"aojiuzhixin_rule_main",
		16010,
		"mibao#Skin",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"ui#heartofaojiureprankextview#505001#389002"
	}
}
local t_heart_of_ao_jiu_clg_activity = {
	[505001] = dataList[1]
}

t_heart_of_ao_jiu_clg_activity.dataList = dataList

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

return t_heart_of_ao_jiu_clg_activity
