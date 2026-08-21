-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130301.lua

module("logic.config.leveleditor.t_level_config_130301", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130301",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "幻影材料本-1",
	lossConditionDesc = "",
	sceneId = "115001",
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
		}
	},
	additionalTerrainList = {
		{
			terrainId = 4001,
			times = 0,
			posList = {
				{
					x = 7,
					y = 9
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
					DIYName = "10回合内刺杀仪式负责人",
					condition = 3,
					monsterIds = {
						13030102
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
			hasSymbol = false,
			groupName = "胜利条件的刺杀怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 13030102,
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
					isInitialStatus = true,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030103,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030103,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 13030103,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030103,
					x = 11,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030103,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 13030103,
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
			y = 8
		},
		{
			x = 6,
			y = 1
		}
	},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 13030101,
			pos = {
				x = 6,
				y = 1
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[13030101] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 41.5,
			maxHp = 584,
			aiName = "auto_yiyun_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 42,
			pre_meleeDef = 84.1,
			sanity = 0,
			remark = "",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 78,
			level = 10,
			monsterGroup = "",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 170,
			pre_meleeAtk = 152.3,
			pre_maxHp = 546.9,
			colorType = 1,
			monsterType = 0,
			id = 13030101,
			mobility = 4,
			pre_magicDef = 34.8,
			aiStepOrder = 0,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 40,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 0,
			pre_inspire = 38.1,
			modelId = 100011,
			magicDef = 39,
			specialSkill = 1101102,
			extraSkills = {},
			attributeGrade = {
				"A",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[13030102] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 11,
			maxHp = 454,
			aiName = "ai-幻影本-刺杀目标1",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 53,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 30.6,
			level = 5,
			monsterGroup = "",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 110,
			pre_maxHp = 2650,
			colorType = 3,
			monsterType = 1,
			id = 13030102,
			mobility = 2,
			pre_magicDef = 30,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 7,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 0,
			pre_inspire = 50.5,
			modelId = 120047,
			magicDef = 54.9,
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
		[13030103] = {
			normalSkill = 1204601,
			name = "水滴执行者",
			pre_magicAtk = 8.4,
			maxHp = 150,
			aiName = "ai-幻影本-守卫小怪",
			battleCamp = 1,
			career = 2,
			magicAtk = 8.4,
			pre_meleeDef = 52,
			sanity = -1,
			remark = "",
			giftSkill = 1223201,
			weakPointHpRate = 0,
			meleeDef = 52,
			level = 5,
			monsterGroup = "",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 83.7,
			pre_meleeAtk = 83.7,
			pre_maxHp = 290.7,
			colorType = 2,
			monsterType = 0,
			id = 13030103,
			mobility = 2,
			pre_magicDef = 24,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22.5,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 0,
			pre_inspire = 22.5,
			modelId = 120046,
			magicDef = 24,
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
