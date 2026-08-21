-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_999002.lua

module("logic.config.leveleditor.t_level_config_999002", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "999002",
	plotEventGroup = 990002,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "wlf个人测试2",
	lossConditionDesc = "",
	sceneId = "931002",
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
			direction = 2,
			x = 1,
			y = 11
		},
		{
			direction = 2,
			x = 1,
			y = 9
		},
		{
			direction = 2,
			x = 1,
			y = 7
		},
		{
			direction = 2,
			x = 1,
			y = 5
		},
		{
			direction = 2,
			x = 1,
			y = 3
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1011,
			times = 1,
			posList = {
				{
					x = 5,
					y = 11
				},
				{
					x = 6,
					y = 11
				},
				{
					x = 7,
					y = 11
				},
				{
					x = 8,
					y = 9
				},
				{
					x = 8,
					y = 7
				},
				{
					x = 8,
					y = 5
				},
				{
					x = 7,
					y = 3
				},
				{
					x = 6,
					y = 3
				},
				{
					x = 5,
					y = 3
				}
			}
		},
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 14,
					y = 11
				},
				{
					x = 14,
					y = 9
				},
				{
					x = 14,
					y = 7
				},
				{
					x = 14,
					y = 5
				},
				{
					x = 14,
					y = 3
				}
			}
		},
		{
			terrainId = 1001,
			times = 1,
			posList = {
				{
					x = 11,
					y = 11
				},
				{
					x = 11,
					y = 3
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
					condition = 6,
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
			groupName = "幻",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 13,
					tag = "",
					monsterId = 99900201,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 99900201,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 99900201,
					x = 11,
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
					monsterId = 99900201,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "104",
			refreshType = 4,
			form = 1,
			plotStr = "202",
			round = 1,
			hasSymbol = false,
			groupName = "盾",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 99900202,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 99900202,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 99900202,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "103",
			refreshType = 4,
			form = 3,
			plotStr = "201",
			round = 4,
			hasSymbol = false,
			groupName = "法",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 99900203,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 99900203,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "101",
			refreshType = 4,
			form = 5,
			plotStr = "101",
			round = 1,
			hasSymbol = false,
			groupName = "狙击",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 99900204,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 99900204,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 99900204,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 99900204,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 99900204,
					x = 9,
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
		[99900201] = {
			normalSkill = 1213215,
			name = "猎食者",
			pre_magicAtk = 22.9,
			maxHp = 12589.2,
			aiName = "boss_equipment_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 22.9,
			pre_meleeDef = 128,
			sanity = 0,
			remark = "",
			giftSkill = 1213217,
			weakPointHpRate = 0.19,
			meleeDef = 128,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 228.8,
			pre_meleeAtk = 228.8,
			pre_maxHp = 12589.2,
			colorType = 2,
			monsterType = 2,
			id = 99900201,
			mobility = 4,
			pre_magicDef = 54,
			aiStepOrder = 3,
			trumpSkill = 1213216,
			isFuzzy = false,
			inspire = 37,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 37,
			modelId = 120017,
			magicDef = 54,
			specialSkill = 1213219,
			extraSkills = {
				1213220
			},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[99900202] = {
			normalSkill = 1282101,
			name = "禁行隔离墩",
			pre_magicAtk = 92.5,
			maxHp = 813.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 92.5,
			pre_meleeDef = 118.3,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 118.3,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 229.8,
			pre_meleeAtk = 229.8,
			pre_maxHp = 813.6,
			colorType = 2,
			monsterType = 1,
			id = 99900202,
			mobility = 2,
			pre_magicDef = 50.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 20.9,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 20.9,
			modelId = 120014,
			magicDef = 50.8,
			specialSkill = 1282102,
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
		[99900203] = {
			normalSkill = 1280701,
			name = "红特异gros",
			pre_magicAtk = 277.4,
			maxHp = 178.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 277.4,
			pre_meleeDef = 51.5,
			sanity = 0,
			remark = "",
			giftSkill = 1280702,
			weakPointHpRate = 0,
			meleeDef = 51.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 111,
			pre_meleeAtk = 111,
			pre_maxHp = 178.3,
			colorType = 1,
			monsterType = 0,
			id = 99900203,
			mobility = 2,
			pre_magicDef = 78.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.9,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 120012,
			magicDef = 78.2,
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
		[99900204] = {
			normalSkill = 1281401,
			name = "迷雾使徒",
			pre_magicAtk = 111,
			maxHp = 178.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 111,
			pre_meleeDef = 68,
			sanity = 0,
			remark = "",
			giftSkill = 1281402,
			weakPointHpRate = 0,
			meleeDef = 68,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 277.4,
			pre_meleeAtk = 277.4,
			pre_maxHp = 178.3,
			colorType = 3,
			monsterType = 0,
			id = 99900204,
			mobility = 2,
			pre_magicDef = 51.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 120008,
			magicDef = 51.5,
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
		}
	}
}

return configData
