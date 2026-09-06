-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_formation_buy_times_cost.lua

module("logicconfig.config.t_breach_formation_buy_times_cost", package.seeall)

local title = {
	consume = 2,
	times = 1
}
local dataList = {
	{
		1,
		"105:148:50"
	},
	{
		2,
		"105:148:50"
	},
	{
		3,
		"105:148:50"
	},
	{
		4,
		"105:148:50"
	},
	{
		5,
		"105:148:50"
	}
}
local t_breach_formation_buy_times_cost = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_breach_formation_buy_times_cost.dataList = dataList

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

return t_breach_formation_buy_times_cost
