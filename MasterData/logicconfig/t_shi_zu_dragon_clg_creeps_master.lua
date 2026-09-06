-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shi_zu_dragon_clg_creeps_master.lua

module("logicconfig.config.t_shi_zu_dragon_clg_creeps_master", package.seeall)

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
		"誓祖圣龙-1-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1002,
		"誓祖圣龙-1-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1003,
		"誓祖圣龙-1-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1004,
		"誓祖圣龙-2-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1005,
		"誓祖圣龙-2-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1006,
		"誓祖圣龙-2-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1007,
		"誓祖圣龙-3-1",
		5,
		"",
		"",
		0,
		0,
		478,
		0,
		"416036",
		"击败敌阵所有精灵即可过关"
	},
	{
		1008,
		"誓祖圣龙-3-2",
		5,
		"",
		"",
		0,
		0,
		478,
		0,
		"412031",
		"击败敌阵所有精灵即可过关"
	},
	{
		1009,
		"誓祖圣龙-3-3",
		5,
		"",
		"",
		0,
		0,
		478,
		0,
		"414033",
		"击败敌阵所有精灵即可过关"
	}
}
local t_shi_zu_dragon_clg_creeps_master = {
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

t_shi_zu_dragon_clg_creeps_master.dataList = dataList

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

return t_shi_zu_dragon_clg_creeps_master
