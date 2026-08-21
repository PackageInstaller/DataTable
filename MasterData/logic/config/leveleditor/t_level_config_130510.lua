-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130510.lua

module("logic.config.leveleditor.t_level_config_130510", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130510",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "狙击材料本-10",
	lossConditionDesc = "",
	sceneId = "116004",
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
			x = 6,
			y = 6
		},
		{
			direction = 1,
			x = 6,
			y = 5
		},
		{
			direction = 1,
			x = 7,
			y = 5
		},
		{
			direction = 1,
			x = 8,
			y = 5
		},
		{
			direction = 1,
			x = 8,
			y = 6
		}
	},
	additionalTerrainList = {
		{
			terrainId = 4003,
			times = 1,
			posList = {
				{
					x = 11,
					y = 3
				},
				{
					x = 13,
					y = 6
				},
				{
					x = 10,
					y = 10
				},
				{
					x = 4,
					y = 2
				},
				{
					x = 1,
					y = 6
				},
				{
					x = 2,
					y = 10
				},
				{
					x = 5,
					y = 12
				},
				{
					x = 6,
					y = 8
				},
				{
					x = 9,
					y = 6
				},
				{
					x = 6,
					y = 4
				}
			}
		}
	},
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
						13051001
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "boss",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 13051001,
					x = 7,
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
	trialHeroes = {},
	monsters = {
		[13051001] = {
			normalSkill = 1203201,
			name = "猎食者",
			pre_magicAtk = 190,
			maxHp = 257302.9,
			aiName = "ai-狙击本-执行者boss",
			battleCamp = 1,
			career = 2,
			magicAtk = 190,
			pre_meleeDef = 898,
			sanity = 0,
			remark = "",
			giftSkill = 1203202,
			weakPointHpRate = 0.3,
			meleeDef = 548,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 2999.7,
			pre_meleeAtk = 1899.7,
			pre_maxHp = 307302.9,
			colorType = 2,
			monsterType = 2,
			id = 13051001,
			mobility = 2,
			pre_magicDef = 548,
			aiStepOrder = 0,
			trumpSkill = 1203203,
			isFuzzy = false,
			inspire = 72,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 72,
			modelId = 120017,
			magicDef = 898,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"A",
				"C",
				"C",
				"S"
			},
			tags = {}
		}
	}
}

return configData
