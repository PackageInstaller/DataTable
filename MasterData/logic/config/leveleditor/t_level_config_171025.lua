-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171025.lua

module("logic.config.leveleditor.t_level_config_171025", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "171025",
	plotEventGroup = 300501,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "见不得光的雕像05",
	lossConditionDesc = "",
	sceneId = "115003",
	winConditionDesc = "利用探照灯创造出的地形环境\n阻止雕像激活邪恶仪式，并击败它\n利用[禁足]限制雕像移动事半功倍",
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
			x = 8,
			y = 6
		},
		{
			direction = 1,
			x = 6,
			y = 6
		}
	},
	additionalTerrainList = {
		{
			terrainId = 9924,
			times = 0,
			posList = {
				{
					x = 2,
					y = 8
				},
				{
					x = 7,
					y = 1
				},
				{
					x = 11,
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
					condition = 3,
					monsterIds = {
						17102501
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
			DIYName = "",
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
			groupName = "雕像",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 17102501,
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
			refreshType = 2,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "路灯小怪",
			color = 3,
			enemyCountY = 8,
			enemyCountX = 8,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 17102502,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 17102502,
					x = 9,
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
					monsterId = 17102502,
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
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "第二回合",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 17102502,
					x = 1,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 17102502,
					x = 0,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 17102502,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 1,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "回合3",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 17102502,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 17102502,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 1,
			plotStr = "",
			round = 4,
			hasSymbol = false,
			groupName = "回合4",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 17102502,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 17102502,
					x = 12,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 1,
			plotStr = "",
			round = 6,
			hasSymbol = false,
			groupName = "回合6",
			color = 7,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 17102502,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 17102502,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 1,
					tag = "",
					monsterId = 17102502,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 1,
			plotStr = "",
			round = 5,
			hasSymbol = false,
			groupName = "回合5",
			color = 6,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 17102502,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 17102502,
					x = 7,
					initialStatus = {
						hpPercent = 100,
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
			monsterId = 17102504,
			pos = {
				x = 6,
				y = 6
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 17102503,
			pos = {
				x = 8,
				y = 6
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[17102501] = {
			normalSkill = 1217121,
			name = "见不得光的雕像",
			pre_magicAtk = 27.3,
			maxHp = 9472,
			aiName = "ai-管制行动-雕像04",
			battleCamp = 1,
			career = 3,
			magicAtk = 27.3,
			pre_meleeDef = 107,
			sanity = 0,
			remark = "",
			giftSkill = 1217124,
			weakPointHpRate = 0,
			meleeDef = 107,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 272.8,
			pre_meleeAtk = 272.8,
			pre_maxHp = 9472,
			colorType = 3,
			monsterType = 0,
			id = 17102501,
			mobility = 5,
			pre_magicDef = 54,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 57,
			modelId = 120092,
			magicDef = 54,
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
		[17102502] = {
			normalSkill = 0,
			name = "巡逻街灯",
			pre_magicAtk = 171,
			maxHp = 1,
			aiName = "ai-管制行动-雕像小怪",
			battleCamp = 1,
			career = 6,
			magicAtk = 171,
			pre_meleeDef = 54.9,
			sanity = 0,
			remark = "",
			giftSkill = 1217126,
			weakPointHpRate = 0,
			meleeDef = 54.9,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 17.1,
			pre_meleeAtk = 17.1,
			pre_maxHp = 1,
			colorType = 4,
			monsterType = 0,
			id = 17102502,
			mobility = 2,
			pre_magicDef = 106.2,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 32,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 32,
			modelId = 120103,
			magicDef = 106.2,
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
		[17102503] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 46,
			maxHp = 1696,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 46,
			pre_meleeDef = 97,
			sanity = 0,
			remark = "一云",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 97,
			level = 15,
			monsterGroup = "角色模板",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 362,
			pre_meleeAtk = 202,
			pre_maxHp = 696,
			colorType = 1,
			monsterType = 0,
			id = 17102503,
			mobility = 4,
			pre_magicDef = 42,
			aiStepOrder = 0,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 43,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 5,
			pre_inspire = 43,
			modelId = 100011,
			magicDef = 42,
			specialSkill = 1101102,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[17102504] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 39,
			maxHp = 1543,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 352,
			pre_meleeDef = 87,
			sanity = 0,
			remark = "安妮薇",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 87,
			level = 15,
			monsterGroup = "角色模板",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 39,
			pre_meleeAtk = 222,
			pre_maxHp = 543,
			colorType = 1,
			monsterType = 0,
			id = 17102504,
			mobility = 2,
			pre_magicDef = 43,
			aiStepOrder = 0,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 53,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 5,
			pre_inspire = 53,
			modelId = 100013,
			magicDef = 43,
			specialSkill = 1101302,
			extraSkills = {},
			attributeGrade = {
				"S",
				"B",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
