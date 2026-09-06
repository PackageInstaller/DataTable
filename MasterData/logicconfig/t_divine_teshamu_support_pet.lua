-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_teshamu_support_pet.lua

module("logicconfig.config.t_divine_teshamu_support_pet", package.seeall)

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
		504001,
		100000001,
		11032,
		"神曜御统·特莎姆",
		100,
		0,
		0,
		"",
		"生命+461538#攻击+135165#物防+30000#魔防+27692#速度+27692",
		true,
		"",
		"",
		""
	},
	{
		504001,
		100000002,
		11032,
		"神曜御统·特莎姆",
		100,
		0,
		0,
		"",
		"生命+923077#攻击+270330#物防+60000#魔防+55385#速度+55385",
		true,
		"",
		"",
		""
	},
	{
		504001,
		100000003,
		11032,
		"神曜御统·特莎姆",
		100,
		0,
		0,
		"",
		"生命+1846154#攻击+540659#物防+120000#魔防+110769#速度+110769",
		true,
		"",
		"",
		""
	}
}
local t_divine_teshamu_support_pet = {
	[504001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3]
	}
}

t_divine_teshamu_support_pet.dataList = dataList

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

return t_divine_teshamu_support_pet
