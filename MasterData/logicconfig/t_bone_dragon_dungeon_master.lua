-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bone_dragon_dungeon_master.lua

module("logicconfig.config.t_bone_dragon_dungeon_master", package.seeall)

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
		"战斗-1",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1002,
		"战斗-2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1003,
		"战斗-3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1004,
		"战斗-4",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1005,
		"战斗-5",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1006,
		"战斗-6",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1007,
		"战斗-7",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1008,
		"战斗-8",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1009,
		"战斗-9",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1010,
		"战斗-10",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1011,
		"战斗-11",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1012,
		"战斗-12",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1013,
		"战斗-13",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1014,
		"战斗-14",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1015,
		"战斗-15",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1016,
		"战斗-16",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1017,
		"战斗-17",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1018,
		"战斗-18",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	}
}
local t_bone_dragon_dungeon_master = {
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

t_bone_dragon_dungeon_master.dataList = dataList

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

return t_bone_dragon_dungeon_master
