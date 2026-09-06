-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mimengli_clg_stage.lua

module("logicconfig.config.t_divine_mimengli_clg_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 5,
	enemyExtPetId = 9,
	type = 3,
	ruleDesc = 11,
	prize = 4,
	stagePlanId = 6,
	signBuffId = 7,
	buffPlanId = 10,
	mustFormPetId = 8,
	activityId = 1
}
local dataList = {
	{
		460001,
		1,
		1,
		"4:266:20",
		"2025-02-28T05:00:00",
		1,
		0,
		0,
		0,
		0,
		"所有关卡破阵成功即可获得本层奖励"
	},
	{
		460001,
		2,
		2,
		"4:266:30",
		"2025-02-28T05:00:00",
		2,
		20062005,
		0,
		0,
		1,
		"1.在每回合结束后，未击败一横排的精灵，则敌阵所有精灵站位将前进一格\r\n2.敌阵二号位会有个漩涡，在敌方移动后，进入到漩涡的精灵会有二次位移"
	},
	{
		460001,
		3,
		3,
		"4:266:50",
		"2025-02-28T05:00:00",
		3,
		20062006,
		10000001,
		10000002,
		0,
		"1.挑战根据弥梦离精灵同时击杀一横排的次数（X）生成“记忆冤魂”\r\n2.<color=#C54949>生成记忆冤魂的数量公式=3-X</color>"
	},
	{
		460002,
		1,
		1,
		"4:266:20",
		"2025-02-28T05:00:00",
		1,
		0,
		0,
		0,
		0,
		"所有关卡破阵成功即可获得本层奖励"
	},
	{
		460002,
		2,
		2,
		"4:266:30",
		"2025-02-28T05:00:00",
		2,
		20062005,
		0,
		0,
		1,
		"1.在每回合结束后，未击败一横排的精灵，则敌阵所有精灵站位将前进一格\r\n2.敌阵二号位会有个漩涡，在敌方移动后，进入到漩涡的精灵会有二次位移"
	},
	{
		460002,
		3,
		3,
		"4:266:50",
		"2025-02-28T05:00:00",
		3,
		20062006,
		10000001,
		10000002,
		0,
		"1.挑战根据弥梦离精灵同时击杀一横排的次数（X）生成“记忆冤魂”\r\n2.<color=#C54949>生成记忆冤魂的数量公式=3-X</color>"
	}
}
local t_divine_mimengli_clg_stage = {
	[460001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[460002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_mimengli_clg_stage.dataList = dataList

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

return t_divine_mimengli_clg_stage
