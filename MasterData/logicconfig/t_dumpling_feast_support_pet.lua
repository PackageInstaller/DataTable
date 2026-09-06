-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_support_pet.lua

module("logicconfig.config.t_dumpling_feast_support_pet", package.seeall)

local title = {
	loveDumpling = 5,
	onlyUseExtProperties = 10,
	creepsId = 2,
	carriedPetId = 15,
	faceId = 13,
	summonedPetId = 12,
	extproperties = 9,
	oraclePetId = 17,
	summonMasterId = 11,
	heavenAwakenSummonPetId = 19,
	buffPlanId = 6,
	maxIntimacyLimit = 7,
	heavenAwakenMasterId = 18,
	supportPetPlan = 1,
	creepsName = 4,
	raceId = 3,
	oracleMasterId = 16,
	lv = 8,
	carriedMasterId = 14
}
local dataList = {
	{
		1,
		100000001,
		18031,
		"瑞狐仙·创世神女",
		{
			1
		},
		1,
		600,
		100,
		"生命+1476923#攻击+298901#物防+80000#魔防+80000#速度+86153",
		true,
		"",
		"",
		"1803101",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1,
		100000002,
		12041,
		"待见春·无烬神女",
		{
			2
		},
		2,
		600,
		100,
		"生命+1230769#攻击+360439#物防+73846#魔防+80000#速度+73846",
		true,
		"",
		"",
		"1204105",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1,
		100000003,
		12044,
		"昆山主·末炎",
		{
			3
		},
		3,
		600,
		100,
		"生命+1230769#攻击+360439#物防+73846#魔防+80000#速度+73846",
		true,
		"",
		"",
		"1204402",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1,
		100000004,
		12045,
		"览浮光·火次元",
		{
			1
		},
		4,
		600,
		100,
		"生命+1230769#攻击+360439#物防+73846#魔防+80000#速度+73846",
		true,
		"",
		"",
		"1204503",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1,
		100000005,
		16028,
		"泽兽辞·诺亚",
		{
			2
		},
		5,
		600,
		100,
		"生命+1230769#攻击+360439#物防+80000#魔防+73846#速度+73846",
		true,
		"",
		"",
		"1602802",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1,
		100000006,
		16045,
		"垂珠泪·超神神女",
		{
			3
		},
		6,
		600,
		100,
		"生命+1230769#攻击+360439#物防+73846#魔防+80000#速度+73846",
		true,
		"",
		"",
		"1604503",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1,
		100000007,
		13028,
		"衔枝雀·永恒神女",
		{
			3
		},
		7,
		600,
		100,
		"生命+1230769#攻击+360439#物防+73846#魔防+80000#速度+73846",
		true,
		"",
		"",
		"1302803",
		0,
		0,
		0,
		0,
		"",
		""
	}
}
local t_dumpling_feast_support_pet = {
	{
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3],
		[100000004] = dataList[4],
		[100000005] = dataList[5],
		[100000006] = dataList[6],
		[100000007] = dataList[7]
	}
}

t_dumpling_feast_support_pet.dataList = dataList

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

return t_dumpling_feast_support_pet
