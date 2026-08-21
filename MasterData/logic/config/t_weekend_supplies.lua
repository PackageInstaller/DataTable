-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_weekend_supplies.lua

module("logic.config.t_weekend_supplies", package.seeall)

local title = {
	saturdayReward = 3,
	name = 2,
	mondayReward = 5,
	sundayReward = 4,
	code = 1,
	extraReward = 6
}
local dataList = {
	{
		110001,
		"test",
		2500101,
		2500102,
		2500103,
		2500104
	}
}
local t_weekend_supplies = {}

t_weekend_supplies.dataList = dataList

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
	t_weekend_supplies[v[1]] = v

	setmetatable(v, mt)
end

return t_weekend_supplies
