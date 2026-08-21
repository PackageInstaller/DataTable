-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150009.lua

module("logic.config.leveleditor.t_level_config_150009", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150009",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "爬塔明面9",
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
			direction = 2,
			x = 9,
			y = 13
		},
		{
			direction = 2,
			x = 10,
			y = 14
		},
		{
			direction = 3,
			x = 5,
			y = 13
		},
		{
			direction = 3,
			x = 4,
			y = 12
		},
		{
			direction = 2,
			x = 10,
			y = 12
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
			groupName = "小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 15000901,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 15000902,
					x = 14,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 15000901,
					x = 14,
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
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 15000902,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15000901,
					x = 11,
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
		[15000901] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 29.4,
			maxHp = 2346,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 29.4,
			pre_meleeDef = 174.8,
			sanity = 0,
			remark = "",
			giftSkill = 1201502,
			weakPointHpRate = 0,
			meleeDef = 174.8,
			level = 28,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 293.6,
			pre_meleeAtk = 293.6,
			pre_maxHp = 2346,
			colorType = 1,
			monsterType = 0,
			id = 15000901,
			mobility = 4,
			pre_magicDef = 94.7,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 49.4,
			modelId = 120015,
			magicDef = 94.7,
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
		[15000902] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 28.5,
			maxHp = 2881.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 28.5,
			pre_meleeDef = 188.5,
			sanity = 0,
			remark = "",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 188.5,
			level = 28,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 284.4,
			pre_meleeAtk = 284.4,
			pre_maxHp = 2881.1,
			colorType = 2,
			monsterType = 0,
			id = 15000902,
			mobility = 2,
			pre_magicDef = 95,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 39.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 39.4,
			modelId = 120014,
			magicDef = 95,
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
		}
	}
}

return configData
