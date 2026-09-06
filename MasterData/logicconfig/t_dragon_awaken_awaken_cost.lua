-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_awaken_awaken_cost.lua

module("logicconfig.config.t_dragon_awaken_awaken_cost", package.seeall)

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
		"10:419002:100"
	},
	{
		419001,
		2,
		"10:419002:200"
	},
	{
		419001,
		3,
		"10:419002:300"
	},
	{
		419001,
		4,
		"10:419002:400"
	},
	{
		419001,
		5,
		"10:419002:500"
	},
	{
		419001,
		6,
		"10:419002:600"
	},
	{
		419002,
		0,
		""
	},
	{
		419002,
		1,
		"10:419005:100"
	},
	{
		419002,
		2,
		"10:419005:200"
	},
	{
		419002,
		3,
		"10:419005:300"
	},
	{
		419002,
		4,
		"10:419005:400"
	},
	{
		419002,
		5,
		"10:419005:500"
	},
	{
		419002,
		6,
		"10:419005:600"
	}
}
local t_dragon_awaken_awaken_cost = {
	[419001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[419002] = {
		[0] = dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_dragon_awaken_awaken_cost.dataList = dataList

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

return t_dragon_awaken_awaken_cost
