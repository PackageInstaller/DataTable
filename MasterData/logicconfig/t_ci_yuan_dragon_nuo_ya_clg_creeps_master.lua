-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_dragon_nuo_ya_clg_creeps_master.lua

module("logicconfig.config.t_ci_yuan_dragon_nuo_ya_clg_creeps_master", package.seeall)

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
		"1-1",
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
		"1-2",
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
		"1-3",
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
		2001,
		"2-1",
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
		2002,
		"2-2",
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
		2003,
		"2-3",
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
		2004,
		"2-4",
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
		3001,
		"3-1",
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
		3002,
		"3-2",
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
		3003,
		"3-3",
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
		3004,
		"3-4",
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
		3005,
		"3-5",
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
local t_ci_yuan_dragon_nuo_ya_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[2001] = dataList[4],
	[2002] = dataList[5],
	[2003] = dataList[6],
	[2004] = dataList[7],
	[3001] = dataList[8],
	[3002] = dataList[9],
	[3003] = dataList[10],
	[3004] = dataList[11],
	[3005] = dataList[12]
}

t_ci_yuan_dragon_nuo_ya_clg_creeps_master.dataList = dataList

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

return t_ci_yuan_dragon_nuo_ya_clg_creeps_master
