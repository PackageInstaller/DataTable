-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_milk_dragon_clg_creeps_master.lua

module("logicconfig.config.t_milk_dragon_clg_creeps_master", package.seeall)

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
		"关卡-1",
		5,
		"",
		"",
		211,
		0,
		411,
		208,
		"",
		""
	},
	{
		1002,
		"关卡-2",
		5,
		"",
		"",
		217,
		0,
		398,
		208,
		"",
		""
	},
	{
		1003,
		"关卡-3",
		5,
		"",
		"",
		214,
		0,
		397,
		208,
		"",
		""
	},
	{
		1004,
		"关卡-4",
		5,
		"",
		"",
		212,
		0,
		411,
		208,
		"",
		""
	},
	{
		1005,
		"关卡-5",
		5,
		"",
		"",
		218,
		0,
		398,
		208,
		"",
		""
	},
	{
		1006,
		"关卡-6",
		5,
		"",
		"",
		215,
		0,
		397,
		208,
		"",
		""
	},
	{
		1007,
		"关卡-7",
		5,
		"",
		"",
		213,
		0,
		411,
		208,
		"412023",
		""
	},
	{
		1008,
		"关卡-8",
		5,
		"",
		"",
		219,
		0,
		398,
		208,
		"416028",
		""
	},
	{
		1009,
		"关卡-9",
		5,
		"",
		"",
		216,
		0,
		397,
		208,
		"412027",
		""
	}
}
local t_milk_dragon_clg_creeps_master = {
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

t_milk_dragon_clg_creeps_master.dataList = dataList

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

return t_milk_dragon_clg_creeps_master
