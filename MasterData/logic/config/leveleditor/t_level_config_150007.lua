-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150007.lua

module("logic.config.leveleditor.t_level_config_150007", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150007",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "爬塔明面7",
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
			direction = 3,
			x = 5,
			y = 6
		},
		{
			direction = 3,
			x = 6,
			y = 6
		},
		{
			direction = 3,
			x = 4,
			y = 6
		},
		{
			direction = 1,
			x = 4,
			y = 8
		},
		{
			direction = 1,
			x = 5,
			y = 7
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
			groupName = "小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 15000701,
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
					monsterId = 15000703,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 15000701,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 15000701,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 15000701,
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
			groupName = "左右狙击",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 15000702,
					x = 2,
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
					monsterId = 15000702,
					x = 8,
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
		[15000701] = {
			normalSkill = 1200701,
			name = "迷雾使徒",
			pre_magicAtk = 26.3,
			maxHp = 2393.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 26.3,
			pre_meleeDef = 178.2,
			sanity = 0,
			remark = "",
			giftSkill = 1200702,
			weakPointHpRate = 0,
			meleeDef = 178.2,
			level = 25,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 262.9,
			pre_meleeAtk = 262.9,
			pre_maxHp = 2393.8,
			colorType = 2,
			monsterType = 0,
			id = 15000701,
			mobility = 2,
			pre_magicDef = 83.7,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 38.5,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.5,
			modelId = 120007,
			magicDef = 83.7,
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
		[15000702] = {
			normalSkill = 1200801,
			name = "迷雾使徒",
			pre_magicAtk = 28.1,
			maxHp = 1705,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 28.1,
			pre_meleeDef = 151.2,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 151.2,
			level = 25,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 280.7,
			pre_meleeAtk = 280.7,
			pre_maxHp = 1705,
			colorType = 3,
			monsterType = 0,
			id = 15000702,
			mobility = 2,
			pre_magicDef = 83.7,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58.5,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 58.5,
			modelId = 120008,
			magicDef = 83.7,
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
		[15000703] = {
			normalSkill = 1200901,
			name = "迷雾使徒",
			pre_magicAtk = 293.2,
			maxHp = 1463.5,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 293.2,
			pre_meleeDef = 93.6,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 93.6,
			level = 25,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 29.3,
			pre_meleeAtk = 29.3,
			pre_maxHp = 1463.5,
			colorType = 4,
			monsterType = 0,
			id = 15000703,
			mobility = 2,
			pre_magicDef = 165.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 38.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.5,
			modelId = 120009,
			magicDef = 165.6,
			specialSkill = 1200902,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			}
		}
	}
}

return configData
