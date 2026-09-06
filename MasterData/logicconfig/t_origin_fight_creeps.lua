-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_creeps.lua

module("logicconfig.config.t_origin_fight_creeps", package.seeall)

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
		10345,
		"龙女·耶梦加得",
		6,
		100,
		"生命+72612#攻击+14695#物防+3933#魔防+3933#速度+4235",
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
		1001,
		2,
		11013,
		"神曜寒魄·冰灵王",
		2,
		100,
		"生命+133123#攻击+10373#物防+7866#魔防+7866#速度+2420",
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
		1001,
		3,
		11002,
		"神罚·秩序圣龙",
		8,
		100,
		"生命+60510#攻击+17721#物防+3630#魔防+3933#速度+3630",
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
		1001,
		4,
		10183,
		"炼狱·暗天使",
		9,
		100,
		"生命+87740#攻击+12966#物防+6051#魔防+6051#速度+3630",
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
		1001,
		5,
		11009,
		"神曜极睿·哆啦梦梦",
		3,
		100,
		"生命+133123#攻击+10373#物防+7866#魔防+7866#速度+2420",
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
		1001,
		6,
		10330,
		"灭世魔女·艾希",
		5,
		100,
		"生命+60510#攻击+17721#物防+3630#魔防+3933#速度+3630",
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
local t_origin_fight_creeps = {
	[1001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_fight_creeps.dataList = dataList

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

return t_origin_fight_creeps
