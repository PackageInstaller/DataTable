-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150059.lua

module("logic.config.leveleditor.t_level_config_150059", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150059",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面59",
	lossConditionDesc = "",
	sceneId = "115001",
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
			y = 9
		},
		{
			direction = 3,
			x = 6,
			y = 9
		},
		{
			direction = 3,
			x = 7,
			y = 9
		},
		{
			direction = 3,
			x = 8,
			y = 9
		},
		{
			direction = 3,
			x = 9,
			y = 9
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
			groupName = "精英大鹿",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15005901,
					x = 7,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "可爱小鹿",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15005904,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15005904,
					x = 8,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "支援小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15005902,
					x = 7,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "黑伞小特异",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15005903,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15005903,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15005903,
					x = 11,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15005903,
					x = 12,
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
		[15005901] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 109.4,
			maxHp = 65581.4,
			aiName = "ai_120090_路障角兽",
			battleCamp = 1,
			career = 2,
			magicAtk = 109.4,
			pre_meleeDef = 627.7,
			sanity = 0,
			remark = "守卫精英（振荡2次；范围变大）",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 627.7,
			level = 69,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1094,
			pre_meleeAtk = 1094,
			pre_maxHp = 65581.4,
			colorType = 2,
			monsterType = 1,
			id = 15005901,
			mobility = 2,
			pre_magicDef = 389,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 62.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 62.7,
			modelId = 120090,
			magicDef = 389,
			specialSkill = 0,
			extraSkills = {
				1209003
			},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[15005902] = {
			normalSkill = 1209501,
			name = "抽水花洒",
			pre_magicAtk = 1334.1,
			maxHp = 6470.5,
			aiName = "ai_120095_抽水花洒",
			battleCamp = 1,
			career = 6,
			magicAtk = 1334.1,
			pre_meleeDef = 379.5,
			sanity = 0,
			remark = "支援小怪",
			giftSkill = 1209503,
			weakPointHpRate = 0,
			meleeDef = 379.5,
			level = 69,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 133.4,
			pre_meleeAtk = 133.4,
			pre_maxHp = 6470.5,
			colorType = 4,
			monsterType = 0,
			id = 15005902,
			mobility = 2,
			pre_magicDef = 532.2,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.7,
			modelId = 120095,
			magicDef = 532.2,
			specialSkill = 1209502,
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
		[15005903] = {
			normalSkill = 1209801,
			name = "徘徊雨具",
			pre_magicAtk = 1399.8,
			maxHp = 6231.8,
			aiName = "ai_120098_黑伞人",
			battleCamp = 1,
			career = 4,
			magicAtk = 1399.8,
			pre_meleeDef = 351.9,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1209802,
			weakPointHpRate = 0,
			meleeDef = 351.9,
			level = 69,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 140,
			pre_meleeAtk = 140,
			pre_maxHp = 6231.8,
			colorType = 1,
			monsterType = 0,
			id = 15005903,
			mobility = 2,
			pre_magicDef = 495,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 79.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 79.7,
			modelId = 120098,
			magicDef = 495,
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
		[15005904] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 112.8,
			maxHp = 10749.9,
			aiName = "ai_120090_路障角兽",
			battleCamp = 1,
			career = 2,
			magicAtk = 112.8,
			pre_meleeDef = 564.9,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 564.9,
			level = 69,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1128.1,
			pre_meleeAtk = 1128.1,
			pre_maxHp = 10749.9,
			colorType = 2,
			monsterType = 0,
			id = 15005904,
			mobility = 2,
			pre_magicDef = 350.1,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.7,
			modelId = 120090,
			magicDef = 350.1,
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
