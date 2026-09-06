-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_snowman_car_game.lua

module("logicconfig.config.t_snowman_car_game", package.seeall)

local title = {
	waitingTime = 5,
	carDuration = 2,
	floatWordsDuration = 4,
	midCarDuration = 3,
	planId = 1
}
local dataList = {
	{
		1,
		0.1,
		0.5,
		1,
		0.05
	}
}
local t_snowman_car_game = {
	dataList[1]
}

t_snowman_car_game.dataList = dataList

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

return t_snowman_car_game
