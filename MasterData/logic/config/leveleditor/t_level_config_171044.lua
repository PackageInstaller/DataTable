-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171044.lua

module("logic.config.leveleditor.t_level_config_171044", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "钢琴教学",
	levelId = "171044",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "钢琴04",
	lossConditionDesc = "",
	sceneId = "930003",
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
			x = 2,
			y = 2
		},
		{
			direction = 1,
			x = 3,
			y = 2
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
						17104401
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 17104401,
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
			direction = 1,
			heroType = 2,
			monsterId = 17104402,
			pos = {
				x = 2,
				y = 2
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 17104403,
			pos = {
				x = 3,
				y = 2
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[17104401] = {
			normalSkill = 1217141,
			name = "容易害羞的钢琴",
			pre_magicAtk = 380.7,
			maxHp = 1085,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 380.7,
			pre_meleeDef = 90,
			sanity = 0,
			remark = "",
			giftSkill = 1217145,
			weakPointHpRate = 0,
			meleeDef = 90,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 38.1,
			pre_meleeAtk = 38.1,
			pre_maxHp = 1085,
			colorType = 1,
			monsterType = 2,
			id = 17104401,
			mobility = 0,
			pre_magicDef = 180,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120100,
			magicDef = 180,
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
		},
		[17104402] = {
			normalSkill = 1102201,
			name = "飞鸟",
			pre_magicAtk = 93.6,
			maxHp = 1530,
			aiName = "",
			battleCamp = 2,
			career = 3,
			magicAtk = 93.6,
			pre_meleeDef = 74,
			sanity = 0,
			remark = "",
			giftSkill = 1102204,
			weakPointHpRate = 0,
			meleeDef = 74,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 282,
			pre_meleeAtk = 282,
			pre_maxHp = 1530,
			colorType = 3,
			monsterType = 0,
			id = 17104402,
			mobility = 2,
			pre_magicDef = 59.1,
			aiStepOrder = 5,
			trumpSkill = 1102203,
			isFuzzy = false,
			inspire = 34,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 34,
			modelId = 100022,
			magicDef = 59.1,
			specialSkill = 1102202,
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
		[17104403] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 84.6,
			maxHp = 1780,
			aiName = "",
			battleCamp = 2,
			career = 1,
			magicAtk = 84.6,
			pre_meleeDef = 76,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 76,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 250,
			pre_meleeAtk = 250,
			pre_maxHp = 1780,
			colorType = 1,
			monsterType = 0,
			id = 17104403,
			mobility = 4,
			pre_magicDef = 68.6,
			aiStepOrder = 4,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 27,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 27,
			modelId = 100016,
			magicDef = 68.6,
			specialSkill = 1101602,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
