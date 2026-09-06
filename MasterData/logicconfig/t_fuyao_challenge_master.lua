-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fuyao_challenge_master.lua

module("logicconfig.config.t_fuyao_challenge_master", package.seeall)

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
		101,
		"火之试炼",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		102,
		"水之试炼",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		103,
		"草之试炼",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		104,
		"光之试炼",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		105,
		"暗之试炼",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		106,
		"空之试炼",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1001,
		"六道·火",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		143,
		56,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1002,
		"六道·水",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		143,
		55,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1003,
		"六道·草",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		143,
		57,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1004,
		"六道·光",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		143,
		58,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1005,
		"六道·暗",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		143,
		59,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1006,
		"六道·空",
		"",
		"",
		0,
		"",
		"",
		0,
		0,
		143,
		143,
		"",
		"击败敌阵全体精灵，即可通关。"
	}
}
local t_fuyao_challenge_master = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[106] = dataList[6],
	[1001] = dataList[7],
	[1002] = dataList[8],
	[1003] = dataList[9],
	[1004] = dataList[10],
	[1005] = dataList[11],
	[1006] = dataList[12]
}

t_fuyao_challenge_master.dataList = dataList

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

return t_fuyao_challenge_master
