-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_nuo_ya_team.lua

module("logicconfig.config.t_king_nuo_ya_team", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	WinDesc = 10,
	skipTime = 3,
	retreatMsgType = 8,
	btlMode = 6,
	btlBg = 4,
	winId = 7,
	creepsMasterId = 1,
	heroSkillId = 5
}
local dataList = {
	{
		10101,
		"日-1-1",
		5,
		"",
		"",
		"",
		0,
		0,
		91,
		"击败所有敌人即可通关"
	},
	{
		10102,
		"日-1-2",
		5,
		"",
		"",
		"",
		0,
		0,
		90,
		"击败所有敌人即可通关"
	},
	{
		10103,
		"日-2-1",
		5,
		"",
		"",
		"",
		0,
		0,
		35,
		"击败所有敌人即可通关"
	},
	{
		10104,
		"日-2-2",
		5,
		"",
		"",
		"",
		0,
		0,
		38,
		"击败所有敌人即可通关"
	},
	{
		10105,
		"日-2-3",
		5,
		"",
		"",
		"",
		0,
		0,
		44,
		"击败所有敌人即可通关"
	},
	{
		10106,
		"日-3-1",
		5,
		"",
		"412012",
		"",
		0,
		0,
		173,
		"击败所有敌人即可通关"
	},
	{
		10107,
		"日-3-2",
		5,
		"",
		"417006",
		"",
		0,
		0,
		174,
		"击败所有敌人即可通关"
	},
	{
		10108,
		"日-3-3",
		5,
		"",
		"411012",
		"",
		0,
		0,
		175,
		"击败所有敌人即可通关"
	},
	{
		10109,
		"日-3-4",
		5,
		"",
		"411010",
		"",
		0,
		0,
		176,
		"击败所有敌人即可通关"
	},
	{
		20101,
		"夜-1-1",
		5,
		"",
		"",
		"",
		0,
		0,
		93,
		"击败所有敌人即可通关"
	},
	{
		20102,
		"夜-1-2",
		5,
		"",
		"",
		"",
		0,
		0,
		92,
		"击败所有敌人即可通关"
	},
	{
		20103,
		"夜-2-1",
		5,
		"",
		"",
		"",
		0,
		0,
		99,
		"击败所有敌人即可通关"
	},
	{
		20104,
		"夜-2-2",
		5,
		"",
		"",
		"",
		0,
		0,
		68,
		"击败所有敌人即可通关"
	},
	{
		20105,
		"夜-2-3",
		5,
		"",
		"",
		"",
		0,
		0,
		180,
		"击败所有敌人即可通关"
	},
	{
		20106,
		"夜-3-1",
		5,
		"",
		"414014",
		"",
		0,
		0,
		177,
		"击败所有敌人即可通关"
	},
	{
		20107,
		"夜-3-2",
		5,
		"",
		"416013",
		"",
		0,
		0,
		178,
		"击败所有敌人即可通关"
	},
	{
		20108,
		"夜-3-3",
		5,
		"",
		"417010",
		"",
		0,
		0,
		179,
		"击败所有敌人即可通关"
	},
	{
		20109,
		"夜-3-4",
		5,
		"",
		"414018",
		"",
		0,
		0,
		177,
		"击败所有敌人即可通关"
	}
}
local t_king_nuo_ya_team = {
	[10101] = dataList[1],
	[10102] = dataList[2],
	[10103] = dataList[3],
	[10104] = dataList[4],
	[10105] = dataList[5],
	[10106] = dataList[6],
	[10107] = dataList[7],
	[10108] = dataList[8],
	[10109] = dataList[9],
	[20101] = dataList[10],
	[20102] = dataList[11],
	[20103] = dataList[12],
	[20104] = dataList[13],
	[20105] = dataList[14],
	[20106] = dataList[15],
	[20107] = dataList[16],
	[20108] = dataList[17],
	[20109] = dataList[18]
}

t_king_nuo_ya_team.dataList = dataList

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

return t_king_nuo_ya_team
