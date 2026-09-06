-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mo_yan_challenge_stage.lua

module("logicconfig.config.t_mo_yan_challenge_stage", package.seeall)

local title = {
	stage = 2,
	name = 4,
	WinDesc = 6,
	skipTime = 8,
	retreatMsgType = 13,
	formCondition = 9,
	planId = 1,
	btlMode = 11,
	btlBg = 10,
	missionDesc = 5,
	winId = 12,
	creepsMasterId = 3,
	showFaceId = 7
}
local dataList = {
	{
		1001,
		1,
		1001,
		"烈火红莲第1阵",
		"",
		"击败敌阵全部精灵",
		10048,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1001,
		2,
		1002,
		"烈火红莲第2阵",
		"",
		"击败敌阵全部精灵",
		10032,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1001,
		3,
		1003,
		"烈火红莲第3阵",
		"",
		"击败敌阵全部精灵",
		10317,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		2001,
		1,
		2001,
		"焚",
		"至少上阵<color=#C54950>3只火属性</color>精灵",
		"击败敌阵全部精灵",
		10309,
		15,
		39,
		"",
		"",
		0,
		0
	},
	{
		2001,
		2,
		2002,
		"焰",
		"至少上阵<color=#C54950>3只火属性</color>精灵",
		"击败敌阵全部精灵",
		10075,
		15,
		39,
		"",
		"",
		0,
		0
	},
	{
		2001,
		3,
		2003,
		"炙",
		"至少上阵<color=#C54950>3只火属性</color>精灵",
		"击败敌阵全部精灵",
		10324,
		15,
		39,
		"",
		"",
		0,
		0
	},
	{
		2001,
		4,
		2004,
		"炽",
		"至少上阵<color=#C54950>3只火属性</color>精灵",
		"击败敌阵全部精灵",
		10131,
		15,
		39,
		"",
		"",
		0,
		0
	},
	{
		2001,
		5,
		2005,
		"烬",
		"至少上阵<color=#C54950>3只火属性</color>精灵",
		"击败敌阵全部精灵",
		10072,
		15,
		39,
		"",
		"",
		0,
		0
	},
	{
		3001,
		1,
		3001,
		"红莲女皇",
		"己方女性精灵对末炎伤害提升<color=#C54950>100%</color>",
		"击败末炎BOSS",
		10097,
		15,
		0,
		"",
		"",
		0,
		0
	}
}
local t_mo_yan_challenge_stage = {
	[1001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[2001] = {
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[3001] = {
		dataList[9]
	}
}

t_mo_yan_challenge_stage.dataList = dataList

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

return t_mo_yan_challenge_stage
