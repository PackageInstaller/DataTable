-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bone_dragon_clg_support_pet.lua

module("logicconfig.config.t_bone_dragon_clg_support_pet", package.seeall)

local title = {
	petEffect = 16,
	heavenAwakenMasterId = 14,
	creepsId = 1,
	onlyUseExtProperties = 6,
	faceId = 9,
	summonedPetId = 8,
	oraclePetId = 13,
	carriedPetId = 11,
	summonMasterId = 7,
	creepsName = 3,
	heavenAwakenSummonPetId = 15,
	raceId = 2,
	extproperties = 5,
	oracleMasterId = 12,
	lv = 4,
	carriedMasterId = 10
}
local dataList = {
	{
		100000001,
		13022,
		"神曜不朽·永恒圣龙",
		100,
		"生命+1169230#攻击+342417#物防+70153#魔防+76000#速度+70153",
		true,
		"",
		"",
		"1302201",
		0,
		0,
		0,
		0,
		"",
		"",
		""
	},
	{
		100000002,
		16034,
		"神曜圣裁·双生圣龙",
		100,
		"生命+1403076#攻击+283956#物防+76000#魔防+76000#速度+81846",
		true,
		"",
		"",
		"1603404",
		0,
		0,
		0,
		0,
		"",
		"",
		""
	},
	{
		100000003,
		11028,
		"浊流千幻·命渊圣龙",
		100,
		"生命+1169230#攻击+342417#物防+70153#魔防+76000#速度+70153",
		true,
		"",
		"",
		"1102801",
		0,
		0,
		0,
		0,
		"",
		"",
		""
	}
}
local t_bone_dragon_clg_support_pet = {
	[100000001] = dataList[1],
	[100000002] = dataList[2],
	[100000003] = dataList[3]
}

t_bone_dragon_clg_support_pet.dataList = dataList

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

return t_bone_dragon_clg_support_pet
