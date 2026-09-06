-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_zhengli_master.lua

module("logicconfig.config.t_origin_zhengli_master", package.seeall)

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
		"源起正理挑战-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵获得40%闪避率和30%减伤"
	},
	{
		1002,
		"源起正理挑战-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵获得40%闪避率和30%减伤"
	},
	{
		1003,
		"源起正理挑战-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵获得40%闪避率和30%减伤"
	},
	{
		1004,
		"源起正理挑战-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵获得40%闪避率和30%减伤"
	},
	{
		1005,
		"源起正理挑战-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵获得40%闪避率和30%减伤"
	},
	{
		1006,
		"源起正理挑战-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵获得40%闪避率和30%减伤"
	},
	{
		1007,
		"源起正理挑战-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵获得40%闪避率和30%减伤"
	},
	{
		1008,
		"源起正理挑战-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵获得40%闪避率和30%减伤"
	},
	{
		1009,
		"源起正理挑战-9",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵获得40%闪避率和30%减伤"
	}
}
local t_origin_zhengli_master = {
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

t_origin_zhengli_master.dataList = dataList

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

return t_origin_zhengli_master
