-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_family_battle_damage_prize.lua

module("logicconfig.config.t_new_family_battle_damage_prize", package.seeall)

local title = {
	prizeId = 2,
	damagePrizePlan = 1,
	damage = 3,
	seasonScore = 4,
	showPrize = 5
}
local dataList = {
	{
		1,
		1,
		1,
		30,
		"8:5:200#8:27:100#104:2:50#4:10000046:30"
	},
	{
		1,
		2,
		1000000,
		60,
		"8:5:200#8:27:100#104:2:50#4:10000046:60"
	},
	{
		1,
		3,
		10000000,
		90,
		"8:5:200#8:27:100#104:2:50#4:10000046:90"
	},
	{
		1,
		4,
		50000000,
		120,
		"8:5:200#8:27:100#104:2:50#4:10000046:120"
	},
	{
		1,
		5,
		100000000,
		150,
		"8:5:200#8:27:100#104:2:50#4:10000046:150"
	}
}
local t_new_family_battle_damage_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_new_family_battle_damage_prize.dataList = dataList

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

return t_new_family_battle_damage_prize
