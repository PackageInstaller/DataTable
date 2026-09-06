-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_best_dragon_soul_params.lua

module("logicconfig.config.t_best_dragon_soul_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"PASS_GAME_SCORE",
		"0"
	},
	{
		"MAX_SCORE_PER_GAME",
		"150"
	}
}
local t_best_dragon_soul_params = {
	PASS_GAME_SCORE = dataList[1],
	MAX_SCORE_PER_GAME = dataList[2]
}

t_best_dragon_soul_params.dataList = dataList

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

return t_best_dragon_soul_params
