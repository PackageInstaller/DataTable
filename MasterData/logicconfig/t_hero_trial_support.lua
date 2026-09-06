-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hero_trial_support.lua

module("logicconfig.config.t_hero_trial_support", package.seeall)

local title = {
	awakenLv = 6,
	raceId = 2,
	creepsId = 1,
	maxHp = 11,
	faceId = 12,
	summonedPetId = 10,
	talentLv = 5,
	summonMasterId = 9,
	equipment = 7,
	creepsName = 3,
	extproperties = 8,
	lv = 4
}
local dataList = {
	{
		1000000001,
		10143,
		"力量王者·龙炎",
		60,
		5,
		3,
		"&4#5",
		"",
		"",
		"",
		"",
		""
	},
	{
		1000000002,
		10143,
		"力量王者·龙炎",
		70,
		6,
		4,
		"&4#6",
		"",
		"",
		"",
		"",
		""
	},
	{
		1000000003,
		10143,
		"力量王者·龙炎",
		80,
		7,
		5,
		"&4#7",
		"",
		"",
		"",
		"",
		""
	},
	{
		1000000004,
		10143,
		"力量王者·龙炎",
		90,
		8,
		6,
		"&3#8",
		"",
		"",
		"",
		"",
		""
	}
}
local t_hero_trial_support = {
	[1000000001] = dataList[1],
	[1000000002] = dataList[2],
	[1000000003] = dataList[3],
	[1000000004] = dataList[4]
}

t_hero_trial_support.dataList = dataList

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

return t_hero_trial_support
