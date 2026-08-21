-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150049.lua

module("logic.config.leveleditor.t_level_config_150049", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150049",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面49",
	lossConditionDesc = "",
	sceneId = "111001",
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
			x = 3,
			y = 0
		},
		{
			direction = 2,
			x = 3,
			y = 2
		},
		{
			direction = 2,
			x = 3,
			y = 1
		},
		{
			direction = 2,
			x = 2,
			y = 7
		},
		{
			direction = 2,
			x = 2,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "狙击精英",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 15004901,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "狙击小怪",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15004902,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15004902,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 15004902,
					x = 0,
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
			groupName = "特异小怪",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15004903,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 15004903,
					x = 11,
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
			groupName = "幻影小怪",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 15004904,
					x = 11,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 15004904,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 15004904,
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
		[15004901] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 110.8,
			maxHp = 36365,
			aiName = "ai_120030_毒沫",
			battleCamp = 1,
			career = 3,
			magicAtk = 110.8,
			pre_meleeDef = 473,
			sanity = 0,
			remark = "狙击精英（弧光额外弹射3次）",
			giftSkill = 1203002,
			weakPointHpRate = 0.3,
			meleeDef = 473,
			level = 64,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1107.8,
			pre_meleeAtk = 1107.8,
			pre_maxHp = 36365,
			colorType = 3,
			monsterType = 1,
			id = 15004901,
			mobility = 2,
			pre_magicDef = 298,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 80,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 80,
			modelId = 120030,
			magicDef = 298,
			specialSkill = 0,
			extraSkills = {
				1203003
			},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[15004902] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 100.1,
			maxHp = 5825,
			aiName = "ai_120088_狂欢路灯",
			battleCamp = 1,
			career = 3,
			magicAtk = 100.1,
			pre_meleeDef = 425.7,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 425.7,
			level = 64,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1001.5,
			pre_meleeAtk = 1001.5,
			pre_maxHp = 5825,
			colorType = 3,
			monsterType = 0,
			id = 15004902,
			mobility = 2,
			pre_magicDef = 268.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 77,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 77,
			modelId = 120088,
			magicDef = 268.2,
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
		[15004903] = {
			normalSkill = 1208201,
			name = "拟态/蚺",
			pre_magicAtk = 1114,
			maxHp = 4894.4,
			aiName = "ai_120082_假死",
			battleCamp = 1,
			career = 4,
			magicAtk = 1114,
			pre_meleeDef = 268.2,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1208202,
			weakPointHpRate = 0,
			meleeDef = 268.2,
			level = 64,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 111.4,
			pre_meleeAtk = 111.4,
			pre_maxHp = 4894.4,
			colorType = 2,
			monsterType = 0,
			id = 15004903,
			mobility = 2,
			pre_magicDef = 425.7,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 77,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 77,
			modelId = 120082,
			magicDef = 425.7,
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
		},
		[15004904] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 95.3,
			maxHp = 6735.1,
			aiName = "ai_120015_矿工探灯",
			battleCamp = 1,
			career = 1,
			magicAtk = 95.3,
			pre_meleeDef = 460.8,
			sanity = 0,
			remark = "幻影小怪（普攻破甲+追击）",
			giftSkill = 1201502,
			weakPointHpRate = 0,
			meleeDef = 460.8,
			level = 64,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 952.5,
			pre_meleeAtk = 952.5,
			pre_maxHp = 6735.1,
			colorType = 1,
			monsterType = 0,
			id = 15004904,
			mobility = 4,
			pre_magicDef = 265.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 67,
			modelId = 120015,
			magicDef = 265.5,
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
		}
	}
}

return configData
