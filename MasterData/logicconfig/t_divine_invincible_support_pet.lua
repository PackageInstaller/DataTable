-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_invincible_support_pet.lua

module("logicconfig.config.t_divine_invincible_support_pet", package.seeall)

local title = {
	awakenLv = 7,
	creepsId = 1,
	normalPlanId = 2,
	onlyUseExtProperties = 10,
	faceId = 13,
	summonedPetId = 12,
	talentLv = 6,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 4,
	extproperties = 9,
	raceId = 3,
	lv = 5
}
local dataList = {
	{
		100000001,
		1,
		14032,
		"神曜战狂·无敌",
		100,
		0,
		0,
		"",
		"生命+181538#攻击+53164#物防+11800#魔防+10892#速度+10892",
		true,
		"",
		"",
		""
	}
}
local t_divine_invincible_support_pet = {
	[100000001] = dataList[1]
}

t_divine_invincible_support_pet.dataList = dataList

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

return t_divine_invincible_support_pet
