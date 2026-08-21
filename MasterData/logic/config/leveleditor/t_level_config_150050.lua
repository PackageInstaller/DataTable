-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150050.lua

module("logic.config.leveleditor.t_level_config_150050", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150050",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面50",
	lossConditionDesc = "",
	sceneId = "111002",
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
			x = 5,
			y = 14
		},
		{
			direction = 3,
			x = 6,
			y = 14
		},
		{
			direction = 3,
			x = 7,
			y = 14
		},
		{
			direction = 3,
			x = 8,
			y = 14
		},
		{
			direction = 3,
			x = 9,
			y = 14
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
					y = 11,
					tag = "",
					monsterId = 15005001,
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
	monsters = {
		[15005001] = {
			normalSkill = 1213215,
			name = "猎食者",
			pre_magicAtk = 115.8,
			maxHp = 144477.7,
			aiName = "boss_equipment_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 115.8,
			pre_meleeDef = 566.3,
			sanity = 0,
			remark = "装备本-中等BOSS1",
			giftSkill = 1213218,
			weakPointHpRate = 0.3,
			meleeDef = 566.3,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1157.6,
			pre_meleeAtk = 1157.6,
			pre_maxHp = 144477.7,
			colorType = 2,
			monsterType = 2,
			id = 15005001,
			mobility = 2,
			pre_magicDef = 322.3,
			aiStepOrder = 0,
			trumpSkill = 1213217,
			isFuzzy = false,
			inspire = 62.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 62.7,
			modelId = 120017,
			magicDef = 322.3,
			specialSkill = 1213216,
			extraSkills = {
				1213219,
				1213220
			},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
