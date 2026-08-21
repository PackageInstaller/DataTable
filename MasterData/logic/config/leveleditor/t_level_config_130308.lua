-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130308.lua

module("logic.config.leveleditor.t_level_config_130308", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130308",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "幻影材料本-8",
	lossConditionDesc = "",
	sceneId = "115002",
	winConditionDesc = "10回合内刺杀所有的仪式负责人",
	forbidAction = {
		auto = false,
		move = false,
		strengthenSkill = false,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 1,
			x = 6,
			y = 1
		},
		{
			direction = 1,
			x = 7,
			y = 2
		},
		{
			direction = 1,
			x = 8,
			y = 1
		},
		{
			direction = 1,
			x = 8,
			y = 3
		},
		{
			direction = 1,
			x = 6,
			y = 3
		}
	},
	additionalTerrainList = {
		{
			terrainId = 4001,
			times = 0,
			posList = {
				{
					x = 7,
					y = 13
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
						13030801,
						13030804
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
			symbolStr = "刺杀",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "胜利条件的刺杀怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 12,
					tag = "",
					monsterId = 13030801,
					x = 7,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "守卫道路的怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 13,
					tag = "",
					monsterId = 13030802,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 13030802,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 13,
					tag = "",
					monsterId = 13030802,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 11,
					tag = "",
					monsterId = 13030802,
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
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "第2个刺杀目标",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 13030804,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组4",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030803,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030803,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030803,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030803,
					x = 11,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 7,
			y = 12
		},
		{
			x = 6,
			y = 1
		}
	},
	lockHeroList = {},
	monsters = {
		[13030801] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 143.7,
			maxHp = 30230,
			aiName = "ai-幻影本-刺杀目标2",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 559,
			sanity = 0,
			remark = "",
			giftSkill = 1223102,
			weakPointHpRate = 0.3,
			meleeDef = 398,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 1437,
			pre_maxHp = 48167,
			colorType = 3,
			monsterType = 1,
			id = 13030801,
			mobility = 2,
			pre_magicDef = 398,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 83,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 83,
			modelId = 120030,
			magicDef = 559,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"C",
				"B"
			},
			tags = {}
		},
		[13030802] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 116.2,
			maxHp = 11239.3,
			aiName = "ai-幻影本-守卫小怪",
			battleCamp = 1,
			career = 2,
			magicAtk = 116.2,
			pre_meleeDef = 574.2,
			sanity = 0,
			remark = "守卫精英-高难度",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 574.2,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1161.8,
			pre_meleeAtk = 1161.8,
			pre_maxHp = 11239.3,
			colorType = 2,
			monsterType = 0,
			id = 13030802,
			mobility = 2,
			pre_magicDef = 356.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120014,
			magicDef = 356.4,
			specialSkill = 0,
			extraSkills = {
				1201404
			},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[13030803] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 116.2,
			maxHp = 11239.3,
			aiName = "ai-幻影本-守卫小怪2",
			battleCamp = 1,
			career = 2,
			magicAtk = 116.2,
			pre_meleeDef = 574.2,
			sanity = 0,
			remark = "守卫精英-高难度",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 574.2,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1161.8,
			pre_meleeAtk = 1161.8,
			pre_maxHp = 11239.3,
			colorType = 2,
			monsterType = 0,
			id = 13030803,
			mobility = 2,
			pre_magicDef = 356.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120014,
			magicDef = 356.4,
			specialSkill = 0,
			extraSkills = {
				1201404
			},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[13030804] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 143.7,
			maxHp = 30230,
			aiName = "ai-幻影本-刺杀目标3",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 559,
			sanity = 0,
			remark = "",
			giftSkill = 1223102,
			weakPointHpRate = 0.3,
			meleeDef = 398,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 1437,
			pre_maxHp = 48167,
			colorType = 3,
			monsterType = 1,
			id = 13030804,
			mobility = 2,
			pre_magicDef = 398,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 83,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 83,
			modelId = 120030,
			magicDef = 559,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"C",
				"B"
			},
			tags = {}
		}
	}
}

return configData
