-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_saint_knight_fire_god_master.lua

module("logicconfig.config.t_divine_saint_knight_fire_god_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 12,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 11,
	ruleDesc = 13,
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
		"神曜炎神-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"416020",
		"",
		"",
		"1、配平等式后方可进入挑战\n\r\n2、击败敌方所有敌人后视为胜利"
	},
	{
		1002,
		"神曜炎神-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"413015",
		"",
		"",
		"1、配平等式后方可进入挑战\n\r\n2、击败敌方所有敌人后视为胜利"
	},
	{
		1003,
		"神曜炎神-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"415027",
		"",
		"",
		"1、配平等式后方可进入挑战\n\r\n2、击败敌方所有敌人后视为胜利"
	},
	{
		1004,
		"神曜炎神-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412023",
		"",
		"",
		"1、配平等式后方可进入挑战\n\r\n2、击败敌方所有敌人后视为胜利"
	},
	{
		1005,
		"神曜炎神-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"417010",
		"",
		"",
		"1、配平等式后方可进入挑战\n\r\n2、击败敌方所有敌人后视为胜利"
	},
	{
		1006,
		"神曜炎神-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"414033",
		"",
		"",
		"1、配平等式后方可进入挑战\n\r\n2、击败敌方所有敌人后视为胜利"
	}
}
local t_divine_saint_knight_fire_god_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_divine_saint_knight_fire_god_master.dataList = dataList

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

return t_divine_saint_knight_fire_god_master
