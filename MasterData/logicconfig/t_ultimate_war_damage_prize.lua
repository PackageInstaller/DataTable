-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_damage_prize.lua

module("logicconfig.config.t_ultimate_war_damage_prize", package.seeall)

local title = {
	prizeId = 2,
	damage = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		434001,
		1,
		100000,
		"10:434001:20"
	},
	{
		434001,
		2,
		1000000,
		"10:434001:40"
	},
	{
		434001,
		3,
		10000000,
		"10:434001:60"
	},
	{
		434001,
		4,
		30000000,
		"10:434001:80"
	},
	{
		434001,
		5,
		50000000,
		"10:434001:120"
	},
	{
		434001,
		6,
		100000000,
		"10:434001:200"
	}
}
local t_ultimate_war_damage_prize = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_ultimate_war_damage_prize.dataList = dataList

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

return t_ultimate_war_damage_prize
