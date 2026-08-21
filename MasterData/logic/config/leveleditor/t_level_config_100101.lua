-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100101.lua

module("logic.config.leveleditor.t_level_config_100101", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "空气工坊01",
	levelId = "100101",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "休闲广场",
	lossConditionDesc = "",
	sceneId = "111004",
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
			x = 1,
			y = 0
		},
		{
			direction = 1,
			x = 1,
			y = 1
		},
		{
			direction = 1,
			x = 0,
			y = 1
		},
		{
			direction = 1,
			x = 0,
			y = 0
		},
		{
			direction = 1,
			x = 2,
			y = 1
		},
		{
			direction = 1,
			x = 2,
			y = 0
		},
		{
			direction = 1,
			x = 0,
			y = 2
		},
		{
			direction = 1,
			x = 1,
			y = 2
		},
		{
			direction = 1,
			x = 2,
			y = 2
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
	monsterGroupList = {},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {}
}

return configData
