-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_respect_challenge_extreme.lua

module("logicconfig.config.t_dragon_respect_challenge_extreme", package.seeall)

local title = {
	stageId = 2,
	levelDescription = 5,
	skinId = 3,
	creepsMasterId = 4,
	extremeChallengePlanId = 1,
	passPrize = 6
}
local dataList = {
	{
		1,
		1,
		16009,
		14112,
		"击败敌阵即可通关",
		""
	},
	{
		1,
		2,
		13004,
		14122,
		"击败敌阵即可通关",
		""
	},
	{
		1,
		3,
		10181,
		14132,
		"击败敌阵即可通关",
		""
	},
	{
		1,
		4,
		14008,
		14142,
		"击败敌阵即可通关",
		""
	},
	{
		1,
		5,
		17002,
		14152,
		"满足伤害区间即可通关",
		"100:17002:1:1"
	}
}
local t_dragon_respect_challenge_extreme = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_dragon_respect_challenge_extreme.dataList = dataList

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

return t_dragon_respect_challenge_extreme
