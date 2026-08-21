-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dungeon_mainline_chapter.lua

module("logic.config.t_dungeon_mainline_chapter", package.seeall)

local title = {
	titleInChapter = 16,
	name = 3,
	sceneCode = 4,
	chapterId = 1,
	branchlineDungeonIds = 7,
	unlockCondition = 24,
	chapterNameRes = 19,
	canMultiplicityCost = 8,
	indexRes = 18,
	iconRes = 17,
	chapterEnglishName = 20,
	bannerRes = 21,
	multiplicityLimit = 10,
	starReward = 14,
	difficulty = 2,
	unlockChaperId = 23,
	unlockLv = 22,
	dungeonIds = 6,
	sceneRange = 5,
	multiplicityOpenCondition = 9,
	sceneCameraRotationY = 25,
	chapterHint = 26,
	titleIdxInChapter = 15,
	consecutive = 12,
	starRewardRequire = 13,
	canRecord = 11
}
local dataList = {
	{
		1,
		1,
		"密室 partA",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110101,
			110102,
			110118,
			110103,
			110119,
			110104,
			110105,
			1101061,
			110107
		},
		{
			{
				120101,
				120102,
				1201031
			},
			{
				120111,
				120112,
				120113
			}
		},
		1,
		2,
		6,
		1,
		6,
		{
			8,
			16,
			24
		},
		{
			1101301,
			1101302,
			1101303
		},
		"fbzx_01",
		"fbzj_01",
		"wfjh_chapter_001",
		"fbzx_number_1",
		"fbjhy_01",
		"fbzx_number_1",
		"main_banner_001",
		1,
		0,
		nil,
		30,
		"EP-01"
	},
	{
		1,
		2,
		"密室 partA-异常",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110131,
			110132,
			110133,
			110134,
			110135,
			110136,
			110137,
			110138
		},
		nil,
		1,
		2,
		6,
		1,
		6,
		{
			8,
			16,
			24
		},
		{
			1101331,
			1101332,
			1101333
		},
		"fbzx_01",
		"fbzj_01",
		"wfjh_chapter_001",
		"",
		"",
		"",
		"",
		1,
		0,
		{
			{
				value = "1101181",
				type = "dungeon"
			}
		},
		30,
		"EP-01"
	},
	{
		2,
		1,
		"密室 partB",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110108,
			110109,
			110120,
			110110,
			1101111,
			110112,
			110113,
			110114,
			110115,
			110116,
			1101171,
			1101181
		},
		{
			{
				120121,
				120122
			}
		},
		1,
		2,
		6,
		1,
		6,
		{
			9,
			18,
			27
		},
		{
			1101304,
			1101305,
			1101306
		},
		"fbzx_02",
		"fbzj_02",
		"wfjh_chapter_002",
		"fbzx_number_2",
		"fbjhy_02",
		"fbzx_number_1",
		"main_banner_001",
		1,
		1,
		{
			{
				value = "110107",
				type = "dungeon"
			}
		},
		30,
		"EP-02"
	},
	{
		2,
		2,
		"密室 partB-异常",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110139,
			110140,
			110141,
			110142,
			110143,
			110144,
			110145,
			110146
		},
		nil,
		1,
		2,
		6,
		1,
		6,
		{
			8,
			16,
			24
		},
		{
			1101334,
			1101335,
			1101336
		},
		"fbzx_02",
		"fbzj_02",
		"wfjh_chapter_002",
		"",
		"",
		"",
		"",
		1,
		1,
		{
			{
				value = "1102151",
				type = "dungeon"
			}
		},
		30,
		"EP-02"
	},
	{
		3,
		1,
		"余响",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			1102011,
			110202,
			110203,
			110204,
			1102051,
			110206,
			110207,
			1102081,
			110209,
			110210,
			110211,
			110212,
			110213,
			110214,
			1102151
		},
		{
			{
				120201,
				120202,
				1202031
			},
			{
				120211,
				120212,
				120213
			},
			{
				120221,
				120222,
				120223
			}
		},
		1,
		2,
		6,
		1,
		6,
		{
			11,
			22,
			33
		},
		{
			1102301,
			1102302,
			1102303
		},
		"fbzx_03",
		"fbzj_03",
		"wfjh_chapter_003",
		"fbzx_number_3",
		"fbjhy_03",
		"fbzx_number_1",
		"main_banner_001",
		1,
		2,
		{
			{
				value = "1101171",
				type = "dungeon"
			}
		},
		30,
		"EP-03"
	},
	{
		3,
		2,
		"余响-异常",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110231,
			110232,
			110233,
			110234,
			110235,
			110236,
			110237,
			110238
		},
		nil,
		1,
		2,
		6,
		1,
		6,
		{
			8,
			16,
			24
		},
		{
			1102331,
			1102332,
			1102333
		},
		"fbzx_03",
		"fbzj_03",
		"wfjh_chapter_003",
		"",
		"",
		"",
		"",
		1,
		2,
		{
			{
				value = "1103181",
				type = "dungeon"
			}
		},
		30,
		"EP-03"
	},
	{
		4,
		1,
		"造梦者",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			1103011,
			110302,
			110303,
			110304,
			1103051,
			110306,
			1103071,
			110308,
			110309,
			110310,
			110311,
			110312,
			110313,
			110314,
			110315,
			110316,
			110317,
			1103181
		},
		{
			{
				120301,
				120302,
				120303
			},
			{
				120311,
				120312,
				120313
			}
		},
		1,
		2,
		6,
		1,
		6,
		{
			14,
			28,
			42
		},
		{
			1103301,
			1103302,
			1103303
		},
		"fbzx_04",
		"fbzj_04",
		"wfjh_chapter_004",
		"fbzx_number_4",
		"fbjhy_04",
		"fbzx_number_1",
		"main_banner_001",
		15,
		3,
		{
			{
				value = "1102151",
				type = "dungeon"
			}
		},
		30,
		"EP-04"
	},
	{
		4,
		2,
		"造梦者-异常",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110331,
			110332,
			110333,
			110334,
			110335,
			110336,
			110337,
			110338
		},
		nil,
		1,
		2,
		6,
		1,
		6,
		{
			8,
			16,
			24
		},
		{
			1103331,
			1103332,
			1103333
		},
		"fbzx_04",
		"fbzj_04",
		"wfjh_chapter_004",
		"",
		"",
		"",
		"",
		15,
		3,
		{
			{
				value = "110412",
				type = "dungeon"
			}
		},
		30,
		"EP-04"
	},
	{
		5,
		1,
		"孤名",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110401,
			110402,
			110403,
			110404,
			110405,
			110406,
			110407,
			110408,
			110409,
			110410,
			110411,
			110412
		},
		nil,
		1,
		2,
		6,
		1,
		6,
		{
			9,
			18,
			36
		},
		{
			1104301,
			1104302,
			1104303
		},
		"fbzx_05",
		"fbzj_05",
		"wfjh_chapter_004",
		"fbzx_number_5",
		"fbjhy_05",
		"fbzx_number_1",
		"main_banner_001",
		23,
		4,
		{
			{
				value = "1103181",
				type = "dungeon"
			}
		},
		30,
		"EP-05"
	},
	{
		5,
		2,
		"孤名-异常",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110431,
			110432,
			110433,
			110434,
			110435,
			110436,
			110437,
			110438
		},
		nil,
		1,
		2,
		6,
		1,
		6,
		{
			8,
			16,
			24
		},
		{
			1104331,
			1104332,
			1104333
		},
		"fbzx_05",
		"fbzj_05",
		"wfjh_chapter_004",
		"",
		"",
		"",
		"",
		23,
		4,
		{
			{
				value = "110512",
				type = "dungeon"
			}
		},
		30,
		"EP-05"
	},
	{
		6,
		1,
		"棋手",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110501,
			110502,
			110503,
			110504,
			110505,
			110506,
			110507,
			110508,
			110509,
			110510,
			110511,
			110512
		},
		nil,
		1,
		2,
		6,
		1,
		6,
		{
			9,
			18,
			36
		},
		{
			1105301,
			1105302,
			1105303
		},
		"fbzx_06",
		"fbzj_06",
		"wfjh_chapter_004",
		"fbzx_number_6",
		"fbjhy_06",
		"fbzx_number_1",
		"main_banner_001",
		30,
		5,
		{
			{
				value = "110412",
				type = "dungeon"
			}
		},
		30,
		"EP-06"
	},
	{
		6,
		2,
		"棋手-异常",
		2001,
		{
			-65,
			-35.94,
			-14.6,
			-59.3
		},
		{
			110531,
			110532,
			110533,
			110534,
			110535,
			110536,
			110537,
			110538
		},
		nil,
		1,
		2,
		6,
		1,
		6,
		{
			8,
			16,
			24
		},
		{
			1105331,
			1105332,
			1105333
		},
		"fbzx_06",
		"fbzj_06",
		"wfjh_chapter_004",
		"",
		"",
		"",
		"",
		30,
		5,
		{
			{
				value = "110438",
				type = "dungeon"
			}
		},
		30,
		"EP-06"
	}
}
local t_dungeon_mainline_chapter = {}

t_dungeon_mainline_chapter.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	local parent1 = t_dungeon_mainline_chapter[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_dungeon_mainline_chapter[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_dungeon_mainline_chapter
