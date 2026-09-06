-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_find_treasure_prize.lua

module("logicconfig.config.t_miracle_find_treasure_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	activityId = 1,
	timeLimit = 4
}
local dataList = {
	{
		379001,
		1,
		"4:510311:1",
		1
	},
	{
		379001,
		2,
		"4:90200:1",
		1
	},
	{
		379001,
		3,
		"4:111:5",
		1
	},
	{
		379001,
		4,
		"4:31:5",
		1
	},
	{
		379001,
		5,
		"104:2:333",
		1
	},
	{
		379001,
		6,
		"104:2:333",
		1
	},
	{
		379001,
		7,
		"8:1:1000000",
		1
	},
	{
		379001,
		8,
		"4:111:5",
		1
	},
	{
		379001,
		9,
		"4:31:5",
		1
	},
	{
		379001,
		10,
		"104:2:222",
		1
	}
}
local t_miracle_find_treasure_prize = {
	[379001] = {
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
	}
}

t_miracle_find_treasure_prize.dataList = dataList

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

return t_miracle_find_treasure_prize
