-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120121.lua

module("logic.config.leveleditor.t_level_config_120121", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal03_block",
	remarks = "",
	levelId = "120121",
	plotEventGroup = 200131,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 15,
	levelName = "1-断章C-1",
	lossConditionDesc = "",
	sceneId = "930101",
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
			y = 10
		},
		{
			direction = 1,
			x = 2,
			y = 10
		},
		{
			direction = 1,
			x = 1,
			y = 9
		},
		{
			direction = 1,
			x = 2,
			y = 7
		},
		{
			direction = 1,
			x = 2,
			y = 9
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 7,
					y = 2
				},
				{
					x = 8,
					y = 2
				},
				{
					x = 9,
					y = 2
				}
			}
		},
		{
			terrainId = 8001,
			times = 0,
			posList = {
				{
					x = 3,
					y = 12
				}
			}
		},
		{
			terrainId = 8002,
			times = 0,
			posList = {
				{
					x = 3,
					y = 11
				}
			}
		},
		{
			terrainId = 8003,
			times = 0,
			posList = {
				{
					x = 11,
					y = 10
				}
			}
		},
		{
			terrainId = 8004,
			times = 0,
			posList = {
				{
					x = 12,
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
					count = 1,
					monsterTag = "",
					DIYName = "",
					condition = 7,
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
			refreshType = 1,
			form = 5,
			plotStr = "1001",
			round = 2,
			hasSymbol = false,
			groupName = "狙击",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12012101,
					x = 2,
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
			groupName = "盾",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 12012103,
					x = 3,
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
					monsterId = 12012103,
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
			form = 4,
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
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 12012104,
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
			refreshType = 4,
			form = 3,
			plotStr = "101",
			round = 1,
			hasSymbol = false,
			groupName = "法2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 12012102,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 12012102,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 4,
			form = 5,
			plotStr = "102",
			round = 1,
			hasSymbol = false,
			groupName = "狙3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12012101,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12012101,
					x = 10,
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
			x = 6,
			y = 1
		}
	},
	lockHeroList = {},
	monsters = {
		[12012101] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 14.4,
			maxHp = 651.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 14.4,
			pre_meleeDef = 78.3,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
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
			id = 12012101,
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
			modelId = 120030,
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
		[12012102] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 155.1,
			maxHp = 547.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 155.1,
			pre_meleeDef = 38.7,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 38.7,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 15.5,
			pre_meleeAtk = 15.5,
			pre_maxHp = 547.7,
			colorType = 3,
			monsterType = 0,
			id = 12012102,
			mobility = 2,
			pre_magicDef = 78.3,
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
			modelId = 120029,
			magicDef = 78.3,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[12012103] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 13.6,
			maxHp = 894.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 13.6,
			pre_meleeDef = 95.4,
			sanity = 0,
			remark = "",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 95.4,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 135.6,
			pre_meleeAtk = 135.6,
			pre_maxHp = 894.2,
			colorType = 2,
			monsterType = 0,
			id = 12012103,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 33,
			modelId = 120028,
			magicDef = 37.8,
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
		[12012104] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 211.6,
			maxHp = 2175.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 211.6,
			pre_meleeDef = 53,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0.3,
			meleeDef = 53,
			level = 18,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 21.2,
			pre_meleeAtk = 21.2,
			pre_maxHp = 2175.8,
			colorType = 3,
			monsterType = 1,
			id = 12012104,
			mobility = 2,
			pre_magicDef = 94,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 58,
			modelId = 120029,
			magicDef = 94,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		}
	}
}

return configData
