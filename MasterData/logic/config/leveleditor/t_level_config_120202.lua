-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120202.lua

module("logic.config.leveleditor.t_level_config_120202", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120202",
	plotEventGroup = 200212,
	maxPerson = 1,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "2-断章A-2",
	lossConditionDesc = "",
	sceneId = "112001",
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
			x = 6,
			y = 7
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 0,
					y = 7
				},
				{
					x = 0,
					y = 8
				},
				{
					x = 0,
					y = 6
				},
				{
					x = 0,
					y = 9
				},
				{
					x = 0,
					y = 5
				}
			}
		},
		{
			terrainId = 1006,
			times = 1,
			posList = {
				{
					x = 7,
					y = 5
				},
				{
					x = 7,
					y = 9
				}
			}
		}
	},
	winConditionGroupList = {
		{
			tag = "201",
			isBackup = false,
			hasTag = true,
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
		},
		{
			tag = "202",
			isBackup = true,
			hasTag = true,
			winConditionList = {
				{
					round = 10,
					heroId = 0,
					count = 12020201,
					monsterTag = "",
					DIYName = "",
					condition = 9,
					monsterIds = {
						12020201
					}
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
			form = 3,
			plotStr = "1001",
			round = 2,
			hasSymbol = false,
			groupName = "徘徊者",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 12020202,
					x = 10,
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
			form = 2,
			plotStr = "101",
			round = 1,
			hasSymbol = false,
			groupName = "召唤1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 12020202,
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
					monsterId = 12020202,
					x = 11,
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
					monsterId = 12020202,
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
			form = 2,
			plotStr = "101",
			round = 1,
			hasSymbol = false,
			groupName = "召唤2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 12020202,
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
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 12020201,
			pos = {
				x = 6,
				y = 7
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[12020201] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 359,
			maxHp = 1086,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 309,
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
			id = 12020201,
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
		},
		[12020202] = {
			normalSkill = 1209704,
			name = "徘徊者",
			pre_magicAtk = 201,
			maxHp = 2350,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 201,
			pre_meleeDef = 156,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.5,
			meleeDef = 156,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 255.4,
			pre_meleeAtk = 255.4,
			pre_maxHp = 2350,
			colorType = 3,
			monsterType = 1,
			id = 12020202,
			mobility = 2,
			pre_magicDef = 126,
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
			modelId = 120097,
			magicDef = 126,
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
		[12020203] = {
			normalSkill = 1209704,
			name = "徘徊者",
			pre_magicAtk = 201,
			maxHp = 2350,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 201,
			pre_meleeDef = 156,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 156,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 255.4,
			pre_meleeAtk = 255.4,
			pre_maxHp = 2350,
			colorType = 3,
			monsterType = 1,
			id = 12020203,
			mobility = 2,
			pre_magicDef = 126,
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
			modelId = 120097,
			magicDef = 126,
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
		[12020204] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 19,
			maxHp = 1178.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 19,
			pre_meleeDef = 134.1,
			sanity = 0,
			remark = "",
			giftSkill = 1202802,
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
			id = 12020204,
			mobility = 2,
			pre_magicDef = 70.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35,
			modelId = 120028,
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
		[12020205] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 277.8,
			maxHp = 1404.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 277.8,
			pre_meleeDef = 78,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0.5,
			meleeDef = 78,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 27.8,
			pre_meleeAtk = 27.8,
			pre_maxHp = 1404.6,
			colorType = 3,
			monsterType = 1,
			id = 12020205,
			mobility = 2,
			pre_magicDef = 126,
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
			magicDef = 126,
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
