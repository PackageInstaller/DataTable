-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_20011001.lua

module("logic.config.leveleditor.t_level_config_20011001", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "20011001",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 99,
	levelName = "保持清醒",
	lossConditionDesc = "",
	sceneId = "10301",
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
			x = 0,
			y = 1
		},
		{
			direction = 2,
			x = 0,
			y = 2
		},
		{
			direction = 2,
			x = 0,
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
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 2001100101,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 2001100101,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 2001100102,
					x = 7,
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
		[2001100101] = {
			normalSkill = 1001,
			name = "临时龟小怪",
			pre_magicAtk = 0,
			maxHp = 1,
			aiName = "mob_passive_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 45,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 45,
			level = 1,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 224.7,
			pre_meleeAtk = 224.7,
			pre_maxHp = 1,
			colorType = 3,
			monsterType = 0,
			id = 2001100101,
			mobility = 2,
			pre_magicDef = 0,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 0,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 120018,
			magicDef = 0,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[2001100102] = {
			normalSkill = 1200301,
			name = "临时龟boss",
			pre_magicAtk = 0,
			maxHp = 1,
			aiName = "mob_passive_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 0,
			pre_meleeDef = 40,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 40,
			level = 1,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 3876.6,
			pre_meleeAtk = 3876.6,
			pre_maxHp = 1,
			colorType = 4,
			monsterType = 0,
			id = 2001100102,
			mobility = 1,
			pre_magicDef = 0,
			aiStepOrder = 2,
			trumpSkill = 1200302,
			isFuzzy = false,
			inspire = 0,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 120020,
			magicDef = 0,
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
		}
	}
}

return configData
