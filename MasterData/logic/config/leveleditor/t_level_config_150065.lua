-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150065.lua

module("logic.config.leveleditor.t_level_config_150065", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150065",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面65",
	lossConditionDesc = "",
	sceneId = "112003",
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
			x = 6,
			y = 5
		},
		{
			direction = 2,
			x = 5,
			y = 5
		},
		{
			direction = 2,
			x = 7,
			y = 6
		},
		{
			direction = 2,
			x = 7,
			y = 7
		},
		{
			direction = 2,
			x = 7,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "陨灭精英",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15006501,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "陨灭小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15006502,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 15006502,
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
			groupName = "快乐小特异",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 15006503,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 15006503,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 15006503,
					x = 5,
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
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15006504,
					x = 11,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15006504,
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
		[15006501] = {
			normalSkill = 1208101,
			name = "拟态/葵",
			pre_magicAtk = 151.7,
			maxHp = 49551.9,
			aiName = "ai_120081_尖刺",
			battleCamp = 1,
			career = 5,
			magicAtk = 1516.7,
			pre_meleeDef = 629,
			sanity = 0,
			remark = "陨灭精英-高难度",
			giftSkill = 1208103,
			weakPointHpRate = 0.3,
			meleeDef = 484,
			level = 75,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 151.6,
			pre_meleeAtk = 1516.6,
			pre_maxHp = 49551.9,
			colorType = 4,
			monsterType = 1,
			id = 15006501,
			mobility = 1,
			pre_magicDef = 484,
			aiStepOrder = 3,
			trumpSkill = 1208102,
			isFuzzy = false,
			inspire = 78,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 78,
			modelId = 120081,
			magicDef = 629,
			specialSkill = 1208104,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"B",
				"A",
				"A"
			},
			tags = {}
		},
		[15006502] = {
			normalSkill = 1209401,
			name = "曳行空调",
			pre_magicAtk = 1362.6,
			maxHp = 9615,
			aiName = "ai_120094_空调狂热者",
			battleCamp = 1,
			career = 5,
			magicAtk = 1362.6,
			pre_meleeDef = 435.6,
			sanity = 0,
			remark = "陨灭小怪",
			giftSkill = 1209403,
			weakPointHpRate = 0,
			meleeDef = 435.6,
			level = 75,
			monsterGroup = "法术陨灭小怪",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 136.3,
			pre_meleeAtk = 136.3,
			pre_maxHp = 9615,
			colorType = 4,
			monsterType = 0,
			id = 15006502,
			mobility = 1,
			pre_magicDef = 566.1,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 75,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 6,
			pre_inspire = 75,
			modelId = 120094,
			magicDef = 566.1,
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
		[15006503] = {
			normalSkill = 1209801,
			name = "徘徊雨具",
			pre_magicAtk = 1571.4,
			maxHp = 7835.8,
			aiName = "ai_120098_黑伞人",
			battleCamp = 1,
			career = 4,
			magicAtk = 1571.4,
			pre_meleeDef = 387.9,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1209802,
			weakPointHpRate = 0,
			meleeDef = 387.9,
			level = 75,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 157.1,
			pre_meleeAtk = 157.1,
			pre_maxHp = 7835.8,
			colorType = 1,
			monsterType = 0,
			id = 15006503,
			mobility = 2,
			pre_magicDef = 547.2,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 85,
			modelId = 120098,
			magicDef = 547.2,
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
		[15006504] = {
			normalSkill = 1209501,
			name = "抽水花洒",
			pre_magicAtk = 1645.2,
			maxHp = 41836.6,
			aiName = "ai_120095_抽水花洒",
			battleCamp = 1,
			career = 6,
			magicAtk = 1645.2,
			pre_meleeDef = 465,
			sanity = 0,
			remark = "支援精英",
			giftSkill = 1209503,
			weakPointHpRate = 0.3,
			meleeDef = 465,
			level = 75,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 164.5,
			pre_meleeAtk = 164.5,
			pre_maxHp = 41836.6,
			colorType = 4,
			monsterType = 1,
			id = 15006504,
			mobility = 2,
			pre_magicDef = 654,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 4,
			monsterGroupEnum = 1,
			pre_inspire = 68,
			modelId = 120095,
			magicDef = 654,
			specialSkill = 1209502,
			extraSkills = {
				1209504
			},
			attributeGrade = {
				"A",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		}
	}
}

return configData
