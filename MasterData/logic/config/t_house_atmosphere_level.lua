-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_atmosphere_level.lua

module("logic.config.t_house_atmosphere_level", package.seeall)

local title = {
	level = 2,
	rankNum = 3,
	type = 1
}
local dataList = {
	{
		2,
		1,
		0
	},
	{
		2,
		2,
		800
	},
	{
		2,
		3,
		1200
	},
	{
		2,
		4,
		2000
	},
	{
		2,
		5,
		3500
	},
	{
		3,
		1,
		0
	},
	{
		3,
		2,
		800
	},
	{
		3,
		3,
		1200
	},
	{
		3,
		4,
		2000
	},
	{
		3,
		5,
		3500
	},
	{
		4,
		1,
		0
	},
	{
		4,
		2,
		800
	},
	{
		4,
		3,
		1200
	},
	{
		4,
		4,
		2000
	},
	{
		4,
		5,
		3500
	},
	{
		5,
		1,
		0
	},
	{
		5,
		2,
		800
	},
	{
		5,
		3,
		1200
	},
	{
		5,
		4,
		2000
	},
	{
		5,
		5,
		3500
	},
	{
		6,
		1,
		0
	},
	{
		6,
		2,
		800
	},
	{
		6,
		3,
		1200
	},
	{
		6,
		4,
		2000
	},
	{
		6,
		5,
		3500
	}
}
local t_house_atmosphere_level = {}

t_house_atmosphere_level.dataList = dataList

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
	local parent1 = t_house_atmosphere_level[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_house_atmosphere_level[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_house_atmosphere_level
