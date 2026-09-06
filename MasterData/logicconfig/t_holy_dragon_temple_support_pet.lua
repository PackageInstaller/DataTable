-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_temple_support_pet.lua

module("logicconfig.config.t_holy_dragon_temple_support_pet", package.seeall)

local title = {
	awakenLv = 7,
	extproperties = 9,
	creepsId = 2,
	supportPetPlan = 1,
	faceId = 13,
	summonedPetId = 12,
	talentLv = 6,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 4,
	onlyUseExtProperties = 10,
	raceId = 3,
	lv = 5
}
local dataList = {
	{
		1,
		100000001,
		14049,
		"凌空引啸·圣光飞龙",
		100,
		0,
		0,
		"",
		"生命+1550769#攻击+439385#物防+84000#魔防+84000#速度+90462",
		true,
		"",
		"",
		""
	}
}
local t_holy_dragon_temple_support_pet = {
	{
		[100000001] = dataList[1]
	}
}

t_holy_dragon_temple_support_pet.dataList = dataList

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

return t_holy_dragon_temple_support_pet
