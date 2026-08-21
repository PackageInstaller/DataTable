-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150105.lua

module("logic.config.leveleditor.t_level_config_150105", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150105",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "爬塔暗面1-5",
	lossConditionDesc = "",
	sceneId = "114001",
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
			x = 8,
			y = 9
		},
		{
			direction = 3,
			x = 10,
			y = 9
		},
		{
			direction = 3,
			x = 9,
			y = 9
		},
		{
			direction = 3,
			x = 5,
			y = 9
		},
		{
			direction = 3,
			x = 4,
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 15010504,
					x = 7,
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
					monsterId = 15010502,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15010503,
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
			groupName = "精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15010501,
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
	trialHeroes = {},
	monsters = {
		[15010501] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 1039.6,
			maxHp = 26738,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 1039.6,
			pre_meleeDef = 260,
			sanity = 0,
			remark = "绿特异精英-高难度（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0.3,
			meleeDef = 260,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 104,
			pre_meleeAtk = 104,
			pre_maxHp = 26738,
			colorType = 3,
			monsterType = 1,
			id = 15010501,
			mobility = 2,
			pre_magicDef = 385,
			aiStepOrder = 2,
			trumpSkill = 1209304,
			isFuzzy = false,
			inspire = 78,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 78,
			modelId = 120093,
			magicDef = 385,
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
		[15010502] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 76.8,
			maxHp = 7272.7,
			aiName = "ai_120014_禁行隔离墩",
			battleCamp = 1,
			career = 2,
			magicAtk = 76.8,
			pre_meleeDef = 400.5,
			sanity = 0,
			remark = "守卫精英（受到攻击后获得1层[坚韧]）",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 400.5,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 767.9,
			pre_meleeAtk = 767.9,
			pre_maxHp = 7272.7,
			colorType = 2,
			monsterType = 0,
			id = 15010502,
			mobility = 2,
			pre_magicDef = 232.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120014,
			magicDef = 232.2,
			specialSkill = 0,
			extraSkills = {
				1201404
			},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[15010503] = {
			normalSkill = 1201601,
			name = "巡逻道闸",
			pre_magicAtk = 80.4,
			maxHp = 5846.8,
			aiName = "ai_120016_巡逻道闸",
			battleCamp = 1,
			career = 1,
			magicAtk = 80.4,
			pre_meleeDef = 375.3,
			sanity = 0,
			remark = "幻影精英-高难度",
			giftSkill = 1201602,
			weakPointHpRate = 0,
			meleeDef = 375.3,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 803.7,
			pre_meleeAtk = 803.7,
			pre_maxHp = 5846.8,
			colorType = 1,
			monsterType = 0,
			id = 15010503,
			mobility = 4,
			pre_magicDef = 231.3,
			aiStepOrder = 0,
			trumpSkill = 1201604,
			isFuzzy = false,
			inspire = 65,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120016,
			magicDef = 231.3,
			specialSkill = 0,
			extraSkills = {
				1201603
			},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[15010504] = {
			normalSkill = 1208101,
			name = "拟态/葵",
			pre_magicAtk = 825.2,
			maxHp = 5181,
			aiName = "ai_120081_尖刺",
			battleCamp = 1,
			career = 5,
			magicAtk = 825.2,
			pre_meleeDef = 267.3,
			sanity = 0,
			remark = "陨灭精英-高难度",
			giftSkill = 1208103,
			weakPointHpRate = 0,
			meleeDef = 267.3,
			level = 60,
			monsterGroup = "法术陨灭小怪",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.5,
			pre_meleeAtk = 82.5,
			pre_maxHp = 5181,
			colorType = 4,
			monsterType = 0,
			id = 15010504,
			mobility = 1,
			pre_magicDef = 359.1,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 6,
			pre_inspire = 65,
			modelId = 120081,
			magicDef = 359.1,
			specialSkill = 1208104,
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
