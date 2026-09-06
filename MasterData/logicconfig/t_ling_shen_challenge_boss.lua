-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_challenge_boss.lua

module("logicconfig.config.t_ling_shen_challenge_boss", package.seeall)

local title = {
	bossId = 2,
	weakStartTime = 6,
	creepsMasterId = 4,
	prizePlanId = 7,
	groupId = 3,
	desc = 11,
	bubble = 9,
	buffBubble = 10,
	raceId = 8,
	activityId = 1,
	startTime = 5
}
local dataList = {
	{
		377001,
		1,
		58,
		1001,
		"2024-05-31T05:00:00",
		"2024-06-04T05:00:00",
		1,
		13005,
		"领神BOSS每个回合结束时\r\n提高20%攻击力",
		"领神疲劳期，我方组队加成\r\n血量+100w,攻击+30w",
		"2-3人组队挑战，每个玩家设定三只精灵作为攻阵一起并肩作战"
	},
	{
		377001,
		2,
		59,
		1002,
		"2024-06-07T05:00:00",
		"2024-06-11T05:00:00",
		1,
		17001,
		"领神BOSS每个回合结束时\r\n提高20%攻击力",
		"领神疲劳期，我方组队加成\r\n血量+100w,攻击+30w",
		"2-3人组队挑战，每个玩家设定三只精灵作为攻阵一起并肩作战"
	},
	{
		377001,
		3,
		60,
		1003,
		"2024-06-14T05:00:00",
		"2024-06-18T05:00:00",
		1,
		17004,
		"领神BOSS每个回合结束时\r\n提高20%攻击力",
		"领神疲劳期，我方组队加成\r\n血量+100w,攻击+30w",
		"2-3人组队挑战，每个玩家设定三只精灵作为攻阵一起并肩作战"
	},
	{
		377001,
		4,
		61,
		1004,
		"2024-06-21T05:00:00",
		"2024-06-25T05:00:00",
		1,
		16010,
		"领神BOSS每个回合结束时\r\n提高20%攻击力",
		"领神疲劳期，我方组队加成\r\n血量+100w,攻击+30w",
		"2-3人组队挑战，每个玩家设定三只精灵作为攻阵一起并肩作战"
	},
	{
		377002,
		1,
		62,
		1005,
		"2024-11-08T05:00:00",
		"2024-11-11T05:00:00",
		2,
		15029,
		"魔君每个回合结束时\r\n提高20%攻击力",
		"魔君疲劳期，我方组队加成\r\n血量+100w,攻击+30w",
		"2-3人组队挑战，每个玩家设定三只精灵作为攻阵一起并肩作战"
	},
	{
		377003,
		1,
		63,
		1006,
		"2025-01-17T05:00:00",
		"2025-01-20T05:00:00",
		3,
		11025,
		"魔君初始获得60%减伤，受击时敌阵每有一种属性，减伤效果降低20%",
		"魔君疲劳期，我方组队加成\r\n血量+100w,攻击+30w",
		"2-3人组队挑战，每个玩家设定三只精灵作为攻阵一起并肩作战"
	},
	{
		377004,
		1,
		64,
		1007,
		"2025-01-24T05:00:00",
		"2025-02-28T05:00:00",
		4,
		13021,
		"瑞兽受到非水火草的伤害降低30%,三个大回合后结束战斗",
		"瑞兽疲劳期，我方组队加成\r\n血量+100w,攻击+30w",
		"2-3人组队挑战，每个玩家设定三只精灵作为攻阵一起并肩作战"
	}
}
local t_ling_shen_challenge_boss = {
	[377001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[377002] = {
		dataList[5]
	},
	[377003] = {
		dataList[6]
	},
	[377004] = {
		dataList[7]
	}
}

t_ling_shen_challenge_boss.dataList = dataList

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

return t_ling_shen_challenge_boss
