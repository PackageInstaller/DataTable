-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_lottery_item.lua

module("logicconfig.config.t_god_lottery_item", package.seeall)

local title = {
	id = 2,
	weight = 4,
	item = 3,
	poolId = 1
}
local dataList = {
	{
		1,
		1,
		"8:1:10000",
		100
	},
	{
		1,
		2,
		"8:1:10001",
		100
	},
	{
		1,
		3,
		"8:1:10002",
		100
	},
	{
		1,
		4,
		"8:1:10003",
		100
	},
	{
		1,
		5,
		"8:1:10004",
		100
	},
	{
		1,
		6,
		"8:1:10005",
		100
	},
	{
		1,
		7,
		"8:1:10006",
		100
	},
	{
		1,
		8,
		"8:1:10007",
		100
	},
	{
		1,
		9,
		"8:1:10008",
		100
	},
	{
		1,
		10,
		"8:1:10009",
		100
	},
	{
		2,
		1,
		"8:1:10000",
		100
	},
	{
		2,
		2,
		"8:1:10001",
		100
	},
	{
		2,
		3,
		"8:1:10002",
		100
	},
	{
		2,
		4,
		"8:1:10003",
		100
	},
	{
		2,
		5,
		"8:1:10004",
		100
	},
	{
		2,
		6,
		"8:1:10005",
		100
	},
	{
		2,
		7,
		"8:1:10006",
		100
	},
	{
		2,
		8,
		"8:1:10007",
		100
	},
	{
		2,
		9,
		"8:1:10008",
		100
	},
	{
		2,
		10,
		"8:1:10009",
		100
	}
}
local t_god_lottery_item = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
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
}

t_god_lottery_item.dataList = dataList

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

return t_god_lottery_item
