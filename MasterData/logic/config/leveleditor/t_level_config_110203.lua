-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110203.lua

module("logic.config.leveleditor.t_level_config_110203", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110203",
	plotEventGroup = 110203,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "主线普通2-3",
	lossConditionDesc = "",
	sceneId = "110002",
	winConditionDesc = "保护迷雾使徒并击败所有敌方",
	forbidAction = {
		auto = false,
		move = false,
		strengthenSkill = false,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 2,
			x = 4,
			y = 14
		},
		{
			direction = 2,
			x = 4,
			y = 13
		},
		{
			direction = 3,
			x = 3,
			y = 12
		},
		{
			direction = 3,
			x = 2,
			y = 12
		},
		{
			direction = 3,
			x = 1,
			y = 12
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1022,
			times = 1,
			posList = {
				{
					x = 5,
					y = 10
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
			condition = 2,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "",
			isBackup = false,
			tag = "",
			targetId = 11020301,
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
			groupName = "己方保护对象",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = true,
					direction = 2,
					y = 13,
					tag = "",
					monsterId = 11020301,
					x = 2,
					initialStatus = {
						hpPercent = 0.6,
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
			groupName = "精英敌人",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 13,
					tag = "",
					monsterId = 11020304,
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
			groupName = "右侧怪物组",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 11020303,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 11020303,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 13,
					tag = "",
					monsterId = 11020303,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 11020303,
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
			groupName = "下方怪物组",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 11020303,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 11020303,
					x = 1,
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
					monsterId = 11020303,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 11020302,
					x = 2,
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
			x = 2,
			y = 8
		},
		{
			x = 5,
			y = 10
		},
		{
			x = 6,
			y = 13
		}
	},
	lockHeroList = {},
	monsters = {
		[11020301] = {
			normalSkill = 1200601,
			name = "迷雾使徒",
			pre_magicAtk = 11.4,
			maxHp = 440.95,
			aiName = "",
			battleCamp = 3,
			career = 1,
			magicAtk = 11.4,
			pre_meleeDef = 65.45,
			sanity = 0,
			remark = "",
			giftSkill = 1200602,
			weakPointHpRate = 0,
			meleeDef = 65.45,
			level = 12,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 114.1,
			pre_meleeAtk = 114.1,
			pre_maxHp = 440.95,
			colorType = 1,
			monsterType = 0,
			id = 11020301,
			mobility = 4,
			pre_magicDef = 32.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 38.5,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.5,
			modelId = 120006,
			magicDef = 32.3,
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
		},
		[11020302] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 11.1,
			maxHp = 547,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 11.1,
			pre_meleeDef = 70.55,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 70.55,
			level = 12,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 110.6,
			pre_meleeAtk = 110.6,
			pre_maxHp = 547,
			colorType = 2,
			monsterType = 0,
			id = 11020302,
			mobility = 2,
			pre_magicDef = 33.15,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 28.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 28.5,
			modelId = 120067,
			magicDef = 33.15,
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
		[11020303] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 11.8,
			maxHp = 383.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 11.8,
			pre_meleeDef = 58.65,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 58.65,
			level = 12,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 118.2,
			pre_meleeAtk = 118.2,
			pre_maxHp = 383.7,
			colorType = 3,
			monsterType = 0,
			id = 11020303,
			mobility = 2,
			pre_magicDef = 33.15,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 48.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 48.5,
			modelId = 120030,
			magicDef = 33.15,
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
		[11020304] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 12.1,
			maxHp = 2573.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 12.1,
			pre_meleeDef = 83,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0.3,
			meleeDef = 83,
			level = 12,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 120.6,
			pre_meleeAtk = 120.6,
			pre_maxHp = 2573.4,
			colorType = 2,
			monsterType = 1,
			id = 11020304,
			mobility = 2,
			pre_magicDef = 39,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 34,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 34,
			modelId = 120067,
			magicDef = 39,
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
