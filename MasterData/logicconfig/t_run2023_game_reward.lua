-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run2023_game_reward.lua

module("logicconfig.config.t_run2023_game_reward", package.seeall)

local title = {
	Id = 2,
	gameTime = 3,
	planId = 1,
	reward = 4
}
local dataList = {
	{
		1,
		1,
		40,
		"8:1:250000"
	},
	{
		1,
		2,
		50,
		"4:30005:3"
	},
	{
		1,
		3,
		60,
		"4:30005:5"
	}
}
local t_run2023_game_reward = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_run2023_game_reward.dataList = dataList

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

return t_run2023_game_reward
