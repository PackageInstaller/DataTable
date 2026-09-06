-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hit_boss_monster.lua

module("logicconfig.config.t_hit_boss_monster", package.seeall)

local title = {
	selfBuffProviderId = 10,
	name = 2,
	WinDesc = 4,
	skipTime = 5,
	retreatMsgType = 9,
	formCondition = 11,
	stageDesc = 13,
	btlMode = 7,
	btlBg = 6,
	missionDesc = 3,
	winId = 8,
	creepsMasterId = 1,
	heroSkillId = 12
}
local dataList = {
	{
		1001,
		"对决",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		71,
		0,
		0,
		0,
		"",
		"五个大回合后结束战斗"
	},
	{
		1002,
		"对决",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		71,
		0,
		0,
		0,
		"",
		"五个大回合后结束战斗"
	}
}
local t_hit_boss_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2]
}

t_hit_boss_monster.dataList = dataList

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

return t_hit_boss_monster
