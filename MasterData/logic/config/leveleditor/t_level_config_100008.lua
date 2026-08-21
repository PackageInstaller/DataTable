-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100008.lua

module("logic.config.leveleditor.t_level_config_100008", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "100008",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 0,
	maxRound = 3,
	levelName = "实机录制",
	lossConditionDesc = "",
	sceneId = "112001",
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
			x = 8,
			y = 7
		},
		{
			direction = 2,
			x = 9,
			y = 8
		},
		{
			direction = 2,
			x = 7,
			y = 8
		},
		{
			direction = 2,
			x = 9,
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
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 10000801,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 10000802,
					x = 11,
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
			isInitialStatus = true,
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000803,
			pos = {
				x = 9,
				y = 8
			},
			initialStatus = {
				hpPercent = 0.4,
				buffList = {}
			}
		},
		{
			isInitialStatus = true,
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000804,
			pos = {
				x = 8,
				y = 7
			},
			initialStatus = {
				hpPercent = 0.4,
				buffList = {}
			}
		},
		{
			isInitialStatus = true,
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000805,
			pos = {
				x = 9,
				y = 6
			},
			initialStatus = {
				hpPercent = 0.4,
				buffList = {}
			}
		},
		{
			isInitialStatus = true,
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000806,
			pos = {
				x = 7,
				y = 8
			},
			initialStatus = {
				hpPercent = 0.4,
				buffList = {}
			}
		}
	},
	monsters = {
		[10000801] = {
			normalSkill = 1201201,
			name = "惑形/蜉蝣",
			pre_magicAtk = 81.6,
			maxHp = 178.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 81.6,
			pre_meleeDef = 68,
			sanity = 0,
			remark = "",
			giftSkill = 1280602,
			weakPointHpRate = 0,
			meleeDef = 68,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 204,
			pre_meleeAtk = 204,
			pre_maxHp = 178.3,
			colorType = 3,
			monsterType = 0,
			id = 10000801,
			mobility = 2,
			pre_magicDef = 51.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.9,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 120029,
			magicDef = 51.5,
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
		[10000802] = {
			normalSkill = 1282101,
			name = "枯荣/孵化",
			pre_magicAtk = 68,
			maxHp = 3388.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 68,
			pre_meleeDef = 118.3,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 118.3,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 169,
			pre_meleeAtk = 169,
			pre_maxHp = 3388.8,
			colorType = 2,
			monsterType = 1,
			id = 10000802,
			mobility = 2,
			pre_magicDef = 50.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 20.9,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 20.9,
			modelId = 120028,
			magicDef = 50.8,
			specialSkill = 1282102,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[10000803] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 204,
			maxHp = 178.3,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 204,
			pre_meleeDef = 51.5,
			sanity = 0,
			remark = "",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 51.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 81.6,
			pre_meleeAtk = 81.6,
			pre_maxHp = 178.3,
			colorType = 3,
			monsterType = 0,
			id = 10000803,
			mobility = 2,
			pre_magicDef = 78.2,
			aiStepOrder = 0,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 31.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 100013,
			magicDef = 78.2,
			specialSkill = 1101302,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[10000804] = {
			normalSkill = 1105301,
			name = "阿妮亚",
			pre_magicAtk = 169,
			maxHp = 213.8,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 169,
			pre_meleeDef = 59.8,
			sanity = 0,
			remark = "",
			giftSkill = 1105304,
			weakPointHpRate = 0,
			meleeDef = 59.8,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 81.6,
			pre_meleeAtk = 81.6,
			pre_maxHp = 213.8,
			colorType = 4,
			monsterType = 0,
			id = 10000804,
			mobility = 2,
			pre_magicDef = 78.2,
			aiStepOrder = 0,
			trumpSkill = 1105303,
			isFuzzy = false,
			inspire = 20.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 20.9,
			modelId = 100053,
			magicDef = 78.2,
			specialSkill = 1105302,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		},
		[10000805] = {
			normalSkill = 1101201,
			name = "芬里尔",
			pre_magicAtk = 204,
			maxHp = 178.3,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 204,
			pre_meleeDef = 51.5,
			sanity = 0,
			remark = "",
			giftSkill = 1101204,
			weakPointHpRate = 0,
			meleeDef = 51.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 81.6,
			pre_meleeAtk = 81.6,
			pre_maxHp = 178.3,
			colorType = 3,
			monsterType = 0,
			id = 10000805,
			mobility = 2,
			pre_magicDef = 78.2,
			aiStepOrder = 0,
			trumpSkill = 1101203,
			isFuzzy = false,
			inspire = 31.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 100012,
			magicDef = 78.2,
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
		},
		[10000806] = {
			normalSkill = 1102201,
			name = "飞鸟",
			pre_magicAtk = 81.6,
			maxHp = 178.3,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 3,
			magicAtk = 81.6,
			pre_meleeDef = 68,
			sanity = 0,
			remark = "",
			giftSkill = 1102204,
			weakPointHpRate = 0,
			meleeDef = 68,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 243,
			pre_meleeAtk = 243,
			pre_maxHp = 178.3,
			colorType = 3,
			monsterType = 0,
			id = 10000806,
			mobility = 2,
			pre_magicDef = 51.5,
			aiStepOrder = 0,
			trumpSkill = 1102203,
			isFuzzy = false,
			inspire = 31.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 100022,
			magicDef = 51.5,
			specialSkill = 1102202,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
