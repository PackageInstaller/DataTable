-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dakinos_clg_monster.lua

module("logicconfig.config.t_divine_dakinos_clg_monster", package.seeall)

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
		"蛊惑-1",
		5,
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
		"蛊惑-2",
		5,
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
		"蛊惑-3",
		5,
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
		2001,
		"污染-1",
		5,
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
		2002,
		"污染-2",
		5,
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
		2003,
		"污染-3",
		5,
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
		3001,
		"救赎-1",
		5,
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
		3002,
		"救赎-2",
		5,
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
		3003,
		"救赎-3",
		5,
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
		40000211,
		"时序-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		40000212,
		"时序-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		40000213,
		"时序-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		40000221,
		"时隙-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		40000222,
		"时隙-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		40000223,
		"时隙-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		40000231,
		"时迹-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		40000232,
		"时迹-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		40000233,
		"时迹-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	}
}
local t_divine_dakinos_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[2001] = dataList[4],
	[2002] = dataList[5],
	[2003] = dataList[6],
	[3001] = dataList[7],
	[3002] = dataList[8],
	[3003] = dataList[9],
	[40000211] = dataList[10],
	[40000212] = dataList[11],
	[40000213] = dataList[12],
	[40000221] = dataList[13],
	[40000222] = dataList[14],
	[40000223] = dataList[15],
	[40000231] = dataList[16],
	[40000232] = dataList[17],
	[40000233] = dataList[18]
}

t_divine_dakinos_clg_monster.dataList = dataList

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

return t_divine_dakinos_clg_monster
