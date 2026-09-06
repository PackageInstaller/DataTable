-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_plus_exchange.lua

module("logicconfig.config.t_star_god_plus_exchange", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"COST_NUM",
		"4"
	},
	{
		"COST_QUALITY",
		"4"
	},
	{
		"CD",
		"30"
	},
	{
		"TIMES",
		"1"
	}
}
local t_star_god_plus_exchange = {
	COST_NUM = dataList[1],
	COST_QUALITY = dataList[2],
	CD = dataList[3],
	TIMES = dataList[4]
}

t_star_god_plus_exchange.dataList = dataList

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

return t_star_god_plus_exchange
