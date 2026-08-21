-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_plotevent999.lua

module("logic.config.t_roguelike_plotevent999", package.seeall)

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
		100,
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
	}
}
local t_roguelike_plotevent999 = {}

t_roguelike_plotevent999.dataList = dataList

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
	local parent1 = t_roguelike_plotevent999[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_roguelike_plotevent999[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_roguelike_plotevent999
