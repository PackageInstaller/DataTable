-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130202.lua

module("logic.config.leveleditor.t_level_config_130202", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130202",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 4,
	levelName = "经验本难度2",
	lossConditionDesc = "",
	sceneId = "111002",
	winConditionDesc = "4回合内尽可能造成更多伤害",
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
			x = 4,
			y = 13
		},
		{
			direction = 2,
			x = 3,
			y = 11
		},
		{
			direction = 2,
			x = 4,
			y = 10
		},
		{
			direction = 4,
			x = 9,
			y = 11
		},
		{
			direction = 4,
			x = 8,
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
					round = 4,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
					monsterIds = {}
				}
			}
		},
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
						13020201
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
			groupName = "BOSS",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13020201,
					x = 6,
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
			x = 6,
			y = 12
		},
		{
			x = 4,
			y = 13
		}
	},
	lockHeroList = {},
	monsters = {
		[13020201] = {
			normalSkill = 1202701,
			name = "惑形/根源",
			pre_magicAtk = 12,
			maxHp = 9078,
			aiName = "ai-经验本-修格斯boss",
			battleCamp = 1,
			career = 5,
			magicAtk = 12,
			pre_meleeDef = 68,
			sanity = 0,
			remark = "",
			giftSkill = 1202705,
			weakPointHpRate = 0.1,
			meleeDef = 68,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 100,
			pre_meleeAtk = 119.7,
			pre_maxHp = 9078,
			colorType = 4,
			monsterType = 2,
			id = 13020201,
			mobility = 0,
			pre_magicDef = 45,
			aiStepOrder = 3,
			trumpSkill = 1202702,
			isFuzzy = false,
			inspire = 45.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 120027,
			magicDef = 45,
			specialSkill = 1202704,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"A",
				"C",
				"B"
			},
			tags = {}
		}
	}
}

return configData
