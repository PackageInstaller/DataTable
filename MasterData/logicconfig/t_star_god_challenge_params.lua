-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_challenge_params.lua

module("logicconfig.config.t_star_god_challenge_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SINGLE_GAME_TIMES",
		"2"
	},
	{
		"GROUP_GAME_TIMES",
		"2"
	},
	{
		"GROUP_COUNT_DOWN",
		"10"
	},
	{
		"HELP_PRIZE_TIMES",
		"99999"
	},
	{
		"GROUP_FORM_CONDITION",
		"0"
	},
	{
		"TODAY_GAME_TIMES",
		"4"
	}
}
local t_star_god_challenge_params = {
	SINGLE_GAME_TIMES = dataList[1],
	GROUP_GAME_TIMES = dataList[2],
	GROUP_COUNT_DOWN = dataList[3],
	HELP_PRIZE_TIMES = dataList[4],
	GROUP_FORM_CONDITION = dataList[5],
	TODAY_GAME_TIMES = dataList[6]
}

t_star_god_challenge_params.dataList = dataList

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

return t_star_god_challenge_params
