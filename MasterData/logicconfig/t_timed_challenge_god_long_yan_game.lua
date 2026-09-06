-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_god_long_yan_game.lua

module("logicconfig.config.t_timed_challenge_god_long_yan_game", package.seeall)

local title = {
	gameName = 2,
	enterAnimPath = 4,
	gamePlanId = 1,
	stageTimeArray = 6,
	bigBgPath = 5,
	rulesKey = 3
}
local dataList = {
	{
		1,
		"拾取碎片",
		"moyanjiehua_rules",
		"storyconfig/animations/story_shenqiyouxi.txt",
		"catchprops/bg_myjgh_01",
		{
			45,
			45,
			45
		}
	}
}
local t_timed_challenge_god_long_yan_game = {
	dataList[1]
}

t_timed_challenge_god_long_yan_game.dataList = dataList

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

return t_timed_challenge_god_long_yan_game
