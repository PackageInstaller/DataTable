-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_plus_exchange_random.lua

module("logicconfig.config.t_star_god_plus_exchange_random", package.seeall)

local title = {
	exchangePrize = 1
}
local dataList = {
	{
		"18:503:1"
	},
	{
		"18:504:1"
	},
	{
		"18:506:1"
	},
	{
		"18:507:1"
	},
	{
		"18:509:1"
	}
}
local t_star_god_plus_exchange_random = {
	["18:503:1"] = dataList[1],
	["18:504:1"] = dataList[2],
	["18:506:1"] = dataList[3],
	["18:507:1"] = dataList[4],
	["18:509:1"] = dataList[5]
}

t_star_god_plus_exchange_random.dataList = dataList

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

return t_star_god_plus_exchange_random
