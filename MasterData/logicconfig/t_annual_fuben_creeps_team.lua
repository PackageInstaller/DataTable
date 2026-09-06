-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_creeps_team.lua

module("logicconfig.config.t_annual_fuben_creeps_team", package.seeall)

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
		101,
		"打破规则-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		102,
		"打破规则-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		103,
		"打破规则-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		104,
		"打破规则-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412031",
		"击败敌阵通关"
	},
	{
		105,
		"打破规则-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"416033",
		"击败敌阵通关"
	},
	{
		106,
		"打破规则-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412027",
		"击败敌阵通关"
	},
	{
		107,
		"打破规则-7",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412029",
		"击败敌阵通关"
	},
	{
		108,
		"打破规则-8",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"414033",
		"击败敌阵通关"
	},
	{
		201,
		"遵从规则-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		202,
		"遵从规则-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		203,
		"遵从规则-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		204,
		"遵从规则-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		205,
		"遵从规则-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		206,
		"遵从规则-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		207,
		"遵从规则-7",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		208,
		"遵从规则-8",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵通关"
	},
	{
		301,
		"BOSS",
		5,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"2个大回合内尽可能对敌阵造成伤害"
	}
}
local t_annual_fuben_creeps_team = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[106] = dataList[6],
	[107] = dataList[7],
	[108] = dataList[8],
	[201] = dataList[9],
	[202] = dataList[10],
	[203] = dataList[11],
	[204] = dataList[12],
	[205] = dataList[13],
	[206] = dataList[14],
	[207] = dataList[15],
	[208] = dataList[16],
	[301] = dataList[17]
}

t_annual_fuben_creeps_team.dataList = dataList

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

return t_annual_fuben_creeps_team
