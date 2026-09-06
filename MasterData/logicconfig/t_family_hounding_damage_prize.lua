-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_hounding_damage_prize.lua

module("logicconfig.config.t_family_hounding_damage_prize", package.seeall)

local title = {
	damageRange = 3,
	desc = 5,
	damagePrizePlanId = 1,
	prize = 4,
	prizeGearId = 2
}
local dataList = {
	{
		1,
		1,
		{
			10000,
			500000
		},
		"8:5:300#9:3001:5#8:27:30#8:41:600",
		"1万-50万伤害可获得奖励："
	},
	{
		1,
		2,
		{
			500000,
			1500000
		},
		"8:5:600#9:3001:5#8:27:60#8:41:800",
		"50万-150万伤害可获得奖励："
	},
	{
		1,
		3,
		{
			1500000,
			2000000000
		},
		"8:5:900#9:3001:5#8:27:90#8:41:1000",
		"150万以上伤害可获得奖励："
	}
}
local t_family_hounding_damage_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_family_hounding_damage_prize.dataList = dataList

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

return t_family_hounding_damage_prize
