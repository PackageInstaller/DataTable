-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_six_art_daoguan_rent_pet.lua

module("logicconfig.config.t_six_art_daoguan_rent_pet", package.seeall)

local title = {
	raceId = 3,
	cost = 6,
	creepsId = 2,
	onlyUseExtProperties = 12,
	faceId = 15,
	summonedPetId = 14,
	talentLv = 8,
	carriedPetId = 17,
	summonMasterId = 13,
	activityId = 1,
	awakenLv = 9,
	equipment = 10,
	creepsName = 5,
	openDateTime = 4,
	extproperties = 11,
	lv = 7,
	carriedMasterId = 16
}
local dataList = {
	{
		447001,
		100000001,
		13021,
		"2025-01-24T05:00:00",
		"神曜混元·真龙",
		"10:447002:1000",
		100,
		0,
		0,
		"",
		"生命+412692#攻击+32158#物防+24386#魔防+24386#速度+7503",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		447001,
		100000002,
		12027,
		"2025-01-24T05:00:00",
		"烈焰王者·无烬",
		"",
		100,
		0,
		0,
		"",
		"生命+318899#攻击+42877#物防+19696#魔防+19696#速度+8441",
		true,
		"100000003",
		"",
		"",
		0,
		0
	},
	{
		447001,
		100000003,
		18011,
		"2025-01-24T05:00:00",
		"圣幻希望·夏因",
		"10:447002:2000",
		100,
		0,
		0,
		"",
		"生命+412692#攻击+32158#物防+24386#魔防+24386#速度+7503",
		true,
		"",
		"100000002",
		"",
		0,
		0
	},
	{
		447001,
		100000004,
		12028,
		"2025-01-24T05:00:00",
		"创始天璇·昆吾",
		"10:447002:1000",
		100,
		0,
		0,
		"",
		"生命+187587#攻击+54936#物防+12193#魔防+11255#速度+11255",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		447001,
		100000005,
		18021,
		"2025-01-24T05:00:00",
		"创世神源·斐希司",
		"10:447002:3000",
		100,
		0,
		0,
		"",
		"生命+412692#攻击+32158#物防+24386#魔防+24386#速度+7503",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		447001,
		100000006,
		13022,
		"2025-02-07T05:00:00",
		"神曜不朽·永恒圣龙",
		"10:447002:1000",
		100,
		0,
		0,
		"",
		"生命+187587#攻击+54936#物防+11255#魔防+12193#速度+11255",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		447001,
		100000007,
		11026,
		"2025-02-07T05:00:00",
		"法度恒常·秩序",
		"10:447002:1000",
		100,
		0,
		0,
		"",
		"生命+187587#攻击+54936#物防+11255#魔防+12193#速度+11255",
		true,
		"",
		"",
		"",
		0,
		0
	}
}
local t_six_art_daoguan_rent_pet = {
	[447001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3],
		[100000004] = dataList[4],
		[100000005] = dataList[5],
		[100000006] = dataList[6],
		[100000007] = dataList[7]
	}
}

t_six_art_daoguan_rent_pet.dataList = dataList

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

return t_six_art_daoguan_rent_pet
