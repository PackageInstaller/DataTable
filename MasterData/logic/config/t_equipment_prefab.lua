-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_equipment_prefab.lua

module("logic.config.t_equipment_prefab", package.seeall)

local title = {
	itemId = 2,
	id = 1,
	level = 3
}
local dataList = {
	{
		1001,
		1250011,
		40
	},
	{
		1002,
		1250011,
		40
	},
	{
		1003,
		1250011,
		30
	},
	{
		1004,
		1250011,
		1
	},
	{
		1005,
		1240021,
		1
	},
	{
		1006,
		1240022,
		1
	},
	{
		1007,
		1240023,
		1
	},
	{
		1008,
		1230101,
		1
	},
	{
		1009,
		1230102,
		1
	},
	{
		1010,
		1230103,
		1
	},
	{
		1011,
		1240101,
		1
	},
	{
		1012,
		1240102,
		1
	},
	{
		1013,
		1240103,
		1
	},
	{
		1014,
		1250071,
		1
	},
	{
		1015,
		1230011,
		1
	},
	{
		1016,
		1230012,
		1
	},
	{
		1017,
		1230013,
		1
	},
	{
		1018,
		1240011,
		1
	},
	{
		1019,
		1240012,
		1
	},
	{
		1020,
		1240013,
		1
	},
	{
		1021,
		1230021,
		1
	},
	{
		1022,
		1230022,
		1
	},
	{
		1023,
		1230023,
		1
	},
	{
		1024,
		1240021,
		1
	},
	{
		1025,
		1240022,
		1
	},
	{
		1026,
		1240023,
		1
	},
	{
		1027,
		1230041,
		1
	},
	{
		1028,
		1230042,
		1
	},
	{
		1029,
		1230043,
		1
	},
	{
		1030,
		1240041,
		1
	},
	{
		1031,
		1240042,
		1
	},
	{
		1032,
		1240043,
		1
	}
}
local t_equipment_prefab = {}

t_equipment_prefab.dataList = dataList

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
	t_equipment_prefab[v[1]] = v

	setmetatable(v, mt)
end

return t_equipment_prefab
