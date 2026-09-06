-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_crystal_param.lua

module("logicconfig.config.t_power_crystal_param", package.seeall)

local title = {
	paramValue = 2,
	paramKey = 1
}
local dataList = {
	{
		"clearCdPrice",
		"10"
	},
	{
		"cdInterval",
		"24"
	},
	{
		"mainCostItem",
		"4:401"
	},
	{
		"secondCostItem",
		"4:402"
	}
}
local t_power_crystal_param = {
	clearCdPrice = dataList[1],
	cdInterval = dataList[2],
	mainCostItem = dataList[3],
	secondCostItem = dataList[4]
}

t_power_crystal_param.dataList = dataList

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

return t_power_crystal_param
