-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110302.lua

module("logic.config.leveleditor.t_level_config_110302", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110302",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 3,
	levelName = "主线普通3-2",
	lossConditionDesc = "",
	sceneId = "112002",
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
			x = 5,
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
					round = 3,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "在罪天使小队的猛攻下存活3回合",
					condition = 2,
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
			groupName = "安布蕾拉",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 11030202,
					x = 5,
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
			groupName = "暮雪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11030203,
					x = 5,
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
			groupName = "安妮薇",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 11030201,
					x = 6,
					initialStatus = {
						hpPercent = 100,
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
			heroId = 2000022,
			direction = 1,
			heroType = 2,
			monsterId = 11030204,
			pos = {
				x = 5,
				y = 6
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[11030201] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 366,
			maxHp = 924.3,
			aiName = "auto_anniwei_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 366,
			pre_meleeDef = 83.7,
			sanity = 0,
			remark = "",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 83.7,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 36.6,
			pre_meleeAtk = 36.6,
			pre_maxHp = 924.3,
			colorType = 1,
			monsterType = 0,
			id = 11030201,
			mobility = 2,
			pre_magicDef = 151.2,
			aiStepOrder = 0,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 58.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 58.5,
			modelId = 100013,
			magicDef = 151.2,
			specialSkill = 1101302,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[11030202] = {
			normalSkill = 1102001,
			name = "安布蕾拉",
			pre_magicAtk = 30.5,
			maxHp = 1544.4,
			aiName = "auto_anbuleila_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 30.5,
			pre_meleeDef = 178.2,
			sanity = 0,
			remark = "",
			giftSkill = 1102004,
			weakPointHpRate = 0,
			meleeDef = 178.2,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 304.8,
			pre_meleeAtk = 304.8,
			pre_maxHp = 1544.4,
			colorType = 2,
			monsterType = 0,
			id = 11030202,
			mobility = 2,
			pre_magicDef = 83.7,
			aiStepOrder = 0,
			trumpSkill = 1102003,
			isFuzzy = false,
			inspire = 38.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.5,
			modelId = 100020,
			magicDef = 83.7,
			specialSkill = 1102002,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[11030203] = {
			normalSkill = 1102101,
			name = "暮雪",
			pre_magicAtk = 32.5,
			maxHp = 1126,
			aiName = "auto_muxue_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 32.5,
			pre_meleeDef = 157.5,
			sanity = 0,
			remark = "",
			giftSkill = 1102104,
			weakPointHpRate = 0,
			meleeDef = 157.5,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 324.6,
			pre_meleeAtk = 324.6,
			pre_maxHp = 1126,
			colorType = 4,
			monsterType = 0,
			id = 11030203,
			mobility = 1,
			pre_magicDef = 98.1,
			aiStepOrder = 0,
			trumpSkill = 1102103,
			isFuzzy = false,
			inspire = 48.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 48.5,
			modelId = 100021,
			magicDef = 98.1,
			specialSkill = 1102102,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[11030204] = {
			normalSkill = 1102201,
			name = "飞鸟",
			pre_magicAtk = 34.7,
			maxHp = 6260.9,
			aiName = "auto_feiniao_ai",
			battleCamp = 0,
			career = 3,
			magicAtk = 34.7,
			pre_meleeDef = 168,
			sanity = 0,
			remark = "",
			giftSkill = 1102204,
			weakPointHpRate = 0,
			meleeDef = 168,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 346.7,
			pre_meleeAtk = 346.7,
			pre_maxHp = 6260.9,
			colorType = 3,
			monsterType = 0,
			id = 11030204,
			mobility = 2,
			pre_magicDef = 93,
			aiStepOrder = 0,
			trumpSkill = 1102203,
			isFuzzy = false,
			inspire = 61.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 61.5,
			modelId = 100022,
			magicDef = 93,
			specialSkill = 1102202,
			extraSkills = {
				1102208,
				1102299
			},
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
