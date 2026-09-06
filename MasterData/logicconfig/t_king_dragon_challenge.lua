-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_dragon_challenge.lua

module("logicconfig.config.t_king_dragon_challenge", package.seeall)

local title = {
	challengeId = 1,
	openTime3 = 6,
	openTime1 = 4,
	loginTaskPlanId = 7,
	openTime2 = 5,
	loginTaskRedpointId = 8,
	planId = 2,
	ruleKey = 3
}
local dataList = {
	{
		48,
		1,
		"KingofTheDragon_rule",
		"2022-08-12T05:00:00",
		"2022-08-12T05:00:00",
		"2022-08-12T05:00:00",
		0,
		0
	},
	{
		56,
		2,
		"zhuzainuoya_rule",
		"2022-11-25T05:00:00",
		"2022-11-25T05:00:00",
		"2022-11-25T05:00:00",
		2,
		408
	}
}
local t_king_dragon_challenge = {
	[48] = dataList[1],
	[56] = dataList[2]
}

t_king_dragon_challenge.dataList = dataList

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

return t_king_dragon_challenge
