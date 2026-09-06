-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_play_music_plan.lua

module("logicconfig.config.t_play_music_plan", package.seeall)

local title = {
	comboPlanId = 2,
	completeScore = 5,
	gamePlanId = 1,
	linePlanId = 3,
	rhythmPlanId = 4
}
local dataList = {
	{
		1,
		2,
		1,
		2,
		500
	},
	{
		2,
		2,
		2,
		2,
		500
	}
}
local t_play_music_plan = {
	dataList[1],
	dataList[2]
}

t_play_music_plan.dataList = dataList

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

return t_play_music_plan
