-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171045.lua

module("logic.config.leveleditor.t_level_config_171045", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "171045",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "钢琴05",
	lossConditionDesc = "",
	sceneId = "109005",
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
			x = 4,
			y = 1
		},
		{
			direction = 1,
			x = 3,
			y = 1
		},
		{
			direction = 1,
			x = 6,
			y = 2
		},
		{
			direction = 1,
			x = 6,
			y = 1
		},
		{
			direction = 1,
			x = 3,
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
					condition = 3,
					monsterIds = {
						17104501
					}
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
					y = 4,
					tag = "",
					monsterId = 17104501,
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
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 17104502,
			pos = {
				x = 3,
				y = 2
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 17104503,
			pos = {
				x = 6,
				y = 2
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[17104501] = {
			normalSkill = 1217141,
			name = "容易害羞的钢琴",
			pre_magicAtk = 272.8,
			maxHp = 7958.8,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 272.8,
			pre_meleeDef = 54,
			sanity = 0,
			remark = "",
			giftSkill = 1217146,
			weakPointHpRate = 0,
			meleeDef = 54,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 27.3,
			pre_meleeAtk = 27.3,
			pre_maxHp = 7958.8,
			colorType = 1,
			monsterType = 2,
			id = 17104501,
			mobility = 0,
			pre_magicDef = 107,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 57,
			modelId = 120100,
			magicDef = 107,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[17104502] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 46,
			maxHp = 696,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 46,
			pre_meleeDef = 97,
			sanity = 0,
			remark = "一云",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 97,
			level = 15,
			monsterGroup = "角色模板",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1720,
			pre_meleeAtk = 202,
			pre_maxHp = 696,
			colorType = 1,
			monsterType = 0,
			id = 17104502,
			mobility = 4,
			pre_magicDef = 42,
			aiStepOrder = 0,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 43,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 5,
			pre_inspire = 43,
			modelId = 100011,
			magicDef = 42,
			specialSkill = 1101102,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[17104503] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 39,
			maxHp = 543,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 1722,
			pre_meleeDef = 87,
			sanity = 0,
			remark = "安妮薇",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 87,
			level = 15,
			monsterGroup = "角色模板",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 39,
			pre_meleeAtk = 222,
			pre_maxHp = 543,
			colorType = 1,
			monsterType = 0,
			id = 17104503,
			mobility = 2,
			pre_magicDef = 43,
			aiStepOrder = 0,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 53,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 5,
			pre_inspire = 53,
			modelId = 100013,
			magicDef = 43,
			specialSkill = 1101302,
			extraSkills = {},
			attributeGrade = {
				"S",
				"B",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
