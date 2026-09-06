-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mimengli_clg_pet.lua

module("logicconfig.config.t_divine_mimengli_clg_pet", package.seeall)

local title = {
	awakenLv = 7,
	talentLv = 6,
	creepsId = 1,
	onlyUseExtProperties = 10,
	faceId = 13,
	summonedPetId = 12,
	posId = 4,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 3,
	extproperties = 9,
	raceId = 2,
	lv = 5
}
local dataList = {
	{
		10000001,
		12029,
		"神曜辉忆·弥梦离",
		5,
		100,
		0,
		0,
		"",
		"生命+1329230#攻击+269011#物防+72000#魔防+72000#速度+77538",
		true,
		"",
		"",
		""
	},
	{
		10000002,
		20023,
		"记忆冤魂",
		5,
		100,
		0,
		0,
		"",
		"生命+2880406#攻击+387281#物防+177907#魔防+177907#速度+76246",
		true,
		"",
		"",
		""
	}
}
local t_divine_mimengli_clg_pet = {
	[10000001] = dataList[1],
	[10000002] = dataList[2]
}

t_divine_mimengli_clg_pet.dataList = dataList

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

return t_divine_mimengli_clg_pet
