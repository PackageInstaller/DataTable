-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_eternal_dragon_clg_creeps_master.lua

module("logicconfig.config.t_origin_eternal_dragon_clg_creeps_master", package.seeall)

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
		"源起永恒-春-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"414033",
		"击败敌阵所有精灵即可通关"
	},
	{
		1002,
		"源起永恒-春-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"411032",
		"击败敌阵所有精灵即可通关"
	},
	{
		1003,
		"源起永恒-春-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"416044",
		"击败敌阵所有精灵即可通关"
	},
	{
		1004,
		"源起永恒-夏-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"416033",
		"击败敌阵所有精灵即可通关"
	},
	{
		1005,
		"源起永恒-夏-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412036",
		"击败敌阵所有精灵即可通关"
	},
	{
		1006,
		"源起永恒-夏-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"414042",
		"击败敌阵所有精灵即可通关"
	},
	{
		1007,
		"源起永恒-秋-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412029",
		"击败敌阵所有精灵即可通关"
	},
	{
		1008,
		"源起永恒-秋-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"416036",
		"击败敌阵所有精灵即可通关"
	},
	{
		1009,
		"源起永恒-秋-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"415039",
		"击败敌阵所有精灵即可通关"
	},
	{
		1010,
		"源起永恒-冬-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412027",
		"击败敌阵所有精灵即可通关"
	},
	{
		1011,
		"源起永恒-冬-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412031",
		"击败敌阵所有精灵即可通关"
	},
	{
		1012,
		"源起永恒-冬-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"414037",
		"击败敌阵所有精灵即可通关"
	}
}
local t_origin_eternal_dragon_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10],
	[1011] = dataList[11],
	[1012] = dataList[12]
}

t_origin_eternal_dragon_clg_creeps_master.dataList = dataList

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

return t_origin_eternal_dragon_clg_creeps_master
