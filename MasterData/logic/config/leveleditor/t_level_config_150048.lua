-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150048.lua

module("logic.config.leveleditor.t_level_config_150048", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150048",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面48",
	lossConditionDesc = "",
	sceneId = "110002",
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
			direction = 3,
			x = 10,
			y = 13
		},
		{
			direction = 3,
			x = 9,
			y = 13
		},
		{
			direction = 3,
			x = 8,
			y = 13
		},
		{
			direction = 4,
			x = 12,
			y = 8
		},
		{
			direction = 4,
			x = 12,
			y = 9
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
			groupName = "守卫精英",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 11,
					tag = "",
					monsterId = 15004804,
					x = 9,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "小奶妈",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 15004803,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "地形陨灭",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 15004802,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 10,
					tag = "",
					monsterId = 15004802,
					x = 8,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "驱散陨灭",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 15004801,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 15004801,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[15004801] = {
			normalSkill = 1209401,
			name = "曳行空调",
			pre_magicAtk = 943.4,
			maxHp = 5712.2,
			aiName = "ai_120094_空调狂热者",
			battleCamp = 1,
			career = 5,
			magicAtk = 943.4,
			pre_meleeDef = 294.3,
			sanity = 0,
			remark = "陨灭小怪",
			giftSkill = 1209403,
			weakPointHpRate = 0,
			meleeDef = 294.3,
			level = 63,
			monsterGroup = "法术陨灭小怪",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 94.4,
			pre_meleeAtk = 94.4,
			pre_maxHp = 5712.2,
			colorType = 4,
			monsterType = 0,
			id = 15004801,
			mobility = 1,
			pre_magicDef = 421.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 6,
			pre_inspire = 66.5,
			modelId = 120094,
			magicDef = 421.6,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"B",
				"B"
			},
			tags = {}
		},
		[15004802] = {
			normalSkill = 1208101,
			name = "拟态/葵",
			pre_magicAtk = 943.4,
			maxHp = 5712.2,
			aiName = "ai_120081_尖刺",
			battleCamp = 1,
			career = 5,
			magicAtk = 943.4,
			pre_meleeDef = 294.3,
			sanity = 0,
			remark = "陨灭小怪",
			giftSkill = 1208103,
			weakPointHpRate = 0,
			meleeDef = 294.3,
			level = 63,
			monsterGroup = "法术陨灭小怪",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 94.4,
			pre_meleeAtk = 94.4,
			pre_maxHp = 5712.2,
			colorType = 4,
			monsterType = 0,
			id = 15004802,
			mobility = 1,
			pre_magicDef = 421.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 6,
			pre_inspire = 66.5,
			modelId = 120081,
			magicDef = 421.6,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"B",
				"B"
			},
			tags = {}
		},
		[15004803] = {
			normalSkill = 1209501,
			name = "抽水花洒",
			pre_magicAtk = 1029.6,
			maxHp = 4824.9,
			aiName = "ai_120095_抽水花洒",
			battleCamp = 1,
			career = 6,
			magicAtk = 1029.6,
			pre_meleeDef = 281.7,
			sanity = 0,
			remark = "支援小怪",
			giftSkill = 1209503,
			weakPointHpRate = 0,
			meleeDef = 281.7,
			level = 63,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 103,
			pre_meleeAtk = 103,
			pre_maxHp = 4824.9,
			colorType = 4,
			monsterType = 0,
			id = 15004803,
			mobility = 2,
			pre_magicDef = 439.6,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56.5,
			modelId = 120095,
			magicDef = 439.6,
			specialSkill = 1209502,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		},
		[15004804] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 85.4,
			maxHp = 48743.2,
			aiName = "ai_120014_禁行隔离墩",
			battleCamp = 1,
			career = 2,
			magicAtk = 85.4,
			pre_meleeDef = 521.5,
			sanity = 0,
			remark = "守卫精英（受到攻击后获得1层[坚韧]）",
			giftSkill = 1201402,
			weakPointHpRate = 0.3,
			meleeDef = 521.5,
			level = 63,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 854.7,
			pre_meleeAtk = 854.7,
			pre_maxHp = 48743.2,
			colorType = 2,
			monsterType = 1,
			id = 15004804,
			mobility = 2,
			pre_magicDef = 286.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 59.5,
			modelId = 120014,
			magicDef = 286.5,
			specialSkill = 0,
			extraSkills = {
				1201404
			},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
