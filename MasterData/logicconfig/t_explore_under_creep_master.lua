-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_explore_under_creep_master.lua

module("logicconfig.config.t_explore_under_creep_master", package.seeall)

local title = {
	name = 2,
	WinDesc = 10,
	skipTime = 3,
	retreatMsgType = 8,
	btlMode = 5,
	btlBg = 4,
	missionDesc = 9,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"强敌1号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1002,
		"强敌2号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1003,
		"强敌3号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1004,
		"强敌4号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1005,
		"强敌5号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1006,
		"强敌6号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1007,
		"强敌7号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1008,
		"强敌8号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1009,
		"强敌9号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1010,
		"强敌10号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1011,
		"强敌11号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	},
	{
		1012,
		"强敌12号",
		5,
		"",
		"",
		0,
		"",
		0,
		"",
		"击败敌阵后即可通关"
	}
}
local t_explore_under_creep_master = {
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

t_explore_under_creep_master.dataList = dataList

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

return t_explore_under_creep_master
