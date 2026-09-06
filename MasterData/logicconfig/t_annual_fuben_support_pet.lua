-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_support_pet.lua

module("logicconfig.config.t_annual_fuben_support_pet", package.seeall)

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
		546001,
		100000001,
		1,
		16041,
		"荣冕之志·极",
		100,
		"生命+2615385#攻击+351649#物防+161538#魔防+161538#速度+69231",
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
		546001,
		100000002,
		1,
		16042,
		"悟命天星·梵天",
		100,
		"生命+1538462#攻击+450549#物防+92308#魔防+100000#速度+92308",
		true,
		"100000003",
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
		546001,
		100000003,
		1,
		16043,
		"天演学神·帝一鸣",
		100,
		"生命+3384615#攻击+263736#物防+200000#魔防+200000#速度+61538",
		true,
		"",
		"100000002",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		546001,
		100000004,
		1,
		16040,
		"神曜离阳·敖九",
		100,
		"生命+2615385#攻击+351649#物防+161538#魔防+161538#速度+69231",
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
		546001,
		100000005,
		1,
		16039,
		"天恩圣祭·空灵圣龙",
		100,
		"生命+1538462#攻击+450549#物防+92308#魔防+100000#速度+92308",
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
		546001,
		100000006,
		1,
		18021,
		"创世神源·斐希司",
		100,
		"生命+3384615#攻击+263736#物防+200000#魔防+200000#速度+61538",
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
local t_annual_fuben_support_pet = {
	[546001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3],
		[100000004] = dataList[4],
		[100000005] = dataList[5],
		[100000006] = dataList[6]
	}
}

t_annual_fuben_support_pet.dataList = dataList

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

return t_annual_fuben_support_pet
