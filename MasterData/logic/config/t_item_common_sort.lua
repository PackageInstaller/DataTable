-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_common_sort.lua

module("logic.config.t_item_common_sort", package.seeall)

local title = {
	sortType = 1,
	sortList = 2
}
local dataList = {
	{
		1,
		{
			1100001,
			1100002,
			1100003,
			1100006,
			1100014
		}
	},
	{
		2,
		{
			20,
			28
		}
	},
	{
		3,
		{
			11,
			14,
			15,
			16,
			13,
			12,
			17,
			18,
			10
		}
	}
}
local t_item_common_sort = {}

t_item_common_sort.dataList = dataList

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
	t_item_common_sort[v[1]] = v

	setmetatable(v, mt)
end

return t_item_common_sort
