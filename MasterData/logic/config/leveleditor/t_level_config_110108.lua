-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110108.lua

module("logic.config.leveleditor.t_level_config_110108", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110108",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通1-8",
	lossConditionDesc = "",
	sceneId = "117005",
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
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 7,
			y = 3
		},
		{
			direction = 1,
			x = 9,
			y = 5
		},
		{
			direction = 1,
			x = 9,
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
			groupName = "精英",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11010804,
					x = 6,
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
			groupName = "远程单位",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11010802,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "侧面的幻影",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11010803,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 11010803,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 11,
			y = 7
		},
		{
			x = 6,
			y = 6
		}
	},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 2000022,
			direction = 1,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 7,
				y = 3
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[11010801] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 9.8,
			maxHp = 317.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 9.8,
			pre_meleeDef = 60,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 60,
			level = 9,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 97.8,
			pre_meleeAtk = 97.8,
			pre_maxHp = 317.6,
			colorType = 2,
			monsterType = 0,
			id = 11010801,
			mobility = 2,
			pre_magicDef = 28,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 25,
			modelId = 120090,
			magicDef = 28,
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
		[11010802] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 10.4,
			maxHp = 222.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 10.4,
			pre_meleeDef = 49.6,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 49.6,
			level = 9,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 104.2,
			pre_meleeAtk = 104.2,
			pre_maxHp = 222.6,
			colorType = 3,
			monsterType = 0,
			id = 11010802,
			mobility = 2,
			pre_magicDef = 28,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120088,
			magicDef = 28,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			}
		},
		[11010803] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 10.1,
			maxHp = 256.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 10.1,
			pre_meleeDef = 55.2,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 55.2,
			level = 9,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 100.7,
			pre_meleeAtk = 100.7,
			pre_maxHp = 256.8,
			colorType = 1,
			monsterType = 0,
			id = 11010803,
			mobility = 4,
			pre_magicDef = 28,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35,
			modelId = 120089,
			magicDef = 28,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[11010804] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 10.6,
			maxHp = 2075.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 10.6,
			pre_meleeDef = 75,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 75,
			level = 9,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 106.3,
			pre_meleeAtk = 106.3,
			pre_maxHp = 2075.4,
			colorType = 2,
			monsterType = 1,
			id = 11010804,
			mobility = 2,
			pre_magicDef = 35,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 33,
			modelId = 120090,
			magicDef = 35,
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
		[11010805] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 12.8,
			maxHp = 1529.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 12.8,
			pre_meleeDef = 62,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 62,
			level = 9,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 128.3,
			pre_meleeAtk = 128.3,
			pre_maxHp = 1529.7,
			colorType = 3,
			monsterType = 1,
			id = 11010805,
			mobility = 2,
			pre_magicDef = 35,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120088,
			magicDef = 35,
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
		[11010806] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 11.8,
			maxHp = 1720.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 11.8,
			pre_meleeDef = 69,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0.3,
			meleeDef = 69,
			level = 9,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 117.5,
			pre_meleeAtk = 117.5,
			pre_maxHp = 1720.9,
			colorType = 1,
			monsterType = 1,
			id = 11010806,
			mobility = 4,
			pre_magicDef = 35,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 43,
			modelId = 120089,
			magicDef = 35,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			}
		}
	}
}

return configData
