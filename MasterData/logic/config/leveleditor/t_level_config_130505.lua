-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130505.lua

module("logic.config.leveleditor.t_level_config_130505", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130505",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "狙击材料本-5",
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
			x = 7,
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
						13050501
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
					monsterId = 13050501,
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
		[13050501] = {
			normalSkill = 1203201,
			name = "猎食者",
			pre_magicAtk = 64.8,
			maxHp = 20944.88,
			aiName = "ai-狙击本-执行者boss",
			battleCamp = 1,
			career = 2,
			magicAtk = 64.8,
			pre_meleeDef = 324,
			sanity = 0,
			remark = "",
			giftSkill = 1203202,
			weakPointHpRate = 0.3,
			meleeDef = 131,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 647.9,
			pre_meleeAtk = 647.9,
			pre_maxHp = 57362.2,
			colorType = 2,
			monsterType = 2,
			id = 13050501,
			mobility = 2,
			pre_magicDef = 161,
			aiStepOrder = 0,
			trumpSkill = 1203203,
			isFuzzy = false,
			inspire = 52,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 52,
			modelId = 120017,
			magicDef = 324,
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
