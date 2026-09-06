-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_alchemy_meng_meng_master.lua

module("logicconfig.config.t_origin_alchemy_meng_meng_master", package.seeall)

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
		"源起炼金梦梦挑战-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"5",
		"8",
		"敌阵精灵格挡率+20%，且每次格挡自身获得30气势"
	},
	{
		1002,
		"源起炼金梦梦挑战-2",
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
		"敌阵精灵格挡率+20%，且每次格挡自身获得30气势"
	},
	{
		1003,
		"源起炼金梦梦挑战-3",
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
		"敌阵精灵格挡率+20%，且每次格挡自身获得30气势"
	},
	{
		1004,
		"源起炼金梦梦挑战-4",
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
		"敌阵精灵格挡率+20%，且每次格挡自身获得30气势"
	},
	{
		1005,
		"源起炼金梦梦挑战-5",
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
		"敌阵精灵格挡率+20%，且每次格挡自身获得30气势"
	},
	{
		1006,
		"源起炼金梦梦挑战-6",
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
		"敌阵精灵格挡率+20%，且每次格挡自身获得30气势"
	},
	{
		1007,
		"源起炼金梦梦挑战-7",
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
		"敌阵精灵格挡率+20%，且每次格挡自身获得30气势"
	},
	{
		1008,
		"源起炼金梦梦挑战-8",
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
		"敌阵精灵格挡率+20%，且每次格挡自身获得30气势"
	}
}
local t_origin_alchemy_meng_meng_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8]
}

t_origin_alchemy_meng_meng_master.dataList = dataList

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

return t_origin_alchemy_meng_meng_master
