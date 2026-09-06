-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_awaken_equipment_cost.lua

module("logicconfig.config.t_dragon_awaken_equipment_cost", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		419001,
		0,
		""
	},
	{
		419001,
		1,
		"10:419002:500"
	},
	{
		419001,
		2,
		"10:419002:600"
	},
	{
		419001,
		3,
		"10:419002:700"
	},
	{
		419001,
		4,
		"10:419002:800"
	},
	{
		419001,
		5,
		"10:419002:900"
	},
	{
		419002,
		0,
		""
	},
	{
		419002,
		1,
		"10:419005:500"
	},
	{
		419002,
		2,
		"10:419005:600"
	},
	{
		419002,
		3,
		"10:419005:700"
	},
	{
		419002,
		4,
		"10:419005:800"
	},
	{
		419002,
		5,
		"10:419005:900"
	}
}
local t_dragon_awaken_equipment_cost = {
	[419001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[419002] = {
		[0] = dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_dragon_awaken_equipment_cost.dataList = dataList

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

return t_dragon_awaken_equipment_cost
