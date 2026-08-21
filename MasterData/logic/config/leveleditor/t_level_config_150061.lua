-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150061.lua

module("logic.config.leveleditor.t_level_config_150061", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150061",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "爬塔明面61",
	lossConditionDesc = "",
	sceneId = "116001",
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
			x = 9,
			y = 2
		},
		{
			direction = 1,
			x = 10,
			y = 2
		},
		{
			direction = 1,
			x = 11,
			y = 2
		},
		{
			direction = 4,
			x = 5,
			y = 3
		},
		{
			direction = 4,
			x = 5,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英黑伞人",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 15006101,
					x = 11,
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
			groupName = "小小黑伞人",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 15006102,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 1,
					tag = "",
					monsterId = 15006102,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 15006102,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 15006102,
					x = 9,
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
			groupName = "守卫小怪",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 15006103,
					x = 10,
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
			groupName = "打杂小特异",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 15006104,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 15006104,
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
		[15006101] = {
			normalSkill = 1209801,
			name = "徘徊雨具",
			pre_magicAtk = 1596,
			maxHp = 40471.7,
			aiName = "ai_120098_黑伞人",
			battleCamp = 1,
			career = 4,
			magicAtk = 1596,
			pre_meleeDef = 398,
			sanity = 0,
			remark = "特异精英",
			giftSkill = 1209802,
			weakPointHpRate = 0.3,
			meleeDef = 398,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 159.6,
			pre_meleeAtk = 159.6,
			pre_maxHp = 40471.7,
			colorType = 1,
			monsterType = 1,
			id = 15006101,
			mobility = 2,
			pre_magicDef = 559,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 83,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 83,
			modelId = 120098,
			magicDef = 559,
			specialSkill = 0,
			extraSkills = {
				1209803
			},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15006102] = {
			normalSkill = 1209801,
			name = "徘徊雨具",
			pre_magicAtk = 1445.7,
			maxHp = 6505.8,
			aiName = "ai_120098_黑伞人",
			battleCamp = 1,
			career = 4,
			magicAtk = 1445.7,
			pre_meleeDef = 358.2,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1209802,
			weakPointHpRate = 0,
			meleeDef = 358.2,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 144.6,
			pre_meleeAtk = 144.6,
			pre_maxHp = 6505.8,
			colorType = 1,
			monsterType = 0,
			id = 15006102,
			mobility = 2,
			pre_magicDef = 503.1,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 80,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 80,
			modelId = 120098,
			magicDef = 503.1,
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
		[15006103] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 116.2,
			maxHp = 11239.3,
			aiName = "ai_120014_禁行隔离墩",
			battleCamp = 1,
			career = 2,
			magicAtk = 116.2,
			pre_meleeDef = 574.2,
			sanity = 0,
			remark = "守卫小怪（受到攻击后锥刺）",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 574.2,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1161.8,
			pre_meleeAtk = 1161.8,
			pre_maxHp = 11239.3,
			colorType = 2,
			monsterType = 0,
			id = 15006103,
			mobility = 2,
			pre_magicDef = 356.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120014,
			magicDef = 356.4,
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
		},
		[15006104] = {
			normalSkill = 1208201,
			name = "拟态/蚺",
			pre_magicAtk = 1445.7,
			maxHp = 6505.8,
			aiName = "ai_120082_假死",
			battleCamp = 1,
			career = 4,
			magicAtk = 1445.7,
			pre_meleeDef = 358.2,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1208202,
			weakPointHpRate = 0,
			meleeDef = 358.2,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 144.6,
			pre_meleeAtk = 144.6,
			pre_maxHp = 6505.8,
			colorType = 2,
			monsterType = 0,
			id = 15006104,
			mobility = 2,
			pre_magicDef = 503.1,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 80,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 80,
			modelId = 120082,
			magicDef = 503.1,
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
		}
	}
}

return configData
