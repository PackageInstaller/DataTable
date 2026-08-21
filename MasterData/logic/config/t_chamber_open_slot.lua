-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_chamber_open_slot.lua

module("logic.config.t_chamber_open_slot", package.seeall)

local title = {
	id = 1,
	lv = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		1
	},
	{
		3,
		1
	},
	{
		4,
		1
	},
	{
		5,
		1
	},
	{
		6,
		1
	}
}
local t_chamber_open_slot = {}

t_chamber_open_slot.dataList = dataList

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
	t_chamber_open_slot[v[1]] = v

	setmetatable(v, mt)
end

return t_chamber_open_slot
