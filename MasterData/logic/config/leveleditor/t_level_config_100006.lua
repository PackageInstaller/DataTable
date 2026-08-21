-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100006.lua

module("logic.config.leveleditor.t_level_config_100006", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "100006",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "猎食者boss战",
	lossConditionDesc = "",
	sceneId = "190021",
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
			direction = 3,
			x = 3,
			y = 5
		},
		{
			direction = 3,
			x = 4,
			y = 6
		},
		{
			direction = 3,
			x = 6,
			y = 5
		},
		{
			direction = 4,
			x = 7,
			y = 4
		},
		{
			direction = 3,
			x = 5,
			y = 6
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 10000601,
					x = 4,
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
		[10000601] = {
			normalSkill = 1201701,
			name = "猎食者",
			pre_magicAtk = 100.8,
			maxHp = 11718,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 100.8,
			pre_meleeDef = 88.6,
			sanity = 0,
			remark = "",
			giftSkill = 1201704,
			weakPointHpRate = 0.3,
			meleeDef = 88.6,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 256.5,
			pre_meleeAtk = 256.5,
			pre_maxHp = 11718,
			colorType = 1,
			monsterType = 2,
			id = 10000601,
			mobility = 2,
			pre_magicDef = 81.8,
			aiStepOrder = 0,
			trumpSkill = 1201703,
			isFuzzy = false,
			inspire = 30.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 30.4,
			modelId = 120017,
			magicDef = 81.8,
			specialSkill = 1201702,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"A",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
