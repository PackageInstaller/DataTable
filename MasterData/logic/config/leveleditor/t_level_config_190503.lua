-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_190503.lua

module("logic.config.leveleditor.t_level_config_190503", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "锥刺体验难度3",
	levelId = "190503",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "锥刺体验难度3",
	lossConditionDesc = "",
	sceneId = "110002",
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
			x = 8,
			y = 5
		},
		{
			direction = 1,
			x = 6,
			y = 5
		},
		{
			direction = 4,
			x = 10,
			y = 7
		},
		{
			direction = 3,
			x = 6,
			y = 9
		},
		{
			direction = 3,
			x = 8,
			y = 9
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
					DIYName = "10回合内击杀所有原体",
					condition = 13,
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
	globalSkillCodeList = {
		1721915
	},
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
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 19050301,
					x = 7,
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
		[19050301] = {
			normalSkill = 1201606,
			name = "巡逻道闸",
			pre_magicAtk = 103,
			maxHp = 100260.4,
			aiName = "ai_120016_巡逻道闸",
			battleCamp = 1,
			career = 1,
			magicAtk = 103,
			pre_meleeDef = 417,
			sanity = 0,
			remark = "幻影精英-高难度",
			giftSkill = 1201602,
			weakPointHpRate = 0.3,
			meleeDef = 257,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1029.6,
			pre_meleeAtk = 1029.6,
			pre_maxHp = 98260.4,
			colorType = 1,
			monsterType = 2,
			id = 19050301,
			mobility = 4,
			pre_magicDef = 257,
			aiStepOrder = 0,
			trumpSkill = 1201605,
			isFuzzy = false,
			inspire = 70,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120016,
			magicDef = 417,
			specialSkill = 0,
			extraSkills = {
				1201603
			},
			attributeGrade = {
				"S",
				"S",
				"C",
				"C",
				"A"
			},
			tags = {}
		}
	}
}

return configData
