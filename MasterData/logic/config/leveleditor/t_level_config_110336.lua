-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110336.lua

module("logic.config.leveleditor.t_level_config_110336", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "困难3-6",
	levelId = "110336",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难3-6",
	lossConditionDesc = "",
	sceneId = "111001",
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
			x = 3,
			y = 2
		},
		{
			direction = 1,
			x = 4,
			y = 2
		},
		{
			direction = 1,
			x = 5,
			y = 2
		},
		{
			direction = 1,
			x = 5,
			y = 1
		},
		{
			direction = 1,
			x = 4,
			y = 1
		},
		{
			direction = 1,
			x = 3,
			y = 1
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 1,
			posList = {
				{
					x = 6,
					y = 10
				}
			}
		},
		{
			terrainId = 1005,
			times = 1,
			posList = {
				{
					x = 7,
					y = 10
				}
			}
		},
		{
			terrainId = 1005,
			times = 1,
			posList = {
				{
					x = 1,
					y = 10
				}
			}
		},
		{
			terrainId = 1005,
			times = 1,
			posList = {
				{
					x = 2,
					y = 10
				}
			}
		}
	},
	winConditionGroupList = {
		{
			tag = "",
			isBackup = false,
			hasTag = false,
			winConditionList = {
				{
					round = 10,
					heroId = 0,
					count = 2,
					monsterTag = "",
					DIYName = "",
					condition = 7,
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组1",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 11033601,
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
			groupName = "怪物组2",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11033602,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11033602,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11033602,
					x = 1,
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
			groupName = "怪物组3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 11033603,
					x = 9,
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
					monsterId = 11033603,
					x = 10,
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
					monsterId = 11033603,
					x = 10,
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
					monsterId = 11033603,
					x = 9,
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
			groupName = "怪物组4",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11033604,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11033604,
					x = 8,
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
		[11033601] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 44,
			maxHp = 19463.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 44,
			pre_meleeDef = 294.8,
			sanity = 0,
			remark = "守卫精英（振荡2次,范围变大）",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 294.8,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 440.3,
			pre_meleeAtk = 440.3,
			pre_maxHp = 19463.1,
			colorType = 2,
			monsterType = 1,
			id = 11033601,
			mobility = 2,
			pre_magicDef = 142.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 49.2,
			modelId = 120090,
			magicDef = 142.2,
			specialSkill = 1209003,
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
		[11033602] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 40.2,
			maxHp = 5429,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 40.2,
			pre_meleeDef = 265.3,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 265.3,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 402.2,
			pre_meleeAtk = 402.2,
			pre_maxHp = 5429,
			colorType = 2,
			monsterType = 0,
			id = 11033602,
			mobility = 2,
			pre_magicDef = 128,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 46.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46.2,
			modelId = 120090,
			magicDef = 128,
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
		[11033603] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 42.4,
			maxHp = 3956,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 42.4,
			pre_meleeDef = 233.8,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时,主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 233.8,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 423.3,
			pre_meleeAtk = 423.3,
			pre_maxHp = 3956,
			colorType = 4,
			monsterType = 0,
			id = 11033603,
			mobility = 1,
			pre_magicDef = 151.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56.2,
			modelId = 120069,
			magicDef = 151.6,
			specialSkill = 1206902,
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
		[11033604] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 451.7,
			maxHp = 3322.4,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 451.7,
			pre_meleeDef = 143.5,
			sanity = 0,
			remark = "支援小怪(主动攻击后援护)",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 143.5,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 45.2,
			pre_meleeAtk = 45.2,
			pre_maxHp = 3322.4,
			colorType = 4,
			monsterType = 0,
			id = 11033604,
			mobility = 2,
			pre_magicDef = 245.7,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 46.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46.2,
			modelId = 120012,
			magicDef = 245.7,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		}
	}
}

return configData
