-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171043.lua

module("logic.config.leveleditor.t_level_config_171043", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "171043",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "钢琴03",
	lossConditionDesc = "",
	sceneId = "109007",
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
			x = 3,
			y = 5
		},
		{
			direction = 2,
			x = 3,
			y = 4
		},
		{
			direction = 2,
			x = 3,
			y = 3
		},
		{
			direction = 4,
			x = 10,
			y = 5
		},
		{
			direction = 4,
			x = 10,
			y = 4
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
					condition = 3,
					monsterIds = {
						17104301
					}
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
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 17104301,
					x = 6,
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
			x = 10,
			y = 4
		}
	},
	lockHeroList = {},
	monsters = {
		[17104301] = {
			normalSkill = 1217141,
			name = "容易害羞的钢琴",
			pre_magicAtk = 1538.9,
			maxHp = 105574.2,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 1538.9,
			pre_meleeDef = 398,
			sanity = 0,
			remark = "",
			giftSkill = 1217144,
			weakPointHpRate = 0,
			meleeDef = 398,
			level = 70,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 153.9,
			pre_meleeAtk = 153.9,
			pre_maxHp = 105574.2,
			colorType = 1,
			monsterType = 2,
			id = 17104301,
			mobility = 0,
			pre_magicDef = 559,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 85,
			modelId = 120100,
			magicDef = 559,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		}
	}
}

return configData
