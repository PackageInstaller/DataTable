-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_challenge.lua

module("logicconfig.config.t_star_god_challenge", package.seeall)

local title = {
	singleFormCondition = 12,
	singlePrize = 8,
	singleCost = 5,
	groupId = 3,
	helpCost = 7,
	singleBuffs = 13,
	helpPrize = 11,
	recommendPower = 15,
	groupPrize = 10,
	intervalRewardShow = 9,
	tier = 1,
	name = 2,
	creepsMasterId = 4,
	groupCost = 6,
	groupBuffs = 14,
	levelDescription = 16
}
local dataList = {
	{
		1,
		"星神幻境塔-1",
		57,
		1,
		"60:1:35",
		"60:1:35",
		"",
		"9:80037:1#4:501:220#4:502:30#9:60003:5#4:503:5#9:101:2#9:403:1#9:501:1",
		{
			"5~9"
		},
		"9:80037:1#4:501:220#4:502:30#9:60003:5#4:503:5#9:101:2#9:403:1#9:501:1",
		"10:170001:5",
		0,
		"1003:99",
		"1001:99",
		700000,
		"3回合内击败敌阵，视为战斗胜利，否则视为战斗失败"
	}
}
local t_star_god_challenge = {
	dataList[1]
}

t_star_god_challenge.dataList = dataList

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

return t_star_god_challenge
