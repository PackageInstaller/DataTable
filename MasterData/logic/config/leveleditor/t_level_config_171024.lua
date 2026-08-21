-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171024.lua

module("logic.config.leveleditor.t_level_config_171024", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "雕像教学",
	levelId = "171024",
	plotEventGroup = 300401,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 20,
	levelName = "见不得光的雕像04",
	lossConditionDesc = "",
	sceneId = "930002",
	winConditionDesc = "学习如何利用探照灯创造出的地形环境，阻止雕像激活邪恶仪式，并击败它",
	forbidAction = {
		auto = true,
		move = false,
		strengthenSkill = false,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 1,
			x = 1,
			y = 10
		},
		{
			direction = 1,
			x = 3,
			y = 10
		}
	},
	additionalTerrainList = {
		{
			terrainId = 9925,
			times = 0,
			posList = {
				{
					x = 10,
					y = 1
				}
			}
		},
		{
			terrainId = 9922,
			times = 0,
			posList = {
				{
					x = 2,
					y = 12
				}
			}
		},
		{
			terrainId = 9923,
			times = 0,
			posList = {
				{
					x = 10,
					y = 12
				}
			}
		},
		{
			terrainId = 1001,
			times = 1,
			posList = {
				{
					x = 1,
					y = 2
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
					condition = 11,
					monsterIds = {
						17102405
					}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 8,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "雕像移动到指定地形相邻格子",
			isBackup = false,
			tag = "",
			targetId = 0,
			monsterIds = {}
		},
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
			groupName = "雕像01",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 17102403,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "101",
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "路灯1",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 17102406,
					x = 1,
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
					monsterId = 17102407,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 4,
			form = 1,
			plotStr = "202",
			round = 3,
			hasSymbol = false,
			groupName = "路灯2",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 3,
					tag = "",
					monsterId = 17102406,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 3,
					tag = "",
					monsterId = 17102407,
					x = 11,
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
			plotStr = "201",
			round = 1,
			hasSymbol = false,
			groupName = "雕像02",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 17102404,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 4,
			form = 2,
			plotStr = "202",
			round = 1,
			hasSymbol = false,
			groupName = "雕像03",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 17102405,
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
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 17102401,
			pos = {
				x = 1,
				y = 10
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 17102402,
			pos = {
				x = 3,
				y = 10
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[17102401] = {
			normalSkill = 1102201,
			name = "飞鸟",
			pre_magicAtk = 141,
			maxHp = 1530,
			aiName = "",
			battleCamp = 2,
			career = 3,
			magicAtk = 141,
			pre_meleeDef = 138,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 138,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 282,
			pre_meleeAtk = 282,
			pre_maxHp = 1530,
			colorType = 3,
			monsterType = 0,
			id = 17102401,
			mobility = 2,
			pre_magicDef = 99,
			aiStepOrder = 3,
			trumpSkill = 1102203,
			isFuzzy = false,
			inspire = 34,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 34,
			modelId = 100022,
			magicDef = 99,
			specialSkill = 1102202,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[17102402] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 141,
			maxHp = 1780,
			aiName = "",
			battleCamp = 2,
			career = 1,
			magicAtk = 141,
			pre_meleeDef = 138,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 138,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 282,
			pre_meleeAtk = 282,
			pre_maxHp = 1780,
			colorType = 1,
			monsterType = 0,
			id = 17102402,
			mobility = 4,
			pre_magicDef = 99,
			aiStepOrder = 3,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 27,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 27,
			modelId = 100016,
			magicDef = 99,
			specialSkill = 1101602,
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
		[17102403] = {
			normalSkill = 1217121,
			name = "见不得光的雕像",
			pre_magicAtk = 20.2,
			maxHp = 150,
			aiName = "ai-管制行动-雕像教学01",
			battleCamp = 1,
			career = 3,
			magicAtk = 20.2,
			pre_meleeDef = 113.4,
			sanity = 0,
			remark = "",
			giftSkill = 1217124,
			weakPointHpRate = 0,
			meleeDef = 113.4,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 202.1,
			pre_meleeAtk = 202.1,
			pre_maxHp = 150,
			colorType = 3,
			monsterType = 0,
			id = 17102403,
			mobility = 5,
			pre_magicDef = 20,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120092,
			magicDef = 20,
			specialSkill = 1217122,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[17102404] = {
			normalSkill = 1217121,
			name = "见不得光的雕像",
			pre_magicAtk = 20.2,
			maxHp = 840.4,
			aiName = "ai-管制行动-雕像教学02",
			battleCamp = 1,
			career = 3,
			magicAtk = 20.2,
			pre_meleeDef = 113.4,
			sanity = 0,
			remark = "",
			giftSkill = 1217124,
			weakPointHpRate = 0,
			meleeDef = 113.4,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 202.1,
			pre_meleeAtk = 202.1,
			pre_maxHp = 840.4,
			colorType = 3,
			monsterType = 0,
			id = 17102404,
			mobility = 5,
			pre_magicDef = 99,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120092,
			magicDef = 99,
			specialSkill = 1217122,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[17102405] = {
			normalSkill = 1217121,
			name = "见不得光的雕像",
			pre_magicAtk = 20.2,
			maxHp = 840.4,
			aiName = "ai-管制行动-雕像教学03",
			battleCamp = 1,
			career = 3,
			magicAtk = 20.2,
			pre_meleeDef = 113.4,
			sanity = 0,
			remark = "",
			giftSkill = 1217124,
			weakPointHpRate = 0,
			meleeDef = 113.4,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 202.1,
			pre_meleeAtk = 202.1,
			pre_maxHp = 840.4,
			colorType = 3,
			monsterType = 0,
			id = 17102405,
			mobility = 5,
			pre_magicDef = 99,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120092,
			magicDef = 99,
			specialSkill = 1217122,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[17102406] = {
			normalSkill = 0,
			name = "巡逻街灯",
			pre_magicAtk = 79.8,
			maxHp = 1,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 79.8,
			pre_meleeDef = 27.9,
			sanity = 0,
			remark = "",
			giftSkill = 1217126,
			weakPointHpRate = 0,
			meleeDef = 27.9,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 8,
			pre_meleeAtk = 8,
			pre_maxHp = 1,
			colorType = 4,
			monsterType = 0,
			id = 17102406,
			mobility = 2,
			pre_magicDef = 48.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 27,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 27,
			modelId = 120103,
			magicDef = 48.6,
			specialSkill = 1217125,
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
		[17102407] = {
			normalSkill = 0,
			name = "巡逻街灯",
			pre_magicAtk = 79.8,
			maxHp = 1,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 79.8,
			pre_meleeDef = 27.9,
			sanity = 0,
			remark = "",
			giftSkill = 1217126,
			weakPointHpRate = 0,
			meleeDef = 27.9,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 8,
			pre_meleeAtk = 8,
			pre_maxHp = 1,
			colorType = 4,
			monsterType = 0,
			id = 17102407,
			mobility = 2,
			pre_magicDef = 48.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 27,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 27,
			modelId = 120103,
			magicDef = 48.6,
			specialSkill = 1217125,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		}
	}
}

return configData
