-- chunkname: @modules/logic/tower/model/TowerTimeLimitLevelModel.lua

module("modules.logic.tower.model.TowerTimeLimitLevelModel", package.seeall)

local TowerTimeLimitLevelModel = class("TowerTimeLimitLevelModel", BaseModel)

function TowerTimeLimitLevelModel:onInit()
	self:reInit()

	self.entranceDifficultyMap = {}
end

function TowerTimeLimitLevelModel:reInit()
	self.curSelectEntrance = 0
end

function TowerTimeLimitLevelModel:cleanData()
	self:reInit()
end

function TowerTimeLimitLevelModel:initDifficultyMulti()
	self.difficultyMultiMap = {}

	local difficultyMultiTab = {
		TowerEnum.ConstId.TimeLimitEasyMulti,
		TowerEnum.ConstId.TimeLimitNormalMulti,
		TowerEnum.ConstId.TimeLimitHardMulti
	}

	for index, difficultyMulti in ipairs(difficultyMultiTab) do
		self.difficultyMultiMap[index] = TowerConfig.instance:getTowerConstConfig(difficultyMulti)
	end
end

function TowerTimeLimitLevelModel:getDifficultyMulti(difficultyId)
	return self.difficultyMultiMap[difficultyId]
end

function TowerTimeLimitLevelModel:setCurSelectEntrance(entranceId)
	self.curSelectEntrance = entranceId
end

function TowerTimeLimitLevelModel:getCurOpenTimeLimitTower()
	local towerOpenList = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Limited) or {}

	for _, openInfoMo in pairs(towerOpenList) do
		if openInfoMo.status == TowerEnum.TowerStatus.Open then
			return openInfoMo
		end
	end
end

function TowerTimeLimitLevelModel:getEntranceBossUsedMap(seasonId)
	local entranceBossUseMap = {}
	local towerInfoMo = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, seasonId)

	for entranceId = 1, 3 do
		local towerCoList = TowerConfig.instance:getTowerLimitedTimeCoList(seasonId, entranceId)
		local layerId = towerCoList[1].layerId
		local subEpisodeMoList = towerInfoMo:getLayerSubEpisodeList(layerId)

		if subEpisodeMoList then
			if not subEpisodeMoList[1].assistBossId then
				entranceBossUseMap[entranceId] = 0
			end
		end
	end

	return entranceBossUseMap
end

function TowerTimeLimitLevelModel:localSaveKey()
	return TowerEnum.LocalPrefsKey.LastEntranceDifficulty
end

function TowerTimeLimitLevelModel:initEntranceDifficulty(towerOpenInfo)
	for entranceId = 1, 3 do
		self.entranceDifficultyMap[entranceId] = self:getLastEntranceDifficulty(entranceId, towerOpenInfo)
	end
end

function TowerTimeLimitLevelModel:getEntranceDifficulty(entranceId)
	return self.entranceDifficultyMap[entranceId]
end

function TowerTimeLimitLevelModel:setEntranceDifficulty(entranceId, difficulty)
	self.entranceDifficultyMap[entranceId] = difficulty
end

function TowerTimeLimitLevelModel:getLastEntranceDifficulty(entranceId, towerOpenInfo)
	return TowerModel.instance:getLocalPrefsState(self:localSaveKey(), entranceId, towerOpenInfo, TowerEnum.Difficulty.Easy)
end

function TowerTimeLimitLevelModel:saveLastEntranceDifficulty(towerOpenInfo)
	for entranceId = 1, 3 do
		local difficultyId = self.entranceDifficultyMap[entranceId]

		TowerModel.instance:setLocalPrefsState(self:localSaveKey(), entranceId, towerOpenInfo, difficultyId)
	end
end

function TowerTimeLimitLevelModel:getHistoryHighScore()
	local curOpenMo = self:getCurOpenTimeLimitTower()

	if not curOpenMo then
		return 0
	end

	if curOpenMo then
		if not curOpenMo.towerId then
			local seasonId = 1
			local towerMo = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, seasonId)

			return towerMo:getHistoryHighScore()
		end
	end
end

TowerTimeLimitLevelModel.instance = TowerTimeLimitLevelModel.New()

return TowerTimeLimitLevelModel
