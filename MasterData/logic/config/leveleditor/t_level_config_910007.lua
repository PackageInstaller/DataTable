-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_910007.lua

module("logic.config.leveleditor.t_level_config_910007", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "910007",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "泡泡体验",
	lossConditionDesc = "",
	sceneId = "112004",
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
			x = 5,
			y = 5
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
			x = 9,
			y = 5
		},
		{
			direction = 1,
			x = 9,
			y = 4
		},
		{
			direction = 1,
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 7,
			y = 4
		},
		{
			direction = 1,
			x = 6,
			y = 4
		},
		{
			direction = 1,
			x = 5,
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
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 91000701,
					x = 6,
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
	monsters = {
		[91000701] = {
			normalSkill = 1207701,
			name = "泡泡",
			pre_magicAtk = 2161.5,
			maxHp = 177681.7,
			aiName = "ai_泡泡",
			battleCamp = 1,
			career = 4,
			magicAtk = 2161.5,
			pre_meleeDef = 550,
			sanity = 0,
			remark = "装备本-BOSS1",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 550,
			level = 90,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 216.2,
			pre_meleeAtk = 216.2,
			pre_maxHp = 177681.7,
			colorType = 3,
			monsterType = 2,
			id = 91000701,
			mobility = 2,
			pre_magicDef = 783,
			aiStepOrder = 0,
			trumpSkill = 1207704,
			isFuzzy = false,
			inspire = 90,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120077,
			magicDef = 783,
			specialSkill = 1207702,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		}
	}
}

return configData
