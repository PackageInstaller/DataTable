-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_crystal_unlock_cost.lua

module("logicconfig.config.t_power_crystal_unlock_cost", package.seeall)

local title = {
	secondCostNum = 3,
	slotId = 1,
	mainCostNum = 2
}
local dataList = {
	{
		1,
		50,
		5
	},
	{
		2,
		60,
		5
	},
	{
		3,
		80,
		1
	},
	{
		4,
		100,
		1
	},
	{
		5,
		120,
		1
	},
	{
		6,
		150,
		1
	},
	{
		7,
		210,
		1
	},
	{
		8,
		280,
		1
	},
	{
		9,
		350,
		1
	},
	{
		10,
		450,
		1
	},
	{
		11,
		600,
		1
	},
	{
		12,
		800,
		1
	}
}
local t_power_crystal_unlock_cost = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12]
}

t_power_crystal_unlock_cost.dataList = dataList

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

return t_power_crystal_unlock_cost
