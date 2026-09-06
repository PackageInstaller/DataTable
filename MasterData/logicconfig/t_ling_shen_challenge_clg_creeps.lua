-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_challenge_clg_creeps.lua

module("logicconfig.config.t_ling_shen_challenge_clg_creeps", package.seeall)

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
		93005,
		"赫魔莉·青骨",
		5,
		100,
		"生命+2000000000#攻击+500000#物防+0#魔防+0#速度+5000",
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
		97001,
		"梦魇始魔·莱莉丝",
		5,
		100,
		"生命+2000000000#攻击+500000#物防+0#魔防+0#速度+5000",
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
		97004,
		"暗祭·达克诺斯",
		5,
		100,
		"生命+2000000000#攻击+500000#物防+0#魔防+0#速度+5000",
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
		96010,
		"离阳龙脉·敖九",
		5,
		100,
		"生命+2000000000#攻击+500000#物防+0#魔防+0#速度+5000",
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
		95029,
		"瘟疫魔君·娜克亚",
		5,
		100,
		"生命+2000000000#攻击+500000#物防+0#魔防+0#速度+5000",
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
		91025,
		"饥荒魔君·古拉丝",
		5,
		100,
		"生命+2000000000#攻击+500000#物防+0#魔防+0#速度+5000",
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
		93021,
		"神曜混元·真龙",
		5,
		100,
		"生命+2000000000#攻击+500000#物防+0#魔防+0#速度+5000",
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
local t_ling_shen_challenge_clg_creeps = {
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
	}
}

t_ling_shen_challenge_clg_creeps.dataList = dataList

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

return t_ling_shen_challenge_clg_creeps
