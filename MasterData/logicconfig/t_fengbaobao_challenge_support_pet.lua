-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fengbaobao_challenge_support_pet.lua

module("logicconfig.config.t_fengbaobao_challenge_support_pet", package.seeall)

local title = {
	awakenLv = 9,
	isFixedPos = 3,
	creepsId = 2,
	supportPlanId = 1,
	faceId = 15,
	summonedPetId = 14,
	talentLv = 8,
	onlyUseExtProperties = 12,
	equipment = 10,
	creepsName = 5,
	summonMasterId = 13,
	extproperties = 11,
	raceId = 4,
	posId = 6,
	lv = 7
}
local dataList = {
	{
		1001,
		10000001,
		false,
		10380,
		"冯宝宝",
		5,
		100,
		0,
		0,
		"",
		"生命+23076#攻击+6538#物防+1250#魔防+1250#速度+1346",
		true,
		"",
		"",
		""
	}
}
local t_fengbaobao_challenge_support_pet = {
	[1001] = {
		[10000001] = dataList[1]
	}
}

t_fengbaobao_challenge_support_pet.dataList = dataList

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

return t_fengbaobao_challenge_support_pet
