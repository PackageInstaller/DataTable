-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_rui_ke_clg_creeps_master.lua

module("logicconfig.config.t_divine_mi_rui_ke_clg_creeps_master", package.seeall)

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
		"1-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"416000",
		""
	},
	{
		1002,
		"1-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"413009",
		""
	},
	{
		1003,
		"1-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"414018",
		""
	},
	{
		1004,
		"2-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"415018",
		""
	},
	{
		1005,
		"2-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"412018",
		""
	},
	{
		1006,
		"2-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"411021",
		""
	},
	{
		1007,
		"3-1",
		5,
		"",
		"",
		186,
		0,
		0,
		192,
		"411012",
		""
	},
	{
		1008,
		"3-2",
		5,
		"",
		"",
		186,
		0,
		0,
		192,
		"417010",
		""
	},
	{
		1009,
		"3-3",
		5,
		"",
		"",
		186,
		0,
		0,
		192,
		"414020",
		""
	}
}
local t_divine_mi_rui_ke_clg_creeps_master = {
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

t_divine_mi_rui_ke_clg_creeps_master.dataList = dataList

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

return t_divine_mi_rui_ke_clg_creeps_master
