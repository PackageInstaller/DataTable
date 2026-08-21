-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166349.lua

module("logic.config.leveleditor.t_level_config_166349", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166349",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学29",
	lossConditionDesc = "",
	sceneId = "99000212",
	winConditionDesc = "利用瓦解",
	forbidAction = {
		auto = true,
		move = false,
		strengthenSkill = true,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 2,
			x = 2,
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
			condition = 3,
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 16634901,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16634901,
					x = 3,
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
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16634902,
			pos = {
				x = 2,
				y = 2
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	trialHeroes = {},
	monsters = {
		[16634901] = {
			normalSkill = 1770133,
			name = "迷雾使徒",
			pre_magicAtk = 14.4,
			maxHp = 655,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 20,
			pre_meleeDef = 78.3,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 1770132,
			weakPointHpRate = 0,
			meleeDef = 80,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 400,
			pre_meleeAtk = 144.2,
			pre_maxHp = 651.8,
			colorType = 3,
			monsterType = 0,
			id = 16634901,
			mobility = 2,
			pre_magicDef = 38.7,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120008,
			magicDef = 40,
			specialSkill = 0,
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
		[16634902] = {
			normalSkill = 1770129,
			name = "厄迪普斯",
			pre_magicAtk = 267.9,
			maxHp = 700,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 300,
			pre_meleeDef = 68.4,
			sanity = 0,
			remark = "厄迪普斯",
			giftSkill = 1770131,
			weakPointHpRate = 0,
			meleeDef = 60,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 20,
			pre_meleeAtk = 26.8,
			pre_maxHp = 712.6,
			colorType = 3,
			monsterType = 0,
			id = 16634902,
			mobility = 2,
			pre_magicDef = 108,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 7,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 100057,
			magicDef = 120,
			specialSkill = 1770130,
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
