-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_best_dragon_soul_game.lua

module("logicconfig.config.t_best_dragon_soul_game", package.seeall)

local title = {
	bigBgPath = 3,
	gameName = 2,
	gamePlanId = 1,
	stageTimeArray = 4
}
local dataList = {
	{
		1,
		"拾取碎片",
		"catchprops/bg_myjgh_01",
		{
			45,
			45,
			45
		}
	}
}
local t_best_dragon_soul_game = {
	dataList[1]
}

t_best_dragon_soul_game.dataList = dataList

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

return t_best_dragon_soul_game
