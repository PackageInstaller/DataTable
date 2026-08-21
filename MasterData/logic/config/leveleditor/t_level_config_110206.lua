-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110206.lua

module("logic.config.leveleditor.t_level_config_110206", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal03_block",
	remarks = "",
	levelId = "110206",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通2-6",
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
			x = 5,
			y = 6
		},
		{
			direction = 1,
			x = 4,
			y = 7
		},
		{
			direction = 1,
			x = 6,
			y = 7
		},
		{
			direction = 3,
			x = 6,
			y = 5
		},
		{
			direction = 3,
			x = 4,
			y = 5
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1022,
			times = 1,
			posList = {
				{
					x = 5,
					y = 2
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "前排",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 11020602,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11020602,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 11020602,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "输出",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 11020601,
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
					monsterId = 11020601,
					x = 4,
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
					monsterId = 11020601,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11020601,
					x = 6,
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
					monsterId = 11020601,
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
			groupName = "精英",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11020603,
					x = 5,
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
			x = 5,
			y = 10
		},
		{
			x = 5,
			y = 2
		}
	},
	lockHeroList = {},
	monsters = {
		[11020601] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 14.1,
			maxHp = 323,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 14.1,
			pre_meleeDef = 83.6,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 83.6,
			level = 14,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 141.2,
			pre_meleeAtk = 141.2,
			pre_maxHp = 523,
			colorType = 2,
			monsterType = 0,
			id = 11020601,
			mobility = 2,
			pre_magicDef = 34.85,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 29.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 29.8,
			modelId = 120067,
			magicDef = 34.85,
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
		[11020602] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 14.1,
			maxHp = 323,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 14.1,
			pre_meleeDef = 83.6,
			sanity = 0,
			remark = "",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 83.6,
			level = 14,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 141.2,
			pre_meleeAtk = 141.2,
			pre_maxHp = 523,
			colorType = 2,
			monsterType = 0,
			id = 11020602,
			mobility = 2,
			pre_magicDef = 34.85,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 29.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 29.8,
			modelId = 120014,
			magicDef = 34.85,
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
		[11020603] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 16.7,
			maxHp = 2221.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 16.7,
			pre_meleeDef = 81,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0.3,
			meleeDef = 81,
			level = 14,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 166.5,
			pre_meleeAtk = 166.5,
			pre_maxHp = 2221.1,
			colorType = 3,
			monsterType = 1,
			id = 11020603,
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
			modelId = 120030,
			magicDef = 41.7,
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
		}
	}
}

return configData
