-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150043.lua

module("logic.config.leveleditor.t_level_config_150043", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150043",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面43",
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
			direction = 4,
			x = 11,
			y = 9
		},
		{
			direction = 4,
			x = 11,
			y = 8
		},
		{
			direction = 4,
			x = 11,
			y = 7
		},
		{
			direction = 4,
			x = 11,
			y = 6
		},
		{
			direction = 4,
			x = 11,
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
			groupName = "幻影精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 15004301,
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
			groupName = "狙击小怪",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 15004302,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 15004302,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 15004302,
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
			groupName = "陨灭小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 15004303,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 15004303,
					x = 8,
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
		[15004301] = {
			normalSkill = 1201601,
			name = "巡逻道闸",
			pre_magicAtk = 81,
			maxHp = 34099.5,
			aiName = "ai_120016_巡逻道闸",
			battleCamp = 1,
			career = 1,
			magicAtk = 81,
			pre_meleeDef = 399,
			sanity = 0,
			remark = "幻影精英",
			giftSkill = 1201602,
			weakPointHpRate = 0.3,
			meleeDef = 399,
			level = 57,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 810.3,
			pre_meleeAtk = 810.3,
			pre_maxHp = 34099.5,
			colorType = 1,
			monsterType = 1,
			id = 15004301,
			mobility = 4,
			pre_magicDef = 244.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 66.8,
			modelId = 120016,
			magicDef = 244.4,
			specialSkill = 0,
			extraSkills = {
				1201603
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
		[15004302] = {
			normalSkill = 1207001,
			name = "彩绘积木",
			pre_magicAtk = 81.2,
			maxHp = 4659.9,
			aiName = "ai_120070_涂鸦积木",
			battleCamp = 1,
			career = 3,
			magicAtk = 81.2,
			pre_meleeDef = 331.4,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 1207003,
			weakPointHpRate = 0,
			meleeDef = 331.4,
			level = 57,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 812,
			pre_meleeAtk = 812,
			pre_maxHp = 4659.9,
			colorType = 3,
			monsterType = 0,
			id = 15004302,
			mobility = 2,
			pre_magicDef = 222.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 73.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 73.8,
			modelId = 120070,
			magicDef = 222.1,
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
		[15004303] = {
			normalSkill = 1209401,
			name = "曳行空调",
			pre_magicAtk = 791.3,
			maxHp = 4796.2,
			aiName = "ai_120094_空调狂热者",
			battleCamp = 1,
			career = 5,
			magicAtk = 791.3,
			pre_meleeDef = 254.9,
			sanity = 0,
			remark = "陨灭小怪",
			giftSkill = 1209403,
			weakPointHpRate = 0,
			meleeDef = 254.9,
			level = 57,
			monsterGroup = "法术陨灭小怪",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 79.1,
			pre_meleeAtk = 79.1,
			pre_maxHp = 4796.2,
			colorType = 4,
			monsterType = 0,
			id = 15004303,
			mobility = 1,
			pre_magicDef = 344,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 6,
			pre_inspire = 63.8,
			modelId = 120094,
			magicDef = 344,
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
		}
	}
}

return configData
