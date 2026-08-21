-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150047.lua

module("logic.config.leveleditor.t_level_config_150047", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150047",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面47",
	lossConditionDesc = "",
	sceneId = "110001",
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
			x = 4,
			y = 11
		},
		{
			direction = 3,
			x = 5,
			y = 11
		},
		{
			direction = 3,
			x = 6,
			y = 11
		},
		{
			direction = 2,
			x = 2,
			y = 9
		},
		{
			direction = 2,
			x = 2,
			y = 8
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
			groupName = "精英特异",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 15004701,
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
			groupName = "支援小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 15004702,
					x = 7,
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
					monsterId = 15004702,
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
			groupName = "幻影小怪",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 15004703,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15004703,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15004703,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15004703,
					x = 3,
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
		[15004701] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 1091.5,
			maxHp = 27356,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 1091.5,
			pre_meleeDef = 269,
			sanity = 0,
			remark = "绿特异精英（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0.3,
			meleeDef = 269,
			level = 61,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 109.2,
			pre_meleeAtk = 109.2,
			pre_maxHp = 27356,
			colorType = 3,
			monsterType = 1,
			id = 15004701,
			mobility = 2,
			pre_magicDef = 407,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 78.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 78.5,
			modelId = 120093,
			magicDef = 407,
			specialSkill = 0,
			extraSkills = {
				1209303
			},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15004702] = {
			normalSkill = 1209501,
			name = "抽水花洒",
			pre_magicAtk = 948.4,
			maxHp = 4492,
			aiName = "ai_120095_抽水花洒",
			battleCamp = 1,
			career = 6,
			magicAtk = 948.4,
			pre_meleeDef = 264.2,
			sanity = 0,
			remark = "支援小怪",
			giftSkill = 1209503,
			weakPointHpRate = 0,
			meleeDef = 264.2,
			level = 61,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 94.8,
			pre_meleeAtk = 94.8,
			pre_maxHp = 4492,
			colorType = 4,
			monsterType = 0,
			id = 15004702,
			mobility = 2,
			pre_magicDef = 396.9,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55.5,
			modelId = 120095,
			magicDef = 396.9,
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
		[15004703] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 84.5,
			maxHp = 5993.5,
			aiName = "ai_120015_矿工探灯",
			battleCamp = 1,
			career = 1,
			magicAtk = 84.5,
			pre_meleeDef = 396.9,
			sanity = 0,
			remark = "幻影小怪（普攻破甲+追击）",
			giftSkill = 1201502,
			weakPointHpRate = 0,
			meleeDef = 396.9,
			level = 61,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 845,
			pre_meleeAtk = 845,
			pre_maxHp = 5993.5,
			colorType = 1,
			monsterType = 0,
			id = 15004703,
			mobility = 4,
			pre_magicDef = 239.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65.5,
			modelId = 120015,
			magicDef = 239.8,
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
