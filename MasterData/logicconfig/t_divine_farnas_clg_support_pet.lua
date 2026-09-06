-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_farnas_clg_support_pet.lua

module("logicconfig.config.t_divine_farnas_clg_support_pet", package.seeall)

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
		522001,
		100000001,
		15037,
		"神曜终灭·法纳斯",
		100,
		"生命+287692#攻击+38681#物防+17769#魔防+17769#速度+7615",
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
local t_divine_farnas_clg_support_pet = {
	[522001] = {
		[100000001] = dataList[1]
	}
}

t_divine_farnas_clg_support_pet.dataList = dataList

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

return t_divine_farnas_clg_support_pet
