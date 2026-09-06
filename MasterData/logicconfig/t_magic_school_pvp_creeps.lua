-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_pvp_creeps.lua

module("logicconfig.config.t_magic_school_pvp_creeps", package.seeall)

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
		95032,
		"绝命终焉·路因加德",
		5,
		100,
		"生命+2000000000#攻击+300000#物防+0#魔防+0#速度+0",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		5,
		5,
		1,
		0,
		0
	},
	{
		1002,
		1,
		94023,
		"希望之神·夏因",
		5,
		100,
		"生命+2000000000#攻击+300000#物防+0#魔防+0#速度+0",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		5,
		5,
		1,
		0,
		0
	},
	{
		1003,
		1,
		92020,
		"六道之祸·终绯",
		5,
		100,
		"生命+2000000000#攻击+300000#物防+0#魔防+0#速度+0",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		5,
		5,
		1,
		0,
		0
	}
}
local t_magic_school_pvp_creeps = {
	[1001] = {
		dataList[1]
	},
	[1002] = {
		dataList[2]
	},
	[1003] = {
		dataList[3]
	}
}

t_magic_school_pvp_creeps.dataList = dataList

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

return t_magic_school_pvp_creeps
