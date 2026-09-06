-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_respect_challenge_universal.lua

module("logicconfig.config.t_dragon_respect_challenge_universal", package.seeall)

local title = {
	challengeId = 2,
	scoreLimit = 4,
	challengeStagePlanId = 5,
	universalChallengePlanId = 1,
	challengeName = 3
}
local dataList = {
	{
		1,
		1,
		"无烬挑战",
		90,
		11
	},
	{
		1,
		2,
		"超神挑战",
		90,
		12
	},
	{
		1,
		3,
		"秩序挑战",
		90,
		13
	}
}
local t_dragon_respect_challenge_universal = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_dragon_respect_challenge_universal.dataList = dataList

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

return t_dragon_respect_challenge_universal
