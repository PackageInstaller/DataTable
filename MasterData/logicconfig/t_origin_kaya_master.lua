-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_kaya_master.lua

module("logicconfig.config.t_origin_kaya_master", package.seeall)

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
		"源起卡雅-1",
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
		"击败敌阵所有精灵即可过关"
	},
	{
		1002,
		"源起卡雅-2",
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
		"击败敌阵所有精灵即可过关"
	},
	{
		1003,
		"源起卡雅-3",
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
		"击败敌阵所有精灵即可过关"
	},
	{
		1004,
		"源起卡雅-4",
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
		"击败敌阵所有精灵即可过关"
	},
	{
		1005,
		"源起卡雅-5",
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
		"击败敌阵所有精灵即可过关"
	},
	{
		1006,
		"源起卡雅-6",
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
		"击败敌阵所有精灵即可过关"
	},
	{
		1007,
		"源起卡雅-7",
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
		"击败敌阵所有精灵即可过关"
	},
	{
		1008,
		"源起卡雅-8",
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
		"击败敌阵所有精灵即可过关"
	},
	{
		1009,
		"源起卡雅-9",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"414042",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1010,
		"源起卡雅-10",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"416044",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1011,
		"源起卡雅-11",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"411032",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	},
	{
		1012,
		"源起卡雅-12",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"415042",
		"",
		"",
		"击败敌阵所有精灵即可过关"
	}
}
local t_origin_kaya_master = {
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

t_origin_kaya_master.dataList = dataList

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

return t_origin_kaya_master
