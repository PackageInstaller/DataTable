-- chunkname: @modules/logic/seasonver/act123/model/Season123EpisodeDetailModel.lua

module("modules.logic.seasonver.act123.model.Season123EpisodeDetailModel", package.seeall)

local Season123EpisodeDetailModel = class("Season123EpisodeDetailModel", BaseModel)

function Season123EpisodeDetailModel:release()
	self.activityId = nil
	self.stage = nil
	self.layer = nil
	self.lastSendEpisodeCfg = nil

	self:clear()
end

function Season123EpisodeDetailModel:init(actId, stage, layer)
	self.activityId = actId
	self.stage = stage
	self.layer = layer
	self.animRecord = Season123LayerLocalRecord.New()

	self.animRecord:init(self.activityId)
	self:initEpisodeList()
end

function Season123EpisodeDetailModel:initEpisodeList()
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

function Season123EpisodeDetailModel:isEpisodeUnlock(layer)
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

function Season123EpisodeDetailModel:setMakertLayerAnim(layer)
	return self.animRecord:add(self.stage, layer)
end

function Season123EpisodeDetailModel:isNeedPlayMakertLayerAnim(layer)
	return self.animRecord:contain(self.stage, layer)
end

function Season123EpisodeDetailModel:getCurrentChallengeLayer()
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

function Season123EpisodeDetailModel:isNextLayerNewStarGroup(layer)
	local co = Season123Config.instance:getSeasonEpisodeCo(self.activityId, layer)

	if co then
		if not co.starGroup then
			local starGroup = 0
			local nextCo = Season123Config.instance:getSeasonEpisodeCo(self.activityId, layer + 1)

			if not nextCo then
				return false
			end

			local nextGroup = nextCo.starGroup

			return starGroup ~= nil and starGroup ~= nextGroup
		end
	end
end

function Season123EpisodeDetailModel:alreadyPassEpisode(layer)
	local mo = self:getById(layer)

	if not mo then
		return false
	end

	local co = Season123Config.instance:getSeasonEpisodeCo(self.activityId, self.stage, layer)

	if mo.round <= 0 and co then
		local episodeInfo = DungeonModel.instance:getEpisodeInfo(co.episodeId)

		if episodeInfo and episodeInfo.star > 0 then
			return true
		end
	end

	return mo.round > 0
end

function Season123EpisodeDetailModel:getCurStarGroup(actId, layer)
	local co = Season123Config.instance:getSeasonEpisodeCo(actId, self.stage, layer)

	return (co or nil) and (co.group or 0)
end

function Season123EpisodeDetailModel:getEpisodeCOListByStar(starGroup)
	local rsList = {}
	local episodeCfgs = Season123Config.instance:getSeasonEpisodeByStage(self.activityId, self.stage)

	if episodeCfgs then
		for _, cfg in ipairs(episodeCfgs) do
			if not cfg.starGroup or cfg.starGroup == starGroup then
				table.insert(rsList, cfg)
			end
		end
	end

	return rsList
end

function Season123EpisodeDetailModel:getCurFinishRound()
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return
	end

	local stageMO = seasonMO:getStageMO(self.stage)

	if not stageMO then
		return
	end

	local episodeMO = stageMO.episodeMap[self.layer]

	if not episodeMO then
		return
	end

	return episodeMO.round
end

Season123EpisodeDetailModel.instance = Season123EpisodeDetailModel.New()

return Season123EpisodeDetailModel
