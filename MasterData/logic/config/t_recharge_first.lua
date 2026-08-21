-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_recharge_first.lua

module("logic.config.t_recharge_first", package.seeall)

local title = {
	reward = 3,
	id = 1,
	money = 2,
	jumpId = 6,
	showBtn = 4,
	showDay = 5,
	dungeonId = 7
}
local dataList = {
	{
		1,
		600,
		2600001,
		1,
		30,
		10801002,
		0
	}
}
local t_recharge_first = {}

t_recharge_first.dataList = dataList

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
	t_recharge_first[v[1]] = v

	setmetatable(v, mt)
end

return t_recharge_first
