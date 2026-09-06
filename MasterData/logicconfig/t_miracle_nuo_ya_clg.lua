-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_nuo_ya_clg.lua

module("logicconfig.config.t_miracle_nuo_ya_clg", package.seeall)

local title = {
	extremeClgPrize = 3,
	jumpStrOne = 6,
	jumpStrFour = 9,
	jumpStrThree = 8,
	skinId = 11,
	supportPetId4MalePlayer = 4,
	jumpStrTwo = 7,
	ruleKeyNor = 13,
	ruleKeyExt = 14,
	norRuleDesc = 15,
	redPointId = 2,
	jumpStrFive = 10,
	supportPetId4FemalePlayer = 5,
	ruleKeyMain = 12,
	activityId = 1,
	bubbleItem = 16
}
local dataList = {
	{
		382001,
		587,
		"100:14025:1:1",
		100000001,
		100000001,
		"func#618#14025",
		"mibao#qijijianglin3",
		"func#43",
		"",
		"",
		14025,
		"MiraclenuoyamainView_rule",
		"MiraclenuoyanorView_rule",
		"miraclenuoyamapview_rule",
		"统计5个回合内对BOSS造成的伤害，根据今日最高伤害所处的区间换算成积分。",
		"100:14025:1:1"
	},
	{
		382002,
		646,
		"8:1:1000",
		100000001,
		100000001,
		"func#618#14025",
		"mibao#qijijianglin3",
		"func#43",
		"",
		"",
		14025,
		"MiraclenuoyamainView_rule",
		"MiraclenuoyanorView_rule",
		"miraclenuoyamapview_rule",
		"统计5个回合内对BOSS造成的伤害，根据今日最高伤害所处的区间换算成积分。",
		"8:1:1000"
	}
}
local t_miracle_nuo_ya_clg = {
	[382001] = dataList[1],
	[382002] = dataList[2]
}

t_miracle_nuo_ya_clg.dataList = dataList

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

return t_miracle_nuo_ya_clg
