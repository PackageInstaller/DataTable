-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_psychic_ji_master.lua

module("logicconfig.config.t_origin_psychic_ji_master", package.seeall)

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
		"源起通灵极-1",
		5,
		0,
		0,
		0,
		"",
		"5",
		"6",
		""
	},
	{
		1002,
		"源起通灵极-2",
		5,
		0,
		0,
		0,
		"",
		"5",
		"6",
		""
	},
	{
		1003,
		"源起通灵极-3",
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
		"源起通灵极-4",
		5,
		0,
		0,
		0,
		"",
		"8",
		"9",
		""
	},
	{
		1005,
		"源起通灵极-5",
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
		1006,
		"源起通灵极全民-1",
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
		"源起通灵极全民-2",
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
		"源起通灵极全民-3",
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
		1009,
		"源起通灵极全民-4",
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
		1010,
		"源起通灵极全民-5",
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
local t_origin_psychic_ji_master = {
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

t_origin_psychic_ji_master.dataList = dataList

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

return t_origin_psychic_ji_master
