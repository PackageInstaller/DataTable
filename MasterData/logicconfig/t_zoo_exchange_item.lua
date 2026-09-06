-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_exchange_item.lua

module("logicconfig.config.t_zoo_exchange_item", package.seeall)

local title = {
	id = 1,
	gain = 3,
	cost = 4,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"4:2:1",
		"8:1:1"
	},
	{
		2,
		1,
		"4:2:2",
		"8:1:2"
	},
	{
		3,
		1,
		"4:2:3",
		"8:1:3"
	},
	{
		4,
		2,
		"4:2:4",
		"8:1:4"
	},
	{
		5,
		2,
		"4:2:5",
		"8:1:5"
	},
	{
		6,
		2,
		"4:2:6",
		"8:1:6"
	},
	{
		7,
		3,
		"4:2:7",
		"8:1:7"
	},
	{
		8,
		3,
		"4:2:8",
		"8:1:8"
	},
	{
		9,
		3,
		"4:2:9",
		"8:1:9"
	},
	{
		10,
		3,
		"4:2:10",
		"8:1:10"
	}
}
local t_zoo_exchange_item = {
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

t_zoo_exchange_item.dataList = dataList

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

return t_zoo_exchange_item
