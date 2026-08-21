-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120213.lua

module("logic.config.leveleditor.t_level_config_120213", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120213",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "2-断章B-3",
	lossConditionDesc = "",
	sceneId = "108004",
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
			x = 1,
			y = 3
		},
		{
			direction = 1,
			x = 2,
			y = 1
		},
		{
			direction = 1,
			x = 1,
			y = 2
		},
		{
			direction = 1,
			x = 2,
			y = 2
		},
		{
			direction = 1,
			x = 1,
			y = 1
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 1,
					y = 14
				},
				{
					x = 2,
					y = 14
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
					condition = 9,
					monsterIds = {
						12021301
					}
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
			targetId = 12021301,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 3,
			plotStr = "1001",
			round = 2,
			hasSymbol = false,
			groupName = "友军",
			color = 8,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 12021301,
					x = 1,
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
			form = 6,
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
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 12021304,
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
			form = 6,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "陨灭",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 12021303,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 12021303,
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
					monsterId = 12021302,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 12021302,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "守卫3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 12021302,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[12021301] = {
			normalSkill = 1200401,
			name = "霁",
			pre_magicAtk = 213.1,
			maxHp = 936.1,
			aiName = "ai-断章2-b3",
			battleCamp = 3,
			career = 6,
			magicAtk = 213.1,
			pre_meleeDef = 76.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 76.5,
			level = 20,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 21.3,
			pre_meleeAtk = 21.3,
			pre_maxHp = 936.1,
			colorType = 4,
			monsterType = 0,
			id = 12021301,
			mobility = 2,
			pre_magicDef = 117.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = 0,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 120004,
			magicDef = 117.9,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			}
		},
		[12021302] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 19,
			maxHp = 1538.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 19,
			pre_meleeDef = 126.9,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 126.9,
			level = 20,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 190.4,
			pre_meleeAtk = 190.4,
			pre_maxHp = 1538.6,
			colorType = 2,
			monsterType = 0,
			id = 12021302,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 120067,
			magicDef = 68.4,
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
		[12021303] = {
			normalSkill = 1201001,
			name = "迷雾使徒",
			pre_magicAtk = 20,
			maxHp = 1110.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 20,
			pre_meleeDef = 112.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 112.5,
			level = 20,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 200.1,
			pre_meleeAtk = 200.1,
			pre_maxHp = 1110.7,
			colorType = 4,
			monsterType = 0,
			id = 12021303,
			mobility = 1,
			pre_magicDef = 80.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 46,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46,
			modelId = 120010,
			magicDef = 80.1,
			specialSkill = 1201002,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[12021304] = {
			normalSkill = 1201001,
			name = "迷雾使徒",
			pre_magicAtk = 24.7,
			maxHp = 4081,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 24.7,
			pre_meleeDef = 125,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.5,
			meleeDef = 125,
			level = 20,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 247.3,
			pre_meleeAtk = 247.3,
			pre_maxHp = 4081,
			colorType = 4,
			monsterType = 1,
			id = 12021304,
			mobility = 1,
			pre_magicDef = 89,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 49,
			modelId = 120010,
			magicDef = 89,
			specialSkill = 1201002,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"B"
			}
		}
	}
}

return configData
