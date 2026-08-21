-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110212.lua

module("logic.config.leveleditor.t_level_config_110212", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110212",
	plotEventGroup = 110212,
	maxPerson = 6,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通2-12",
	lossConditionDesc = "",
	sceneId = "108002",
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
			y = 4
		},
		{
			direction = 2,
			x = 2,
			y = 3
		},
		{
			direction = 2,
			x = 3,
			y = 3
		},
		{
			direction = 1,
			x = 3,
			y = 2
		},
		{
			direction = 1,
			x = 4,
			y = 2
		},
		{
			direction = 3,
			x = 2,
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
						11021201
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
			groupName = "大水晶",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 11021201,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "小水晶",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 11021202,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 11021202,
					x = 9,
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
					monsterId = 11021202,
					x = 0,
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
	lockHeroList = {
		{
			isInitialStatus = true,
			heroId = 2000016,
			direction = 2,
			heroType = 2,
			monsterId = 11021204,
			pos = {
				x = 3,
				y = 3
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 99,
						buffId = 33002,
						layer = 1
					}
				}
			}
		}
	},
	monsters = {
		[11021201] = {
			normalSkill = 1208301,
			name = "异变以太水晶",
			pre_magicAtk = 262.9,
			maxHp = 8094.7,
			aiName = "ai_大型以太晶石",
			battleCamp = 1,
			career = 4,
			magicAtk = 262.9,
			pre_meleeDef = 53,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 53,
			level = 18,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 26.3,
			pre_meleeAtk = 26.3,
			pre_maxHp = 8094.7,
			colorType = 2,
			monsterType = 2,
			id = 11021201,
			mobility = 0,
			pre_magicDef = 94,
			aiStepOrder = 0,
			trumpSkill = 1208303,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120083,
			magicDef = 94,
			specialSkill = 1208302,
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
		[11021202] = {
			normalSkill = 0,
			name = "伴生以太水晶",
			pre_magicAtk = 211.6,
			maxHp = 2175.8,
			aiName = "ai_小型以太晶石",
			battleCamp = 1,
			career = 4,
			magicAtk = 211.6,
			pre_meleeDef = 53,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 53,
			level = 18,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 21.2,
			pre_meleeAtk = 21.2,
			pre_maxHp = 2175.8,
			colorType = 2,
			monsterType = 1,
			id = 11021202,
			mobility = 0,
			pre_magicDef = 94,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 58,
			modelId = 120084,
			magicDef = 94,
			specialSkill = 1208401,
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
		[11021203] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 170.5,
			maxHp = 590.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 170.5,
			pre_meleeDef = 47.7,
			sanity = 0,
			remark = "",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 47.7,
			level = 18,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 17,
			pre_meleeAtk = 17,
			pre_maxHp = 590.6,
			colorType = 1,
			monsterType = 0,
			id = 11021203,
			mobility = 2,
			pre_magicDef = 84.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120068,
			magicDef = 84.6,
			specialSkill = 0,
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
		[11021204] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 19.6,
			maxHp = 3500,
			aiName = "auto_yanhuo_ai",
			battleCamp = 3,
			career = 1,
			magicAtk = 19.6,
			pre_meleeDef = 117.9,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 117.9,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 196.4,
			pre_meleeAtk = 196.4,
			pre_maxHp = 1249.1,
			colorType = 1,
			monsterType = 0,
			id = 11021204,
			mobility = 4,
			pre_magicDef = 68.4,
			aiStepOrder = 0,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 46,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46,
			modelId = 100016,
			magicDef = 68.4,
			specialSkill = 1101602,
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
