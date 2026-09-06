-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_never_land_creeps.lua

module("logicconfig.config.t_never_land_creeps", package.seeall)

local title = {
	awakenLv = 8,
	raceId = 3,
	creepsId = 2,
	onlyUseExtProperties = 11,
	faceId = 14,
	summonedPetId = 13,
	posId = 5,
	summonMasterId = 12,
	equipment = 9,
	creepsName = 4,
	talentLv = 7,
	extproperties = 10,
	creepsMasterId = 1,
	showIndex = 15,
	lv = 6
}
local dataList = {
	{
		101,
		1,
		93008,
		"不朽枯木·永恒圣龙",
		8,
		100,
		0,
		0,
		"",
		"生命+1000000000#攻击+126154#物防+120000#魔防+120000#速度+18462",
		true,
		"",
		"",
		"",
		""
	},
	{
		101,
		2,
		93009,
		"神曜永恒·阿瑞斯",
		2,
		100,
		0,
		0,
		"",
		"生命+1000000000#攻击+73846#物防+180000#魔防+180000#速度+12308",
		true,
		"",
		"",
		"",
		""
	},
	{
		102,
		1,
		93008,
		"不朽枯木·永恒圣龙",
		8,
		100,
		0,
		0,
		"",
		"生命+1000000000#攻击+126154#物防+120000#魔防+120000#速度+18462",
		true,
		"",
		"",
		"",
		""
	},
	{
		102,
		2,
		93009,
		"神曜永恒·阿瑞斯",
		2,
		100,
		0,
		0,
		"",
		"生命+1000000000#攻击+73846#物防+180000#魔防+180000#速度+12308",
		true,
		"",
		"",
		"",
		""
	}
}
local t_never_land_creeps = {
	[101] = {
		dataList[1],
		dataList[2]
	},
	[102] = {
		dataList[3],
		dataList[4]
	}
}

t_never_land_creeps.dataList = dataList

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

return t_never_land_creeps
