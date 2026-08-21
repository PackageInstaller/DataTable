-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_hero_filter_const.lua

module("logic.config.t_hero_filter_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"DepotTagList",
		0,
		0,
		"",
		{
			1004,
			1008,
			1009,
			1010,
			1011,
			1012,
			1013,
			2001,
			2002,
			2003,
			2004,
			2005,
			2006,
			2007,
			2008
		}
	}
}
local t_hero_filter_const = {}

t_hero_filter_const.dataList = dataList

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
	t_hero_filter_const[v[1]] = v

	setmetatable(v, mt)
end

return t_hero_filter_const
