-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100004.lua

module("logic.config.leveleditor.t_level_config_100004", package.seeall)

local configData = {
	battleMusicName = "music_battle_shenhua_buxiu_block",
	remarks = "",
	levelId = "100004",
	plotEventGroup = 100004,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "序章-4",
	lossConditionDesc = "",
	sceneId = "109001",
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
			x = 9,
			y = 7
		}
	},
	additionalTerrainList = {},
	winConditionGroupList = {
		{
			tag = "102",
			isBackup = false,
			hasTag = false,
			winConditionList = {
				{
					round = 3,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "击败未知原体",
					condition = 2,
					monsterIds = {
						10000401
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
			symbolStr = "",
			refreshType = 1,
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "不朽",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 10000401,
					x = 13,
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
			round = 1,
			hasSymbol = false,
			groupName = "开场刷新",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 10000403,
					x = 13,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 10000403,
					x = 13,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 4,
			form = 2,
			plotStr = "101",
			round = 1,
			hasSymbol = false,
			groupName = "第一回合行动结束时刷新",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 10000403,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 10000404,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 10000403,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 10000403,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 10000404,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 10000404,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 10000403,
					x = 13,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 10000403,
					x = 13,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 4,
			form = 2,
			plotStr = "102",
			round = 1,
			hasSymbol = false,
			groupName = "第二回合行动结束时刷新",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 10000404,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 10000404,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 10000403,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 10000403,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 10000403,
					x = 11,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 10000403,
					x = 13,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 10000403,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 10000404,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 10000404,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 10000403,
					x = 13,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 10000403,
					x = 13,
					initialStatus = {
						hpPercent = 1,
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
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000402,
			pos = {
				x = 9,
				y = 7
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[10000401] = {
			normalSkill = 1202601,
			name = "未知原体",
			pre_magicAtk = 165,
			maxHp = 12961,
			aiName = "ai-不朽-打爱丽丝",
			battleCamp = 1,
			career = 4,
			magicAtk = 165,
			pre_meleeDef = 34,
			sanity = 0,
			remark = "不朽",
			giftSkill = 1202625,
			weakPointHpRate = 0.18,
			meleeDef = 34,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 49.5,
			pre_meleeAtk = 49.5,
			pre_maxHp = 3240,
			colorType = 3,
			monsterType = 2,
			id = 10000401,
			mobility = 0,
			pre_magicDef = 61,
			aiStepOrder = 0,
			trumpSkill = 1202624,
			isFuzzy = false,
			inspire = 55,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120026,
			magicDef = 61,
			specialSkill = 1202622,
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
		[10000402] = {
			normalSkill = 1100231,
			name = "？？？",
			pre_magicAtk = 36,
			maxHp = 2536,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 316,
			pre_meleeDef = 70,
			sanity = 0,
			remark = "爱丽丝",
			giftSkill = 1100234,
			weakPointHpRate = 0,
			meleeDef = 49,
			level = 10,
			monsterGroup = "A角色模板",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 40,
			pre_meleeAtk = 186,
			pre_maxHp = 456,
			colorType = 3,
			monsterType = 0,
			id = 10000402,
			mobility = 2,
			pre_magicDef = 40,
			aiStepOrder = 0,
			trumpSkill = 1100233,
			isFuzzy = false,
			inspire = 45,
			camp = 6,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 7,
			pre_inspire = 50,
			modelId = 100002,
			magicDef = 80,
			specialSkill = 0,
			extraSkills = {
				1100235
			},
			attributeGrade = {
				"S",
				"C",
				"A",
				"S",
				"A",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[10000403] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 126.9,
			maxHp = 192.6,
			aiName = "",
			battleCamp = 1,
			career = 4,
			magicAtk = 126.9,
			pre_meleeDef = 28.8,
			sanity = 0,
			remark = "红特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 28.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = true,
			hasGodlike = false,
			meleeAtk = 12.7,
			pre_meleeAtk = 12.7,
			pre_maxHp = 192.6,
			colorType = 1,
			monsterType = 0,
			id = 10000403,
			mobility = 2,
			pre_magicDef = 51.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 120029,
			magicDef = 51.2,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[10000404] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 11.7,
			maxHp = 229.2,
			aiName = "",
			battleCamp = 1,
			career = 3,
			magicAtk = 11.7,
			pre_meleeDef = 51.2,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 51.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = true,
			hasGodlike = false,
			meleeAtk = 116.6,
			pre_meleeAtk = 116.6,
			pre_maxHp = 229.2,
			colorType = 3,
			monsterType = 0,
			id = 10000404,
			mobility = 2,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 120030,
			magicDef = 28.8,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
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
		[10000405] = {
			normalSkill = 1208201,
			name = "拟态/蚺",
			pre_magicAtk = 126.9,
			maxHp = 192.6,
			aiName = "",
			battleCamp = 1,
			career = 4,
			magicAtk = 126.9,
			pre_meleeDef = 28.8,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1208202,
			weakPointHpRate = 0,
			meleeDef = 28.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = true,
			hasGodlike = false,
			meleeAtk = 12.7,
			pre_meleeAtk = 12.7,
			pre_maxHp = 192.6,
			colorType = 2,
			monsterType = 0,
			id = 10000405,
			mobility = 2,
			pre_magicDef = 51.2,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 120082,
			magicDef = 51.2,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A",
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
