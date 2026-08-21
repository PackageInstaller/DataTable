-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130701.lua

module("logic.config.leveleditor.t_level_config_130701", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130701",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "陨灭材料本-1",
	lossConditionDesc = "",
	sceneId = "130703",
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
			x = 8,
			y = 4
		},
		{
			direction = 2,
			x = 2,
			y = 6
		}
	},
	additionalTerrainList = {
		{
			terrainId = 4004,
			times = 0,
			posList = {
				{
					x = 4,
					y = 12
				},
				{
					x = 5,
					y = 12
				},
				{
					x = 6,
					y = 12
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
					DIYName = "拦截不超过10个密室原体入侵",
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
			count = 10,
			hasTag = false,
			DIYName = "10个密室原体成功入侵",
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
			groupName = "第1波",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 13070102,
					x = 4,
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
					monsterId = 13070103,
					x = 5,
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
					monsterId = 13070104,
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
			groupName = "第2波",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 13070102,
					x = 4,
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
					monsterId = 13070103,
					x = 5,
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
					monsterId = 13070104,
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
			round = 3,
			hasSymbol = false,
			groupName = "第3波",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 13070102,
					x = 4,
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
					monsterId = 13070104,
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
					monsterId = 13070102,
					x = 4,
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
					monsterId = 13070104,
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
			round = 4,
			hasSymbol = false,
			groupName = "第4波",
			color = 6,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 13070102,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 13070104,
					x = 6,
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
					monsterId = 13070102,
					x = 4,
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
					monsterId = 13070104,
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
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 4,
			heroType = 2,
			monsterId = 13070101,
			pos = {
				x = 8,
				y = 4
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[13070101] = {
			normalSkill = 1103601,
			name = "多萝西",
			pre_magicAtk = 150.9,
			maxHp = 372.7,
			aiName = "auto_duoluoxi_ai",
			battleCamp = 2,
			career = 5,
			magicAtk = 150.9,
			pre_meleeDef = 55.2,
			sanity = 0,
			remark = "",
			giftSkill = 1103604,
			weakPointHpRate = 0,
			meleeDef = 55.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 42.7,
			pre_meleeAtk = 42.7,
			pre_maxHp = 372.7,
			colorType = 4,
			monsterType = 0,
			id = 13070101,
			mobility = 1,
			pre_magicDef = 78.7,
			aiStepOrder = 2,
			trumpSkill = 1103603,
			isFuzzy = false,
			inspire = 41.1,
			camp = 4,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 41.1,
			modelId = 100036,
			magicDef = 78.7,
			specialSkill = 1103602,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[13070102] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 134,
			maxHp = 80,
			aiName = "ai-陨灭本-1.1",
			battleCamp = 1,
			career = 1,
			magicAtk = 53,
			pre_meleeDef = 21,
			sanity = 0,
			remark = "",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 21,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 134,
			pre_meleeAtk = 53,
			pre_maxHp = 80,
			colorType = 1,
			monsterType = 0,
			id = 13070102,
			mobility = 4,
			pre_magicDef = 41.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 23,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 23,
			modelId = 120097,
			magicDef = 21,
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
		},
		[13070103] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 134,
			maxHp = 80,
			aiName = "ai-陨灭本-1.2",
			battleCamp = 1,
			career = 1,
			magicAtk = 53,
			pre_meleeDef = 21,
			sanity = 0,
			remark = "",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 21,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 134,
			pre_meleeAtk = 53,
			pre_maxHp = 80,
			colorType = 1,
			monsterType = 0,
			id = 13070103,
			mobility = 4,
			pre_magicDef = 41.2,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 23,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 23,
			modelId = 120097,
			magicDef = 21,
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
		},
		[13070104] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 134,
			maxHp = 80,
			aiName = "ai-陨灭本-1.3",
			battleCamp = 1,
			career = 1,
			magicAtk = 53,
			pre_meleeDef = 21,
			sanity = 0,
			remark = "",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 21,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 134,
			pre_meleeAtk = 53,
			pre_maxHp = 80,
			colorType = 1,
			monsterType = 0,
			id = 13070104,
			mobility = 4,
			pre_magicDef = 41.2,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 23,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 23,
			modelId = 120097,
			magicDef = 21,
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
