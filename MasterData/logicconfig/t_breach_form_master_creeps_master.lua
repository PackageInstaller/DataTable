-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_form_master_creeps_master.lua

module("logicconfig.config.t_breach_form_master_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 13,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 12,
	ruleDesc = 11,
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
		"破阵宗师-1",
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
		""
	},
	{
		1002,
		"破阵宗师-2",
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
		""
	},
	{
		1003,
		"破阵宗师-3",
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
		""
	},
	{
		1004,
		"破阵宗师-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"6",
		"7"
	},
	{
		1005,
		"破阵宗师-5",
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
		""
	},
	{
		1006,
		"破阵宗师-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"5",
		"7"
	},
	{
		1007,
		"破阵宗师-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"4",
		"7"
	},
	{
		1008,
		"破阵宗师-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"5",
		"8"
	},
	{
		1009,
		"破阵宗师-9",
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
		""
	}
}
local t_breach_form_master_creeps_master = {
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

t_breach_form_master_creeps_master.dataList = dataList

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

return t_breach_form_master_creeps_master
