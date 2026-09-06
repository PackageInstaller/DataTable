-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_hall_support_pet.lua

module("logicconfig.config.t_star_hall_support_pet", package.seeall)

local title = {
	activityId = 1,
	heavenAwakenMasterId = 15,
	creepsId = 2,
	onlyUseExtProperties = 7,
	faceId = 10,
	summonedPetId = 9,
	carriedPetId = 12,
	oraclePetId = 14,
	summonMasterId = 8,
	creepsName = 4,
	raceId = 3,
	heavenAwakenSummonPetId = 16,
	extproperties = 6,
	oracleMasterId = 13,
	lv = 5,
	carriedMasterId = 11
}
local dataList = {
	{
		494001,
		100000001,
		16035,
		"神曜圣谕·女帝",
		100,
		"生命+4659487#攻击+363077#物防+275333#魔防+275333#速度+84718",
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
		494001,
		100000002,
		16036,
		"神曜创物·以撒",
		100,
		"生命+2117949#攻击+620256#物防+137667#魔防+127077#速度+127077",
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
		494002,
		100000001,
		16035,
		"神曜圣谕·女帝",
		100,
		"生命+4659487#攻击+363077#物防+275333#魔防+275333#速度+84718",
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
		494002,
		100000002,
		16036,
		"神曜创物·以撒",
		100,
		"生命+2117949#攻击+620256#物防+137667#魔防+127077#速度+127077",
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
		494002,
		100000003,
		16037,
		"神曜缚灵·费因",
		100,
		"生命+2117949#攻击+620256#物防+127077#魔防+137667#速度+127077",
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
local t_star_hall_support_pet = {
	[494001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2]
	},
	[494002] = {
		[100000001] = dataList[3],
		[100000002] = dataList[4],
		[100000003] = dataList[5]
	}
}

t_star_hall_support_pet.dataList = dataList

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

return t_star_hall_support_pet
