-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bone_dragon_dungeon_pet_shop.lua

module("logicconfig.config.t_bone_dragon_dungeon_pet_shop", package.seeall)

local title = {
	shopPosId = 2,
	price = 3,
	creepsId = 4,
	onlyUseExtProperties = 12,
	faceId = 15,
	summonedPetId = 14,
	talentLv = 8,
	extproperties = 11,
	summonMasterId = 13,
	carriedPetId = 17,
	activityId = 1,
	awakenLv = 9,
	equipment = 10,
	creepsName = 6,
	raceId = 5,
	lv = 7,
	carriedMasterId = 16
}
local dataList = {
	{
		490001,
		1,
		"10:490002:160",
		100000001,
		16035,
		"神曜圣谕·女帝",
		100,
		0,
		0,
		"",
		"生命+2436923#攻击+189890#物防+144000#魔防+144000#速度+44307",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		490001,
		2,
		"10:490002:160",
		100000002,
		16036,
		"神曜创物·以撒",
		100,
		0,
		0,
		"",
		"生命+1107692#攻击+324395#物防+72000#魔防+66461#速度+66461",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		490001,
		3,
		"10:490002:160",
		100000003,
		16037,
		"神曜缚灵·费因",
		100,
		0,
		0,
		"",
		"生命+1107692#攻击+324395#物防+66461#魔防+72000#速度+66461",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		490001,
		4,
		"10:490002:160",
		100000004,
		16038,
		"乐律之神·音织",
		100,
		0,
		0,
		"",
		"生命+2436923#攻击+189890#物防+144000#魔防+144000#速度+44307",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		490001,
		5,
		"10:490002:160",
		100000005,
		16039,
		"天恩圣祭·空灵圣龙",
		100,
		0,
		0,
		"",
		"生命+1107692#攻击+324395#物防+66461#魔防+72000#速度+66461",
		true,
		"",
		"",
		"1603901",
		0,
		0
	}
}
local t_bone_dragon_dungeon_pet_shop = {
	[490001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_bone_dragon_dungeon_pet_shop.dataList = dataList

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

return t_bone_dragon_dungeon_pet_shop
