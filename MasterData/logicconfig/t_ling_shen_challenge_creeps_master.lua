-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_challenge_creeps_master.lua

module("logicconfig.config.t_ling_shen_challenge_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"青骨对决",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"领神BOSS每个回合结束时提高20%攻击力"
	},
	{
		1002,
		"莱莉丝对决",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"领神BOSS每个回合结束时提高20%攻击力"
	},
	{
		1003,
		"达克诺斯对决",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"领神BOSS每个回合结束时提高20%攻击力"
	},
	{
		1004,
		"敖久试炼",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"领神BOSS每个回合结束时提高20%攻击力"
	},
	{
		1005,
		"娜克亚试炼",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"领神BOSS每个回合结束时提高20%攻击力"
	},
	{
		1006,
		"古拉丝试炼",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"魔君初始获得60%减伤，受击时敌阵每有一种属性，减伤效果降低20%"
	},
	{
		1007,
		"瑞兽试炼",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"瑞兽受到非水火草的伤害降低30%,三个大回合后结束战斗"
	}
}
local t_ling_shen_challenge_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7]
}

t_ling_shen_challenge_creeps_master.dataList = dataList

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

return t_ling_shen_challenge_creeps_master
