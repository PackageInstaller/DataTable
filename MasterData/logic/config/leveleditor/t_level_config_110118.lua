-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110118.lua

module("logic.config.leveleditor.t_level_config_110118", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110118",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "主线普通1-2.1",
	lossConditionDesc = "",
	sceneId = "111003",
	winConditionDesc = "",
	forbidAction = {
		auto = false,
		move = false,
		strengthenSkill = false,
		useSpecifyTypeSkill = {
			2,
			3
		},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 4,
			x = 5,
			y = 5
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "一回合路障",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 11011801,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 1,
					tag = "",
					monsterId = 11011801,
					x = 3,
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
					monsterId = 11011802,
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
			heroId = 2000022,
			direction = 4,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 5,
				y = 2
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 2000016,
			direction = 4,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 5,
				y = 5
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[11011801] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 6.6,
			maxHp = 258,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 2,
			magicAtk = 6.6,
			pre_meleeDef = 48.6,
			sanity = 0,
			remark = "守卫小怪（新手展示动画用）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 48.6,
			level = 2,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 66.1,
			pre_meleeAtk = 66.1,
			pre_maxHp = 338.5,
			colorType = 2,
			monsterType = 0,
			id = 11011801,
			mobility = 2,
			pre_magicDef = 22.5,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26,
			modelId = 120090,
			magicDef = 22.5,
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
		[11011802] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 7.1,
			maxHp = 156,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 2,
			magicAtk = 7.1,
			pre_meleeDef = 43.2,
			sanity = 0,
			remark = "守卫小怪（新手展示动画用）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 43.2,
			level = 1,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 70.6,
			pre_meleeAtk = 70.6,
			pre_maxHp = 244.6,
			colorType = 2,
			monsterType = 0,
			id = 11011802,
			mobility = 2,
			pre_magicDef = 20,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 20,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 20,
			modelId = 120090,
			magicDef = 20,
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
		}
	}
}

return configData
