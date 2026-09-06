-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_disorder_dragon_monster.lua

module("logicconfig.config.t_divine_disorder_dragon_monster", package.seeall)

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
		"变幻-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到神曜王龙攻击时,变身为神曜王龙"
	},
	{
		1002,
		"变幻-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到神曜黄金攻击时,变身为神曜黄金"
	},
	{
		1003,
		"变幻-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到神曜无烬攻击时,变身为神曜无烬"
	},
	{
		1004,
		"变幻-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到神曜次元攻击时,变身为神曜次元"
	},
	{
		1005,
		"变幻-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到神曜超神攻击时,变身为神曜超神"
	},
	{
		1006,
		"变幻-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到神曜秩序攻击时,变身为神曜秩序"
	},
	{
		1007,
		"变幻-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"413015",
		"己阵受到永恒圣龙攻击时,变身为永恒圣龙"
	},
	{
		1008,
		"变幻-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到神曜时空龙攻击时,变身为神曜时空龙"
	},
	{
		1009,
		"变幻-9",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到神曜龙主攻击时,变身为神曜龙主"
	},
	{
		1010,
		"变幻-10",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到神曜解神攻击时,变身为神曜解神"
	},
	{
		1011,
		"变幻-11",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到敖九攻击时,变身为敖九"
	},
	{
		1012,
		"变幻-12",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"己阵受到凡尔维斯攻击时,变身为凡尔维斯"
	}
}
local t_divine_disorder_dragon_monster = {
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

t_divine_disorder_dragon_monster.dataList = dataList

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

return t_divine_disorder_dragon_monster
