-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100003.lua

module("logic.config.leveleditor.t_level_config_100003", package.seeall)

local configData = {
	battleMusicName = "music_battle_shenhua_buxiu_block",
	remarks = "",
	levelId = "100003",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "序章-3",
	lossConditionDesc = "",
	sceneId = "109001",
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
			x = 10,
			y = 5
		},
		{
			direction = 2,
			x = 10,
			y = 8
		}
	},
	additionalTerrainList = {},
	winConditionGroupList = {
		{
			tag = "102",
			isBackup = false,
			hasTag = false,
			winConditionList = {
				{
					round = 10,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "击败未知原体",
					condition = 10,
					monsterIds = {
						10000301
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "不朽",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 10000301,
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
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000302,
			pos = {
				x = 10,
				y = 8
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000303,
			pos = {
				x = 10,
				y = 5
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[10000301] = {
			normalSkill = 1202601,
			name = "未知原体",
			pre_magicAtk = 165,
			maxHp = 6240,
			aiName = "ai-不朽-序章",
			battleCamp = 1,
			career = 4,
			magicAtk = 165,
			pre_meleeDef = 34,
			sanity = 0,
			remark = "",
			giftSkill = 1202607,
			weakPointHpRate = 0,
			meleeDef = 34,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 49.5,
			pre_meleeAtk = 49.5,
			pre_maxHp = 3240,
			colorType = 3,
			monsterType = 2,
			id = 10000301,
			mobility = 0,
			pre_magicDef = 61,
			aiStepOrder = 0,
			trumpSkill = 1202603,
			isFuzzy = false,
			inspire = 55,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120026,
			magicDef = 61,
			specialSkill = 1202602,
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
		[10000302] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 41.5,
			maxHp = 800,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 41.5,
			pre_meleeDef = 84.1,
			sanity = 0,
			remark = "",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 84.1,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 152.3,
			pre_meleeAtk = 152.3,
			pre_maxHp = 800,
			colorType = 1,
			monsterType = 0,
			id = 10000302,
			mobility = 4,
			pre_magicDef = 34.8,
			aiStepOrder = 0,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 38.1,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.1,
			modelId = 100011,
			magicDef = 34.8,
			specialSkill = 1101102,
			extraSkills = {
				1760001
			},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[10000303] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 38,
			maxHp = 800,
			aiName = "auto_yanhuo_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 38,
			pre_meleeDef = 63.1,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 63.1,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 167.5,
			pre_meleeAtk = 167.5,
			pre_maxHp = 800,
			colorType = 1,
			monsterType = 0,
			id = 10000303,
			mobility = 4,
			pre_magicDef = 29.8,
			aiStepOrder = 0,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 38.8,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.8,
			modelId = 100016,
			magicDef = 29.8,
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
