-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130809.lua

module("logic.config.leveleditor.t_level_config_130809", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130809",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "支援材料本-9",
	lossConditionDesc = "",
	sceneId = "109002",
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
			x = 3,
			y = 7
		},
		{
			direction = 2,
			x = 3,
			y = 3
		},
		{
			direction = 2,
			x = 3,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 4
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
					DIYName = "10回合内击杀所有迷雾使徒",
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
			DIYName = "暮雪死亡",
			isBackup = false,
			tag = "",
			targetId = 13080901,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "保护友方目标",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = true,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 13080901,
					x = 4,
					initialStatus = {
						hpPercent = 0.45,
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
			groupName = "怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 13080902,
					x = 13,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 13080902,
					x = 12,
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
					monsterId = 13080902,
					x = 12,
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
					monsterId = 13080902,
					x = 15,
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
					monsterId = 13080902,
					x = 15,
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
					monsterId = 13080902,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 13080902,
					x = 13,
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
					monsterId = 13080902,
					x = 12,
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
			x = 12,
			y = 5
		},
		{
			x = 3,
			y = 7
		}
	},
	lockHeroList = {},
	monsters = {
		[13080901] = {
			normalSkill = 1228101,
			name = "暮雪",
			pre_magicAtk = 1000,
			maxHp = 17500,
			aiName = "ai-支援本-友方炮台",
			battleCamp = 3,
			career = 5,
			magicAtk = 9000,
			pre_meleeDef = 1000,
			sanity = 0,
			remark = "",
			giftSkill = 1228103,
			weakPointHpRate = 0,
			meleeDef = 9000,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 9000,
			pre_meleeAtk = 1000,
			pre_maxHp = 2000,
			colorType = 4,
			monsterType = 0,
			id = 13080901,
			mobility = 0,
			pre_magicDef = 1000,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 10,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 10,
			modelId = 100021,
			magicDef = 9000,
			specialSkill = 1228102,
			extraSkills = {},
			attributeGrade = {
				"C",
				"A",
				"A",
				"A",
				"A"
			},
			tags = {}
		},
		[13080902] = {
			normalSkill = 1228202,
			name = "迷雾使徒",
			pre_magicAtk = 100,
			maxHp = 1000,
			aiName = "ai-支援本-敌方炮台",
			battleCamp = 1,
			career = 5,
			magicAtk = 100,
			pre_meleeDef = 1000,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 9000,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 100,
			pre_meleeAtk = 100,
			pre_maxHp = 1000,
			colorType = 4,
			monsterType = 0,
			id = 13080902,
			mobility = 0,
			pre_magicDef = 1000,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 10,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 10,
			modelId = 120010,
			magicDef = 9000,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"C",
				"A"
			},
			tags = {}
		}
	}
}

return configData
