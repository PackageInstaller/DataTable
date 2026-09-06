-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_invincible_creeps_master.lua

module("logicconfig.config.t_divine_invincible_creeps_master", package.seeall)

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
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"5",
		"6"
	},
	{
		1004,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"",
		3,
		"",
		"",
		0,
		0,
		429,
		0,
		"",
		"",
		"",
		""
	},
	{
		1006,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"5",
		"6"
	},
	{
		2001,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		2002,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		2003,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		2004,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		2005,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		2006,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		2007,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		2008,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	},
	{
		2009,
		"",
		3,
		"",
		"",
		0,
		0,
		144,
		0,
		"",
		"",
		"",
		""
	}
}
local t_divine_invincible_creeps_master = {
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
	[2007] = dataList[13],
	[2008] = dataList[14],
	[2009] = dataList[15]
}

t_divine_invincible_creeps_master.dataList = dataList

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

return t_divine_invincible_creeps_master
