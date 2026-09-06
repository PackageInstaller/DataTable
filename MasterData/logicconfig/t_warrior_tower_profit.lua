-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_warrior_tower_profit.lua

module("logicconfig.config.t_warrior_tower_profit", package.seeall)

local title = {
	cost = 2,
	buyId = 1
}
local dataList = {
	{
		1,
		"105:2:50"
	},
	{
		2,
		"105:2:50"
	},
	{
		3,
		"105:2:50"
	},
	{
		4,
		"105:2:50"
	},
	{
		5,
		"105:2:50"
	},
	{
		6,
		"105:2:100"
	},
	{
		7,
		"105:2:100"
	},
	{
		8,
		"105:2:100"
	},
	{
		9,
		"105:2:100"
	},
	{
		10,
		"105:2:100"
	},
	{
		11,
		"105:2:100"
	},
	{
		12,
		"105:2:100"
	},
	{
		13,
		"105:2:100"
	},
	{
		14,
		"105:2:100"
	},
	{
		15,
		"105:2:100"
	},
	{
		16,
		"105:2:100"
	},
	{
		17,
		"105:2:100"
	},
	{
		18,
		"105:2:100"
	},
	{
		19,
		"105:2:100"
	},
	{
		20,
		"105:2:100"
	}
}
local t_warrior_tower_profit = {
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
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20]
}

t_warrior_tower_profit.dataList = dataList

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

return t_warrior_tower_profit
