-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_sign_in_history_reward.lua

module("logic.config.t_sign_in_history_reward", package.seeall)

local title = {
	id = 1,
	importentRewards = 3,
	rewards = 2
}
local dataList = {
	{
		20001,
		{
			{
				num = 100,
				code = 1100002
			},
			{
				num = 10,
				code = 1001001
			},
			{
				num = 1,
				code = 2810005
			},
			{
				num = 30,
				code = 1003003
			},
			{
				num = 1,
				code = 2601014
			},
			{
				num = 60,
				code = 1008001
			},
			{
				num = 1,
				code = 2810004
			}
		},
		{
			2,
			5,
			7
		}
	}
}
local t_sign_in_history_reward = {}

t_sign_in_history_reward.dataList = dataList

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
	t_sign_in_history_reward[v[1]] = v

	setmetatable(v, mt)
end

return t_sign_in_history_reward
