-- chunkname: @modules/logic/tower/model/TowerMo.lua

module("modules.logic.tower.model.TowerMo", package.seeall)

local TowerMo = pureTable("TowerMo")

function TowerMo:init(id)
	self.id = id
end

function TowerMo:updateInfo(info)
	self.type = info.type
	self.towerId = info.towerId
	self.passLayerId = info.passLayerId

	self:updateLayerInfos(info.layerNOs)
	self:updateLayerScore(info.layerNOs)
	self:updateHistoryHighScore(info.historyHighScore)
	self:updateOpenSpLayer(info.openSpLayerIds)
	self:updatePassBossTeachIds(info.passTeachIds)
end

function TowerMo:updatePassBossTeachIds(passTeachIds)
	self.passBossTeachDict = {}

	if passTeachIds then
		for i = 1, #passTeachIds do
			self.passBossTeachDict[passTeachIds[i]] = 1
		end
	end
end

function TowerMo:isPassBossTeach(teachId)
	return self.passBossTeachDict[teachId] == 1
end

function TowerMo:updateOpenSpLayer(ids)
	self.openSpLayerDict = {}

	if ids then
		for i = 1, #ids do
			self.openSpLayerDict[ids[i]] = 1
		end
	end
end

function TowerMo:isSpLayerOpen(layer)
	return self.openSpLayerDict[layer] ~= nil
end

function TowerMo:hasNewSpLayer(towerOpenInfo)
	local hasNew = false

	for k, v in pairs(self.openSpLayerDict) do
		local newState = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossSpOpen, self.towerId, towerOpenInfo, TowerEnum.LockKey)

		if newState == TowerEnum.LockKey then
			hasNew = true

			break
		end
	end

	return hasNew
end

function TowerMo:clearSpLayerNewTag(towerOpenInfo)
	local hasNew = false

	for k, v in pairs(self.openSpLayerDict) do
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossSpOpen, self.towerId, towerOpenInfo, TowerEnum.UnlockKey)
	end

	return hasNew
end

function TowerMo:isLayerUnlock(layer, episodeMo)
	if episodeMo == nil then
		episodeMo = TowerModel.instance:getEpisodeMoByTowerType(self.type)
	end

	if not episodeMo then
		return false
	end

	local episodeConfig = episodeMo:getEpisodeConfig(self.towerId, layer)

	if not episodeConfig then
		return false
	end

	return self:isLayerPass(episodeConfig.preLayerId, episodeMo)
end

function TowerMo:isLayerPass(layer, episodeMo)
	if episodeMo == nil then
		episodeMo = TowerModel.instance:getEpisodeMoByTowerType(self.type)
	end

	if not episodeMo then
		return false
	end

	local layerIndex = episodeMo:getEpisodeIndex(self.towerId, layer, true)
	local curIndex = episodeMo:getEpisodeIndex(self.towerId, self.passLayerId, true)

	return layerIndex <= curIndex
end

function TowerMo:updateLayerInfos(layerSubEpisodes)
	self.layerSubEpisodeMap = self.layerSubEpisodeMap or {}

	if layerSubEpisodes then
		for index, subEpisodeInfo in ipairs(layerSubEpisodes) do
			local subEpisodeList = {}

			for i = 1, #subEpisodeInfo.episodeNOs do
				local subEpisodeMo = TowerSubEpisodeMo.New()

				subEpisodeMo:updateInfo(subEpisodeInfo.episodeNOs[i])
				table.insert(subEpisodeList, subEpisodeMo)
			end

			self.layerSubEpisodeMap[subEpisodeInfo.layerId] = subEpisodeList
		end
	end
end

function TowerMo:resetLayerInfos(subEpisodeInfo)
	local subEpisodeList = {}

	for i = 1, #subEpisodeInfo.episodeNOs do
		local subEpisodeMo = TowerSubEpisodeMo.New()

		subEpisodeMo:updateInfo(subEpisodeInfo.episodeNOs[i])
		table.insert(subEpisodeList, subEpisodeMo)
	end

	self.layerSubEpisodeMap[subEpisodeInfo.layerId] = subEpisodeList
end

function TowerMo:resetLayerScore(layerInfo)
	if layerInfo then
		self.layerScoreMap[layerInfo.layerId] = layerInfo.currHighScore
	end
end

function TowerMo:updateHistoryHighScore(score)
	self.historyHighScore = score
end

function TowerMo:getHistoryHighScore()
	return self.historyHighScore or 0
