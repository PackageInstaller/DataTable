-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110144.lua

module("logic.config.leveleditor.t_level_config_110144", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110144",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "新困难1-6",
	lossConditionDesc = "",
	sceneId = "109006",
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
			y = 3
		},
		{
			direction = 1,
			x = 6,
			y = 4
		},
		{
			direction = 3,
			x = 7,
			y = 3
		},
		{
			direction = 3,
			x = 8,
			y = 3
		},
		{
			direction = 1,
			x = 7,
			y = 4
		},
		{
			direction = 3,
			x = 6,
			y = 3
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
			groupName = "后排高压力怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 11014404,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11014401,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11014404,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 11014402,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 11014403,
					x = 4,
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
		[11014401] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 16.2,
			maxHp = 2680,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 16.2,
			pre_meleeDef = 97,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 97,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 162.1,
			pre_meleeAtk = 162.1,
			pre_maxHp = 2680,
			colorType = 1,
			monsterType = 1,
			id = 11014401,
			mobility = 4,
			pre_magicDef = 42,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 46,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 46,
			modelId = 120089,
			magicDef = 42,
			specialSkill = 1208904,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[11014402] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 14.7,
			maxHp = 3191.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 14.7,
			pre_meleeDef = 106,
			sanity = 0,
			remark = "守卫精英（振荡2次；范围变大）",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 106,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 147,
			pre_meleeAtk = 147,
			pre_maxHp = 3191.3,
			colorType = 2,
			monsterType = 1,
			id = 11014402,
			mobility = 2,
			pre_magicDef = 42,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 120090,
			magicDef = 42,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[11014403] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 14.4,
			maxHp = 651.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 14.4,
			pre_meleeDef = 78.3,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 78.3,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 144.2,
			pre_meleeAtk = 144.2,
			pre_maxHp = 651.8,
			colorType = 3,
			monsterType = 0,
			id = 11014403,
			mobility = 2,
			pre_magicDef = 38.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120088,
			magicDef = 38.7,
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
		[11014404] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 14,
			maxHp = 738.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 14,
			pre_meleeDef = 87.3,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 87.3,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 139.5,
			pre_meleeAtk = 139.5,
			pre_maxHp = 738.7,
			colorType = 1,
			monsterType = 0,
			id = 11014404,
			mobility = 4,
			pre_magicDef = 37.8,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 43,
			modelId = 120089,
			magicDef = 37.8,
			specialSkill = 1208902,
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
