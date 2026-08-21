-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120113.lua

module("logic.config.leveleditor.t_level_config_120113", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120113",
	plotEventGroup = 200123,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "1-断章B-3",
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
			direction = 1,
			x = 7,
			y = 6
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
					condition = 3,
					monsterIds = {
						12011304
					}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 1,
			maxDeadCount = 0,
			count = 3,
			hasTag = false,
			DIYName = "",
			isBackup = false,
			tag = "",
			targetId = 12011304,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
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
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 12011304,
					x = 7,
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
			form = 1,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "放映机",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 12,
					tag = "",
					monsterId = 12011305,
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
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 12011303,
					x = 9,
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
					monsterId = 12011303,
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
	lockHeroList = {},
	monsters = {
		[12011301] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 16.5,
			maxHp = 559.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 16.5,
			pre_meleeDef = 96.3,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 96.3,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 164.9,
			pre_meleeAtk = 164.9,
			pre_maxHp = 559.9,
			colorType = 3,
			monsterType = 0,
			id = 12011301,
			mobility = 2,
			pre_magicDef = 48.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 52,
			modelId = 120030,
			magicDef = 48.6,
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
		[12011302] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 175.7,
			maxHp = 470.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 175.7,
			pre_meleeDef = 48.6,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 48.6,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 17.6,
			pre_meleeAtk = 17.6,
			pre_maxHp = 470.5,
			colorType = 3,
			monsterType = 0,
			id = 12011302,
			mobility = 2,
			pre_magicDef = 96.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 52,
			modelId = 120029,
			magicDef = 96.3,
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
		[12011303] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 15.6,
			maxHp = 761.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 15.6,
			pre_meleeDef = 115.2,
			sanity = 0,
			remark = "",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 115.2,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 156.3,
			pre_meleeAtk = 156.3,
			pre_maxHp = 761.4,
			colorType = 2,
			monsterType = 0,
			id = 12011303,
			mobility = 2,
			pre_magicDef = 48.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 32,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 32,
			modelId = 120028,
			magicDef = 48.6,
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
		[12011304] = {
			normalSkill = 1209702,
			name = "徘徊者",
			pre_magicAtk = 20,
			maxHp = 1111,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 20,
			pre_meleeDef = 112,
			sanity = 0,
			remark = "",
			giftSkill = 1209703,
			weakPointHpRate = 0.5,
			meleeDef = 112,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 199.7,
			pre_meleeAtk = 199.7,
			pre_maxHp = 1111,
			colorType = 4,
			monsterType = 1,
			id = 12011304,
			mobility = 1,
			pre_magicDef = 64,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120097,
			magicDef = 64,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"B"
			},
			tags = {}
		},
		[12011305] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 45.3,
			maxHp = 35833.3,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 45.3,
			pre_meleeDef = 234,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 234,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 453.2,
			pre_meleeAtk = 453.2,
			pre_maxHp = 35833.3,
			colorType = 2,
			monsterType = 0,
			id = 12011305,
			mobility = 0,
			pre_magicDef = 122,
			aiStepOrder = 0,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 45,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120087,
			magicDef = 122,
			specialSkill = 1208702,
			extraSkills = {
				1208705
			},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
