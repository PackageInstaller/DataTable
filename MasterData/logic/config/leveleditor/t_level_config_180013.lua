-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_180013.lua

module("logic.config.leveleditor.t_level_config_180013", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "180013",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "安妮薇",
	lossConditionDesc = "",
	sceneId = "114001",
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
					DIYName = "击杀所有敌人",
					condition = 1,
					monsterIds = {}
				}
			}
		}
	},
	lossConditionList = {},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 18001302,
					x = 9,
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
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 18001301,
			pos = {
				x = 5,
				y = 7
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[18001301] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 155.3,
			maxHp = 474.5,
			aiName = "auto_anniwei_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 155.3,
			pre_meleeDef = 37.9,
			sanity = 0,
			remark = "",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 37.9,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 35.2,
			pre_meleeAtk = 35.2,
			pre_maxHp = 474.5,
			colorType = 1,
			monsterType = 0,
			id = 18001301,
			mobility = 2,
			pre_magicDef = 67.9,
			aiStepOrder = 2,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 48.1,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 48.1,
			modelId = 100013,
			magicDef = 67.9,
			specialSkill = 1101302,
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
		[18001302] = {
			normalSkill = 1209801,
			name = "徘徊雨具",
			pre_magicAtk = 40,
			maxHp = 449.59,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 40,
			pre_meleeDef = 40.46,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 40.46,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 136.7,
			pre_meleeAtk = 136.7,
			pre_maxHp = 449.59,
			colorType = 2,
			monsterType = 0,
			id = 18001302,
			mobility = 2,
			pre_magicDef = 51.59,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 20.53,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 20.53,
			modelId = 120098,
			magicDef = 51.59,
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
		}
	}
}

return configData
