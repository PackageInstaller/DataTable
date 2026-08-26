-- chunkname: @modules/logic/tower/model/TowerEpisodeMo.lua

module("modules.logic.tower.model.TowerEpisodeMo", package.seeall)

local TowerEpisodeMo = pureTable("TowerEpisodeMo")

function TowerEpisodeMo:init(towerType, config)
	self.towerType = towerType

	self:initEpisode(config)
end

function TowerEpisodeMo:initEpisode(config)
	self.episodeList = {}
	self.preEpisodeDict = {}
	self.normalEpisodeCountDict = {}
	self.configDict = config.configDict

	local towerId

	for _, episode in pairs(config.configList) do
		local preEpisodeDict = self.preEpisodeDict[episode.towerId]

		if not preEpisodeDict then
			preEpisodeDict = {}
			self.preEpisodeDict[episode.towerId] = preEpisodeDict
		end

		preEpisodeDict[episode.preLayerId] = episode.layerId
	end

	local episodeConfig, nextEpisode, episodes

	for towerId, dict in pairs(self.preEpisodeDict) do
		local episodeList = self.episodeList[towerId]

		if not episodeList then
			episodeList = {}
			self.episodeList[towerId] = episodeList
		end

		nextEpisode = dict[0]
		episodes = self:getEpisodeDict(towerId)

		while nextEpisode ~= nil do
			if episodes[nextEpisode].openRound > 0 and self.normalEpisodeCountDict[towerId] == nil then
				self.normalEpisodeCountDict[towerId] = #episodeList
			end

			table.insert(episodeList, nextEpisode)

			nextEpisode = dict[nextEpisode]
		end

		if self.normalEpisodeCountDict[towerId] == nil then
			self.normalEpisodeCountDict[towerId] = #episodeList
		end
	end
end

function TowerEpisodeMo:getEpisodeList(towerId)
	return self.episodeList[towerId]
end

function TowerEpisodeMo:getEpisodeDict(towerId)
	return self.configDict[towerId]
end

function TowerEpisodeMo:getEpisodeConfig(towerId, layer)
	local dict = self:getEpisodeDict(towerId)
	local config = dict and dict[layer]

	if config == nil and layer ~= 0 then
		logError(string.format("episode config is nil, towerType:%s,towerId:%s,layer:%s", self.towerType, towerId, layer))
	end

	return config
end

function TowerEpisodeMo:getNextEpisodeLayer(towerId, layer)
	local dict = self.preEpisodeDict[towerId]

	return dict and dict[layer]
end

function TowerEpisodeMo:getEpisodeIndex(towerId, layerId, realIndex)
	local config = self:getEpisodeConfig(towerId, layerId)

	if not config then
		return 0
	end

	local isSp = config.openRound > 0
	local list = self:getEpisodeList(towerId)
	local index = tabletool.indexOf(list, layerId)

	if not realIndex then
		if isSp then
			if not self.normalEpisodeCountDict[towerId] then
				local begin = 0

				index = index - begin
			end
		end
	end

	return index
end

function TowerEpisodeMo:getSpEpisodes(towerId)
	local list = {}
	local begin = self.normalEpisodeCountDict[towerId]

	if begin then
		local episodeList = self:getEpisodeList(towerId)

		for i = begin + 1, #episodeList do
			table.insert(list, episodeList[i])
		end
	end

	return list
end

function TowerEpisodeMo:getLayerCount(towerId, isSp)
	if not self.normalEpisodeCountDict[towerId] then
		local count = 0

		if isSp then
			local episodeList = self:getEpisodeList(towerId)

			count = #episodeList - self.normalEpisodeCountDict[towerId]
		end

		return self.normalEpisodeCountDict[towerId]
	end
end

function TowerEpisodeMo:isPassAllUnlockLayers(towerId)
	local towerInfo = TowerModel.instance:getTowerInfoById(self.towerType, towerId)

	if towerInfo then
		if not towerInfo.passLayerId then
			local passLayerId = 0
			local nextLayerId = self:getNextEpisodeLayer(towerId, passLayerId)

			if not nextLayerId then
				return true
			end

			local layerConfig = self:getEpisodeConfig(towerId, nextLayerId)

			if not layerConfig then
				return true
			end

			local isSp = layerConfig.openRound > 0

			if not isSp then
				return false
			end

			return not towerInfo:isSpLayerOpen(nextLayerId)
		end
	end
end

return TowerEpisodeMo
