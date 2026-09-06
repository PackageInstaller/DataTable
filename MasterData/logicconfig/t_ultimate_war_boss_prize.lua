-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_boss_prize.lua

module("logicconfig.config.t_ultimate_war_boss_prize", package.seeall)

local title = {
	prizeId = 2,
	beatBossCount = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		434001,
		1,
		1,
		"10:434001:500"
	},
	{
		434001,
		2,
		2,
		"10:434001:500"
	},
	{
		434001,
		3,
		3,
		"10:434001:500"
	},
	{
		434001,
		4,
		4,
		"10:434001:500"
	},
	{
		434001,
		5,
		5,
		"10:434001:500"
	}
}
local t_ultimate_war_boss_prize = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_ultimate_war_boss_prize.dataList = dataList

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

return t_ultimate_war_boss_prize
