-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sword_storm_creeps.lua

module("logicconfig.config.t_sword_storm_creeps", package.seeall)

local title = {
	onlyUseExtProperties = 8,
	raceId = 3,
	creepsId = 2,
	carriedPetId = 14,
	faceId = 12,
	summonedPetId = 10,
	posId = 5,
	normalSkillLv = 17,
	summonMasterId = 9,
	psychicedNormalSkillLv = 20,
	psychicedUltimateSkillLv = 21,
	creepsMasterId = 1,
	extBuffs = 11,
	passiveSkillLv = 19,
	oraclePetId = 16,
	ultimateSkillLv = 18,
	creepsName = 4,
	extproperties = 7,
	oracleMasterId = 15,
	lv = 6,
	carriedMasterId = 13
}
local dataList = {
	{
		1001,
		1,
		97025,
		"通灵秘源·究",
		5,
		100,
		"生命+2000000000#攻击+300000#物防+100000#魔防+100000#速度+0",
		true,
		"",
		"",
		"20072101:99#20072102:99",
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
		97026,
		"万刃殁锋·殒劫圣龙",
		5,
		100,
		"生命+2000000000#攻击+300000#物防+100000#魔防+100000#速度+0",
		true,
		"",
		"",
		"20072103:99",
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
		97015,
		"神曜权御·龙尊圣主",
		5,
		100,
		"生命+2000000000#攻击+300000#物防+100000#魔防+100000#速度+0",
		true,
		"",
		"",
		"20072101:99#20072102:99",
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
		97027,
		"虚骸噬灭·薄伽丘",
		5,
		100,
		"生命+2000000000#攻击+300000#物防+100000#魔防+100000#速度+0",
		true,
		"",
		"",
		"20072101:99#20072102:99",
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
		93030,
		"苍青圣骑·阿特拉斯",
		5,
		100,
		"生命+2000000000#攻击+300000#物防+100000#魔防+100000#速度+0",
		true,
		"",
		"",
		"20072101:99#20072102:99",
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
		97028,
		"万相同观·权天使",
		5,
		100,
		"生命+2000000000#攻击+300000#物防+100000#魔防+100000#速度+0",
		true,
		"",
		"",
		"20072103:99",
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
local t_sword_storm_creeps = {
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
	}
}

t_sword_storm_creeps.dataList = dataList

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

return t_sword_storm_creeps
