-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_creeps.lua

module("logicconfig.config.t_armor_hero_creeps", package.seeall)

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
		97014,
		"神曜天元·王者圣龙",
		5,
		100,
		"生命+1500000000#攻击+100000#物防+50000#魔防+50000#速度+0",
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
		92021,
		"神曜烈焰·无烬圣龙",
		5,
		100,
		"生命+1500000000#攻击+100000#物防+50000#魔防+50000#速度+0",
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
local t_armor_hero_creeps = {
	[1001] = {
		dataList[1]
	},
	[1002] = {
		dataList[2]
	}
}

t_armor_hero_creeps.dataList = dataList

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

return t_armor_hero_creeps
