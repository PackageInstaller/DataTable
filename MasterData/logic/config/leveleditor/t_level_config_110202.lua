-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110202.lua

module("logic.config.leveleditor.t_level_config_110202", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110202",
	plotEventGroup = 110202,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通2-2",
	lossConditionDesc = "",
	sceneId = "110002",
	winConditionDesc = "消灭所有迷雾使徒且撤离的敌方人数不超过3人",
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
			y = 10
		},
		{
			direction = 2,
			x = 4,
			y = 9
		},
		{
			direction = 4,
			x = 10,
			y = 10
		},
		{
			direction = 4,
			x = 9,
			y = 9
		},
		{
			direction = 4,
			x = 10,
			y = 8
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1004,
			times = 0,
			posList = {
				{
					x = 6,
					y = 14
				},
				{
					x = 7,
					y = 14
				},
				{
					x = 8,
					y = 14
				},
				{
					x = 6,
					y = 13
				},
				{
					x = 7,
					y = 13
				},
				{
					x = 8,
					y = 13
				}
			}
		},
		{
			terrainId = 1022,
			times = 1,
			posList = {
				{
					x = 7,
					y = 7
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
			condition = 6,
			maxDeadCount = 0,
			count = 4,
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
			groupName = "第一组前方",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 11020202,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 11020202,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 10,
					tag = "",
					monsterId = 11020203,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 11020203,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "第二组中部高速",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11020201,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11020201,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "第三组中部低速",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11020202,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 11020202,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 11020202,
					x = 5,
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
			y = 13
		},
		{
			x = 7,
			y = 7
		}
	},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 2000016,
			direction = 4,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 10,
				y = 8
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[11020201] = {
			normalSkill = 1200601,
			name = "迷雾使徒",
			pre_magicAtk = 11,
			maxHp = 409.3,
			aiName = "ai_主线2_2",
			battleCamp = 1,
			career = 1,
			magicAtk = 11,
			pre_meleeDef = 63.3,
			sanity = 0,
			remark = "",
			giftSkill = 1200602,
			weakPointHpRate = 0,
			meleeDef = 63.3,
			level = 11,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 109.4,
			pre_meleeAtk = 109.4,
			pre_maxHp = 409.3,
			colorType = 1,
			monsterType = 0,
			id = 11020201,
			mobility = 4,
			pre_magicDef = 31.45,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 38.3,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.3,
			modelId = 120006,
			magicDef = 31.45,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[11020202] = {
			normalSkill = 1200701,
			name = "迷雾使徒",
			pre_magicAtk = 10.6,
			maxHp = 505.85,
			aiName = "ai_主线2_2",
			battleCamp = 1,
			career = 2,
			magicAtk = 10.6,
			pre_meleeDef = 68.4,
			sanity = 0,
			remark = "",
			giftSkill = 1200702,
			weakPointHpRate = 0,
			meleeDef = 68.4,
			level = 11,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 106.2,
			pre_meleeAtk = 106.2,
			pre_maxHp = 505.85,
			colorType = 2,
			monsterType = 0,
			id = 11020202,
			mobility = 2,
			pre_magicDef = 31.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 28.3,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 28.3,
			modelId = 120007,
			magicDef = 31.9,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			}
		},
		[11020203] = {
			normalSkill = 1200901,
			name = "迷雾使徒",
			pre_magicAtk = 118.4,
			maxHp = 306.75,
			aiName = "ai_主线2_2",
			battleCamp = 1,
			career = 6,
			magicAtk = 118.4,
			pre_meleeDef = 37,
			sanity = 0,
			remark = "",
			giftSkill = 1200903,
			weakPointHpRate = 0,
			meleeDef = 37,
			level = 11,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 11.9,
			pre_meleeAtk = 11.9,
			pre_maxHp = 306.75,
			colorType = 4,
			monsterType = 0,
			id = 11020203,
			mobility = 2,
			pre_magicDef = 63.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 28.3,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 28.3,
			modelId = 120009,
			magicDef = 63.3,
			specialSkill = 1200902,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			}
		}
	}
}

return configData
