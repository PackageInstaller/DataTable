-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_940001.lua

module("logic.config.leveleditor.t_level_config_940001", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "940001",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "体验关卡9/9",
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
			direction = 1,
			x = 6,
			y = 4
		},
		{
			direction = 1,
			x = 9,
			y = 5
		},
		{
			direction = 2,
			x = 10,
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 94000102,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 94000102,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 94000102,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 94000102,
					x = 12,
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
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 94000101,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 94000104,
			pos = {
				x = 6,
				y = 4
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 94000103,
			pos = {
				x = 9,
				y = 5
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 94000105,
			pos = {
				x = 10,
				y = 5
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[94000101] = {
			normalSkill = 1200601,
			name = "迷雾使徒",
			pre_magicAtk = 68.8,
			maxHp = 1819,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 68.8,
			pre_meleeDef = 30,
			sanity = 0,
			remark = "",
			giftSkill = 1740001,
			weakPointHpRate = 0,
			meleeDef = 30,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 90,
			pre_meleeAtk = 90,
			pre_maxHp = 1819,
			colorType = 2,
			monsterType = 0,
			id = 94000101,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 120007,
			magicDef = 37.8,
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
		},
		[94000102] = {
			normalSkill = 1284301,
			name = "迷雾使徒",
			pre_magicAtk = 140.9,
			maxHp = 175,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 140.9,
			pre_meleeDef = 108.8,
			sanity = 0,
			remark = "",
			giftSkill = 1284302,
			weakPointHpRate = 0,
			meleeDef = 108.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 150,
			pre_meleeAtk = 150,
			pre_maxHp = 175,
			colorType = 1,
			monsterType = 0,
			id = 94000102,
			mobility = 4,
			pre_magicDef = 77.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 19.8,
			camp = 7,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 0,
			monsterGroupEnum = 1,
			pre_inspire = 19.8,
			modelId = 120006,
			magicDef = 77.6,
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
		[94000103] = {
			normalSkill = 1102001,
			name = "安布蕾拉",
			pre_magicAtk = 88.8,
			maxHp = 449.8,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 2,
			magicAtk = 88.8,
			pre_meleeDef = 69,
			sanity = 0,
			remark = "",
			giftSkill = 1102004,
			weakPointHpRate = 0,
			meleeDef = 69,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 220.8,
			pre_meleeAtk = 220.8,
			pre_maxHp = 449.8,
			colorType = 2,
			monsterType = 0,
			id = 94000103,
			mobility = 2,
			pre_magicDef = 48.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 19.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 19.4,
			modelId = 100020,
			magicDef = 48.8,
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
		},
		[94000104] = {
			normalSkill = 1200701,
			name = "烟火",
			pre_magicAtk = 96.5,
			maxHp = 200.1,
			aiName = "auto_yanhuo_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 96.5,
			pre_meleeDef = 62.2,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 62.2,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 244.8,
			pre_meleeAtk = 244.8,
			pre_maxHp = 200.1,
			colorType = 1,
			monsterType = 0,
			id = 94000104,
			mobility = 4,
			pre_magicDef = 48.8,
			aiStepOrder = 1,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 24.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 24.4,
			modelId = 100016,
			magicDef = 48.8,
			specialSkill = 1101602,
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
		[94000105] = {
			normalSkill = 1102201,
			name = "飞鸟",
			pre_magicAtk = 82.6,
			maxHp = 94,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 3,
			magicAtk = 82.6,
			pre_meleeDef = 43,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 43,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 206.4,
			pre_meleeAtk = 206.4,
			pre_maxHp = 94,
			colorType = 3,
			monsterType = 0,
			id = 94000105,
			mobility = 2,
			pre_magicDef = 32.5,
			aiStepOrder = 1,
			trumpSkill = 1102203,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100022,
			magicDef = 32.5,
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
		}
	}
}

return configData
