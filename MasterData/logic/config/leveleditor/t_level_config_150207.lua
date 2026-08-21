-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150207.lua

module("logic.config.leveleditor.t_level_config_150207", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "国坤爬塔暗面7",
	levelId = "150207",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔暗面2-7",
	lossConditionDesc = "",
	sceneId = "112001",
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
			y = 8
		},
		{
			direction = 2,
			x = 7,
			y = 7
		},
		{
			direction = 2,
			x = 7,
			y = 6
		},
		{
			direction = 2,
			x = 8,
			y = 8
		},
		{
			direction = 2,
			x = 8,
			y = 7
		},
		{
			direction = 2,
			x = 8,
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15020701,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[15020701] = {
			normalSkill = 1101321,
			name = "安妮薇",
			pre_magicAtk = 1864.5,
			maxHp = 203498.4,
			aiName = "ai_国坤暗面安妮薇",
			battleCamp = 1,
			career = 4,
			magicAtk = 1923,
			pre_meleeDef = 463,
			sanity = 0,
			remark = "国坤暗塔用黑化安妮薇",
			giftSkill = 1101323,
			weakPointHpRate = 0.4,
			meleeDef = 1023,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 186.5,
			pre_meleeAtk = 186.5,
			pre_maxHp = 143498.4,
			colorType = 3,
			monsterType = 2,
			id = 15020701,
			mobility = 2,
			pre_magicDef = 656,
			aiStepOrder = 0,
			trumpSkill = 1101320,
			isFuzzy = false,
			inspire = 90,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 100013,
			magicDef = 1233,
			specialSkill = 1101322,
			extraSkills = {
				1101324,
				1101325
			},
			attributeGrade = {
				"S",
				"C",
				"A",
				"S",
				"A"
			},
			tags = {}
		}
	}
}

return configData
