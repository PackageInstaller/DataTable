-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_layer.lua

module("logic.config.t_roguelike_layer", package.seeall)

local title = {
	id = 1,
	mapIds = 3,
	layer = 2
}
local dataList = {
	{
		100,
		1,
		{
			100001
		}
	},
	{
		101,
		1,
		{
			101001
		}
	},
	{
		101,
		2,
		{
			101002
		}
	},
	{
		101,
		3,
		{
			101003
		}
	}
}
local t_roguelike_layer = {}

t_roguelike_layer.dataList = dataList

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
	local parent1 = t_roguelike_layer[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_roguelike_layer[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_roguelike_layer
