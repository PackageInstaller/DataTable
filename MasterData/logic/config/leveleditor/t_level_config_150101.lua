-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150101.lua

module("logic.config.leveleditor.t_level_config_150101", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "嘉乐爬塔暗面1-1",
	levelId = "150101",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "爬塔暗面1-1",
	lossConditionDesc = "",
	sceneId = "110001",
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
			x = 6,
			y = 9
		},
		{
			direction = 3,
			x = 5,
			y = 8
		},
		{
			direction = 3,
			x = 4,
			y = 9
		},
		{
			direction = 2,
			x = 9,
			y = 9
		},
		{
			direction = 2,
			x = 10,
			y = 10
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
			groupName = "左边",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15010102,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15010103,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15010101,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15010102,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "右边",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15010103,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 15010102,
					x = 11,
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
					monsterId = 15010102,
					x = 13,
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
		[15010101] = {
			normalSkill = 1209401,
			name = "曳行空调",
			pre_magicAtk = 607.9,
			maxHp = 3270.9,
			aiName = "ai_120094_空调狂热者",
			battleCamp = 1,
			career = 5,
			magicAtk = 607.9,
			pre_meleeDef = 193.5,
			sanity = 0,
			remark = "陨灭小怪",
			giftSkill = 1209403,
			weakPointHpRate = 0,
			meleeDef = 193.5,
			level = 50,
			monsterGroup = "法术陨灭小怪",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 60.8,
			pre_meleeAtk = 60.8,
			pre_maxHp = 3270.9,
			colorType = 4,
			monsterType = 0,
			id = 15010101,
			mobility = 1,
			pre_magicDef = 270.9,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 6,
			pre_inspire = 60,
			modelId = 120094,
			magicDef = 270.9,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"B",
				"B"
			},
			tags = {}
		},
		[15010102] = {
			normalSkill = 1200701,
			name = "迷雾使徒",
			pre_magicAtk = 56.7,
			maxHp = 4529.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 56.7,
			pre_meleeDef = 306,
			sanity = 0,
			remark = "守卫小怪",
			giftSkill = 1200702,
			weakPointHpRate = 0,
			meleeDef = 306,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 566.9,
			pre_meleeAtk = 566.9,
			pre_maxHp = 4529.1,
			colorType = 2,
			monsterType = 0,
			id = 15010102,
			mobility = 2,
			pre_magicDef = 164.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120007,
			magicDef = 164.7,
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
		[15010103] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 693.9,
			maxHp = 2678.7,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 693.9,
			pre_meleeDef = 165.6,
			sanity = 0,
			remark = "蓝特异小怪（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0,
			meleeDef = 165.6,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 69.4,
			pre_meleeAtk = 69.4,
			pre_maxHp = 2678.7,
			colorType = 2,
			monsterType = 0,
			id = 15010103,
			mobility = 2,
			pre_magicDef = 260.1,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120093,
			magicDef = 260.1,
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
		}
	}
}

return configData
