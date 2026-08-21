-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110432.lua

module("logic.config.leveleditor.t_level_config_110432", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "主线困难4-2",
	levelId = "110432",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难4-2",
	lossConditionDesc = "",
	sceneId = "109001",
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
			x = 10,
			y = 5
		},
		{
			direction = 2,
			x = 10,
			y = 8
		},
		{
			direction = 2,
			x = 10,
			y = 7
		},
		{
			direction = 2,
			x = 10,
			y = 6
		},
		{
			direction = 2,
			x = 10,
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
			form = 5,
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
					y = 7,
					tag = "",
					monsterId = 11043201,
					x = 15,
					initialStatus = {
						hpPercent = 100,
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
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11043202,
					x = 14,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 11043202,
					x = 14,
					initialStatus = {
						hpPercent = 100,
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
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11043203,
					x = 12,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 11043203,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 11043203,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11043203,
					x = 12,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 11043203,
					x = 12,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 4,
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
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11043204,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[11043201] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 70.7,
			maxHp = 18719.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 70.7,
			pre_meleeDef = 315,
			sanity = 0,
			remark = "陨灭精英（具有3层及以上的轰鸣时；主动攻击必定暴击；暴伤提升）",
			giftSkill = 1206903,
			weakPointHpRate = 0.3,
			meleeDef = 315,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 707.4,
			pre_meleeAtk = 707.4,
			pre_maxHp = 18719.9,
			colorType = 4,
			monsterType = 1,
			id = 11043201,
			mobility = 1,
			pre_magicDef = 226.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63.6,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 63.6,
			modelId = 120069,
			magicDef = 226.8,
			specialSkill = 1206902,
			extraSkills = {
				1206904
			},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"B"
			},
			tags = {}
		},
		[11043202] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 64,
			maxHp = 3524.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 64,
			pre_meleeDef = 283.5,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 283.5,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 640.1,
			pre_meleeAtk = 640.1,
			pre_maxHp = 3524.7,
			colorType = 4,
			monsterType = 0,
			id = 11043202,
			mobility = 1,
			pre_magicDef = 204.1,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60.6,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60.6,
			modelId = 120069,
			magicDef = 204.1,
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
		[11043203] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 59.7,
			maxHp = 4897.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 59.7,
			pre_meleeDef = 319.3,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 319.3,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 596.5,
			pre_meleeAtk = 596.5,
			pre_maxHp = 4897.7,
			colorType = 2,
			monsterType = 0,
			id = 11043203,
			mobility = 2,
			pre_magicDef = 174.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50.6,
			modelId = 120028,
			magicDef = 174.4,
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
		[11043204] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 698.8,
			maxHp = 2972.3,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 698.8,
			pre_meleeDef = 193.9,
			sanity = 0,
			remark = "支援小怪(主动攻击后援护)",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 193.9,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 69.9,
			pre_meleeAtk = 69.9,
			pre_maxHp = 2972.3,
			colorType = 4,
			monsterType = 0,
			id = 11043204,
			mobility = 2,
			pre_magicDef = 297.2,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50.6,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50.6,
			modelId = 120012,
			magicDef = 297.2,
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
		},
		[11043205] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 58,
			maxHp = 30672.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 58,
			pre_meleeDef = 354.8,
			sanity = 0,
			remark = "守卫精英（受到攻击后触发振荡；振荡范围强化）",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 354.8,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 579.6,
			pre_meleeAtk = 579.6,
			pre_maxHp = 30672.7,
			colorType = 2,
			monsterType = 1,
			id = 11043205,
			mobility = 2,
			pre_magicDef = 193.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 53.6,
			modelId = 120028,
			magicDef = 193.8,
			specialSkill = 1202803,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
