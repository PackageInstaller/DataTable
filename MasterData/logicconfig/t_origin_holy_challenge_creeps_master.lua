-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_holy_challenge_creeps_master.lua

module("logicconfig.config.t_origin_holy_challenge_creeps_master", package.seeall)

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
		"源起圣光飞龙挑战-1",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"源起圣光飞龙挑战-2",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"源起圣光飞龙挑战-3",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1004,
		"源起圣光飞龙挑战-4",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"源起圣光飞龙挑战-5",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1006,
		"源起圣光飞龙挑战-6",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1007,
		"源起圣光飞龙挑战-7",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1008,
		"源起圣光飞龙挑战-8",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1009,
		"源起圣光飞龙挑战-9",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1010,
		"源起圣光飞龙挑战-10",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1011,
		"源起圣光飞龙挑战-11",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	},
	{
		1012,
		"源起圣光飞龙挑战-12",
		5,
		"",
		"",
		0,
		0,
		0,
		239,
		"",
		"",
		"",
		""
	}
}
local t_origin_holy_challenge_creeps_master = {
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

t_origin_holy_challenge_creeps_master.dataList = dataList

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

return t_origin_holy_challenge_creeps_master
