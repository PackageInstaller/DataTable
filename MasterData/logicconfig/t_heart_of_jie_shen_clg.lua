-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_heart_of_jie_shen_clg.lua

module("logicconfig.config.t_heart_of_jie_shen_clg", package.seeall)

local title = {
	rank = 12,
	raceId2 = 9,
	chiCreepsMasterId = 3,
	jumpTo = 15,
	raceId1 = 8,
	tips = 7,
	rankTips = 17,
	lockPetCount = 4,
	dailyRankPrize = 6,
	activityId = 1,
	reward = 16,
	rank_challenge = 13,
	yiCreepsMasterId = 2,
	shop = 14,
	gameRuleKey = 11,
	challengeClosedTimeRange = 5,
	ruleKey = 10
}
local dataList = {
	{
		389001,
		1001,
		1002,
		3,
		"02:00:00-09:00:00",
		"4:244:1",
		"挑战时间：9:00--2:00",
		16001,
		16026,
		"heartofjieshenclg",
		"jieshen_gameRule",
		"次日重置排行榜，每日凌晨五点发放奖励内容",
		"历史排行榜不重置，每隔十分钟刷新排行榜",
		"mibao#Skin",
		"func#618#16026",
		"4:244:1",
		"1、次日凌晨5点结算排行；\r\n2、最后一个状态标记为“√”的奥奇，则是拥有解神意志·赤；\r\n3、可以去掉未拥有的勾选按钮，筛选未拥有解神意志·赤的奥奇，查看名次。"
	},
	{
		389002,
		2001,
		2002,
		3,
		"00:00:00-09:00:00",
		"4:425:1",
		"挑战时间：9:00--2:00",
		16010,
		16040,
		"heartofaojiuclg",
		"aojiuzhixin_gameRule",
		"次日重置排行榜，每日凌晨五点发放奖励内容",
		"历史排行榜不重置，每隔十分钟刷新排行榜",
		"mibao#Skin",
		"func#618#16040",
		"4:425:1",
		"1、次日凌晨5点结算排行；\r\n2、最后一个状态标记为“√”的奥奇，则是拥有离阳龙脉·敖九；\r\n3、可以去掉未拥有的勾选按钮，筛选未拥有离阳龙脉·敖九的奥奇，查看名次。"
	}
}
local t_heart_of_jie_shen_clg = {
	[389001] = dataList[1],
	[389002] = dataList[2]
}

t_heart_of_jie_shen_clg.dataList = dataList

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

return t_heart_of_jie_shen_clg
