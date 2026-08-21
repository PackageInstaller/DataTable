-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_990003.lua

module("logic.config.leveleditor.t_level_config_990003", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "990003",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 99,
	levelName = "测试出生点位置",
	lossConditionDesc = "",
	sceneId = "109001",
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
			x = 4,
			y = 8
		},
		{
			direction = 2,
			x = 4,
			y = 6
		},
		{
			direction = 2,
			x = 4,
			y = 5
		},
		{
			direction = 2,
			x = 4,
			y = 3
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
					round = 3,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "击杀所有grox先遣队",
					condition = 1,
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
					round = 99,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = true,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 99000301,
					x = 9,
					initialStatus = {
						hpPercent = 0.1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 99000302,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 99000302,
					x = 9,
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
			y = 2
		}
	},
	lockHeroList = {},
	monsters = {
		[99000301] = {
			normalSkill = 0,
			name = "哨兵",
			pre_magicAtk = 15,
			maxHp = 49.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 15,
			pre_meleeDef = 23,
			sanity = 0,
			remark = "",
			giftSkill = 1290555,
			weakPointHpRate = 0,
			meleeDef = 23,
			level = 1,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 15,
			pre_meleeAtk = 15,
			pre_maxHp = 49.3,
			colorType = 4,
			monsterType = 0,
			id = 99000301,
			mobility = 3,
			pre_magicDef = 23,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 18.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 18.8,
			modelId = 120016,
			magicDef = 23,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[99000302] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 60,
			maxHp = 150,
			aiName = "gold_attack_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 60,
			pre_meleeDef = 37.8,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 37.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 60,
			pre_meleeAtk = 60,
			pre_maxHp = 150,
			colorType = 1,
			monsterType = 0,
			id = 99000302,
			mobility = 4,
			pre_magicDef = 49.5,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 120089,
			magicDef = 49.5,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
