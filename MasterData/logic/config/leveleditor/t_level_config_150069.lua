-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150069.lua

module("logic.config.leveleditor.t_level_config_150069", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150069",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面69",
	lossConditionDesc = "",
	sceneId = "116004",
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
			x = 5,
			y = 8
		},
		{
			direction = 3,
			x = 6,
			y = 8
		},
		{
			direction = 3,
			x = 7,
			y = 8
		},
		{
			direction = 2,
			x = 9,
			y = 5
		},
		{
			direction = 2,
			x = 9,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "超级幻影",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 15006901,
					x = 6,
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
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15006902,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15006902,
					x = 7,
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
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 15006903,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 15006903,
					x = 13,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 15006903,
					x = 12,
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
			groupName = "支援小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15006904,
					x = 6,
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
		[15006901] = {
			normalSkill = 1201503,
			name = "虫态补光灯",
			pre_magicAtk = 144.9,
			maxHp = 72200.2,
			aiName = "ai_120015_矿工探灯",
			battleCamp = 1,
			career = 1,
			magicAtk = 144.9,
			pre_meleeDef = 685.2,
			sanity = 0,
			remark = "幻影精英-高难度",
			giftSkill = 1201504,
			weakPointHpRate = 0.3,
			meleeDef = 685.2,
			level = 78,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1449,
			pre_meleeAtk = 1449,
			pre_maxHp = 72200.2,
			colorType = 1,
			monsterType = 1,
			id = 15006901,
			mobility = 4,
			pre_magicDef = 446.6,
			aiStepOrder = 0,
			trumpSkill = 1201506,
			isFuzzy = false,
			inspire = 79.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 79.2,
			modelId = 120015,
			magicDef = 446.6,
			specialSkill = 0,
			extraSkills = {
				1201505
			},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[15006902] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 137.5,
			maxHp = 11769.6,
			aiName = "ai_120015_矿工探灯",
			battleCamp = 1,
			career = 1,
			magicAtk = 137.5,
			pre_meleeDef = 616.7,
			sanity = 0,
			remark = "幻影小怪（普攻破甲+追击）",
			giftSkill = 1201502,
			weakPointHpRate = 0,
			meleeDef = 616.7,
			level = 78,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1375.4,
			pre_meleeAtk = 1375.4,
			pre_maxHp = 11769.6,
			colorType = 1,
			monsterType = 0,
			id = 15006902,
			mobility = 4,
			pre_magicDef = 401.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 76.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 76.2,
			modelId = 120015,
			magicDef = 401.9,
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
		[15006903] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 1628.5,
			maxHp = 8474,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 1628.5,
			pre_meleeDef = 405.2,
			sanity = 0,
			remark = "绿特异小怪（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0,
			meleeDef = 405.2,
			level = 78,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 162.8,
			pre_meleeAtk = 162.8,
			pre_maxHp = 8474,
			colorType = 3,
			monsterType = 0,
			id = 15006903,
			mobility = 2,
			pre_magicDef = 573.1,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 86.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 86.2,
			modelId = 120093,
			magicDef = 573.1,
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
		[15006904] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 1551.8,
			maxHp = 8821.1,
			aiName = "ai_120012_修补师轮胎",
			battleCamp = 1,
			career = 6,
			magicAtk = 1551.8,
			pre_meleeDef = 437.4,
			sanity = 0,
			remark = "支援小怪(主动攻击后援护)",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 437.4,
			level = 78,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 155.2,
			pre_meleeAtk = 155.2,
			pre_maxHp = 8821.1,
			colorType = 4,
			monsterType = 0,
			id = 15006904,
			mobility = 2,
			pre_magicDef = 616.7,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 66.2,
			modelId = 120012,
			magicDef = 616.7,
			specialSkill = 1201202,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		}
	}
}

return configData
