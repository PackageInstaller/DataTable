-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_empress_normal_clg_support_pet.lua

module("logicconfig.config.t_divine_empress_normal_clg_support_pet", package.seeall)

local title = {
	awakenLv = 7,
	lv = 5,
	creepsId = 2,
	onlyUseExtProperties = 10,
	faceId = 13,
	summonedPetId = 12,
	talentLv = 6,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 4,
	extproperties = 9,
	raceId = 3,
	activityId = 1
}
local dataList = {
	{
		485001,
		100000001,
		16035,
		"神曜圣谕·女帝",
		100,
		0,
		0,
		"",
		"生命+372307#攻击+29011#物防+22000#魔防+22000#速度+6769",
		true,
		"",
		"",
		""
	}
}
local t_divine_empress_normal_clg_support_pet = {
	[485001] = {
		[100000001] = dataList[1]
	}
}

t_divine_empress_normal_clg_support_pet.dataList = dataList

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

return t_divine_empress_normal_clg_support_pet
