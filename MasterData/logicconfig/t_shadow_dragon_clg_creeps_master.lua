-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shadow_dragon_clg_creeps_master.lua

module("logicconfig.config.t_shadow_dragon_clg_creeps_master", package.seeall)

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
		"现在关卡-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1002,
		"现在关卡-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"6",
		"7"
	},
	{
		1003,
		"现在关卡-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1004,
		"现在关卡-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"5",
		"7"
	},
	{
		1005,
		"现在关卡-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1006,
		"未来关卡-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1007,
		"未来关卡-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"6",
		"7"
	},
	{
		1008,
		"未来关卡-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1009,
		"未来关卡-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1010,
		"过去关卡-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1011,
		"过去关卡-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1012,
		"过去关卡-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1013,
		"过去关卡-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	}
}
local t_shadow_dragon_clg_creeps_master = {
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
	[1013] = dataList[13]
}

t_shadow_dragon_clg_creeps_master.dataList = dataList

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

return t_shadow_dragon_clg_creeps_master
