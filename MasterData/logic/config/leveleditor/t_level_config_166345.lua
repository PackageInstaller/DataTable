-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166345.lua

module("logic.config.leveleditor.t_level_config_166345", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166345",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学25",
	lossConditionDesc = "",
	sceneId = "99000211",
	winConditionDesc = "注意单体援护特性",
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
			x = 2,
			y = 2
		},
		{
			direction = 2,
			x = 1,
			y = 1
		},
		{
			direction = 2,
			x = 2,
			y = 0
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
					y = 2,
					tag = "",
					monsterId = 16634504,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 16634504,
					x = 3,
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
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16634501,
			pos = {
				x = 1,
				y = 1
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		},
		{
			isInitialStatus = true,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16634502,
			pos = {
				x = 2,
				y = 2
			},
			initialStatus = {
				hpPercent = 0.1,
				buffList = {}
			}
		},
		{
			isInitialStatus = true,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16634503,
			pos = {
				x = 2,
				y = 0
			},
			initialStatus = {
				hpPercent = 0.1,
				buffList = {}
			}
		}
	},
	monsters = {
		[16634501] = {
			normalSkill = 1740077,
			name = "欧几里得",
			pre_magicAtk = 113.2,
			maxHp = 199.8,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 113.2,
			pre_meleeDef = 33.6,
			sanity = -1,
			remark = "欧几里得",
			giftSkill = 1740078,
			weakPointHpRate = 0,
			meleeDef = 33.6,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 11.3,
			pre_meleeAtk = 11.3,
			pre_maxHp = 199.8,
			colorType = 4,
			monsterType = 0,
			id = 16634501,
			mobility = 2,
			pre_magicDef = 57.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25.5,
			camp = 5,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 25.5,
			modelId = 100007,
			magicDef = 57.6,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			}
		},
		[16634502] = {
			normalSkill = 1740006,
			name = "一云",
			pre_magicAtk = 10.5,
			maxHp = 200,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = -1,
			remark = "一云",
			giftSkill = 1740009,
			weakPointHpRate = 0,
			meleeDef = 57.6,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 140,
			pre_meleeAtk = 104.8,
			pre_maxHp = 266.6,
			colorType = 1,
			monsterType = 0,
			id = 16634502,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 100011,
			magicDef = 28.8,
			specialSkill = 1740007,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[16634503] = {
			normalSkill = 1740010,
			name = "烟火",
			pre_magicAtk = 10.5,
			maxHp = 200,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = -1,
			remark = "烟火",
			giftSkill = 1740013,
			weakPointHpRate = 0,
			meleeDef = 57.6,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 140,
			pre_meleeAtk = 104.8,
			pre_maxHp = 266.6,
			colorType = 1,
			monsterType = 0,
			id = 16634503,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 1740012,
			isFuzzy = false,
			inspire = 35.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 100016,
			magicDef = 28.8,
			specialSkill = 1740011,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[16634504] = {
			normalSkill = 1740055,
			name = "迷雾使徒",
			pre_magicAtk = 10.5,
			maxHp = 255,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = 0,
			remark = "幻影小怪模板",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 10.5,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 104.8,
			pre_meleeAtk = 104.8,
			pre_maxHp = 266.6,
			colorType = 1,
			monsterType = 0,
			id = 16634504,
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
