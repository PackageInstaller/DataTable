-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130203.lua

module("logic.config.leveleditor.t_level_config_130203", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130203",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 4,
	levelName = "经验本难度3",
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
					round = 4,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 3,
					monsterIds = {
						13020301
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
					monsterId = 13020301,
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
		[13020301] = {
			normalSkill = 1202701,
			name = "惑形/根源",
			pre_magicAtk = 155.4,
			maxHp = 8085.6,
			aiName = "ai-经验本-修格斯boss",
			battleCamp = 1,
			career = 5,
			magicAtk = 155.4,
			pre_meleeDef = 52,
			sanity = 0,
			remark = "",
			giftSkill = 1202705,
			weakPointHpRate = 0.07,
			meleeDef = 52,
			level = 15,
			monsterGroup = "经验本",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 15.5,
			pre_meleeAtk = 15.5,
			pre_maxHp = 8085.6,
			colorType = 4,
			monsterType = 2,
			id = 13020301,
			mobility = 0,
			pre_magicDef = 92,
			aiStepOrder = 3,
			trumpSkill = 1202702,
			isFuzzy = false,
			inspire = 48,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 2,
			pre_inspire = 48,
			modelId = 120027,
			magicDef = 92,
			specialSkill = 1202704,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"C",
				"S"
			},
			tags = {}
		}
	}
}

return configData
