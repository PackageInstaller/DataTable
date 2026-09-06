-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_farnas_clg_creeps_master.lua

module("logicconfig.config.t_farnas_clg_creeps_master", package.seeall)

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
		"全民挑战-1-1",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		102,
		"全民挑战-1-2",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		103,
		"全民挑战-1-3",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		104,
		"全民挑战-2-1",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		105,
		"全民挑战-2-2",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		106,
		"全民挑战-2-3",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		107,
		"全民挑战-3-1",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		108,
		"全民挑战-3-2",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		109,
		"全民挑战-3-3",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		1001,
		"极限挑战-1",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		1002,
		"极限挑战-2",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		1003,
		"极限挑战-3",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		1004,
		"极限挑战-4",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		1005,
		"极限挑战-5",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	},
	{
		1006,
		"极限挑战-6",
		5,
		"",
		"",
		0,
		0,
		230,
		0,
		""
	}
}
local t_farnas_clg_creeps_master = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[106] = dataList[6],
	[107] = dataList[7],
	[108] = dataList[8],
	[109] = dataList[9],
	[1001] = dataList[10],
	[1002] = dataList[11],
	[1003] = dataList[12],
	[1004] = dataList[13],
	[1005] = dataList[14],
	[1006] = dataList[15]
}

t_farnas_clg_creeps_master.dataList = dataList

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

return t_farnas_clg_creeps_master
