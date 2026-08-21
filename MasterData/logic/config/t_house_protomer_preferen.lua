-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_protomer_preferen.lua

module("logic.config.t_house_protomer_preferen", package.seeall)

local title = {
	id = 1,
	nameattr = 2,
	iconattr = 3
}
local dataList = {
	{
		1,
		"敏捷",
		"room_preference_02"
	},
	{
		2,
		"力量",
		"room_preference_02"
	},
	{
		3,
		"洞察",
		"room_preference_01"
	},
	{
		4,
		"知识",
		"room_preference_01"
	},
	{
		5,
		"沟通",
		"room_preference_02"
	},
	{
		6,
		"幸运",
		"room_preference_01"
	}
}
local t_house_protomer_preferen = {}

t_house_protomer_preferen.dataList = dataList

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
	t_house_protomer_preferen[v[1]] = v

	setmetatable(v, mt)
end

return t_house_protomer_preferen
