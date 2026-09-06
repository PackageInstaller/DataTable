-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fuyao_story_base.lua

module("logicconfig.config.t_fuyao_story_base", package.seeall)

local title = {
	jumpStrOne = 5,
	jumpRedIdThree = 10,
	jumpStrThree = 7,
	jumpStrTwo = 6,
	jumpRedIdTwo = 9,
	basePlanId = 1,
	jumpRedIdOne = 8,
	endTime = 3,
	ruleKeyMain = 4,
	startTime = 2
}
local dataList = {
	{
		1,
		"2025-07-25T05:00:00",
		"2025-08-22T05:00:00",
		"fuyao_story_rule",
		"ui#ultimatetrialrankfatherview",
		"ui#commongrouptaskmainview#472001",
		"func#191#472#472001",
		"",
		"474",
		""
	}
}
local t_fuyao_story_base = {
	dataList[1]
}

t_fuyao_story_base.dataList = dataList

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

return t_fuyao_story_base
