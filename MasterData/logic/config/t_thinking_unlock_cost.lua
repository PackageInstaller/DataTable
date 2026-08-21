-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_thinking_unlock_cost.lua

module("logic.config.t_thinking_unlock_cost", package.seeall)

local title = {
	cost = 2,
	num = 1
}
local dataList = {
	{
		0,
		{
			{
				id = 1005101,
				num = 1
			},
			{
				id = 1100003,
				num = 1000
			}
		}
	},
	{
		1,
		{
			{
				id = 1005101,
				num = 2
			},
			{
				id = 1100003,
				num = 2000
			}
		}
	},
	{
		2,
		{
			{
				id = 1005101,
				num = 3
			},
			{
				id = 1100003,
				num = 3000
			}
		}
	}
}
local t_thinking_unlock_cost = {}

t_thinking_unlock_cost.dataList = dataList

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
	t_thinking_unlock_cost[v[1]] = v

	setmetatable(v, mt)
end

return t_thinking_unlock_cost
