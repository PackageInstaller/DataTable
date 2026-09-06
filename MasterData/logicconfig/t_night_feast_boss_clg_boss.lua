-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_night_feast_boss_clg_boss.lua

module("logicconfig.config.t_night_feast_boss_clg_boss", package.seeall)

local title = {
	bossId = 2,
	openTime = 3,
	creepsMasterId = 5,
	prizePlanId = 6,
	rankPrizePlanId = 7,
	ruleDesc = 9,
	endTime = 4,
	raceId = 8,
	activityId = 1
}
local dataList = {
	{
		335001,
		1,
		"2025-08-22T05:00:21",
		"2025-09-22T05:00:21",
		1001,
		1,
		1,
		1402201,
		""
	},
	{
		335002,
		1,
		"2025-10-24T05:00:00",
		"2025-11-21T05:00:00",
		9001,
		2,
		2,
		1801102,
		"希望神女攻击生命值低于50%的目标有50%的概率对其施加禁疗效果"
	},
	{
		335002,
		2,
		"2025-10-31T05:00:00",
		"2025-11-21T05:00:00",
		9002,
		3,
		2,
		1503902,
		"击杀带嘲讽的2只超神后才可对boss本体造成伤害，boss攻击男性精灵时，施加混乱状态"
	},
	{
		335002,
		3,
		"2025-11-07T05:00:00",
		"2025-11-21T05:00:00",
		9003,
		3,
		2,
		1504101,
		"每回合第一个攻击悼影神女的精灵将会被施加无法行动状态（1回合），且悼影神女将对该精灵造成自身攻击*200%的伤害"
	}
}
local t_night_feast_boss_clg_boss = {
	[335001] = {
		dataList[1]
	},
	[335002] = {
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_night_feast_boss_clg_boss.dataList = dataList

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

return t_night_feast_boss_clg_boss
