-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hero_trial_boss_creeps.lua

module("logicconfig.config.t_hero_trial_boss_creeps", package.seeall)

local title = {
	awakenLv = 8,
	raceId = 3,
	creepsId = 2,
	onlyUseExtProperties = 11,
	faceId = 14,
	summonedPetId = 13,
	posId = 5,
	summonMasterId = 12,
	equipment = 9,
	creepsName = 4,
	talentLv = 7,
	extproperties = 10,
	creepsMasterId = 1,
	lv = 6
}
local dataList = {
	{
		1,
		1,
		90016,
		"撒古特",
		2,
		50,
		4,
		0,
		"",
		"生命+80000000#攻击+12000#物防+300#魔防+300#速度+1000",
		true,
		"",
		"",
		""
	},
	{
		1,
		2,
		90016,
		"撒古特",
		5,
		50,
		4,
		0,
		"",
		"生命+80000000#攻击+12000#物防+300#魔防+300#速度+1000",
		true,
		"",
		"",
		""
	},
	{
		1,
		3,
		90202,
		"真元玄武",
		8,
		50,
		4,
		0,
		"",
		"生命+80000000#攻击+15000#物防+300#魔防+300#速度+1000",
		true,
		"",
		"",
		""
	},
	{
		2,
		1,
		90016,
		"撒古特",
		2,
		60,
		5,
		0,
		"",
		"生命+80000000#攻击+16000#物防+400#魔防+400#速度+1500",
		true,
		"",
		"",
		""
	},
	{
		2,
		2,
		90016,
		"撒古特",
		5,
		60,
		5,
		0,
		"",
		"生命+80000000#攻击+16000#物防+400#魔防+400#速度+1500",
		true,
		"",
		"",
		""
	},
	{
		2,
		3,
		90318,
		"砂隐尊主·阿米尔",
		8,
		60,
		5,
		0,
		"",
		"生命+80000000#攻击+32000#物防+400#魔防+400#速度+1500",
		true,
		"",
		"",
		""
	},
	{
		3,
		1,
		90016,
		"撒古特",
		2,
		70,
		6,
		0,
		"",
		"生命+80000000#攻击+20000#物防+500#魔防+500#速度+1800",
		true,
		"",
		"",
		""
	},
	{
		3,
		2,
		90016,
		"撒古特",
		5,
		70,
		6,
		0,
		"",
		"生命+80000000#攻击+20000#物防+500#魔防+500#速度+1800",
		true,
		"",
		"",
		""
	},
	{
		3,
		3,
		90352,
		"天女武神·狄丝",
		8,
		70,
		6,
		0,
		"",
		"生命+80000000#攻击+40000#物防+500#魔防+500#速度+1800",
		true,
		"",
		"",
		""
	},
	{
		4,
		1,
		90016,
		"撒古特",
		2,
		80,
		7,
		0,
		"",
		"生命+80000000#攻击+24000#物防+600#魔防+600#速度+2000",
		true,
		"",
		"",
		""
	},
	{
		4,
		2,
		90016,
		"撒古特",
		5,
		80,
		7,
		0,
		"",
		"生命+80000000#攻击+24000#物防+600#魔防+600#速度+2000",
		true,
		"",
		"",
		""
	},
	{
		4,
		3,
		90144,
		"生命王者·阿瑞斯",
		8,
		80,
		7,
		0,
		"",
		"生命+80000000#攻击+48000#物防+600#魔防+600#速度+2000",
		true,
		"",
		"",
		""
	}
}
local t_hero_trial_boss_creeps = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_hero_trial_boss_creeps.dataList = dataList

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

return t_hero_trial_boss_creeps
