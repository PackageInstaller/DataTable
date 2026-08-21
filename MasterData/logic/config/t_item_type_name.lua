-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_type_name.lua

module("logic.config.t_item_type_name", package.seeall)

local title = {
	name = 3,
	subType = 2,
	type = 1
}
local dataList = {
	{
		10,
		1,
		"珍贵资产"
	},
	{
		10,
		2,
		"消耗品"
	},
	{
		10,
		3,
		"守秘人升级"
	},
	{
		10,
		4,
		"养成材料"
	},
	{
		10,
		5,
		"养成材料"
	},
	{
		10,
		6,
		"强化材料"
	},
	{
		10,
		7,
		"养成材料"
	},
	{
		10,
		8,
		"礼盒"
	},
	{
		10,
		11,
		"消耗品"
	},
	{
		10,
		13,
		"珍贵资产"
	},
	{
		12,
		0,
		"携带物"
	},
	{
		13,
		0,
		"携带物"
	},
	{
		28,
		0,
		"礼盒"
	},
	{
		28,
		10,
		"礼盒"
	},
	{
		36,
		1,
		"合成材料"
	},
	{
		36,
		2,
		"合成材料"
	},
	{
		14,
		1,
		"养成材料"
	},
	{
		14,
		2,
		"合成材料"
	},
	{
		15,
		0,
		"装束"
	},
	{
		18,
		1,
		"梦境档案"
	},
	{
		22,
		1,
		"收藏品"
	},
	{
		22,
		2,
		"收藏品"
	},
	{
		23,
		1,
		"收藏品"
	}
}
local t_item_type_name = {}

t_item_type_name.dataList = dataList

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
	local parent1 = t_item_type_name[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_item_type_name[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_item_type_name
