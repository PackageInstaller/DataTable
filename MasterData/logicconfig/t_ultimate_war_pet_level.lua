-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_pet_level.lua

module("logicconfig.config.t_ultimate_war_pet_level", package.seeall)

local title = {
	petLevel = 2,
	puzzleImgUrl = 6,
	creepsId = 5,
	maxHp = 12,
	faceId = 13,
	summonedPetId = 15,
	talentLv = 11,
	desc = 4,
	summonMasterId = 14,
	puzzlePos = 7,
	carriedPetId = 21,
	extproperties = 24,
	psychicedNormalSkillLv = 29,
	holyStripeSuitName = 17,
	activityId = 1,
	normalSkillLv = 26,
	param = 3,
	passiveSkillLv = 28,
	onlyUseExtProperties = 25,
	oraclePetId = 23,
	ultimateSkillLv = 27,
	fixedStarGodId = 16,
	imgUrl = 19,
	psychicedUltimateSkillLv = 30,
	holyStripeSuitDesc = 18,
	creepsName = 9,
	raceId = 8,
	oracleMasterId = 22,
	lv = 10,
	carriedMasterId = 20
}
local dataList = {
	{
		434001,
		1,
		"",
		"初始形态",
		2000001,
		"ultimatewar/board_zhongyanzhizhan_01",
		{
			273,
			0
		},
		18021,
		"创世神源·斐希司",
		60,
		0,
		"",
		"",
		"",
		"",
		nil,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"生命+812308#攻击+63296#物防+48000#魔防+48000#速度+14769",
		true,
		1,
		1,
		1,
		0,
		0
	},
	{
		434001,
		2,
		"COST$10:434002:100",
		"全属性提高，获得星神（无双，永恒传说，泰坦之躯，气吞山河）",
		2000002,
		"ultimatewar/board_zhongyanzhizhan_02",
		{
			253,
			197
		},
		18021,
		"创世神源·斐希司",
		70,
		0,
		"",
		"",
		"",
		"",
		nil,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"生命+1667220#攻击+134582#物防+96000#魔防+96000#速度+29538#防暴率+0.3605#起始气势+50",
		true,
		2,
		2,
		1,
		0,
		0
	},
	{
		434001,
		3,
		"COST$10:434002:300",
		"全属性提高，获得灵纹（沉石之纹）",
		2000003,
		"ultimatewar/board_zhongyanzhizhan_03",
		{
			65,
			185
		},
		18021,
		"创世神源·斐希司",
		80,
		0,
		"",
		"",
		"",
		"",
		nil,
		"沉石之纹",
		"己阵存活精灵越多，提升减伤越高，最高24%",
		"icon_xitong_lingwen_07",
		0,
		0,
		0,
		0,
		"生命+2479528#攻击+197878#物防+144000#魔防+144000#速度+44308#防暴率+0.3605#起始气势+50",
		true,
		3,
		3,
		1,
		0,
		0
	},
	{
		434001,
		4,
		"COST$10:434002:500",
		"全属性提高，本源技初始获得1层",
		2000004,
		"ultimatewar/board_zhongyanzhizhan_04",
		{
			-37,
			5
		},
		18021,
		"创世神源·斐希司",
		90,
		0,
		"",
		"",
		"",
		"",
		nil,
		"沉石之纹",
		"己阵存活精灵越多，提升减伤越高，最高24%",
		"icon_xitong_lingwen_07",
		0,
		0,
		0,
		0,
		"生命+3291836#攻击+261175#物防+192000#魔防+192000#速度+59077#防暴率+0.3605#起始气势+50",
		true,
		4,
		4,
		1,
		0,
		0
	},
	{
		434001,
		5,
		"PLOT$5",
		"全属性提高，本源技初始获得3层",
		2000005,
		"ultimatewar/board_zhongyanzhizhan_05",
		{
			75,
			-112
		},
		18021,
		"创世神源·斐希司",
		100,
		0,
		"",
		"",
		"",
		"",
		nil,
		"沉石之纹",
		"己阵存活精灵越多，提升减伤越高，最高24%",
		"icon_xitong_lingwen_07",
		0,
		0,
		0,
		0,
		"生命+4104143#攻击+324472#物防+240000#魔防+240000#速度+73846#防暴率+0.3605#起始气势+50",
		true,
		5,
		5,
		1,
		0,
		0
	}
}
local t_ultimate_war_pet_level = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_ultimate_war_pet_level.dataList = dataList

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

return t_ultimate_war_pet_level
