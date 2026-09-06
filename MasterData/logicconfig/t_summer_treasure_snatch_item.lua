-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_treasure_snatch_item.lua

module("logicconfig.config.t_summer_treasure_snatch_item", package.seeall)

local title = {
	itemId = 2,
	itemType = 3,
	cost = 6,
	matStr = 7,
	weeklyBuyTimesLimit = 5,
	itemParam = 4,
	activityId = 1
}
local dataList = {
	{
		623001,
		1,
		3,
		8,
		0,
		0,
		""
	},
	{
		623001,
		2,
		3,
		9,
		0,
		0,
		""
	},
	{
		623001,
		3,
		3,
		10,
		0,
		0,
		""
	},
	{
		623001,
		4,
		3,
		11,
		0,
		0,
		""
	},
	{
		623001,
		5,
		3,
		12,
		0,
		0,
		""
	},
	{
		623001,
		6,
		3,
		13,
		0,
		0,
		""
	},
	{
		623001,
		7,
		1,
		1,
		99,
		10,
		"1004:1745"
	},
	{
		623001,
		8,
		2,
		1,
		0,
		15,
		"1004:1818"
	},
	{
		623001,
		9,
		2,
		2,
		0,
		15,
		"1004:1819"
	},
	{
		623001,
		10,
		2,
		3,
		0,
		15,
		"1004:1820"
	},
	{
		623001,
		11,
		2,
		4,
		0,
		15,
		"1004:1821"
	},
	{
		623001,
		12,
		3,
		7,
		0,
		20,
		""
	},
	{
		623001,
		13,
		3,
		1,
		0,
		20,
		""
	},
	{
		623001,
		14,
		3,
		2,
		0,
		20,
		""
	},
	{
		623001,
		15,
		3,
		3,
		0,
		20,
		""
	},
	{
		623001,
		16,
		3,
		4,
		0,
		20,
		""
	},
	{
		623001,
		17,
		3,
		5,
		0,
		20,
		""
	},
	{
		623001,
		18,
		3,
		6,
		0,
		20,
		""
	},
	{
		623001,
		19,
		3,
		14,
		0,
		20,
		""
	},
	{
		623001,
		20,
		3,
		15,
		0,
		20,
		""
	},
	{
		623001,
		21,
		3,
		16,
		0,
		20,
		""
	},
	{
		623001,
		22,
		3,
		17,
		0,
		20,
		""
	},
	{
		623001,
		23,
		3,
		18,
		0,
		20,
		""
	},
	{
		623001,
		24,
		3,
		19,
		0,
		20,
		""
	}
}
local t_summer_treasure_snatch_item = {
	[623001] = {
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
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_summer_treasure_snatch_item.dataList = dataList

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

return t_summer_treasure_snatch_item
