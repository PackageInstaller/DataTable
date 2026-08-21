-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110102.lua

module("logic.config.leveleditor.t_level_config_110102", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110102",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "主线普通1-2",
	lossConditionDesc = "",
	sceneId = "117002",
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
			x = 5,
			y = 7
		},
		{
			direction = 2,
			x = 4,
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
			groupName = "初始刷新怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11010201,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 11010202,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "第一二回合过度怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11010203,
					x = 9,
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
			groupName = "烟火单独怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 11010204,
					x = 6,
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
			heroId = 2000022,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 5,
				y = 7
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 2000016,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 4,
				y = 6
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[11010201] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 8.1,
			maxHp = 221,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 3,
			magicAtk = 8.1,
			pre_meleeDef = 49.6,
			sanity = 0,
			remark = "狙击小怪（新手展示动画用）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 49.6,
			level = 4,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 80.7,
			pre_meleeAtk = 80.7,
			pre_maxHp = 280.8,
			colorType = 3,
			monsterType = 0,
			id = 11010201,
			mobility = 2,
			pre_magicDef = 23.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22,
			modelId = 120088,
			magicDef = 23.2,
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
		[11010202] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 8.3,
			maxHp = 189,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 3,
			magicAtk = 8.3,
			pre_meleeDef = 39.2,
			sanity = 0,
			remark = "狙击小怪（新手展示动画用）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 39,
			level = 3,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.8,
			pre_meleeAtk = 82.8,
			pre_maxHp = 189.2,
			colorType = 3,
			monsterType = 0,
			id = 11010202,
			mobility = 2,
			pre_magicDef = 22.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 41.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 41.5,
			modelId = 120088,
			magicDef = 22.4,
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
		[11010203] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 8.3,
			maxHp = 235,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 3,
			magicAtk = 8.3,
			pre_meleeDef = 39.2,
			sanity = 0,
			remark = "狙击小怪（新手展示动画用）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 39,
			level = 3,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.8,
			pre_meleeAtk = 82.8,
			pre_maxHp = 189.2,
			colorType = 3,
			monsterType = 0,
			id = 11010203,
			mobility = 2,
			pre_magicDef = 22.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 41.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 41.5,
			modelId = 120088,
			magicDef = 22.4,
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
		[11010204] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 8.3,
			maxHp = 180,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 3,
			magicAtk = 8.3,
			pre_meleeDef = 39.2,
			sanity = 0,
			remark = "狙击小怪（新手展示动画用）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 39,
			level = 3,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.8,
			pre_meleeAtk = 82.8,
			pre_maxHp = 189.2,
			colorType = 3,
			monsterType = 0,
			id = 11010204,
			mobility = 2,
			pre_magicDef = 22.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 41.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 41.5,
			modelId = 120088,
			magicDef = 22.4,
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
		}
	}
}

return configData
