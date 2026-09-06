-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wisdom_courage_clg_boss_damage.lua

module("logicconfig.config.t_wisdom_courage_clg_boss_damage", package.seeall)

local title = {
	prizeId = 2,
	activityId = 1,
	damage = 3,
	prize = 4,
	desc = 5
}
local dataList = {
	{
		456001,
		1,
		"10000000",
		"8:1:1000000#10:453001:300",
		"1000万伤害以上可以获得："
	},
	{
		456001,
		2,
		"50000000",
		"4:510022:2#10:453001:300",
		"5000万伤害以上可以获得："
	},
	{
		456001,
		3,
		"100000000",
		"4:400002:50#10:453001:300",
		"1亿伤害以上可以获得："
	},
	{
		456001,
		4,
		"200000000",
		"4:90316:1#10:453001:300",
		"2亿伤害以上可以获得："
	},
	{
		456001,
		5,
		"300000000",
		"4:30006:50#10:453001:300",
		"3亿伤害以上可以获得："
	}
}
local t_wisdom_courage_clg_boss_damage = {
	[456001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_wisdom_courage_clg_boss_damage.dataList = dataList

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

return t_wisdom_courage_clg_boss_damage
