-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_999001.lua

module("logic.config.leveleditor.t_level_config_999001", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "999001",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "wlf个人测试用",
	lossConditionDesc = "",
	sceneId = "931001",
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
			x = 2,
			y = 3
		},
		{
			direction = 1,
			x = 4,
			y = 3
		},
		{
			direction = 1,
			x = 3,
			y = 3
		},
		{
			direction = 1,
			x = 5,
			y = 3
		},
		{
			direction = 1,
			x = 6,
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
					y = 5,
					tag = "",
					monsterId = 99900101,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 99900101,
					x = 5,
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
		[99900101] = {
			normalSkill = 1213253,
			name = "禁行隔离墩",
			pre_magicAtk = 15.6,
			maxHp = 761.4,
			aiName = "elite03_equipment_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 15.6,
			pre_meleeDef = 115.2,
			sanity = 0,
			remark = "",
			giftSkill = 1213255,
			weakPointHpRate = 0,
			meleeDef = 115.2,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 156.3,
			pre_meleeAtk = 156.3,
			pre_maxHp = 761.4,
			colorType = 2,
			monsterType = 0,
			id = 99900101,
			mobility = 2,
			pre_magicDef = 48.6,
			aiStepOrder = 2,
			trumpSkill = 1213254,
			isFuzzy = false,
			inspire = 32,
			camp = 7,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 32,
			modelId = 120014,
			magicDef = 48.6,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
