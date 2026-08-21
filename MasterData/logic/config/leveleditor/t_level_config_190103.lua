-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_190103.lua

module("logic.config.leveleditor.t_level_config_190103", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "190103",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "追击体验难度3",
	lossConditionDesc = "",
	sceneId = "116002",
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
			x = 9,
			y = 8
		},
		{
			direction = 4,
			x = 5,
			y = 8
		},
		{
			direction = 3,
			x = 8,
			y = 6
		},
		{
			direction = 3,
			x = 6,
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
					DIYName = "10回合内击杀所有原体",
					condition = 13,
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
	globalSkillCodeList = {
		1721911
	},
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
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 19010302,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 19010302,
					x = 0,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 19010302,
					x = 14,
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
		[19010301] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 84.7,
			maxHp = 5029.5,
			aiName = "ai_追击体验本",
			battleCamp = 1,
			career = 3,
			magicAtk = 84.7,
			pre_meleeDef = 346.5,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 234,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 846.7,
			pre_meleeAtk = 846.7,
			pre_maxHp = 5029.5,
			colorType = 3,
			monsterType = 0,
			id = 19010301,
			mobility = 2,
			pre_magicDef = 234,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 75,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 75,
			modelId = 120088,
			magicDef = 346.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"C",
				"C",
				"B"
			},
			tags = {}
		},
		[19010302] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 94,
			maxHp = 53499.7,
			aiName = "ai_追击体验本",
			battleCamp = 1,
			career = 3,
			magicAtk = 111,
			pre_meleeDef = 385,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.18,
			meleeDef = 260,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1109.9,
			pre_meleeAtk = 940.1,
			pre_maxHp = 31822,
			colorType = 3,
			monsterType = 1,
			id = 19010302,
			mobility = 2,
			pre_magicDef = 260,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 78,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 78,
			modelId = 120088,
			magicDef = 385,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"C",
				"C",
				"B"
			},
			tags = {}
		}
	}
}

return configData
