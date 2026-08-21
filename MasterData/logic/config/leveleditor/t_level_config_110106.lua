-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110106.lua

module("logic.config.leveleditor.t_level_config_110106", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110106",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通1-6",
	lossConditionDesc = "",
	sceneId = "108004",
	winConditionDesc = "",
	forbidAction = {
		auto = false,
		move = false,
		strengthenSkill = false,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 1,
			x = 10,
			y = 5
		},
		{
			direction = 1,
			x = 11,
			y = 5
		},
		{
			direction = 1,
			x = 10,
			y = 4
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 9,
					y = 10
				},
				{
					x = 9,
					y = 9
				}
			}
		}
	},
	winConditionGroupList = {
		{
			tag = "",
			isBackup = false,
			hasTag = false,
			winConditionList = {
				{
					round = 10,
					heroId = 0,
					count = 2,
					monsterTag = "",
					DIYName = "2名守秘人到达撤离点",
					condition = 7,
					monsterIds = {}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 3,
			maxDeadCount = 1,
			count = 0,
			hasTag = false,
			DIYName = "",
			isBackup = false,
			tag = "",
			targetId = 0,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "左侧怪物组",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11010601,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11010601,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "中央怪物组",
			color = 6,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11010603,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 11010702,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 11010702,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11010603,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 9,
			y = 9
		},
		{
			x = 10,
			y = 5
		}
	},
	lockHeroList = {},
	monsters = {
		[11010601] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 8.7,
			maxHp = 159.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 8.7,
			pre_meleeDef = 44,
			sanity = 0,
			remark = "",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 44,
			level = 7,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 86.8,
			pre_meleeAtk = 86.8,
			pre_maxHp = 159.9,
			colorType = 3,
			monsterType = 0,
			id = 11010601,
			mobility = 2,
			pre_magicDef = 24.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 43,
			modelId = 120012,
			magicDef = 24.8,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11010602] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 8.4,
			maxHp = 183.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 8.4,
			pre_meleeDef = 48.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 48.8,
			level = 7,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 84.2,
			pre_meleeAtk = 84.2,
			pre_maxHp = 183.2,
			colorType = 1,
			monsterType = 0,
			id = 11010602,
			mobility = 3,
			pre_magicDef = 22.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 33,
			modelId = 120015,
			magicDef = 22.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11010603] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 8.2,
			maxHp = 225.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 8.2,
			pre_meleeDef = 52.8,
			sanity = 0,
			remark = "",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 52.8,
			level = 7,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.1,
			pre_meleeAtk = 82.1,
			pre_maxHp = 225.4,
			colorType = 2,
			monsterType = 0,
			id = 11010603,
			mobility = 2,
			pre_magicDef = 24,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 23,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 23,
			modelId = 120014,
			magicDef = 24,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[11010604] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 8.7,
			maxHp = 159.9,
			aiName = "elite_jiguang_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 8.7,
			pre_meleeDef = 44,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.5,
			meleeDef = 44,
			level = 7,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 86.8,
			pre_meleeAtk = 86.8,
			pre_maxHp = 159.9,
			colorType = 3,
			monsterType = 1,
			id = 11010604,
			mobility = 2,
			pre_magicDef = 24.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 43,
			modelId = 120012,
			magicDef = 24.8,
			specialSkill = 1282202,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11010605] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 92.7,
			maxHp = 134.3,
			aiName = "mob_active_ai",
			battleCamp = 3,
			career = 4,
			magicAtk = 92.7,
			pre_meleeDef = 24.8,
			sanity = 0,
			remark = "",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 24.8,
			level = 7,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 9.3,
			pre_meleeAtk = 9.3,
			pre_maxHp = 134.3,
			colorType = 1,
			monsterType = 0,
			id = 11010605,
			mobility = 2,
			pre_magicDef = 45.8,
			aiStepOrder = 0,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 43,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 43,
			modelId = 100013,
			magicDef = 45.8,
			specialSkill = 1101302,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[11010606] = {
			normalSkill = 1101201,
			name = "芬里尔",
			pre_magicAtk = 92.7,
			maxHp = 134.3,
			aiName = "mob_active_ai",
			battleCamp = 3,
			career = 4,
			magicAtk = 92.7,
			pre_meleeDef = 24.8,
			sanity = 0,
			remark = "",
			giftSkill = 1101204,
			weakPointHpRate = 0,
			meleeDef = 24.8,
			level = 7,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 9.3,
			pre_meleeAtk = 9.3,
			pre_maxHp = 134.3,
			colorType = 1,
			monsterType = 0,
			id = 11010606,
			mobility = 2,
			pre_magicDef = 45.8,
			aiStepOrder = 0,
			trumpSkill = 1101203,
			isFuzzy = false,
			inspire = 43,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 43,
			modelId = 100012,
			magicDef = 45.8,
			specialSkill = 1101202,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		}
	}
}

return configData
