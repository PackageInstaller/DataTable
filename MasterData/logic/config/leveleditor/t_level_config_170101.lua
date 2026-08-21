-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_170101.lua

module("logic.config.leveleditor.t_level_config_170101", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "170101",
	plotEventGroup = 0,
	maxPerson = 0,
	initRotationOffSet = 0,
	maxRound = 8,
	levelName = "足球PVP",
	lossConditionDesc = "",
	sceneId = "170101",
	winConditionDesc = "",
	forbidAction = {
		auto = false,
		move = false,
		strengthenSkill = false,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {},
	additionalTerrainList = {},
	winConditionGroupList = {
		{
			tag = "",
			isBackup = false,
			hasTag = false,
			winConditionList = {
				{
					round = 8,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
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
			groupName = "足球NPC",
			color = 7,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 17010101,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 7,
			y = 7
		}
	},
	lockHeroList = {},
	monsters = {
		[17010101] = {
			normalSkill = 1217002,
			name = "足球",
			pre_magicAtk = 0,
			maxHp = 0,
			aiName = "football_ai",
			battleCamp = 0,
			career = 6,
			magicAtk = 0,
			pre_meleeDef = 0,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 0,
			level = 99,
			monsterGroup = "",
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 0,
			pre_maxHp = 0,
			colorType = 4,
			monsterType = 0,
			id = 17010101,
			mobility = 1,
			pre_magicDef = 0,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 0,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 0,
			pre_inspire = 0,
			modelId = 120007,
			magicDef = 0,
			specialSkill = 1217001,
			extraSkills = {
				1217003
			},
			attributeGrade = {
				"C",
				"C",
				"C",
				"C",
				"C"
			}
		}
	}
}

return configData
