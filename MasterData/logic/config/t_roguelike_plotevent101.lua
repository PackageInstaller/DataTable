-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_plotevent101.lua

module("logic.config.t_roguelike_plotevent101", package.seeall)

local title = {
	scene = 5,
	prestory = 6,
	poststory = 7,
	type = 3,
	id = 2,
	touches = 8,
	scriptId = 1,
	layer = 4
}
local dataList = {
	{
		101,
		1000101,
		1,
		0,
		0,
		"5010107",
		"5010201",
		{
			1,
			2,
			3
		}
	},
	{
		101,
		1010301,
		1,
		0,
		0,
		"",
		"",
		{
			4,
			5,
			6,
			7,
			8
		}
	},
	{
		101,
		1010302,
		1,
		0,
		0,
		"",
		"",
		{
			9,
			10,
			11,
			12
		}
	},
	{
		101,
		1010303,
		1,
		0,
		0,
		"",
		"",
		{
			13,
			14,
			15
		}
	},
	{
		101,
		1010304,
		1,
		0,
		0,
		"",
		"",
		{
			16,
			17,
			18,
			19,
			20
		}
	}
}
local t_roguelike_plotevent101 = {}

t_roguelike_plotevent101.dataList = dataList

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
	local parent1 = t_roguelike_plotevent101[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_roguelike_plotevent101[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_roguelike_plotevent101
