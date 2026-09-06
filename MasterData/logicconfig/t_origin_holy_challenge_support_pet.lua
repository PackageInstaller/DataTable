-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_holy_challenge_support_pet.lua

module("logicconfig.config.t_origin_holy_challenge_support_pet", package.seeall)

local title = {
	raceId = 2,
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
	extproperties = 5,
	oracleMasterId = 12,
	lv = 4,
	carriedMasterId = 10
}
local dataList = {
	{
		100000001,
		14049,
		"凌空引啸·圣光飞龙",
		100,
		"生命+1476923#攻击+418462#物防+80000#魔防+80000#速度+86154",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"0",
		"0"
	}
}
local t_origin_holy_challenge_support_pet = {
	[100000001] = dataList[1]
}

t_origin_holy_challenge_support_pet.dataList = dataList

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

return t_origin_holy_challenge_support_pet
