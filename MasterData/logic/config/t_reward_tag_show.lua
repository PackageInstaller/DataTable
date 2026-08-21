-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_reward_tag_show.lua

module("logic.config.t_reward_tag_show", package.seeall)

local title = {
	sort = 2,
	programNum = 1
}
local dataList = {
	{
		0,
		1
	},
	{
		1,
		1
	},
	{
		2,
		10
	},
	{
		3,
		99
	},
	{
		4,
		12
	},
	{
		5,
		13
	},
	{
		6,
		14
	},
	{
		7,
		15
	},
	{
		8,
		16
	},
	{
		9,
		11
	},
	{
		10,
		10
	},
	{
		11,
		10
	},
	{
		12,
		10
	},
	{
		13,
		15
	},
	{
		14,
		15
	}
}
local t_reward_tag_show = {}

t_reward_tag_show.dataList = dataList

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
	t_reward_tag_show[v[1]] = v

	setmetatable(v, mt)
end

return t_reward_tag_show
