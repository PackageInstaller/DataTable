-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_farm_zone.lua

module("logicconfig.config.t_eternal_farm_zone", package.seeall)

local title = {
	activityId = 1,
	name = 4,
	zoneId = 2,
	showYardId = 6,
	condition = 5,
	indexNum = 3
}
local dataList = {
	{
		296001,
		1,
		8,
		"菜园",
		"",
		1
	},
	{
		296001,
		2,
		8,
		"果园",
		"",
		1
	},
	{
		296001,
		3,
		3,
		"禽场",
		"",
		1
	},
	{
		296002,
		1,
		3,
		"富强蝴蝶",
		"",
		1
	},
	{
		296002,
		2,
		3,
		"友善蝴蝶",
		"1:12",
		1
	},
	{
		296002,
		3,
		3,
		"安康蝴蝶",
		"2:9",
		1
	},
	{
		296003,
		1,
		8,
		"菜园",
		"",
		1
	},
	{
		296003,
		2,
		8,
		"果园",
		"",
		1
	},
	{
		296003,
		3,
		3,
		"禽场",
		"",
		1
	},
	{
		296004,
		1,
		8,
		"菜园",
		"",
		1
	},
	{
		296004,
		2,
		8,
		"果园",
		"",
		1
	},
	{
		296004,
		3,
		3,
		"禽场",
		"",
		1
	},
	{
		296005,
		1,
		8,
		"菜园",
		"",
		1
	},
	{
		296005,
		2,
		8,
		"果园",
		"",
		1
	},
	{
		296005,
		3,
		3,
		"禽场",
		"",
		1
	},
	{
		296006,
		1,
		8,
		"菜园",
		"",
		1
	},
	{
		296006,
		2,
		6,
		"苹果园",
		"",
		1
	},
	{
		296006,
		3,
		3,
		"禽场",
		"",
		1
	},
	{
		296006,
		4,
		6,
		"梨场",
		"",
		1
	},
	{
		296007,
		1,
		8,
		"菜园",
		"",
		1
	},
	{
		296007,
		2,
		6,
		"苹果园",
		"",
		1
	},
	{
		296007,
		3,
		3,
		"禽场",
		"",
		1
	},
	{
		296007,
		4,
		6,
		"梨场",
		"",
		1
	},
	{
		296007,
		5,
		6,
		"鱼塘",
		"",
		2
	},
	{
		296007,
		6,
		6,
		"牛棚",
		"",
		2
	},
	{
		296008,
		1,
		8,
		"菜园",
		"",
		1
	},
	{
		296008,
		2,
		6,
		"苹果园",
		"",
		1
	},
	{
		296008,
		3,
		3,
		"禽场",
		"",
		1
	},
	{
		296008,
		4,
		6,
		"梨场",
		"",
		1
	},
	{
		296008,
		5,
		6,
		"鱼塘",
		"",
		2
	},
	{
		296008,
		6,
		6,
		"牛棚",
		"",
		2
	}
}
local t_eternal_farm_zone = {
	[296001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[296002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[296003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[296004] = {
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[296005] = {
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[296006] = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19]
	},
	[296007] = {
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	},
	[296008] = {
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31]
	}
}

t_eternal_farm_zone.dataList = dataList

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

return t_eternal_farm_zone
