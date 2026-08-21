-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_990010.lua

module("logic.config.leveleditor.t_level_config_990010", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "测试1001~1004,2001~2002地形",
	levelId = "990010",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 99,
	levelName = "测试-附加地形1",
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
			direction = 2,
			x = 1,
			y = 13
		},
		{
			direction = 2,
			x = 1,
			y = 11
		},
		{
			direction = 2,
			x = 1,
			y = 9
		},
		{
			direction = 2,
			x = 12,
			y = 10
		},
		{
			direction = 2,
			x = 12,
			y = 6
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1001,
			times = 5,
			posList = {
				{
					x = 5,
					y = 12
				},
				{
					x = 6,
					y = 12
				},
				{
					x = 5,
					y = 11
				},
				{
					x = 6,
					y = 11
				}
			}
		},
		{
			terrainId = 1002,
			times = 3,
			posList = {
				{
					x = 4,
					y = 9
				},
				{
					x = 5,
					y = 9
				},
				{
					x = 4,
					y = 8
				},
				{
					x = 5,
					y = 8
				}
			}
		},
		{
			terrainId = 1003,
			times = 0,
			posList = {
				{
					x = 4,
					y = 6
				},
				{
					x = 5,
					y = 6
				},
				{
					x = 4,
					y = 5
				},
				{
					x = 5,
					y = 5
				}
			}
		},
		{
			terrainId = 1004,
			times = 0,
			posList = {
				{
					x = 8,
					y = 6
				},
				{
					x = 9,
					y = 6
				},
				{
					x = 8,
					y = 5
				},
				{
					x = 9,
					y = 5
				}
			}
		},
		{
			terrainId = 2001,
			times = 0,
			posList = {
				{
					x = 8,
					y = 12
				},
				{
					x = 9,
					y = 12
				},
				{
					x = 8,
					y = 11
				},
				{
					x = 9,
					y = 11
				}
			}
		},
		{
			terrainId = 2002,
			times = 0,
			posList = {
				{
					x = 8,
					y = 9
				},
				{
					x = 9,
					y = 9
				},
				{
					x = 8,
					y = 8
				},
				{
					x = 9,
					y = 8
				}
			}
		}
	},
	winConditionGroupList = {
		{
			tag = "",
			isBackup = false,
			hasTag = false,
			winConditionList = {
				{
					round = 99,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组1",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 99001001,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 99001001,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 99001001,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 99001001,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 99001001,
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
	lockHeroList = {},
	monsters = {
		[99001001] = {
			normalSkill = 1200601,
			name = "迷雾使徒",
			pre_magicAtk = 68.8,
			maxHp = 150.2,
			aiName = "",
			battleCamp = 1,
			career = 2,
			magicAtk = 68.8,
			pre_meleeDef = 53.5,
			sanity = 1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 53.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 171.2,
			pre_meleeAtk = 171.2,
			pre_maxHp = 150.2,
			colorType = 2,
			monsterType = 0,
			id = 99001001,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 120007,
			magicDef = 37.8,
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
