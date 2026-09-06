-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_world_cup_top_guess.lua

module("logicconfig.config.t_world_cup_top_guess", package.seeall)

local title = {
	prize = 3,
	rightNum = 2,
	activityId = 1
}
local dataList = {
	{
		602001,
		1,
		"4:400004:10"
	},
	{
		602001,
		2,
		"4:400004:10"
	},
	{
		602001,
		3,
		"2:319:1"
	}
}
local t_world_cup_top_guess = {
	[602001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_world_cup_top_guess.dataList = dataList

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

return t_world_cup_top_guess
