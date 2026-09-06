-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_clear_star_game_score_plan.lua

module("logicconfig.config.t_clear_star_game_score_plan", package.seeall)

local title = {
	sortId = 2,
	popNum = 3,
	planId = 1,
	scoreRate = 4
}
local dataList = {
	{
		1,
		1,
		5,
		1
	},
	{
		1,
		2,
		10,
		2
	},
	{
		1,
		3,
		15,
		3
	}
}
local t_clear_star_game_score_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_clear_star_game_score_plan.dataList = dataList

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

return t_clear_star_game_score_plan
