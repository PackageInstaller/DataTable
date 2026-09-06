-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_creeps.lua

module("logicconfig.config.t_dumpling_feast_creeps", package.seeall)

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
		92041,
		"怒焰临渊·无烬",
		5,
		100,
		"生命+2000000000#攻击+500000#物防+100000#魔防+100000#速度+0",
		true,
		"",
		"",
		"9204106",
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
local t_dumpling_feast_creeps = {
	[1001] = {
		dataList[1]
	}
}

t_dumpling_feast_creeps.dataList = dataList

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

return t_dumpling_feast_creeps
