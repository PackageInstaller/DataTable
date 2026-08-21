-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110337.lua

module("logic.config.leveleditor.t_level_config_110337", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "困难3-7",
	levelId = "110337",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难3-7",
	lossConditionDesc = "",
	sceneId = "116002",
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
			x = 7,
			y = 0
		},
		{
			direction = 4,
			x = 7,
			y = 1
		},
		{
			direction = 4,
			x = 7,
			y = 2
		},
		{
			direction = 2,
			x = 9,
			y = 2
		},
		{
			direction = 2,
			x = 9,
			y = 1
		},
		{
			direction = 2,
			x = 9,
			y = 0
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组1",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 1,
					tag = "",
					monsterId = 11033701,
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
			refreshType = 2,
			form = 5,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "伏兵",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 11033703,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 11033703,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11033702,
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
			groupName = "花剑雨伞",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 11033703,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 11033703,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 0,
					tag = "",
					monsterId = 11033703,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 11033703,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 11033703,
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
			groupName = "怪物组4",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 3,
					tag = "",
					monsterId = 11033704,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 11033704,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 0,
					tag = "",
					monsterId = 11033704,
					x = 4,
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
		[11033701] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 601.7,
			maxHp = 12472.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 601.7,
			pre_meleeDef = 145.6,
			sanity = 0,
			remark = "绿特异精英（主动攻击触发超感,超感强化）",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 145.6,
			level = 44,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 60.1,
			pre_meleeAtk = 60.1,
			pre_maxHp = 12472.3,
			colorType = 3,
			monsterType = 1,
			id = 11033701,
			mobility = 2,
			pre_magicDef = 254.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 69.6,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 69.6,
			modelId = 120068,
			magicDef = 254.6,
			specialSkill = 1206803,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[11033702] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 601.7,
			maxHp = 12472.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 601.7,
			pre_meleeDef = 145.6,
			sanity = 0,
			remark = "红特异精英（主动攻击触发超感,超感强化）",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 145.6,
			level = 44,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 60.1,
			pre_meleeAtk = 60.1,
			pre_maxHp = 12472.3,
			colorType = 1,
			monsterType = 1,
			id = 11033702,
			mobility = 2,
			pre_magicDef = 254.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 69.6,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 69.6,
			modelId = 120068,
			magicDef = 254.6,
			specialSkill = 1206803,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[11033703] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 42.5,
			maxHp = 4613.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 42.5,
			pre_meleeDef = 252,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 252,
			level = 44,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 424.5,
			pre_meleeAtk = 424.5,
			pre_maxHp = 4613.7,
			colorType = 1,
			monsterType = 0,
			id = 11033703,
			mobility = 4,
			pre_magicDef = 129.2,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56.6,
			modelId = 120089,
			magicDef = 129.2,
			specialSkill = 1208902,
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
		[11033704] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 44.1,
			maxHp = 4031.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 44.1,
			pre_meleeDef = 229.1,
			sanity = 0,
			remark = "狙击小怪（弧光,弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 229.1,
			level = 44,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 440.5,
			pre_meleeAtk = 440.5,
			pre_maxHp = 4031.8,
			colorType = 3,
			monsterType = 0,
			id = 11033704,
			mobility = 2,
			pre_magicDef = 131,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 66.6,
			modelId = 120030,
			magicDef = 131,
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
		}
	}
}

return configData
