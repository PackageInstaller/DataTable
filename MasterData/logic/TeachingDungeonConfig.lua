-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/config/TeachingDungeonConfig.lua

module("logic.extensions.teachingdungeon.config.TeachingDungeonConfig", package.seeall)

local TeachingDungeonConfig = class("TeachingDungeonConfig", BaseConfig)
local table_insert = table.insert

function TeachingDungeonConfig:onInit()
	TeachingDungeonConfig.super.onInit(self)

	self._cofigStageCfg = nil
	self._cofigSupportCfg = nil
	self._cofigTeamCfg = nil
	self._cofigCreepsCfg = nil
	self._stageId2PetIds = {}
	self._teamId2EnemyPetIds = {}
	self._petsCfgKV = nil
	self._enemyPetsCfgKV = nil
end

function TeachingDungeonConfig:getNames()
	return {
		"battle_college_stage",
		"battle_college_support",
		"battle_college_team",
		"battle_college_creeps",
		"battle_college_common"
	}
end

function TeachingDungeonConfig:handleConfig(name, content)
	if name == "battle_college_stage" then
		self._cofigStageCfg = content.dataList
		self._cofigStageLevelKeyCfg = {}

		for i, v in ipairs(self._cofigStageCfg) do
			self._cofigStageLevelKeyCfg[v.level] = self._cofigStageLevelKeyCfg[v.level] or {}

			table.insert(self._cofigStageLevelKeyCfg[v.level], v)
		end

		self.battle_college_stageCfg = content
	elseif name == "battle_college_support" then
		self._cofigSupportCfg = content
	elseif name == "battle_college_team" then
		self._cofigTeamCfg = content.dataList
	elseif name == "battle_college_creeps" then
		self._cofigCreepsCfg = content
	elseif name == "battle_college_common" then
		self._battle_college_commonCfg = content
	end
end

function TeachingDungeonConfig:getConfigByStageId(stageId)
	return self.battle_college_stageCfg[stageId]
end

function TeachingDungeonConfig:getConfigPetIds(stageId)
	stageId = stageId or TeachingDungeonModel.instance:getCurrStageId()

	local list = {}

	for _, v in pairs(self._cofigSupportCfg[stageId]) do
		table_insert(list, v.creepsId)
	end

	return list
end

function TeachingDungeonConfig:getEnemyConfigPetIds()
	local stageId = TeachingDungeonModel.instance:getCurrStageId()
	local teamId = self:stageId2TeamId(stageId)

	if not self._teamId2EnemyPetIds[teamId] then
		local list = {}

		for k, v in pairs(self._cofigCreepsCfg[teamId]) do
			table_insert(list, v.creepsId)
		end

		self._teamId2EnemyPetIds[teamId] = list
	end

	return self._teamId2EnemyPetIds[teamId]
end

function TeachingDungeonConfig:stageId2TeamId(stageId)
	return self._cofigStageCfg[stageId].teamId
end

function TeachingDungeonConfig:getPetCfg(creepsId)
	local stageId = TeachingDungeonModel.instance:getCurrStageId()

	return self._cofigSupportCfg[stageId][creepsId]
end

function TeachingDungeonConfig:getSupportCfgs()
	local stageId = TeachingDungeonModel.instance:getCurrStageId()

	return self._cofigSupportCfg[stageId]
end

function TeachingDungeonConfig:getEnemyPetCfg(creepsId)
	local stageId = TeachingDungeonModel.instance:getCurrStageId()
	local teamId = self:stageId2TeamId(stageId)

	return self._cofigCreepsCfg[teamId][creepsId]
end

function TeachingDungeonConfig:getMainTabDatas()
	return self._cofigStageCfg
end

function TeachingDungeonConfig:getRewardListByStageId(stageId)
	if not self._stageId2RewardList then
		self._stageId2RewardList = {}

		for k, v in pairs(self._cofigStageCfg) do
			self._stageId2RewardList[v.stageId] = self:prizeStr2Table(v.firstPassPrize)
		end
	end

	return self._stageId2RewardList[stageId]
end

function TeachingDungeonConfig:getPfRewardListByStageId(stageId)
	if not self._stageId2PfRewardList then
		self._stageId2PfRewardList = {}

		for k, v in pairs(self._cofigStageCfg) do
			self._stageId2PfRewardList[v.stageId] = self:prizeStr2Table(v.perfectPassPrize)
		end
	end

	return self._stageId2PfRewardList[stageId]
end

function TeachingDungeonConfig:prizeStr2Table(str)
	local list = {}

	if not string.nilorempty(str) then
		local array = string.split(str, "#")

		for k, v in pairs(array) do
			table_insert(list, v)
		end
	end

	return list
end

function TeachingDungeonConfig:getCreepCfg()
	local stageId = TeachingDungeonModel.instance:getCurrStageId()
	local teamId = self:stageId2TeamId(stageId)

	return self._cofigCreepsCfg[teamId]
end

function TeachingDungeonConfig:getMonsterCfg(stageId)
	stageId = stageId or TeachingDungeonModel.instance:getCurrStageId()

	local teamId = self:stageId2TeamId(stageId)

	return self._cofigTeamCfg[teamId]
end

function TeachingDungeonConfig:getStageDesc()
	local stageId = TeachingDungeonModel.instance:getCurrStageId()

	return self._cofigStageCfg[stageId].desc
end

function TeachingDungeonConfig:getStageUnLokId(stageId)
	return self._cofigStageCfg[stageId].unlockId
end

function TeachingDungeonConfig:getStageName(stageId)
	return self._cofigStageCfg[stageId].stageName
end

function TeachingDungeonConfig:getStageCfgByLevel(level)
	return self._cofigStageLevelKeyCfg[level] or {}
end

function TeachingDungeonConfig:getTitleDesc()
	return self._battle_college_commonCfg.GetTitleDesc.value
end

TeachingDungeonConfig.instance = TeachingDungeonConfig.New()

return TeachingDungeonConfig
