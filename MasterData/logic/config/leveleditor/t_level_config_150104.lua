-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150104.lua

module("logic.config.leveleditor.t_level_config_150104", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150104",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "爬塔暗面1-4",
	lossConditionDesc = "",
	sceneId = "920020",
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
			x = 7,
			y = 7
		},
		{
			direction = 3,
			x = 5,
			y = 8
		},
		{
			direction = 3,
			x = 6,
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
			y = 8
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
			groupName = "小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 15010403,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 15010403,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 15010403,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15010401,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15010401,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15010401,
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
			groupName = "精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15010402,
					x = 7,
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
	trialHeroes = {},
	monsters = {
		[15010401] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 71.5,
			maxHp = 6372.3,
			aiName = "ai_120028_秽卵",
			battleCamp = 1,
			career = 2,
			magicAtk = 71.5,
			pre_meleeDef = 372.6,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 372.6,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 715.1,
			pre_meleeAtk = 715.1,
			pre_maxHp = 6372.3,
			colorType = 2,
			monsterType = 0,
			id = 15010401,
			mobility = 2,
			pre_magicDef = 213.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120028,
			magicDef = 213.3,
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
		[15010402] = {
			normalSkill = 1209501,
			name = "抽水花洒",
			pre_magicAtk = 920.9,
			maxHp = 20241.8,
			aiName = "ai_120095_抽水花洒",
			battleCamp = 1,
			career = 6,
			magicAtk = 920.9,
			pre_meleeDef = 261,
			sanity = 0,
			remark = "支援精英",
			giftSkill = 1209503,
			weakPointHpRate = 0.3,
			meleeDef = 261,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 92.1,
			pre_meleeAtk = 92.1,
			pre_maxHp = 20241.8,
			colorType = 4,
			monsterType = 1,
			id = 15010402,
			mobility = 2,
			pre_magicDef = 387,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 4,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120095,
			magicDef = 387,
			specialSkill = 1209502,
			extraSkills = {
				1209504
			},
			attributeGrade = {
				"A",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15010403] = {
			normalSkill = 1201601,
			name = "巡逻道闸",
			pre_magicAtk = 74.9,
			maxHp = 5130.3,
			aiName = "ai_120016_巡逻道闸",
			battleCamp = 1,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 348.3,
			sanity = 0,
			remark = "幻影小怪",
			giftSkill = 1201602,
			weakPointHpRate = 0,
			meleeDef = 348.3,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 748.6,
			pre_meleeAtk = 748.6,
			pre_maxHp = 5130.3,
			colorType = 1,
			monsterType = 0,
			id = 15010403,
			mobility = 4,
			pre_magicDef = 212.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 63,
			modelId = 120016,
			magicDef = 212.4,
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
