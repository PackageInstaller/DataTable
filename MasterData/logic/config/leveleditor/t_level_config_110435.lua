-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110435.lua

module("logic.config.leveleditor.t_level_config_110435", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "主线困难5-5",
	levelId = "110435",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难4-5",
	lossConditionDesc = "",
	sceneId = "113003",
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
			y = 7
		},
		{
			direction = 1,
			x = 7,
			y = 7
		},
		{
			direction = 4,
			x = 6,
			y = 6
		},
		{
			direction = 3,
			x = 6,
			y = 5
		},
		{
			direction = 3,
			x = 7,
			y = 5
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
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 11043504,
					x = 7,
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
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 11043503,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 11043503,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11043503,
					x = 3,
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
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 11043502,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 11043502,
					x = 8,
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
			groupName = "怪物组4",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 11043501,
					x = 7,
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
		[11043501] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 1011.4,
			maxHp = 25505,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 1011.4,
			pre_meleeDef = 251.2,
			sanity = 0,
			remark = "绿特异精英（主动攻击触发超感；超感强化）",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 251.2,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 101.2,
			pre_meleeAtk = 101.2,
			pre_maxHp = 25505,
			colorType = 3,
			monsterType = 1,
			id = 11043501,
			mobility = 2,
			pre_magicDef = 373.8,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 77.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 77.2,
			modelId = 120068,
			magicDef = 373.8,
			specialSkill = 1206803,
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
		[11043502] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 919.8,
			maxHp = 4019,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 919.8,
			pre_meleeDef = 226.1,
			sanity = 0,
			remark = "蓝特异小怪",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 226.1,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 92,
			pre_meleeAtk = 92,
			pre_maxHp = 4019,
			colorType = 2,
			monsterType = 0,
			id = 11043502,
			mobility = 2,
			pre_magicDef = 336.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 74.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 74.2,
			modelId = 120068,
			magicDef = 336.4,
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
		[11043503] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 919.8,
			maxHp = 4019,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 919.8,
			pre_meleeDef = 226.1,
			sanity = 0,
			remark = "红特异小怪（主动攻击触发超感）",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 226.1,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 92,
			pre_meleeAtk = 92,
			pre_maxHp = 4019,
			colorType = 1,
			monsterType = 0,
			id = 11043503,
			mobility = 2,
			pre_magicDef = 336.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 74.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 74.2,
			modelId = 120068,
			magicDef = 336.4,
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
		[11043504] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 74.7,
			maxHp = 6912.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 74.7,
			pre_meleeDef = 389.3,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 389.3,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 746.8,
			pre_meleeAtk = 746.8,
			pre_maxHp = 6912.5,
			colorType = 2,
			monsterType = 0,
			id = 11043504,
			mobility = 2,
			pre_magicDef = 224.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 54.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 54.2,
			modelId = 120090,
			magicDef = 224.6,
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
		[11043505] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 72.5,
			maxHp = 43029.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 72.5,
			pre_meleeDef = 432.6,
			sanity = 0,
			remark = "守卫精英（振荡2次；范围变大）",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 432.6,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 725,
			pre_meleeAtk = 725,
			pre_maxHp = 43029.8,
			colorType = 2,
			monsterType = 1,
			id = 11043505,
			mobility = 2,
			pre_magicDef = 249.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 57.2,
			modelId = 120090,
			magicDef = 249.6,
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
		}
	}
}

return configData
