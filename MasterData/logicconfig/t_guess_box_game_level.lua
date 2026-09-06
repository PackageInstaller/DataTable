-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_box_game_level.lua

module("logicconfig.config.t_guess_box_game_level", package.seeall)

local title = {
	levelId = 2,
	levelPlanId = 1,
	type = 4,
	boxPlanId = 3,
	canGuessTimes = 5
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		2
	},
	{
		1,
		2,
		2,
		2,
		3
	},
	{
		2,
		1,
		3,
		1,
		1
	}
}
local t_guess_box_game_level = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3]
	}
}

t_guess_box_game_level.dataList = dataList

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

return t_guess_box_game_level
