-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110204.lua

module("logic.config.leveleditor.t_level_config_110204", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110204",
	plotEventGroup = 110204,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "主线普通2-4",
	lossConditionDesc = "",
	sceneId = "110002",
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
			x = 12,
			y = 11
		},
		{
			direction = 3,
			x = 13,
			y = 11
		},
		{
			direction = 3,
			x = 12,
			y = 12
		},
		{
			direction = 3,
			x = 13,
			y = 12
		},
		{
			direction = 4,
			x = 11,
			y = 13
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1022,
			times = 1,
			posList = {
				{
					x = 8,
					y = 12
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
			groupName = "前排单位",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 11020404,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 11020402,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11020402,
					x = 11,
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
			groupName = "后方骚然",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 11,
					tag = "",
					monsterId = 11020403,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 11020403,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 11020403,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 13,
					tag = "",
					monsterId = 11020403,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 12,
					tag = "",
					monsterId = 11020403,
					x = 6,
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
			y = 8
		},
		{
			x = 8,
			y = 12
		}
	},
	lockHeroList = {},
	monsters = {
		[11020401] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 11.9,
			maxHp = 596.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 11.9,
			pre_meleeDef = 77.05,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 77.05,
			level = 13,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 118.9,
			pre_meleeAtk = 118.9,
			pre_maxHp = 596.5,
			colorType = 2,
			monsterType = 0,
			id = 11020401,
			mobility = 2,
			pre_magicDef = 34,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 29.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 29.2,
			modelId = 120067,
			magicDef = 34,
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
		[11020402] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 12.7,
			maxHp = 423.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 12.7,
			pre_meleeDef = 63.75,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 63.75,
			level = 13,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 126.9,
			pre_meleeAtk = 126.9,
			pre_maxHp = 423.2,
			colorType = 3,
			monsterType = 0,
			id = 11020402,
			mobility = 2,
			pre_magicDef = 34.3,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 49.2,
			modelId = 120030,
			magicDef = 34.3,
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
		[11020403] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 12.3,
			maxHp = 484.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 12.3,
			pre_meleeDef = 71.1,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 71.1,
			level = 13,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 122.6,
			pre_meleeAtk = 122.6,
			pre_maxHp = 484.6,
			colorType = 1,
			monsterType = 0,
			id = 11020403,
			mobility = 4,
			pre_magicDef = 33.45,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 39.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 39.2,
			modelId = 120089,
			magicDef = 33.45,
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
		},
		[11020404] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 13,
			maxHp = 2779.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 13,
			pre_meleeDef = 90.7,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0.3,
			meleeDef = 90.7,
			level = 13,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 129.4,
			pre_meleeAtk = 129.4,
			pre_maxHp = 2779.4,
			colorType = 2,
			monsterType = 1,
			id = 11020404,
			mobility = 2,
			pre_magicDef = 40,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 34.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 34.7,
			modelId = 120067,
			magicDef = 40,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
