-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110317.lua

module("logic.config.leveleditor.t_level_config_110317", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110317",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "主线普通3-17",
	lossConditionDesc = "",
	sceneId = "114001",
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
			x = 6,
			y = 6
		},
		{
			direction = 2,
			x = 5,
			y = 7
		},
		{
			direction = 1,
			x = 7,
			y = 5
		},
		{
			direction = 1,
			x = 8,
			y = 6
		},
		{
			direction = 4,
			x = 9,
			y = 7
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
						11031701
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
			groupName = "boss组",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11031701,
					x = 7,
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
			groupName = "小怪1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "101",
					monsterId = 11031702,
					x = 2,
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
			groupName = "小怪2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "102",
					monsterId = 11031703,
					x = 12,
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
			groupName = "小怪2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "103",
					monsterId = 11031704,
					x = 7,
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
		[11031701] = {
			normalSkill = 1100201,
			name = "爱丽丝",
			pre_magicAtk = 522.5,
			maxHp = 23966.8,
			aiName = "ai-爱丽丝-3-12",
			battleCamp = 1,
			career = 4,
			magicAtk = 522.5,
			pre_meleeDef = 115,
			sanity = 0,
			remark = "爱丽丝主线boss",
			giftSkill = 1100223,
			weakPointHpRate = 0,
			meleeDef = 115,
			level = 30,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 52.2,
			pre_meleeAtk = 52.2,
			pre_maxHp = 23966.8,
			colorType = 3,
			monsterType = 2,
			id = 11031701,
			mobility = 2,
			pre_magicDef = 183,
			aiStepOrder = 0,
			trumpSkill = 1100221,
			isFuzzy = false,
			inspire = 65,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 100002,
			magicDef = 183,
			specialSkill = 1100222,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			}
		},
		[11031702] = {
			normalSkill = 1100201,
			name = "分身",
			pre_magicAtk = 348.1,
			maxHp = 1906.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 348.1,
			pre_meleeDef = 103.5,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 103.5,
			level = 30,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 34.8,
			pre_meleeAtk = 34.8,
			pre_maxHp = 1906.5,
			colorType = 3,
			monsterType = 0,
			id = 11031702,
			mobility = 2,
			pre_magicDef = 164.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = true,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "ma_common_body_16001",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 100002,
			magicDef = 164.7,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			}
		},
		[11031703] = {
			normalSkill = 1100201,
			name = "分身",
			pre_magicAtk = 348.1,
			maxHp = 1906.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 348.1,
			pre_meleeDef = 103.5,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 103.5,
			level = 30,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 34.8,
			pre_meleeAtk = 34.8,
			pre_maxHp = 1906.5,
			colorType = 3,
			monsterType = 0,
			id = 11031703,
			mobility = 2,
			pre_magicDef = 164.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = true,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "ma_common_body_16001",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 100002,
			magicDef = 164.7,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			}
		},
		[11031704] = {
			normalSkill = 1100201,
			name = "分身",
			pre_magicAtk = 348.1,
			maxHp = 1906.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 348.1,
			pre_meleeDef = 103.5,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 103.5,
			level = 30,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 34.8,
			pre_meleeAtk = 34.8,
			pre_maxHp = 1906.5,
			colorType = 3,
			monsterType = 0,
			id = 11031704,
			mobility = 2,
			pre_magicDef = 164.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = true,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "ma_common_body_16001",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 100002,
			magicDef = 164.7,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			}
		}
	}
}

return configData
