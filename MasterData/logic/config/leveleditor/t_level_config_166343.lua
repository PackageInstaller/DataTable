-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166343.lua

module("logic.config.leveleditor.t_level_config_166343", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166343",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学23",
	lossConditionDesc = "",
	sceneId = "99000211",
	winConditionDesc = "存活后反击震荡",
	forbidAction = {
		auto = true,
		move = false,
		strengthenSkill = true,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 2,
			x = 0,
			y = 2
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
			condition = 3,
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
					y = 3,
					tag = "",
					monsterId = 16634302,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 16634302,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16634302,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {
		{
			isInitialStatus = true,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16634301,
			pos = {
				x = 0,
				y = 2
			},
			initialStatus = {
				hpPercent = 0.5,
				buffList = {}
			}
		}
	},
	monsters = {
		[16634301] = {
			normalSkill = 1740065,
			name = "辛德瑞拉",
			pre_magicAtk = 10.2,
			maxHp = 190,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 2,
			magicAtk = 10.2,
			pre_meleeDef = 62.4,
			sanity = -1,
			remark = "辛德瑞拉",
			giftSkill = 1740068,
			weakPointHpRate = 0,
			meleeDef = 62.4,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 140,
			pre_meleeAtk = 101.8,
			pre_maxHp = 330.3,
			colorType = 2,
			monsterType = 0,
			id = 16634301,
			mobility = 2,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 25.5,
			modelId = 100041,
			magicDef = 28.8,
			specialSkill = 1740066,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			}
		},
		[16634302] = {
			normalSkill = 1740055,
			name = "迷雾使徒",
			pre_magicAtk = 10.5,
			maxHp = 100,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = 0,
			remark = "幻影小怪模板",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 20,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 160,
			pre_meleeAtk = 104.8,
			pre_maxHp = 266.6,
			colorType = 1,
			monsterType = 0,
			id = 16634302,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.5,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 120006,
			magicDef = 28.8,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		}
	}
}

return configData
