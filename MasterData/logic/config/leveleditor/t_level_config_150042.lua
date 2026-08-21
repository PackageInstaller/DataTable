-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150042.lua

module("logic.config.leveleditor.t_level_config_150042", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150042",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面42",
	lossConditionDesc = "",
	sceneId = "108003",
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
			x = 4,
			y = 2
		},
		{
			direction = 1,
			x = 5,
			y = 2
		},
		{
			direction = 1,
			x = 6,
			y = 2
		},
		{
			direction = 4,
			x = 8,
			y = 5
		},
		{
			direction = 2,
			x = 2,
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
			groupName = "陨灭精英",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 15004201,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 15004201,
					x = 4,
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
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 15004202,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 15004202,
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
			groupName = "特异小怪",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15004203,
					x = 9,
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
					monsterId = 15004203,
					x = 1,
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
		[15004201] = {
			normalSkill = 1208101,
			name = "拟态/葵",
			pre_magicAtk = 864.1,
			maxHp = 24661.8,
			aiName = "ai_120081_尖刺",
			battleCamp = 1,
			career = 5,
			magicAtk = 864.1,
			pre_meleeDef = 278.6,
			sanity = 0,
			remark = "陨灭精英",
			giftSkill = 1208103,
			weakPointHpRate = 0.3,
			meleeDef = 278.6,
			level = 56,
			monsterGroup = "法术陨灭小怪",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 86.4,
			pre_meleeAtk = 86.4,
			pre_maxHp = 24661.8,
			colorType = 4,
			monsterType = 1,
			id = 15004201,
			mobility = 1,
			pre_magicDef = 376.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 6,
			pre_inspire = 66.4,
			modelId = 120081,
			magicDef = 376.6,
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
		[15004202] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 80.1,
			maxHp = 4536.7,
			aiName = "ai_120030_毒沫",
			battleCamp = 1,
			career = 3,
			magicAtk = 80.1,
			pre_meleeDef = 326.3,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 326.3,
			level = 56,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 800.4,
			pre_meleeAtk = 800.4,
			pre_maxHp = 4536.7,
			colorType = 3,
			monsterType = 0,
			id = 15004202,
			mobility = 2,
			pre_magicDef = 218.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 73.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 73.4,
			modelId = 120030,
			magicDef = 218.2,
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
		[15004203] = {
			normalSkill = 1209801,
			name = "徘徊雨具",
			pre_magicAtk = 894.1,
			maxHp = 3811.9,
			aiName = "ai_120098_黑伞人",
			battleCamp = 1,
			career = 4,
			magicAtk = 894.1,
			pre_meleeDef = 218.2,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1209802,
			weakPointHpRate = 0,
			meleeDef = 218.2,
			level = 56,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 89.4,
			pre_meleeAtk = 89.4,
			pre_maxHp = 3811.9,
			colorType = 1,
			monsterType = 0,
			id = 15004203,
			mobility = 2,
			pre_magicDef = 326.3,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 73.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 73.4,
			modelId = 120098,
			magicDef = 326.3,
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
