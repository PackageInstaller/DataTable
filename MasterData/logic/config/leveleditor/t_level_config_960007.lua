-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_960007.lua

module("logic.config.leveleditor.t_level_config_960007", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "960007",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "CPJ-H1.7",
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
			direction = 3,
			x = 4,
			y = 7
		},
		{
			direction = 3,
			x = 5,
			y = 7
		},
		{
			direction = 3,
			x = 6,
			y = 7
		},
		{
			direction = 1,
			x = 6,
			y = 8
		},
		{
			direction = 1,
			x = 7,
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
			groupName = "左下攻坚",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 96000703,
					x = 1,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 96000703,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 96000701,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 96000702,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 96000703,
					x = 5,
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
		[96000701] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 13.8,
			maxHp = 2985.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 13.8,
			pre_meleeDef = 98.3,
			sanity = 0,
			remark = "守卫精英（振荡2次；范围变大）",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 98.3,
			level = 14,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 138.2,
			pre_meleeAtk = 138.2,
			pre_maxHp = 2985.3,
			colorType = 2,
			monsterType = 1,
			id = 96000701,
			mobility = 2,
			pre_magicDef = 41,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 35.3,
			modelId = 120090,
			magicDef = 41,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			}
		},
		[96000702] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 16.7,
			maxHp = 2221.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 16.7,
			pre_meleeDef = 81,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 81,
			level = 14,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 166.5,
			pre_meleeAtk = 166.5,
			pre_maxHp = 2221.1,
			colorType = 3,
			monsterType = 1,
			id = 96000702,
			mobility = 2,
			pre_magicDef = 41.7,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 55.3,
			modelId = 120088,
			magicDef = 41.7,
			specialSkill = 1208802,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			}
		},
		[96000703] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 13.1,
			maxHp = 528.15,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 13.1,
			pre_meleeDef = 76.8,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 76.8,
			level = 14,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 131,
			pre_meleeAtk = 131,
			pre_maxHp = 528.15,
			colorType = 1,
			monsterType = 0,
			id = 96000703,
			mobility = 4,
			pre_magicDef = 34.55,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 39.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 39.8,
			modelId = 120089,
			magicDef = 34.55,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		}
	}
}

return configData
