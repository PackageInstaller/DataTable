-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fruit_ninja_game_plan.lua

module("logicconfig.config.t_fruit_ninja_game_plan", package.seeall)

local title = {
	comboPlanId = 4,
	healthCount = 7,
	gamePlanId = 1,
	defaultCriticalRate = 6,
	gameTime = 5,
	rhythmPlanId = 2,
	crazyRhythmPlanId = 3
}
local dataList = {
	{
		1,
		1,
		3,
		1,
		60,
		0.01,
		0
	},
	{
		2,
		2,
		3,
		1,
		-1,
		0.01,
		3
	}
}
local t_fruit_ninja_game_plan = {
	dataList[1],
	dataList[2]
}

t_fruit_ninja_game_plan.dataList = dataList

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

return t_fruit_ninja_game_plan
