-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171006.lua

module("logic.config.leveleditor.t_level_config_171006", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "新手引导用",
	levelId = "171006",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 20,
	levelName = "厄运预告6",
	lossConditionDesc = "",
	sceneId = "117004",
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
			x = 7,
			y = 5
		},
		{
			direction = 1,
			x = 5,
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
					monsterTag = "110",
					DIYName = "击杀厄运预告召唤的BOSS",
					condition = 12,
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
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 17100601,
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
			x = 6,
			y = 12
		}
	},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 17100602,
			pos = {
				x = 5,
				y = 4
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
			monsterId = 17100603,
			pos = {
				x = 7,
				y = 5
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[17100601] = {
			normalSkill = 0,
			name = "厄运预告",
			pre_magicAtk = 500,
			maxHp = 9999,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 500,
			pre_meleeDef = 9999,
			sanity = 0,
			remark = "",
			giftSkill = 1217112,
			weakPointHpRate = 0,
			meleeDef = 9999,
			level = 99,
			monsterGroup = "",
			hasGodlike = false,
			meleeAtk = 500,
			pre_meleeAtk = 500,
			pre_maxHp = 9999,
			colorType = 4,
			monsterType = 0,
			id = 17100601,
			mobility = 0,
			pre_magicDef = 9999,
			aiStepOrder = 3,
			trumpSkill = 1217103,
			isFuzzy = false,
			inspire = 100,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 0,
			pre_inspire = 100,
			modelId = 120091,
			magicDef = 9999,
			specialSkill = 1217111,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"C",
				"C",
				"C"
			}
		},
		[17100602] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 46,
			maxHp = 696,
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
			hasGodlike = false,
			meleeAtk = 502,
			pre_meleeAtk = 202,
			pre_maxHp = 696,
			colorType = 1,
			monsterType = 0,
			id = 17100602,
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
				"C"
			}
		},
		[17100603] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 39,
			maxHp = 543,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 522,
			pre_meleeDef = 87,
			sanity = 0,
			remark = "安妮薇",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 87,
			level = 15,
			monsterGroup = "角色模板",
			hasGodlike = false,
			meleeAtk = 39,
			pre_meleeAtk = 222,
			pre_maxHp = 543,
			colorType = 1,
			monsterType = 0,
			id = 17100603,
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
				"C"
			}
		}
	}
}

return configData
