-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_level.lua

module("logic.config.t_air_studio_level", package.seeall)

local title = {
	lv = 1,
	exp = 2
}
local dataList = {
	{
		1,
		90
	},
	{
		2,
		180
	},
	{
		3,
		270
	},
	{
		4,
		360
	},
	{
		5,
		450
	},
	{
		6,
		540
	},
	{
		7,
		630
	},
	{
		8,
		720
	},
	{
		9,
		810
	},
	{
		10,
		900
	},
	{
		11,
		990
	},
	{
		12,
		1080
	},
	{
		13,
		1170
	},
	{
		14,
		1260
	},
	{
		15,
		1350
	},
	{
		16,
		1440
	},
	{
		17,
		1530
	},
	{
		18,
		1620
	},
	{
		19,
		1710
	},
	{
		20,
		1800
	},
	{
		21,
		1890
	}
}
local t_air_studio_level = {}

t_air_studio_level.dataList = dataList

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
	t_air_studio_level[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_level
