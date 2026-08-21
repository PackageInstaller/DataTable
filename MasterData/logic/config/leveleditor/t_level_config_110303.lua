-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110303.lua

module("logic.config.leveleditor.t_level_config_110303", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110303",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通3-3",
	lossConditionDesc = "",
	sceneId = "111003",
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
			x = 17,
			y = 6
		},
		{
			direction = 4,
			x = 18,
			y = 5
		},
		{
			direction = 4,
			x = 17,
			y = 4
		},
		{
			direction = 4,
			x = 18,
			y = 3
		},
		{
			direction = 4,
			x = 18,
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
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 11030301,
					x = 10,
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
			groupName = "精英伴生",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 11030303,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 11030303,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 11030302,
					x = 10,
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
			groupName = "第一波接敌",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 11030302,
					x = 13,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 11030302,
					x = 14,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 11030303,
					x = 12,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[11030301] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 29.7,
			maxHp = 10258.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 29.7,
			pre_meleeDef = 198,
			sanity = 0,
			remark = "守卫精英（主动攻击触发2次锥刺并回血坚韧）",
			giftSkill = 1206702,
			weakPointHpRate = 0.3,
			meleeDef = 198,
			level = 25,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 297.1,
			pre_meleeAtk = 297.1,
			pre_maxHp = 10258.5,
			colorType = 2,
			monsterType = 1,
			id = 11030301,
			mobility = 2,
			pre_magicDef = 93,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 41.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 41.5,
			modelId = 120067,
			magicDef = 93,
			specialSkill = 1206703,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			}
		},
		[11030302] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 30.5,
			maxHp = 1544.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 30.5,
			pre_meleeDef = 178.2,
			sanity = 0,
			remark = "守卫小怪（主动攻击触发2次锥刺）",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 178.2,
			level = 25,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 304.8,
			pre_meleeAtk = 304.8,
			pre_maxHp = 1544.4,
			colorType = 2,
			monsterType = 0,
			id = 11030302,
			mobility = 2,
			pre_magicDef = 83.7,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 38.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.5,
			modelId = 120067,
			magicDef = 83.7,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			}
		},
		[11030303] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 33.2,
			maxHp = 1100,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 33.2,
			pre_meleeDef = 151.2,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 151.2,
			level = 25,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 331.9,
			pre_meleeAtk = 331.9,
			pre_maxHp = 1100,
			colorType = 3,
			monsterType = 0,
			id = 11030303,
			mobility = 2,
			pre_magicDef = 83.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 58.5,
			modelId = 120088,
			magicDef = 83.7,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			}
		}
	}
}

return configData
