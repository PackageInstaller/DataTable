-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bone_dragon_clg_creeps_master.lua

module("logicconfig.config.t_bone_dragon_clg_creeps_master", package.seeall)

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
		"空灵-1",
		5,
		"",
		"",
		0,
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
		"空灵-2",
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
		"空灵-3",
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
		"6"
	},
	{
		1004,
		"空灵-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"412029",
		"",
		"",
		""
	},
	{
		1005,
		"空灵-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"3",
		"6"
	},
	{
		1006,
		"空灵-6",
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
		"6"
	}
}
local t_bone_dragon_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_bone_dragon_clg_creeps_master.dataList = dataList

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

return t_bone_dragon_clg_creeps_master
