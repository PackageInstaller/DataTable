-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_protomer_prototype.lua

module("logic.config.t_house_protomer_prototype", package.seeall)

local title = {
	id = 1,
	name = 2,
	icon = 3
}
local dataList = {
	{
		1,
		"电子干涉",
		"room_holding_prototype_type_1"
	},
	{
		2,
		"物理干涉",
		"room_holding_prototype_type_2"
	},
	{
		3,
		"灵感操作",
		"room_holding_prototype_type_2"
	},
	{
		4,
		"法则掌控",
		"room_holding_prototype_type_2"
	},
	{
		5,
		"心智影响",
		"room_holding_prototype_type_1"
	},
	{
		6,
		"特殊",
		"room_holding_prototype_type_1"
	}
}
local t_house_protomer_prototype = {}

t_house_protomer_prototype.dataList = dataList

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
	t_house_protomer_prototype[v[1]] = v

	setmetatable(v, mt)
end

return t_house_protomer_prototype
