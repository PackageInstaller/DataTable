-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_super_dragon_clg_creeps_master.lua

module("logicconfig.config.t_divine_super_dragon_clg_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
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
		101,
		"星宙关卡-1",
		5,
		"",
		"",
		0,
		0,
		0,
		187,
		"417006"
	},
	{
		102,
		"星宙关卡-2",
		5,
		"",
		"",
		0,
		0,
		0,
		164,
		"415020"
	},
	{
		103,
		"星宙关卡-3",
		5,
		"",
		"",
		0,
		0,
		0,
		188,
		"411012"
	},
	{
		104,
		"星宙关卡-4",
		5,
		"",
		"",
		0,
		0,
		0,
		77,
		"417010"
	},
	{
		105,
		"星宙关卡-5",
		5,
		"",
		"",
		0,
		0,
		0,
		71,
		"414020"
	},
	{
		106,
		"星宙关卡-6",
		5,
		"",
		"",
		0,
		0,
		0,
		102,
		"413009"
	},
	{
		107,
		"星宙关卡-7",
		5,
		"",
		"",
		0,
		0,
		0,
		189,
		"412012"
	},
	{
		1001,
		"超神关卡-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		1002,
		"超神关卡-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		1003,
		"超神关卡-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		1004,
		"超神关卡-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		1005,
		"超神关卡-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		1006,
		"超神关卡-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		1007,
		"超神关卡-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	}
}
local t_divine_super_dragon_clg_creeps_master = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[106] = dataList[6],
	[107] = dataList[7],
	[1001] = dataList[8],
	[1002] = dataList[9],
	[1003] = dataList[10],
	[1004] = dataList[11],
	[1005] = dataList[12],
	[1006] = dataList[13],
	[1007] = dataList[14]
}

t_divine_super_dragon_clg_creeps_master.dataList = dataList

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

return t_divine_super_dragon_clg_creeps_master
