-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_990012.lua

module("logic.config.leveleditor.t_level_config_990012", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "测试附加地形多格单位、覆盖情况",
	levelId = "990012",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 99,
	levelName = "测试-附加地形3",
	lossConditionDesc = "",
	sceneId = "920001",
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
			x = 2,
			y = 11
		},
		{
			direction = 2,
			x = 2,
			y = 10
		},
		{
			direction = 2,
			x = 2,
			y = 9
		},
		{
			direction = 2,
			x = 2,
			y = 8
		},
		{
			direction = 2,
			x = 2,
			y = 7
		},
		{
			direction = 2,
			x = 2,
			y = 6
		},
		{
			direction = 2,
			x = 2,
			y = 5
		},
		{
			direction = 2,
			x = 2,
			y = 4
		},
		{
			direction = 2,
			x = 2,
			y = 2
		},
		{
			direction = 2,
			x = 2,
			y = 3
		},
		{
			direction = 2,
			x = 2,
			y = 1
		},
		{
			direction = 2,
			x = 2,
			y = 12
		},
		{
			direction = 2,
			x = 2,
			y = 13
		},
		{
			direction = 2,
			x = 13,
			y = 13
		},
		{
			direction = 2,
			x = 13,
			y = 8
		},
		{
			direction = 2,
			x = 13,
			y = 12
		},
		{
			direction = 2,
			x = 13,
			y = 11
		},
		{
			direction = 2,
			x = 13,
			y = 10
		},
		{
			direction = 2,
			x = 13,
			y = 9
		},
		{
			direction = 2,
			x = 13,
			y = 7
		},
		{
			direction = 2,
			x = 13,
			y = 6
		},
		{
			direction = 2,
			x = 13,
			y = 5
		},
		{
			direction = 2,
			x = 13,
			y = 4
		},
		{
			direction = 2,
			x = 13,
			y = 3
		},
		{
			direction = 2,
			x = 13,
			y = 2
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1009,
			times = 0,
			posList = {
				{
					x = 6,
					y = 9
				},
				{
					x = 7,
					y = 9
				},
				{
					x = 7,
					y = 10
				},
				{
					x = 6,
					y = 10
				},
				{
					x = 7,
					y = 5
				},
				{
					x = 6,
					y = 5
				}
			}
		},
		{
			terrainId = 1011,
			times = 0,
			posList = {
				{
					x = 7,
					y = 4
				},
				{
					x = 6,
					y = 4
				}
			}
		},
		{
			terrainId = 2002,
			times = 0,
			posList = {
				{
					x = 10,
					y = 6
				},
				{
					x = 11,
					y = 6
				},
				{
					x = 11,
					y = 7
				},
				{
					x = 10,
					y = 7
				}
			}
		},
		{
			terrainId = 1004,
			times = 0,
			posList = {
				{
					x = 11,
					y = 5
				},
				{
					x = 11,
					y = 4
				},
				{
					x = 10,
					y = 5
				},
				{
					x = 10,
					y = 4
				}
			}
		},
		{
			terrainId = 9901,
			times = 0,
			posList = {
				{
					x = 10,
					y = 3
				},
				{
					x = 11,
					y = 3
				},
				{
					x = 11,
					y = 2
				},
				{
					x = 10,
					y = 2
				}
			}
		},
		{
			terrainId = 9913,
			times = 0,
			posList = {
				{
					x = 12,
					y = 4
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "4格怪物演示",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 99001201,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 99001201,
					x = 6,
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
		[99001201] = {
			normalSkill = 1201701,
			name = "猎食者",
			pre_magicAtk = 0,
			maxHp = 10,
			aiName = "",
			battleCamp = 1,
			career = 2,
			magicAtk = 0,
			pre_meleeDef = 35,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 35,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 17795.6,
			pre_meleeAtk = 17795.6,
			pre_maxHp = 10,
			colorType = 2,
			monsterType = 0,
			id = 99001201,
			mobility = 2,
			pre_magicDef = 0,
			aiStepOrder = 3,
			trumpSkill = 1201703,
			isFuzzy = false,
			inspire = 0,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 120017,
			magicDef = 0,
			specialSkill = 1201710,
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
