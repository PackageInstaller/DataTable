-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120201.lua

module("logic.config.leveleditor.t_level_config_120201", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120201",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "2-断章A-1",
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
			y = 4
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1006,
			times = 1,
			posList = {
				{
					x = 6,
					y = 9
				}
			}
		}
	},
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
			targetId = 2000053,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 2,
			form = 5,
			plotStr = "1001",
			round = 4,
			hasSymbol = false,
			groupName = "狙击",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 12020101,
					x = 5,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "奶",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 12020102,
					x = 4,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "守卫",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 12020103,
					x = 5,
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "狙击精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 12020104,
					x = 5,
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
			monsterId = 12020105,
			pos = {
				x = 4,
				y = 4
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[12020101] = {
			normalSkill = 1200801,
			name = "迷雾使徒",
			pre_magicAtk = 20.2,
			maxHp = 840.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 20.2,
			pre_meleeDef = 113.4,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 113.4,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 202.1,
			pre_meleeAtk = 202.1,
			pre_maxHp = 840.4,
			colorType = 3,
			monsterType = 0,
			id = 12020101,
			mobility = 2,
			pre_magicDef = 70.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120008,
			magicDef = 70.2,
			specialSkill = 1200802,
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
		[12020102] = {
			normalSkill = 1200901,
			name = "迷雾使徒",
			pre_magicAtk = 210.4,
			maxHp = 760,
			aiName = "ai_治疗",
			battleCamp = 1,
			career = 6,
			magicAtk = 210.4,
			pre_meleeDef = 79.2,
			sanity = 0,
			remark = "",
			giftSkill = 1200903,
			weakPointHpRate = 0,
			meleeDef = 79.2,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 21,
			pre_meleeAtk = 21,
			pre_maxHp = 760,
			colorType = 4,
			monsterType = 0,
			id = 12020102,
			mobility = 2,
			pre_magicDef = 124.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35,
			modelId = 120009,
			magicDef = 124.2,
			specialSkill = 1200902,
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
		[12020103] = {
			normalSkill = 1200701,
			name = "迷雾使徒",
			pre_magicAtk = 19,
			maxHp = 1178.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 19,
			pre_meleeDef = 134.1,
			sanity = 0,
			remark = "",
			giftSkill = 1200702,
			weakPointHpRate = 0,
			meleeDef = 134.1,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 190.3,
			pre_meleeAtk = 190.3,
			pre_maxHp = 1178.3,
			colorType = 2,
			monsterType = 0,
			id = 12020103,
			mobility = 2,
			pre_magicDef = 70.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35,
			modelId = 120007,
			magicDef = 70.2,
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
		[12020104] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 25.5,
			maxHp = 1671.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 25.5,
			pre_meleeDef = 126,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0.5,
			meleeDef = 126,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 255.4,
			pre_meleeAtk = 255.4,
			pre_maxHp = 1671.6,
			colorType = 3,
			monsterType = 1,
			id = 12020104,
			mobility = 2,
			pre_magicDef = 78,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 58,
			modelId = 120030,
			magicDef = 78,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[12020105] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 359,
			maxHp = 1086,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 359,
			pre_meleeDef = 84,
			sanity = 0,
			remark = "",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 84,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 101,
			pre_meleeAtk = 101,
			pre_maxHp = 1086,
			colorType = 1,
			monsterType = 0,
			id = 12020105,
			mobility = 2,
			pre_magicDef = 134,
			aiStepOrder = 1,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 56,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 100013,
			magicDef = 134,
			specialSkill = 1101302,
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
