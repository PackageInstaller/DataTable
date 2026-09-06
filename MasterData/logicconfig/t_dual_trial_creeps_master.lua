-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_trial_creeps_master.lua

module("logicconfig.config.t_dual_trial_creeps_master", package.seeall)

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
		"战斗事件-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵即可通关"
	},
	{
		1002,
		"战斗事件-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵即可通关"
	},
	{
		1003,
		"战斗事件-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵即可通关"
	},
	{
		1004,
		"战斗事件-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵即可通关"
	},
	{
		1005,
		"战斗事件-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵即可通关"
	},
	{
		1006,
		"战斗事件-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵即可通关"
	},
	{
		1007,
		"战斗事件-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵即可通关"
	},
	{
		1008,
		"战斗事件-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵即可通关"
	},
	{
		1009,
		"战斗事件-9",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵即可通关"
	}
}
local t_dual_trial_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9]
}

t_dual_trial_creeps_master.dataList = dataList

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

return t_dual_trial_creeps_master
