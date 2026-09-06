-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_endless_dark_clg_support_pet.lua

module("logicconfig.config.t_endless_dark_clg_support_pet", package.seeall)

local title = {
	supportPetPoolId = 3,
	onlyUseExtProperties = 8,
	creepsId = 2,
	carriedPetId = 13,
	faceId = 11,
	summonedPetId = 10,
	raceId = 4,
	heavenAwakenSummonPetId = 17,
	summonMasterId = 9,
	activityId = 1,
	heavenAwakenMasterId = 16,
	oraclePetId = 15,
	creepsName = 5,
	extproperties = 7,
	oracleMasterId = 14,
	lv = 6,
	carriedMasterId = 12
}
local dataList = {
	{
		555001,
		100000001,
		1,
		13026,
		"生息永恒·阿瑞斯",
		100,
		"生命+1353846#攻击+147692#物防+80000#魔防+80000#速度+24615",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		555001,
		100000002,
		1,
		13023,
		"神曜天衍·昆仑",
		100,
		"生命+615385#攻击+252308#物防+40000#魔防+36923#速度+36923",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		555001,
		100000003,
		1,
		16033,
		"神曜王者·极",
		100,
		"生命+1046154#攻击+196923#物防+64615#魔防+64615#速度+27692",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		555001,
		100000004,
		1,
		13024,
		"神曜圣骑·万象迷踪",
		100,
		"生命+1353846#攻击+147692#物防+80000#魔防+80000#速度+24615",
		true,
		"",
		"100000005",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		555001,
		100000005,
		1,
		12031,
		"神曜圣骑·红莲烈心",
		100,
		"生命+615385#攻击+252308#物防+36923#魔防+40000#速度+36923",
		true,
		"100000004",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		555001,
		100000006,
		1,
		13022,
		"神曜不朽·永恒圣龙",
		100,
		"生命+615385#攻击+252308#物防+36923#魔防+40000#速度+36923",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		555001,
		100000007,
		1,
		12038,
		"神曜焚劫·终绯",
		100,
		"生命+1046154#攻击+196923#物防+64615#魔防+64615#速度+27692",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		555001,
		100000008,
		1,
		14037,
		"神曜王者·时空龙尊",
		100,
		"生命+615385#攻击+252308#物防+40000#魔防+36923#速度+36923",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		555001,
		100000009,
		1,
		11030,
		"神曜吞天·兰德斯",
		100,
		"生命+1353846#攻击+147692#物防+80000#魔防+80000#速度+24615",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		555001,
		100000010,
		1,
		12033,
		"神曜虚无·伏妖",
		100,
		"生命+615385#攻击+252308#物防+36923#魔防+40000#速度+36923",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	}
}
local t_endless_dark_clg_support_pet = {
	[555001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3],
		[100000004] = dataList[4],
		[100000005] = dataList[5],
		[100000006] = dataList[6],
		[100000007] = dataList[7],
		[100000008] = dataList[8],
		[100000009] = dataList[9],
		[100000010] = dataList[10]
	}
}

t_endless_dark_clg_support_pet.dataList = dataList

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

return t_endless_dark_clg_support_pet
