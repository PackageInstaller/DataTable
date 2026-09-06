-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_xingjiang_master.lua

module("logicconfig.config.t_origin_xingjiang_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 12,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 11,
	ruleDesc = 13,
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
		"源起星绛挑战-1",
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
		"源起星绛挑战-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"6",
		"7",
		""
	},
	{
		1003,
		"源起星绛挑战-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"6",
		"7",
		""
	},
	{
		1004,
		"源起星绛挑战-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"6",
		"7",
		""
	},
	{
		1005,
		"源起星绛挑战-5",
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
		"源起星绛挑战-6",
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
local t_origin_xingjiang_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_origin_xingjiang_master.dataList = dataList

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

return t_origin_xingjiang_master
