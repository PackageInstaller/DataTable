-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_151005.lua

module("logic.config.leveleditor.t_level_config_151005", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "151005",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "样板爬塔5",
	lossConditionDesc = "",
	sceneId = "190011",
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
			x = 5,
			y = 4
		},
		{
			direction = 2,
			x = 4,
			y = 4
		},
		{
			direction = 2,
			x = 5,
			y = 3
		},
		{
			direction = 2,
			x = 4,
			y = 3
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
			groupName = "boss",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15100501,
					x = 4,
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
			groupName = "支援小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 15100502,
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
		[15100501] = {
			normalSkill = 1283601,
			name = "猎食者",
			pre_magicAtk = 100.4,
			maxHp = 2017.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 100.4,
			pre_meleeDef = 64.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 64.8,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 255,
			pre_meleeAtk = 255,
			pre_maxHp = 2017.8,
			colorType = 1,
			monsterType = 2,
			id = 15100501,
			mobility = 2,
			pre_magicDef = 59.8,
			aiStepOrder = 0,
			trumpSkill = 1283603,
			isFuzzy = false,
			inspire = 26.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 26.4,
			modelId = 120017,
			magicDef = 59.8,
			specialSkill = 1283602,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[15100502] = {
			normalSkill = 1281101,
			name = "支援gros1",
			pre_magicAtk = 229.8,
			maxHp = 213.8,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 229.8,
			pre_meleeDef = 59.8,
			sanity = 0,
			remark = "",
			giftSkill = 1281102,
			weakPointHpRate = 0,
			meleeDef = 59.8,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 111,
			pre_meleeAtk = 111,
			pre_maxHp = 213.8,
			colorType = 4,
			monsterType = 0,
			id = 15100502,
			mobility = 2,
			pre_magicDef = 78.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 20.9,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 20.9,
			modelId = 100060,
			magicDef = 78.2,
			specialSkill = 1281103,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		}
	}
}

return configData
