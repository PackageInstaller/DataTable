-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130706.lua

module("logic.config.leveleditor.t_level_config_130706", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130706",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "陨灭材料本-6",
	lossConditionDesc = "",
	sceneId = "130709",
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
			direction = 4,
			x = 5,
			y = 5
		},
		{
			direction = 2,
			x = 8,
			y = 8
		}
	},
	additionalTerrainList = {
		{
			terrainId = 4004,
			times = 0,
			posList = {
				{
					x = 6,
					y = 7
				},
				{
					x = 7,
					y = 7
				},
				{
					x = 6,
					y = 6
				},
				{
					x = 7,
					y = 6
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
					DIYName = "拦截不超过5个密室原体入侵",
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
			count = 5,
			hasTag = false,
			DIYName = "5个密室原体成功入侵",
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
			groupName = "初始-中下",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 13070603,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 13070603,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "初始-中上",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 13070604,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 13070604,
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
			form = 6,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "初始-右上",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13070604,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13070604,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13070604,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 13070604,
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
			form = 6,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "初始-左下",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 13070603,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 13070603,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 13070603,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 13070603,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "第3回合-左下",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 13070603,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 13070603,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 13070603,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 13070603,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "第3回合-右上",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13070604,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13070604,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 13070604,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 13070604,
					x = 13,
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
		[13070601] = {
			normalSkill = 0,
			name = "彩绘积木",
			pre_magicAtk = 40.3,
			maxHp = 1631.8,
			aiName = "ai-陨灭本-小怪2",
			battleCamp = 1,
			career = 3,
			magicAtk = 40.3,
			pre_meleeDef = 206.1,
			sanity = 0,
			remark = "",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 80.1,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 403.1,
			pre_meleeAtk = 403.1,
			pre_maxHp = 3474.9,
			colorType = 3,
			monsterType = 0,
			id = 13070601,
			mobility = 2,
			pre_magicDef = 122.4,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120070,
			magicDef = 138.6,
			specialSkill = 0,
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
		[13070602] = {
			normalSkill = 0,
			name = "彩绘积木",
			pre_magicAtk = 40.3,
			maxHp = 1631.8,
			aiName = "ai-陨灭本-小怪3",
			battleCamp = 1,
			career = 3,
			magicAtk = 40.3,
			pre_meleeDef = 206.1,
			sanity = 0,
			remark = "",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 80.1,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 403.1,
			pre_meleeAtk = 403.1,
			pre_maxHp = 3474.9,
			colorType = 3,
			monsterType = 0,
			id = 13070602,
			mobility = 2,
			pre_magicDef = 122.4,
			aiStepOrder = 20,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120070,
			magicDef = 138.6,
			specialSkill = 0,
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
		[13070603] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 38.8,
			maxHp = 1700,
			aiName = "ai-陨灭本-小怪2",
			battleCamp = 1,
			career = 1,
			magicAtk = 38.8,
			pre_meleeDef = 226.8,
			sanity = 0,
			remark = "",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 28.8,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 388,
			pre_meleeAtk = 388,
			pre_maxHp = 3979.8,
			colorType = 1,
			monsterType = 0,
			id = 13070603,
			mobility = 4,
			pre_magicDef = 120.6,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 23,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120097,
			magicDef = 28.8,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"C",
				"C",
				"B"
			},
			tags = {}
		},
		[13070604] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 38.8,
			maxHp = 1700,
			aiName = "ai-陨灭本-小怪3",
			battleCamp = 1,
			career = 1,
			magicAtk = 38.8,
			pre_meleeDef = 226.8,
			sanity = 0,
			remark = "",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 28.8,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 388,
			pre_meleeAtk = 388,
			pre_maxHp = 3979.8,
			colorType = 1,
			monsterType = 0,
			id = 13070604,
			mobility = 4,
			pre_magicDef = 120.6,
			aiStepOrder = 20,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 23,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120097,
			magicDef = 28.8,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"C",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
