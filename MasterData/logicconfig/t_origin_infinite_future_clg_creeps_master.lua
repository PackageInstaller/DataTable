-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_infinite_future_clg_creeps_master.lua

module("logicconfig.config.t_origin_infinite_future_clg_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 13,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 12,
	ruleDesc = 11,
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
		"源起无限未来挑战-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"己阵精灵出手一次累计10点进度，男性精灵出手累计20点，进度每满60点，己阵全体受到敌阵攻击力最高的精灵200%的毁灭伤害（每个大回合限1次）",
		"",
		""
	},
	{
		1002,
		"源起无限未来挑战-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"己阵精灵出手一次累计10点进度，男性精灵出手累计20点，进度每满60点，己阵全体受到敌阵攻击力最高的精灵200%的毁灭伤害（每个大回合限1次）",
		"",
		""
	},
	{
		1003,
		"源起无限未来挑战-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"己阵精灵出手一次累计10点进度，男性精灵出手累计20点，进度每满60点，己阵全体受到敌阵攻击力最高的精灵200%的毁灭伤害（每个大回合限1次）",
		"",
		""
	},
	{
		1004,
		"源起无限未来挑战-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"己阵精灵出手一次累计10点进度，男性精灵出手累计20点，进度每满60点，己阵全体受到敌阵攻击力最高的精灵200%的毁灭伤害（每个大回合限1次）",
		"",
		""
	},
	{
		1005,
		"源起无限未来挑战-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"己阵精灵出手一次累计10点进度，男性精灵出手累计20点，进度每满60点，己阵全体受到敌阵攻击力最高的精灵200%的毁灭伤害（每个大回合限1次）",
		"",
		""
	},
	{
		1006,
		"源起无限未来挑战-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"己阵精灵出手一次累计10点进度，男性精灵出手累计20点，进度每满60点，己阵全体受到敌阵攻击力最高的精灵200%的毁灭伤害（每个大回合限1次）",
		"",
		""
	}
}
local t_origin_infinite_future_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_origin_infinite_future_clg_creeps_master.dataList = dataList

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

return t_origin_infinite_future_clg_creeps_master
