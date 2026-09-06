-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_god_long_yan_params.lua

module("logicconfig.config.t_timed_challenge_god_long_yan_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_GAME_TIMES",
		"3"
	},
	{
		"MAX_SCORE_PER_GAME",
		"150"
	},
	{
		"GAME_PRIZE",
		"8:29:1"
	}
}
local t_timed_challenge_god_long_yan_params = {
	DAILY_GAME_TIMES = dataList[1],
	MAX_SCORE_PER_GAME = dataList[2],
	GAME_PRIZE = dataList[3]
}

t_timed_challenge_god_long_yan_params.dataList = dataList

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

return t_timed_challenge_god_long_yan_params
