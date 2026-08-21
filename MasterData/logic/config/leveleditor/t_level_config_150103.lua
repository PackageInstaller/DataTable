-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150103.lua

module("logic.config.leveleditor.t_level_config_150103", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150103",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔暗面1-3",
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
			direction = 3,
			x = 10,
			y = 9
		},
		{
			direction = 3,
			x = 7,
			y = 8
		},
		{
			direction = 3,
			x = 12,
			y = 9
		},
		{
			direction = 3,
			x = 6,
			y = 9
		},
		{
			direction = 3,
			x = 11,
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15010301,
					x = 11,
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
					monsterId = 15010301,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15010303,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15010303,
					x = 7,
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
			groupName = "精英陨灭",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15010302,
					x = 10,
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
		[15010301] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 71.5,
			maxHp = 6372.3,
			aiName = "ai_120090_路障角兽",
			battleCamp = 1,
			career = 2,
			magicAtk = 71.5,
			pre_meleeDef = 372.6,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 372.6,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 715.1,
			pre_meleeAtk = 715.1,
			pre_maxHp = 6372.3,
			colorType = 2,
			monsterType = 0,
			id = 15010301,
			mobility = 2,
			pre_magicDef = 213.3,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120090,
			magicDef = 213.3,
			specialSkill = 1209003,
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
		[15010302] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 85.2,
			maxHp = 24026.1,
			aiName = "ai_120069_疯狂车轴",
			battleCamp = 1,
			career = 5,
			magicAtk = 85.2,
			pre_meleeDef = 371,
			sanity = 0,
			remark = "陨灭精英（具有3层及以上的轰鸣时；主动攻击必定暴击；暴伤提升）",
			giftSkill = 1206903,
			weakPointHpRate = 0.3,
			meleeDef = 371,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 851.6,
			pre_meleeAtk = 851.6,
			pre_maxHp = 24026.1,
			colorType = 4,
			monsterType = 1,
			id = 15010302,
			mobility = 1,
			pre_magicDef = 274,
			aiStepOrder = 1,
			trumpSkill = 1206902,
			isFuzzy = false,
			inspire = 66,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 4,
			monsterGroupEnum = 1,
			pre_inspire = 66,
			modelId = 120069,
			magicDef = 274,
			specialSkill = 0,
			extraSkills = {
				1206904
			},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"B"
			},
			tags = {}
		},
		[15010303] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 76.9,
			maxHp = 4539.7,
			aiName = "ai_120069_疯狂车轴",
			battleCamp = 1,
			career = 5,
			magicAtk = 76.9,
			pre_meleeDef = 333.9,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 333.9,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 768.7,
			pre_meleeAtk = 768.7,
			pre_maxHp = 4539.7,
			colorType = 4,
			monsterType = 0,
			id = 15010303,
			mobility = 1,
			pre_magicDef = 246.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 63,
			modelId = 120069,
			magicDef = 246.6,
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
