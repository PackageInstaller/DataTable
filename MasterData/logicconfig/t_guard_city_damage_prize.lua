-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_city_damage_prize.lua

module("logicconfig.config.t_guard_city_damage_prize", package.seeall)

local title = {
	prizeId = 2,
	damagePrizePlanId = 1,
	damage = 3,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		10000,
		"4:30005:2"
	},
	{
		1,
		2,
		200000,
		"4:30005:3"
	},
	{
		1,
		3,
		500000,
		"4:30005:4"
	},
	{
		2,
		1,
		10000,
		"8:1:10000"
	},
	{
		2,
		2,
		200000,
		"8:1:15000"
	},
	{
		2,
		3,
		500000,
		"8:1:20000"
	}
}
local t_guard_city_damage_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_guard_city_damage_prize.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_guard_city_damage_prize
