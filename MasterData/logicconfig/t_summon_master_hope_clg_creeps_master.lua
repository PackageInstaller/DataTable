-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_hope_clg_creeps_master.lua

module("logicconfig.config.t_summon_master_hope_clg_creeps_master", package.seeall)

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
		1001,
		"关卡-1",
		5,
		"",
		"",
		0,
		0,
		334,
		0,
		""
	},
	{
		1002,
		"关卡-2",
		5,
		"",
		"",
		0,
		0,
		334,
		0,
		""
	},
	{
		1003,
		"关卡-3",
		5,
		"",
		"",
		0,
		0,
		334,
		0,
		""
	},
	{
		1004,
		"关卡-4",
		5,
		"",
		"",
		0,
		0,
		334,
		0,
		""
	},
	{
		1005,
		"关卡-5",
		5,
		"",
		"",
		0,
		0,
		334,
		0,
		""
	},
	{
		1006,
		"关卡-6",
		5,
		"",
		"",
		0,
		0,
		334,
		0,
		""
	}
}
local t_summon_master_hope_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_summon_master_hope_clg_creeps_master.dataList = dataList

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

return t_summon_master_hope_clg_creeps_master
