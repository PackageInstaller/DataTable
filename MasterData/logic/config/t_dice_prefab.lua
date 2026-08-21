-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dice_prefab.lua

module("logic.config.t_dice_prefab", package.seeall)

local title = {
	id = 1,
	itemId = 2
}
local dataList = {
	{
		2001,
		2501001
	},
	{
		2002,
		2501002
	},
	{
		2003,
		2501003
	},
	{
		2004,
		2501001
	},
	{
		2005,
		2501001
	},
	{
		2006,
		2501001
	},
	{
		2007,
		2501002
	},
	{
		2008,
		2501003
	},
	{
		2009,
		2501001
	},
	{
		2010,
		2501001
	},
	{
		2011,
		2501002
	},
	{
		2012,
		2501002
	},
	{
		2013,
		2501003
	},
	{
		2014,
		2501003
	}
}
local t_dice_prefab = {}

t_dice_prefab.dataList = dataList

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
	t_dice_prefab[v[1]] = v

	setmetatable(v, mt)
end

return t_dice_prefab