end

function TowerMo:updateLayerScore(layerNOs)
	self.layerScoreMap = {}

	if layerNOs then
		for index, layerInfo in ipairs(layerNOs) do
			self.layerScoreMap[layerInfo.layerId] = layerInfo.currHighScore
		end
	end
end

function TowerMo:getLayerScore(layerId)
	return self.layerScoreMap[layerId] or 0
end

function TowerMo:getLayerSubEpisodeList(layerId, ignoreTip)
	if not self.layerSubEpisodeMap[layerId] and not ignoreTip then
		logError("该层没有子关卡信息：" .. layerId)
	end

	return self.layerSubEpisodeMap[layerId]
end

function TowerMo:getSubEpisodeMoByEpisodeId(episodeId)
	self.layerSubEpisodeMap = self.layerSubEpisodeMap or {}

	for layerId, subEpisodeList in pairs(self.layerSubEpisodeMap) do
		for index, subEpisodeMo in ipairs(subEpisodeList) do
			if subEpisodeMo.episodeId == episodeId then
				return subEpisodeMo, layerId
			end
		end
	end
end

function TowerMo:getSubEpisodePassCount(layerId)
	local passCount = 0
	local subEpisodeList = self:getLayerSubEpisodeList(layerId, true) or {}

	for index, subEpisodeMo in ipairs(subEpisodeList) do
		if subEpisodeMo.status == TowerEnum.PassEpisodeState.Pass then
			passCount = passCount + 1
		end
	end

	return passCount
end

function TowerMo:getTaskGroupId()
	local openInfo = TowerModel.instance:getTowerOpenInfo(self.type, self.towerId)

	if openInfo == nil then
		return
	end

	local timeConfig = TowerConfig.instance:getBossTimeTowerConfig(self.towerId, openInfo.round)

	return timeConfig and timeConfig.taskGroupId
end

function TowerMo:getBanHeroAndBoss(layerId, difficulty, episodeId)
	if self.type == TowerEnum.TowerType.Boss then
		return
	end

	local heros = {}
	local assistBosss = {}
	local trialHeros = {}
	local subEpisodes = self:getLayerSubEpisodeList(layerId, true)

	if not subEpisodes then
		return heros, assistBosss, trialHeros
	end

	if self.type == TowerEnum.TowerType.Normal then
		local co = TowerConfig.instance:getPermanentEpisodeCo(layerId)

		if co and co.isElite == 1 then
			for k, v in pairs(subEpisodes) do
				v:getHeros(heros)
				v:getAssistBossId(assistBosss)
				v:getTrialHeros(trialHeros)
			end
		end
	else
		local openInfo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

		if openInfo then
			for entranceId = 1, 3 do
				local towerCoList = TowerConfig.instance:getTowerLimitedTimeCoList(openInfo.towerId, entranceId)

				if towerCoList then
					for _, v in pairs(towerCoList) do
						subEpisodes = self:getLayerSubEpisodeList(v.layerId, true)

						if subEpisodes then
							for _, subEpisode in pairs(subEpisodes) do
								subEpisode:getHeros(heros)
								subEpisode:getAssistBossId(assistBosss)
								subEpisode:getTrialHeros(trialHeros)
							end
						end
					end
				end
			end
		end
	end

	return heros, assistBosss, trialHeros
end

function TowerMo:getBanAssistBosss(layerId)
	local subEpisodes = self:getLayerSubEpisodeList(layerId, true)
	local assistBosss = {}

	if subEpisodes then
		for k, v in pairs(subEpisodes) do
			v:getAssistBossId(assistBosss)
		end
	end

	return assistBosss
end

function TowerMo:isHeroGroupLock(layerId, episodeId)
	if self.type == TowerEnum.TowerType.Boss then
		return false
	end

	local subEpisodes = self:getLayerSubEpisodeList(layerId, true)

	if self.type == TowerEnum.TowerType.Normal then
		local co = TowerConfig.instance:getPermanentEpisodeCo(layerId)

		if co and co.isElite ~= 1 then
			return false
		end

		if subEpisodes then
			for k, v in pairs(subEpisodes) do
				if v.episodeId == episodeId then
					if v.status == 1 then
						return true, v
					else
						return false
					end
				end
			end
		end

		return false
	end

	if subEpisodes then
		for k, v in pairs(subEpisodes) do
			if v.status == 1 then
				return true, v
			end
		end
	end

	return false
end

return TowerMo
