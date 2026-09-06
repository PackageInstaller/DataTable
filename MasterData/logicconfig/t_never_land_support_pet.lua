-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_never_land_support_pet.lua

module("logicconfig.config.t_never_land_support_pet", package.seeall)

local title = {
	awakenLv = 7,
	talentLv = 6,
	creepsId = 1,
	onlyUseExtProperties = 10,
	faceId = 15,
	summonedPetId = 13,
	posId = 4,
	summonMasterId = 12,
	equipment = 8,
	creepsName = 3,
	isFixedPos = 11,
	maxHp = 14,
	raceId = 2,
	extproperties = 9,
	lv = 5
}
local dataList = {
	{
		10000001,
		13008,
		"不朽枯木·永恒圣龙",
		8,
		100,
		0,
		0,
		"",
		"生命+769231#攻击+315385#物防+46154#魔防+50000#速度+46154",
		true,
		true,
		"",
		"",
		"",
		""
	},
	{
		10000002,
		13009,
		"神曜永恒·阿瑞斯",
		2,
		100,
		0,
		0,
		"",
		"生命+1692308#攻击+184615#物防+100000#魔防+100000#速度+30769",
		true,
		true,
		"",
		"",
		"",
		""
	}
}
local t_never_land_support_pet = {
	[10000001] = {
		[13008] = dataList[1]
	},
	[10000002] = {
		[13009] = dataList[2]
	}
}

t_never_land_support_pet.dataList = dataList

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

return t_never_land_support_pet
