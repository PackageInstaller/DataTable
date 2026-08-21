-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_180002.lua

module("logic.config.leveleditor.t_level_config_180002", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "180002",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "爱丽丝",
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
					monsterId = 18000202,
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
			monsterId = 18000201,
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
		[18000201] = {
			normalSkill = 1100201,
			name = "爱丽丝",
			pre_magicAtk = 47.3,
			maxHp = 392.3,
			aiName = "auto_attack_ai",
			battleCamp = 2,
			career = 5,
			magicAtk = 47.3,
			pre_meleeDef = 81.6,
			sanity = 0,
			remark = "",
			giftSkill = 1100204,
			weakPointHpRate = 0,
			meleeDef = 81.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 193.6,
			pre_meleeAtk = 193.6,
			pre_maxHp = 392.3,
			colorType = 4,
			monsterType = 0,
			id = 18000201,
			mobility = 1,
			pre_magicDef = 52.7,
			aiStepOrder = 2,
			trumpSkill = 1100203,
			isFuzzy = false,
			inspire = 38.5,
			camp = 6,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.5,
			modelId = 100002,
			magicDef = 52.7,
			specialSkill = 1100202,
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
		[18000202] = {
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
			id = 18000202,
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
