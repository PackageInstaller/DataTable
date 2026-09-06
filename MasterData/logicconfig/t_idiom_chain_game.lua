-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_idiom_chain_game.lua

module("logicconfig.config.t_idiom_chain_game", package.seeall)

local title = {
	gamePlanId = 1,
	wordCount = 2
}
local dataList = {
	{
		1,
		10
	},
	{
		2,
		18
	}
}
local t_idiom_chain_game = {
	dataList[1],
	dataList[2]
}

t_idiom_chain_game.dataList = dataList

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

return t_idiom_chain_game
