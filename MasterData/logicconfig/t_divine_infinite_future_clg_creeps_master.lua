-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_infinite_future_clg_creeps_master.lua

module("logicconfig.config.t_divine_infinite_future_clg_creeps_master", package.seeall)

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
		"关卡-1-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		1002,
		"关卡-1-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		1003,
		"关卡-1-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		1004,
		"关卡-1-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		1005,
		"关卡-1-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		1006,
		"关卡-1-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		2001,
		"关卡-2-1",
		5,
		"",
		"",
		0,
		0,
		440,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		2002,
		"关卡-2-2",
		5,
		"",
		"",
		0,
		0,
		440,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		2003,
		"关卡-2-3",
		5,
		"",
		"",
		0,
		0,
		440,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		2004,
		"关卡-2-4",
		5,
		"",
		"",
		0,
		0,
		440,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		2005,
		"关卡-2-5",
		5,
		"",
		"",
		0,
		0,
		440,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		2006,
		"关卡-2-6",
		5,
		"",
		"",
		0,
		0,
		440,
		0,
		"",
		"击败敌阵全部精灵即可过关"
	},
	{
		3001,
		"关卡-3-1",
		5,
		"",
		"",
		0,
		0,
		441,
		0,
		"413020",
		"击败敌阵全部精灵即可过关"
	},
	{
		3002,
		"关卡-3-2",
		5,
		"",
		"",
		0,
		0,
		441,
		0,
		"414027",
		"击败敌阵全部精灵即可过关"
	},
	{
		3003,
		"关卡-3-3",
		5,
		"",
		"",
		0,
		0,
		441,
		0,
		"412027",
		"击败敌阵全部精灵即可过关"
	},
	{
		3004,
		"关卡-3-4",
		5,
		"",
		"",
		0,
		0,
		441,
		0,
		"412023",
		"击败敌阵全部精灵即可过关"
	},
	{
		3005,
		"关卡-3-5",
		5,
		"",
		"",
		0,
		0,
		441,
		0,
		"416028",
		"击败敌阵全部精灵即可过关"
	},
	{
		3006,
		"关卡-3-6",
		5,
		"",
		"",
		0,
		0,
		441,
		0,
		"414029",
		"击败敌阵全部精灵即可过关"
	}
}
local t_divine_infinite_future_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[2001] = dataList[7],
	[2002] = dataList[8],
	[2003] = dataList[9],
	[2004] = dataList[10],
	[2005] = dataList[11],
	[2006] = dataList[12],
	[3001] = dataList[13],
	[3002] = dataList[14],
	[3003] = dataList[15],
	[3004] = dataList[16],
	[3005] = dataList[17],
	[3006] = dataList[18]
}

t_divine_infinite_future_clg_creeps_master.dataList = dataList

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

return t_divine_infinite_future_clg_creeps_master
