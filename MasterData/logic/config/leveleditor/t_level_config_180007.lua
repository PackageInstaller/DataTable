-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_180007.lua

module("logic.config.leveleditor.t_level_config_180007", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "180007",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "欧几里得",
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
					monsterId = 18000702,
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
			monsterId = 18000701,
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
		[18000701] = {
			normalSkill = 1100701,
			name = "欧几里得",
			pre_magicAtk = 172.1,
			maxHp = 371.5,
			aiName = "auto_support_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 172.1,
			pre_meleeDef = 41,
			sanity = 0,
			remark = "",
			giftSkill = 1100704,
			weakPointHpRate = 0,
			meleeDef = 41,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 33.2,
			pre_meleeAtk = 33.2,
			pre_maxHp = 371.5,
			colorType = 4,
			monsterType = 0,
			id = 18000701,
			mobility = 2,
			pre_magicDef = 73.3,
			aiStepOrder = 1,
			trumpSkill = 1100703,
			isFuzzy = false,
			inspire = 31.1,
			camp = 5,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.1,
			modelId = 100007,
			magicDef = 73.3,
			specialSkill = 1100702,
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
		[18000702] = {
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
			id = 18000702,
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
