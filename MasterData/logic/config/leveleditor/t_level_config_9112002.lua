-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_9112002.lua

module("logic.config.leveleditor.t_level_config_9112002", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "9112002",
	plotEventGroup = 0,
	maxPerson = 9,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "意识空间002",
	lossConditionDesc = "",
	sceneId = "112002",
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
			x = 4,
			y = 10
		},
		{
			direction = 2,
			x = 7,
			y = 12
		},
		{
			direction = 2,
			x = 10,
			y = 8
		},
		{
			direction = 2,
			x = 12,
			y = 9
		},
		{
			direction = 2,
			x = 5,
			y = 6
		},
		{
			direction = 2,
			x = 7,
			y = 5
		},
		{
			direction = 2,
			x = 11,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 8
		},
		{
			direction = 2,
			x = 5,
			y = 8
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
					condition = 2,
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
					direction = 4,
					y = 13,
					tag = "",
					monsterId = 911200201,
					x = 0,
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
		[911200201] = {
			normalSkill = 1204501,
			name = "水滴执行者幻影",
			pre_magicAtk = 26.928,
			maxHp = 2000,
			aiName = "",
			battleCamp = 1,
			career = 1,
			magicAtk = 26.928,
			pre_meleeDef = 17.17,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 17.17,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 67.32,
			pre_meleeAtk = 67.32,
			pre_maxHp = 2000,
			colorType = 1,
			monsterType = 1,
			id = 911200201,
			mobility = 3,
			pre_magicDef = 15.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 18.4,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 18.4,
			modelId = 120045,
			magicDef = 15.8,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
