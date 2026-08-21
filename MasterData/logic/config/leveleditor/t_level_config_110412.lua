-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110412.lua

module("logic.config.leveleditor.t_level_config_110412", package.seeall)

local configData = {
	battleMusicName = "music_battle_character_anna_block",
	remarks = "",
	levelId = "110412",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通4-12",
	lossConditionDesc = "",
	sceneId = "110002",
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
			direction = 3,
			x = 5,
			y = 8
		},
		{
			direction = 3,
			x = 6,
			y = 8
		},
		{
			direction = 3,
			x = 7,
			y = 8
		},
		{
			direction = 3,
			x = 5,
			y = 9
		},
		{
			direction = 3,
			x = 7,
			y = 9
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
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11041201,
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
	lockHeroList = {},
	monsters = {
		[11041201] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 70.3,
			maxHp = 68687.9,
			aiName = "ai_蠕虫放映机",
			battleCamp = 1,
			career = 2,
			magicAtk = 70.3,
			pre_meleeDef = 340,
			sanity = 0,
			remark = "boss模板",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 340,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 702.9,
			pre_meleeAtk = 702.9,
			pre_maxHp = 68687.9,
			colorType = 2,
			monsterType = 2,
			id = 11041201,
			mobility = 0,
			pre_magicDef = 183,
			aiStepOrder = 1,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 55,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120087,
			magicDef = 183,
			specialSkill = 1208702,
			extraSkills = {
				1208705
			},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
