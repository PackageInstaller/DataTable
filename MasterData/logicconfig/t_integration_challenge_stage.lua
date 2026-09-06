-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_integration_challenge_stage.lua

module("logicconfig.config.t_integration_challenge_stage", package.seeall)

local title = {
	stageId = 3,
	name = 5,
	popCondition = 17,
	skipTime = 10,
	retreatMsgType = 14,
	battleDesc = 6,
	type = 2,
	openTime = 18,
	btlBg = 11,
	missionDesc = 7,
	power = 19,
	creepsMasterId = 4,
	showFaceId = 9,
	challengePlanId = 1,
	WinDesc = 8,
	formCondition = 15,
	btlMode = 12,
	winId = 13,
	popExplanation = 16
}
local dataList = {
	{
		1,
		1,
		1,
		1001,
		"心心挑战",
		"",
		"",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		0,
		"统计通关的回合数",
		"击败敌方所有精灵",
		nil,
		0
	},
	{
		1,
		1,
		2,
		1002,
		"念念挑战",
		"",
		"",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		0,
		"统计通关的回合数",
		"击败敌方所有精灵",
		nil,
		0
	},
	{
		1,
		2,
		1,
		1003,
		"合体挑战",
		"",
		"",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		0,
		"完成希妮安挑战解锁双生合体",
		"击败敌方所有精灵",
		"2021-11-05T05:00:00",
		400000
	}
}
local t_integration_challenge_stage = {
	{
		{
			dataList[1],
			dataList[2]
		},
		{
			dataList[3]
		}
	}
}

t_integration_challenge_stage.dataList = dataList

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

return t_integration_challenge_stage
