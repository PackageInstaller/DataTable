-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150020.lua

module("logic.config.leveleditor.t_level_config_150020", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150020",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面20",
	lossConditionDesc = "",
	sceneId = "109003",
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
			x = 7,
			y = 5
		},
		{
			direction = 1,
			x = 8,
			y = 5
		},
		{
			direction = 1,
			x = 9,
			y = 5
		},
		{
			direction = 4,
			x = 8,
			y = 1
		},
		{
			direction = 4,
			x = 8,
			y = 2
		},
		{
			direction = 1,
			x = 6,
			y = 5
		}
	},
	additionalTerrainList = {},
	winConditionGroupList = {
		{
			tag = "",
			isBackup = false,
			hasTag = false,
			winConditionList = {
				{
					round = 10,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 1,
					monsterIds = {}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 1,
			maxDeadCount = 0,
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 1,
					tag = "",
					monsterId = 15002002,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 15002003,
					x = 6,
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
			groupName = "怪物组2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 15002004,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[15002001] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 33.1,
			maxHp = 4267.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 33.1,
			pre_meleeDef = 213.3,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 213.3,
			level = 35,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 330.9,
			pre_meleeAtk = 330.9,
			pre_maxHp = 4267.2,
			colorType = 2,
			monsterType = 0,
			id = 15002001,
			mobility = 2,
			pre_magicDef = 112.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 42,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 42,
			modelId = 120090,
			magicDef = 112.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			}
		},
		[15002002] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 35.6,
			maxHp = 2986.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 35.6,
			pre_meleeDef = 180.9,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 180.9,
			level = 35,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 355.8,
			pre_meleeAtk = 355.8,
			pre_maxHp = 2986.8,
			colorType = 3,
			monsterType = 0,
			id = 15002002,
			mobility = 2,
			pre_magicDef = 113.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 62,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 62,
			modelId = 120088,
			magicDef = 113.4,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			}
		},
		[15002003] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 34.2,
			maxHp = 3453.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 34.2,
			pre_meleeDef = 198,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 198,
			level = 35,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 342.2,
			pre_meleeAtk = 342.2,
			pre_maxHp = 3453.1,
			colorType = 1,
			monsterType = 0,
			id = 15002003,
			mobility = 4,
			pre_magicDef = 111.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 52,
			modelId = 120089,
			magicDef = 111.6,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[15002004] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 50.6,
			maxHp = 51594.3,
			aiName = "ai_蠕虫放映机_爬塔",
			battleCamp = 1,
			career = 2,
			magicAtk = 50.6,
			pre_meleeDef = 237,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.17,
			meleeDef = 237,
			level = 35,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 506,
			pre_meleeAtk = 506,
			pre_maxHp = 51594.3,
			colorType = 2,
			monsterType = 2,
			id = 15002004,
			mobility = 0,
			pre_magicDef = 125,
			aiStepOrder = 0,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 47,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 47,
			modelId = 120087,
			magicDef = 125,
			specialSkill = 1208702,
			extraSkills = {
				1208705
			},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			}
		}
	}
}

return configData
