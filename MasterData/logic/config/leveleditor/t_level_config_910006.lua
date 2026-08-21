-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_910006.lua

module("logic.config.leveleditor.t_level_config_910006", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "910006",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 15,
	levelName = "高难boss体验",
	lossConditionDesc = "",
	sceneId = "910001",
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
			x = 6,
			y = 8
		},
		{
			direction = 1,
			x = 8,
			y = 8
		},
		{
			direction = 1,
			x = 7,
			y = 8
		},
		{
			direction = 1,
			x = 7,
			y = 7
		},
		{
			direction = 3,
			x = 7,
			y = 6
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
					condition = 3,
					monsterIds = {
						91000601
					}
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
			groupName = "Boss",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 91000601,
					x = 6,
					initialStatus = {
						hpPercent = 100,
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
			groupName = "小水晶",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 91000602,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 91000602,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 91000602,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 91000602,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[91000601] = {
			normalSkill = 1208301,
			name = "异变以太水晶",
			pre_magicAtk = 1433.3,
			maxHp = 121226.9,
			aiName = "ai_大型以太晶石高难测试",
			battleCamp = 1,
			career = 4,
			magicAtk = 1433.3,
			pre_meleeDef = 356,
			sanity = 0,
			remark = "boss模板",
			giftSkill = 1710006,
			weakPointHpRate = 0.3,
			meleeDef = 2356,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 143.3,
			pre_meleeAtk = 143.3,
			pre_maxHp = 121226.9,
			colorType = 1,
			monsterType = 2,
			id = 91000601,
			mobility = 0,
			pre_magicDef = 517,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 85,
			modelId = 120083,
			magicDef = 2517,
			specialSkill = 1208302,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[91000602] = {
			normalSkill = 0,
			name = "伴生以太水晶",
			pre_magicAtk = 1023.9,
			maxHp = 14000,
			aiName = "ai_小型以太晶石",
			battleCamp = 1,
			career = 4,
			magicAtk = 1023.9,
			pre_meleeDef = 320.4,
			sanity = 0,
			remark = "4格精英模板（没移动力；要注意）",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 320.4,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 102.4,
			pre_meleeAtk = 102.4,
			pre_maxHp = 9971.1,
			colorType = 2,
			monsterType = 0,
			id = 91000602,
			mobility = 0,
			pre_magicDef = 465.3,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 80,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 80,
			modelId = 120084,
			magicDef = 465.3,
			specialSkill = 1208401,
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
