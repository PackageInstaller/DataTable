-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_hope_master.lua

module("logicconfig.config.t_divine_hope_master", package.seeall)

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
		"神曜希望-1-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1002,
		"神曜希望-1-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1003,
		"神曜希望-1-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1004,
		"神曜希望-1-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1005,
		"神曜希望-1-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1006,
		"神曜希望-1-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1007,
		"神曜希望-2-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1008,
		"神曜希望-2-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1009,
		"神曜希望-2-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1010,
		"神曜希望-2-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1011,
		"神曜希望-2-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1012,
		"神曜希望-2-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1013,
		"神曜希望-3-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"416033",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1014,
		"神曜希望-3-2",
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
		"击败敌阵所有精灵即可过关"
	},
	{
		1015,
		"神曜希望-3-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412036",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1016,
		"神曜希望-3-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"416036",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1017,
		"神曜希望-3-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"411032",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1018,
		"神曜希望-3-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412031",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	}
}
local t_divine_hope_master = {
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
	[1012] = dataList[12],
	[1013] = dataList[13],
	[1014] = dataList[14],
	[1015] = dataList[15],
	[1016] = dataList[16],
	[1017] = dataList[17],
	[1018] = dataList[18]
}

t_divine_hope_master.dataList = dataList

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

return t_divine_hope_master
