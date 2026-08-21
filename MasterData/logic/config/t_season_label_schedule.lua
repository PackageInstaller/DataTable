-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_season_label_schedule.lua

module("logic.config.t_season_label_schedule", package.seeall)

local title = {
	reward = 5,
	seasonId = 1,
	count = 4,
	id = 2,
	label = 3
}
local dataList = {
	{
		10000,
		1,
		100039,
		1,
		2015101
	},
	{
		10000,
		2,
		100039,
		2,
		2015102
	},
	{
		10000,
		3,
		100039,
		3,
		2015103
	},
	{
		10000,
		4,
		100039,
		4,
		2015104
	},
	{
		10000,
		5,
		100039,
		5,
		2015105
	},
	{
		10000,
		6,
		100032,
		1,
		2015111
	},
	{
		10000,
		7,
		100032,
		3,
		2015112
	},
	{
		10000,
		8,
		100032,
		5,
		2015113
	},
	{
		10000,
		9,
		100032,
		7,
		2015114
	},
	{
		10000,
		10,
		100032,
		9,
		2015115
	}
}
local t_season_label_schedule = {}

t_season_label_schedule.dataList = dataList

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
	local parent1 = t_season_label_schedule[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_season_label_schedule[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_season_label_schedule
