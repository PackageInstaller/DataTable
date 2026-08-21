-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_999998.lua

module("logic.config.leveleditor.t_level_config_999998", package.seeall)

local configData = {
	battleMusicName = "music_battle_character_anna_block",
	remarks = "",
	levelId = "999998",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "空气工坊-1",
	lossConditionDesc = "",
	sceneId = "110002",
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
			direction = 3,
			x = 5,
			y = 9
		},
		{
			direction = 3,
			x = 7,
			y = 9
		},
		{
			direction = 3,
			x = 6,
			y = 10
		},
		{
			direction = 3,
			x = 8,
			y = 10
		},
		{
			direction = 2,
			x = 7,
			y = 10
		},
		{
			direction = 2,
			x = 7,
			y = 11
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
					round = 3,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "校正放映机",
					condition = 4,
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
			targetId = 11010707,
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
