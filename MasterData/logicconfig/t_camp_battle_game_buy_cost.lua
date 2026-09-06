-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_game_buy_cost.lua

module("logicconfig.config.t_camp_battle_game_buy_cost", package.seeall)

local title = {
	cost = 3,
	gameBuyPlanId = 1,
	buyTimes = 2
}
local dataList = {
	{
		1,
		1,
		"105:2:100"
	},
	{
		1,
		2,
		"105:2:200"
	},
	{
		2,
		1,
		"105:2:100"
	},
	{
		2,
		2,
		"105:2:200"
	}
}
local t_camp_battle_game_buy_cost = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	}
}

t_camp_battle_game_buy_cost.dataList = dataList

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

return t_camp_battle_game_buy_cost
