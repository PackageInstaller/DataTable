-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_air_season_cup.lua

module("logic.config.t_item_air_season_cup", package.seeall)

local title = {
	quality = 6,
	priority = 8,
	name = 2,
	type = 4,
	desc = 9,
	cupGetWay = 10,
	repeatItem = 7,
	subType = 5,
	isShowBag = 11,
	id = 1,
	icon = 3
}
local dataList = {
	{
		3300001,
		"第一赛季",
		"3400001",
		33,
		1,
		4,
		"{1100003:100}",
		97,
		"第一赛季文案",
		"第一赛季获取描述",
		0
	},
	{
		3300002,
		"第二赛季",
		"3400002",
		33,
		1,
		4,
		"{1100003:100}",
		98,
		"第二赛季文案",
		"第二赛季获取描述",
		0
	},
	{
		3300003,
		"勇士杯",
		"3400003",
		33,
		1,
		4,
		"{1100003:100}",
		99,
		"勇士杯文案",
		"勇士杯获取描述",
		0
	}
}
local t_item_air_season_cup = {}

t_item_air_season_cup.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_item_air_season_cup[v[1]] = v

	setmetatable(v, mt)
end

return t_item_air_season_cup
