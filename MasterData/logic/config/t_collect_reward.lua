-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_collect_reward.lua

module("logic.config.t_collect_reward", package.seeall)

local title = {
	reward = 3,
	describe = 4,
	count = 2,
	type = 1
}
local dataList = {
	{
		1,
		5,
		2015101,
		"收集%s个角色"
	},
	{
		1,
		10,
		2015101,
		"收集%s个角色"
	},
	{
		1,
		15,
		2015101,
		"收集%s个角色"
	},
	{
		1,
		20,
		2015101,
		"收集%s个角色"
	},
	{
		9,
		5,
		2015101,
		"收集%s个角色"
	},
	{
		9,
		10,
		2015101,
		"收集%s个角色"
	},
	{
		9,
		15,
		2015101,
		"收集%s个角色"
	},
	{
		9,
		20,
		2015101,
		"收集%s个角色"
	}
}
local t_collect_reward = {}

t_collect_reward.dataList = dataList

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
	local parent1 = t_collect_reward[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_collect_reward[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_collect_reward
