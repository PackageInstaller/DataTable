-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_help_pet.lua

module("logicconfig.config.t_canton_opera_road_help_pet", package.seeall)

local title = {
	awakenLv = 6,
	talentLv = 5,
	creepsId = 1,
	onlyUseExtProperties = 10,
	faceId = 13,
	summonedPetId = 12,
	posId = 7,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 3,
	extproperties = 9,
	isFixedPos = 14,
	raceId = 2,
	lv = 4
}
local dataList = {
	{
		1000000001,
		10099,
		"战神·天蛮王",
		100,
		0,
		0,
		5,
		"",
		"生命+1046159#攻击+196924#物防+64615#魔防+64615#速度+27692",
		true,
		"",
		"",
		"1009901",
		true
	},
	{
		1000000002,
		10167,
		"梦蝶·潘多拉",
		100,
		0,
		0,
		5,
		"",
		"生命+615387#攻击+252308#物防+36923#魔防+40000#速度+36923",
		true,
		"",
		"",
		"1016702",
		true
	},
	{
		1000000003,
		13003,
		"生命神祇·阿瑞斯",
		100,
		0,
		0,
		5,
		"",
		"生命+1046159#攻击+196924#物防+64615#魔防+64615#速度+27692",
		true,
		"",
		"",
		"1300301",
		true
	},
	{
		1000000004,
		17003,
		"天元·王者圣龙",
		100,
		0,
		0,
		5,
		"",
		"生命+615387#攻击+252308#物防+36923#魔防+40000#速度+36923",
		true,
		"",
		"",
		"1700301",
		true
	}
}
local t_canton_opera_road_help_pet = {
	[1000000001] = dataList[1],
	[1000000002] = dataList[2],
	[1000000003] = dataList[3],
	[1000000004] = dataList[4]
}

t_canton_opera_road_help_pet.dataList = dataList

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

return t_canton_opera_road_help_pet
