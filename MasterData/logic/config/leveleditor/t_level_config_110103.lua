-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110103.lua

module("logic.config.leveleditor.t_level_config_110103", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110103",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通1-3",
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
			direction = 2,
			x = 7,
			y = 5
		},
		{
			direction = 2,
			x = 6,
			y = 6
		},
		{
			direction = 4,
			x = 5,
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
					round = 3,
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
			groupName = "远程怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11010302,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11010302,
					x = 10,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "前排怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11010301,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 11010301,
					x = 10,
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
			groupName = "左侧幻影怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11010303,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 11010303,
					x = 3,
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
			isInitialStatus = false,
			heroId = 2000016,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 7,
				y = 5
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 2000022,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 6,
				y = 6
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[11010301] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 7,
			maxHp = 147,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 2,
			magicAtk = 7,
			pre_meleeDef = 44.8,
			sanity = 0,
			remark = "守卫小怪（新手展示动画用）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 44.8,
			level = 3,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 55.9,
			pre_meleeAtk = 55.9,
			pre_maxHp = 192.4,
			colorType = 2,
			monsterType = 0,
			id = 11010301,
			mobility = 2,
			pre_magicDef = 20.2,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 21,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 21,
			modelId = 120090,
			magicDef = 20.2,
			specialSkill = 1209004,
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
		[11010302] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 8.9,
			maxHp = 215,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 3,
			magicAtk = 8.9,
			pre_meleeDef = 42.4,
			sanity = 0,
			remark = "狙击小怪（新手展示动画用）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 42.4,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 89.3,
			pre_meleeAtk = 89.3,
			pre_maxHp = 205.4,
			colorType = 3,
			monsterType = 0,
			id = 11010302,
			mobility = 2,
			pre_magicDef = 24,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 42.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 42.5,
			modelId = 120088,
			magicDef = 24,
			specialSkill = 1208804,
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
		[11010303] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 8,
			maxHp = 140,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 1,
			magicAtk = 8,
			pre_meleeDef = 44,
			sanity = 0,
			remark = "幻影小怪（新手展示动画用）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 44,
			level = 3,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 80,
			pre_meleeAtk = 80,
			pre_maxHp = 217.4,
			colorType = 1,
			monsterType = 0,
			id = 11010303,
			mobility = 4,
			pre_magicDef = 21.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.5,
			modelId = 120089,
			magicDef = 21.6,
			specialSkill = 1208906,
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
