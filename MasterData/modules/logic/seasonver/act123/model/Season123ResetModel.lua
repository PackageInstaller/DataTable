-- chunkname: @modules/logic/seasonver/act123/model/Season123ResetModel.lua

module("modules.logic.seasonver.act123.model.Season123ResetModel", package.seeall)

local Season123ResetModel = class("Season123ResetModel", BaseModel)

Season123ResetModel.EmptySelect = -1

function Season123ResetModel:release()
	return
end

function Season123ResetModel:init(actId, stage, layer)
	self.activityId = actId
	self.stage = stage

	self:initEpisodeList()
	self:initDefaultSelected(layer)
end

function Season123ResetModel:initEpisodeList()
	local episodeList = {}
	local episodeCfgs = Season123Config.instance:getSeasonEpisodeByStage(self.activityId, self.stage)

	logNormal("episode list length : " .. tostring(#episodeCfgs))

	local seasonMO = Season123Model.instance:getActInfo(self.activityId)
	local curStageMO = seasonMO:getStageMO(self.stage)

	if curStageMO then
		for i = 1, #episodeCfgs do
			local episodeCfg = episodeCfgs[i]
			local episodeMO = curStageMO.episodeMap[episodeCfg.layer]
			local mo = Season123EpisodeListMO.New()

			mo:init(episodeMO, episodeCfg)
			table.insert(episodeList, mo)
		end
	end

	self:setList(episodeList)
end

function Season123ResetModel:isEpisodeUnlock(layer)
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)
	local curLayerMO = self:getById(layer)

	if curLayerMO.isFinished then
		return true
	end

	if layer <= 1 then
		if not seasonMO then
			return false
		end

		return self.stage == seasonMO.stage
	end

	local prevLayerMO = self:getById(layer - 1)

	if not prevLayerMO or not prevLayerMO.isFinished then
		return false
	end

	return true
end

function Season123ResetModel:initDefaultSelected(layer)
	self.layer = layer

	self:updateHeroList()
end

function Season123ResetModel:getCurrentChallengeLayer()
	local list = self:getList()

	if not list or #list <= 0 then
		return 0
	end

	for i = 1, #list do
		if not list[i].isFinished then
			return i
		end
	end

	return list[#list].cfg.layer
end

function Season123ResetModel:getStageCO()
	return Season123Config.instance:getStageCo(self.activityId, self.stage)
end

function Season123ResetModel:getSelectLayerCO()
	if self.layer then
		return Season123Config.instance:getSeasonEpisodeCo(self.activityId, self.stage, self.layer)
	end
end

function Season123ResetModel:updateHeroList()
	self._showHeroMOList = {}

	if self.layer == Season123ResetModel.EmptySelect then
		return
	end

	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return
	end

	local stageMO = seasonMO:getStageMO(self.stage)

	if not stageMO then
		return
	end

	if not self.layer then
		local layer = self:getCurrentChallengeLayer()

		if layer then
			local episodeMO = stageMO.episodeMap[layer]

			if not episodeMO then
				return
			end

			local heroList = episodeMO.heroes

			for _, season123HeroMO in ipairs(heroList) do
				local heroMO = HeroModel.instance:getById(season123HeroMO.heroUid)

				if not heroMO then
					local assistHeroMO, assistMO = Season123Model.instance:getAssistData(self.activityId, self.stage)

					if assistMO and assistMO.heroUid == season123HeroMO.heroUid then
						local mo = Season123ShowHeroMO.New()

						mo:init(assistHeroMO, assistMO.heroUid, assistMO.heroId, assistMO.skin, season123HeroMO.hpRate, true)
						table.insert(self._showHeroMOList, mo)
					end
				else
					local mo = Season123ShowHeroMO.New()

					mo:init(heroMO, heroMO.uid, heroMO.heroId, heroMO.skin, season123HeroMO.hpRate, false)
					table.insert(self._showHeroMOList, mo)
				end
			end
		end
	end
end

function Season123ResetModel:getHeroList()
	return self._showHeroMOList
end

Season123ResetModel.instance = Season123ResetModel.New()

return Season123ResetModel
