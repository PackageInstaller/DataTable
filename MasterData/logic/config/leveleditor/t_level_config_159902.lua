-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_159902.lua

module("logic.config.leveleditor.t_level_config_159902", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "159902",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔2-1(旧)",
	lossConditionDesc = "",
	sceneId = "150002",
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
			x = 1,
			y = 1
		},
		{
			direction = 2,
			x = 2,
			y = 1
		},
		{
			direction = 2,
			x = 3,
			y = 2
		},
		{
			direction = 2,
			x = 4,
			y = 1
		},
		{
			direction = 2,
			x = 5,
			y = 1
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
					condition = 6,
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
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 15990201,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 15990201,
					x = 3,
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
					monsterId = 15990201,
					x = 5,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 15990202,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 15990202,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 15990202,
					x = 1,
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
		[15990201] = {
			normalSkill = 1213213,
			name = "小怪",
			pre_magicAtk = 0,
			maxHp = 1,
			aiName = "mob_passive_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 0,
			pre_meleeDef = 35,
			sanity = 0,
			remark = "",
			giftSkill = 1213212,
			weakPointHpRate = 0,
			meleeDef = 35,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 252.6,
			pre_meleeAtk = 252.6,
			pre_maxHp = 1,
			colorType = 1,
			monsterType = 0,
			id = 15990201,
			mobility = 3,
			pre_magicDef = 0,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 0,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 120007,
			magicDef = 0,
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
		[15990202] = {
			normalSkill = 1213211,
			name = "精英",
			pre_magicAtk = 0,
			maxHp = 2,
			aiName = "elite_equipment_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 0,
			pre_meleeDef = 49,
			sanity = 0,
			remark = "",
			giftSkill = 1213214,
			weakPointHpRate = 0,
			meleeDef = 49,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 389,
			pre_meleeAtk = 389,
			pre_maxHp = 2,
			colorType = 2,
			monsterType = 0,
			id = 15990202,
			mobility = 3,
			pre_magicDef = 0,
			aiStepOrder = 2,
			trumpSkill = 1213221,
			isFuzzy = false,
			inspire = 0,
			camp = 8,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 120006,
			magicDef = 0,
			specialSkill = 0,
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
