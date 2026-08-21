-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_map_dice.lua

module("logic.config.t_roguelike_map_dice", package.seeall)

local title = {
	map1 = 2,
	map5 = 6,
	map2 = 3,
	map6 = 7,
	id = 1,
	map4 = 5,
	weight = 8,
	map3 = 4
}
local dataList = {
	{
		1,
		1,
		2,
		3,
		4,
		5,
		6,
		0
	},
	{
		2,
		4,
		5,
		6,
		7,
		8,
		9,
		0
	},
	{
		3,
		1,
		2,
		3,
		7,
		8,
		9,
		0
	}
}
local t_roguelike_map_dice = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_roguelike_map_dice.dataList = dataList

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
	setmetatable(v, mt)
end

return t_roguelike_map_dice
