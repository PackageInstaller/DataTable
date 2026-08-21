-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_910001.lua

module("logic.config.leveleditor.t_level_config_910001", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "910001",
	plotEventGroup = 910001,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "战斗事件测试1",
	lossConditionDesc = "",
	sceneId = "190001",
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
			x = 2,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 6
		},
		{
			direction = 2,
			x = 4,
			y = 6
		}
	},
	additionalTerrainList = {},
	winConditionGroupList = {
		{
			tag = "101",
			isBackup = false,
			hasTag = true,
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
		},
		{
			tag = "102",
			isBackup = true,
			hasTag = true,
			winConditionList = {
				{
					round = 3,
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
			hasTag = true,
			DIYName = "",
			isBackup = false,
			tag = "201",
			targetId = 0,
			monsterIds = {}
		},
		{
			condition = 3,
			maxDeadCount = 0,
			count = 0,
			hasTag = true,
			DIYName = "",
			isBackup = true,
			tag = "202",
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
					y = 9,
					tag = "",
					monsterId = 91000102,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 91000103,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 91000101,
			pos = {
				x = 4,
				y = 6
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[91000101] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 74.9,
			maxHp = 148.9,
			aiName = "",
			battleCamp = 2,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 41,
			sanity = 0,
			remark = "",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 41,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 189.6,
			pre_meleeAtk = 189.6,
			pre_maxHp = 148.9,
			colorType = 1,
			monsterType = 0,
			id = 91000101,
			mobility = 3,
			pre_magicDef = 37.8,
			aiStepOrder = 0,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 22.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22.4,
			modelId = 100011,
			magicDef = 37.8,
			specialSkill = 1101102,
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
		[91000102] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 74.9,
			maxHp = 148.9,
			aiName = "",
			battleCamp = 1,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 41,
			sanity = 0,
			remark = "",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 41,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 189.6,
			pre_meleeAtk = 189.6,
			pre_maxHp = 148.9,
			colorType = 1,
			monsterType = 0,
			id = 91000102,
			mobility = 3,
			pre_magicDef = 37.8,
			aiStepOrder = 0,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 22.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22.4,
			modelId = 100011,
			magicDef = 37.8,
			specialSkill = 1101102,
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
		[91000103] = {
			normalSkill = 1101201,
			name = "芬里尔",
			pre_magicAtk = 206.4,
			maxHp = 112.8,
			aiName = "",
			battleCamp = 1,
			career = 4,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = 0,
			remark = "",
			giftSkill = 1101204,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.8,
			colorType = 1,
			monsterType = 0,
			id = 91000103,
			mobility = 2,
			pre_magicDef = 49.5,
			aiStepOrder = 0,
			trumpSkill = 1101203,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100012,
			magicDef = 49.5,
			specialSkill = 1101202,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		}
	}
}

return configData
