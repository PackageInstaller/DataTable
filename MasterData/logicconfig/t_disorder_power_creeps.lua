-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_power_creeps.lua

module("logicconfig.config.t_disorder_power_creeps", package.seeall)

local title = {
	onlyUseExtProperties = 8,
	raceId = 3,
	creepsId = 2,
	carriedPetId = 13,
	faceId = 11,
	summonedPetId = 10,
	posId = 5,
	psychicedNormalSkillLv = 19,
	summonMasterId = 9,
	psychicedUltimateSkillLv = 20,
	creepsMasterId = 1,
	normalSkillLv = 16,
	passiveSkillLv = 18,
	oraclePetId = 15,
	ultimateSkillLv = 17,
	creepsName = 4,
	extproperties = 7,
	oracleMasterId = 14,
	lv = 6,
	carriedMasterId = 12
}
local dataList = {
	{
		1001,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1002,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1003,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1004,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1005,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1006,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1007,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1008,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1009,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1010,
		1,
		96030,
		"神曜无序·昧",
		5,
		100,
		"生命+50000000#攻击+200000#物防+0#魔防+0#速度+1000000",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
}
local t_disorder_power_creeps = {
	[1001] = {
		dataList[1]
	},
	[1002] = {
		dataList[2]
	},
	[1003] = {
		dataList[3]
	},
	[1004] = {
		dataList[4]
	},
	[1005] = {
		dataList[5]
	},
	[1006] = {
		dataList[6]
	},
	[1007] = {
		dataList[7]
	},
	[1008] = {
		dataList[8]
	},
	[1009] = {
		dataList[9]
	},
	[1010] = {
		dataList[10]
	}
}

t_disorder_power_creeps.dataList = dataList

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

return t_disorder_power_creeps
