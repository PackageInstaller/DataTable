-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_guess.lua

module("logicconfig.config.t_teen_champion_king_guess", package.seeall)

local title = {
	maxGuessScore = 2,
	failReturnRatio = 3,
	gussPlanId = 1,
	sucReturnRatio = 4
}
local dataList = {
	{
		1,
		5000,
		0.9,
		3
	}
}
local t_teen_champion_king_guess = {
	dataList[1]
}

t_teen_champion_king_guess.dataList = dataList

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

return t_teen_champion_king_guess
