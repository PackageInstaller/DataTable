-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_clg_creeps_master.lua

module("logicconfig.config.t_boccaccio_clg_creeps_master", package.seeall)

local title = {
	skipTime = 3,
	name = 2,
	heavenAwakenSummonPetId = 11,
	formCondition = 7,
	retreatMsgType = 5,
	heavenAwakenMasterId = 10,
	ruleDesc = 9,
	selfBuffProviderId = 6,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 8
}
local dataList = {
	{
		1001,
		"薄伽丘-1",
		5,
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
		"薄伽丘-2",
		5,
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
		"薄伽丘-3",
		5,
		0,
		0,
		0,
		0,
		"",
		"",
		"5",
		"6"
	},
	{
		1004,
		"薄伽丘-4",
		5,
		0,
		0,
		0,
		0,
		"",
		"",
		"7",
		"8"
	},
	{
		1005,
		"薄伽丘-5",
		5,
		0,
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
		"薄伽丘-6",
		5,
		0,
		0,
		0,
		0,
		"",
		"",
		"6",
		"7"
	}
}
local t_boccaccio_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_boccaccio_clg_creeps_master.dataList = dataList

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

return t_boccaccio_clg_creeps_master
