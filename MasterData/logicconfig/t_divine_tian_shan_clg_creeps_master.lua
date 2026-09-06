-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tian_shan_clg_creeps_master.lua

module("logicconfig.config.t_divine_tian_shan_clg_creeps_master", package.seeall)

local title = {
	skipTime = 3,
	ruleDesc = 8,
	heavenAwakenSummonPetId = 10,
	formCondition = 6,
	heavenAwakenMasterId = 9,
	name = 2,
	selfBuffProviderId = 5,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"神曜天闪阵-1",
		5,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"神曜天闪阵-2",
		5,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"神曜天闪阵-3",
		5,
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
		"神曜天闪阵-4",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"神曜天闪阵-5",
		5,
		0,
		0,
		0,
		"",
		"",
		"5",
		"6"
	},
	{
		1006,
		"神曜天闪阵-6",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1007,
		"神曜天闪阵-7",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1008,
		"神曜天闪阵-8",
		5,
		0,
		0,
		0,
		"",
		"",
		"5",
		"6"
	},
	{
		201,
		"风暴领主",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		202,
		"闪电领主",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		203,
		"骤雨领主",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		204,
		"冰雹领主",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	}
}
local t_divine_tian_shan_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[201] = dataList[9],
	[202] = dataList[10],
	[203] = dataList[11],
	[204] = dataList[12]
}

t_divine_tian_shan_clg_creeps_master.dataList = dataList

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

return t_divine_tian_shan_clg_creeps_master
