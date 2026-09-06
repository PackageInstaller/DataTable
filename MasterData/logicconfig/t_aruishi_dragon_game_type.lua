-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aruishi_dragon_game_type.lua

module("logicconfig.config.t_aruishi_dragon_game_type", package.seeall)

local title = {
	stagePlanId = 3,
	gridPlanId = 4,
	activityId = 1,
	type = 2
}
local dataList = {
	{
		366001,
		1,
		1,
		1
	},
	{
		366001,
		2,
		2,
		2
	},
	{
		366001,
		3,
		3,
		3
	}
}
local t_aruishi_dragon_game_type = {
	[366001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_aruishi_dragon_game_type.dataList = dataList

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

return t_aruishi_dragon_game_type
