-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132309.lua

module("logic.config.leveleditor.t_level_config_132309", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "132309",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "装备本-狙击09",
	lossConditionDesc = "",
	sceneId = "113001",
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
			y = 7
		},
		{
			direction = 2,
			x = 11,
			y = 8
		},
		{
			direction = 2,
			x = 11,
			y = 6
		},
		{
			direction = 2,
			x = 10,
			y = 5
		},
		{
			direction = 2,
			x = 11,
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
						13230901
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
					y = 11,
					tag = "",
					monsterId = 13230901,
					x = 14,
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
		[13230901] = {
			normalSkill = 1210701,
			name = "零号女仆",
			pre_magicAtk = 186.5,
			maxHp = 170783.2,
			aiName = "ai_零号女仆",
			battleCamp = 1,
			career = 3,
			magicAtk = 186.5,
			pre_meleeDef = 656,
			sanity = 0,
			remark = "狙击装备本boss",
			giftSkill = 1210708,
			weakPointHpRate = 0.3,
			meleeDef = 656,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1864.5,
			pre_meleeAtk = 1864.5,
			pre_maxHp = 170783.2,
			colorType = 3,
			monsterType = 2,
			id = 13230901,
			mobility = 2,
			pre_magicDef = 463,
			aiStepOrder = 3,
			trumpSkill = 1210704,
			isFuzzy = false,
			inspire = 90,
			camp = 5,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120107,
			magicDef = 463,
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
