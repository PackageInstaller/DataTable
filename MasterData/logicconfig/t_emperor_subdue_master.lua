-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_emperor_subdue_master.lua

module("logicconfig.config.t_emperor_subdue_master", package.seeall)

local title = {
	skipTime = 3,
	heavenAwakenMasterId = 8,
	heavenAwakenSummonPetId = 9,
	formCondition = 6,
	name = 2,
	ruleDesc = 10,
	selfBuffProviderId = 5,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"降魔-1",
		5,
		0,
		0,
		220,
		"",
		"5",
		"6",
		""
	},
	{
		1002,
		"降魔-2",
		5,
		0,
		0,
		220,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"降魔-3",
		5,
		0,
		0,
		220,
		"",
		"",
		"",
		""
	},
	{
		1004,
		"降魔-4",
		5,
		0,
		0,
		220,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"降魔-5",
		5,
		0,
		0,
		220,
		"",
		"",
		"",
		""
	},
	{
		1006,
		"降魔-boss",
		5,
		117,
		0,
		220,
		"",
		"",
		"",
		"5个大回合内对boss造成尽可能多的伤害"
	},
	{
		1007,
		"降魔-boss",
		5,
		117,
		0,
		220,
		"",
		"",
		"",
		"5个大回合内对boss造成尽可能多的伤害"
	},
	{
		1008,
		"降魔-boss",
		5,
		117,
		0,
		220,
		"",
		"",
		"",
		"5个大回合内对boss造成尽可能多的伤害"
	},
	{
		1009,
		"降魔-boss",
		5,
		117,
		0,
		220,
		"",
		"",
		"",
		"5个大回合内对boss造成尽可能多的伤害"
	},
	{
		1010,
		"降魔-boss",
		5,
		117,
		0,
		220,
		"",
		"",
		"",
		"5个大回合内对boss造成尽可能多的伤害"
	}
}
local t_emperor_subdue_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10]
}

t_emperor_subdue_master.dataList = dataList

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

return t_emperor_subdue_master
