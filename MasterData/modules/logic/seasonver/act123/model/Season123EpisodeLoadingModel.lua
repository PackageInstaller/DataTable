-- chunkname: @modules/logic/seasonver/act123/model/Season123EpisodeLoadingModel.lua

module("modules.logic.seasonver.act123.model.Season123EpisodeLoadingModel", package.seeall)

local Season123EpisodeLoadingModel = class("Season123EpisodeLoadingModel", BaseModel)

function Season123EpisodeLoadingModel:release()
	self.activityId = nil
	self.stage = nil
	self.layer = nil
	self._layerDict = nil

	self:clear()
end

function Season123EpisodeLoadingModel:init(actId, stage, layer)
	self.activityId = actId
	self.stage = stage
	self.layer = layer
	self._layerDict = {}

	self:initEpisodeList()
end

Season123EpisodeLoadingModel.AnimCount = 7
Season123EpisodeLoadingModel.EmptyStyleCount = 3
Season123EpisodeLoadingModel.TargetEpisodeOrder = 5

function Season123EpisodeLoadingModel:initEpisodeList()
	local episodeList = {}
	local episodeCfgs = Season123Config.instance:getSeasonEpisodeByStage(self.activityId, self.stage)

	logNormal("episode list length : " .. tostring(#episodeCfgs))

	local seasonMO = Season123Model.instance:getActInfo(self.activityId)
	local curStageMO = seasonMO:getStageMO(self.stage)

	if curStageMO then
		local episodeCount = #episodeCfgs

		for i = 1, Season123EpisodeLoadingModel.AnimCount do
			local index = (self.layer - Season123EpisodeLoadingModel.TargetEpisodeOrder + i) % (episodeCount + 1)
			local mo = Season123EpisodeLoadingMO.New()

			if index == 0 then
				mo:init(i, nil, nil, 1)
			else
				local episodeCfg = episodeCfgs[index]
				local episodeMO = curStageMO.episodeMap[episodeCfg.layer]

				mo:init(i, episodeMO, episodeCfg)

				self._layerDict[episodeCfg.layer] = self._layerDict[episodeCfg.layer] or mo
			end

			table.insert(episodeList, mo)
		end
	end

	self:setList(episodeList)
end

function Season123EpisodeLoadingModel:isEpisodeUnlock(layer)
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)
	local curLayerMO = self._layerDict[layer]

	if curLayerMO and curLayerMO.isFinished then
		return true
	end

	if layer <= 1 then
		if not seasonMO then
			return false
		end

		return self.stage == seasonMO.stage
	end

	local prevLayerMO = self._layerDict[layer - 1]

	if not prevLayerMO or not prevLayerMO.isFinished then
		return false
	end

	return true
end

function Season123EpisodeLoadingModel:inCurrentStage()
	local actMO = Season123Model.instance:getActInfo(self.activityId)

	return actMO ~= nil and not actMO:isNotInStage() and actMO.stage == Season123EpisodeLoadingModel.instance.stage
end

Season123EpisodeLoadingModel.instance = Season123EpisodeLoadingModel.New()

return Season123EpisodeLoadingModel
