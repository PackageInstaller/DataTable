-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132303.lua

module("logic.config.leveleditor.t_level_config_132303", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "132303",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "装备本-狙击03",
	lossConditionDesc = "",
	sceneId = "132301",
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
			y = 7
		},
		{
			direction = 2,
			x = 4,
			y = 7
		},
		{
			direction = 2,
			x = 3,
			y = 6
		},
		{
			direction = 2,
			x = 4,
			y = 5
		},
		{
			direction = 2,
			x = 5,
			y = 5
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
						13230301
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
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 13230301,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[13230301] = {
			normalSkill = 1210701,
			name = "零号女仆",
			pre_magicAtk = 33.9,
			maxHp = 13691.6,
			aiName = "ai_零号女仆",
			battleCamp = 1,
			career = 3,
			magicAtk = 33.9,
			pre_meleeDef = 120,
			sanity = 0,
			remark = "狙击装备本boss",
			giftSkill = 1210705,
			weakPointHpRate = 0.3,
			meleeDef = 120,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 338.8,
			pre_meleeAtk = 338.8,
			pre_maxHp = 13691.6,
			colorType = 3,
			monsterType = 2,
			id = 13230301,
			mobility = 2,
			pre_magicDef = 76,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 61,
			camp = 5,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 61,
			modelId = 120107,
			magicDef = 76,
			specialSkill = 1210702,
			extraSkills = {
				1210703
			},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
