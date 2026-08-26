-- chunkname: @modules/logic/seasonver/act123/model/Season123EpisodeListModel.lua

module("modules.logic.seasonver.act123.model.Season123EpisodeListModel", package.seeall)

local Season123EpisodeListModel = class("Season123EpisodeListModel", BaseModel)

function Season123EpisodeListModel:reInit()
	self._loadingRecordMap = nil
end

function Season123EpisodeListModel:onInit()
	return
end

function Season123EpisodeListModel:release()
	self.activityId = nil
	self.stage = nil
	self.lastSendEpisodeCfg = nil
	self.curSelectLayer = nil

	self:clear()
end

function Season123EpisodeListModel:init(actId, stage)
	self.activityId = actId
	self.stage = stage

	self:initEpisodeList()
	self:initSelectLayer()
end

function Season123EpisodeListModel:initEpisodeList()
	local episodeList = {}
	local episodeCfgs = Season123Config.instance:getSeasonEpisodeByStage(self.activityId, self.stage)
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

function Season123EpisodeListModel:initSelectLayer()
	self.curSelectLayer = self:getCurrentChallengeLayer()
end

function Season123EpisodeListModel:isEpisodeUnlock(layer)
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

function Season123EpisodeListModel:inCurrentStage()
	local actMO = Season123Model.instance:getActInfo(self.activityId)

	return actMO ~= nil and not actMO:isNotInStage() and actMO.stage == Season123EpisodeListModel.instance.stage
end

function Season123EpisodeListModel:getCurrentChallengeLayer()
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

function Season123EpisodeListModel:getEnemyCareerList(episodeId)
	local fightParam = FightParam.New()

	fightParam:setEpisodeId(episodeId)

	local bossCareerDict = {}
	local enemyCareerDict = {}
	local enemyList = {}
	local enemyBossList = {}

	for i, v in ipairs(fightParam.monsterGroupIds) do
		local bossId = lua_monster_group.configDict[v].bossId
		local ids = string.splitToNumber(lua_monster_group.configDict[v].monster, "#")

		for index, id in ipairs(ids) do
			local enemyCareer = lua_monster.configDict[id].career

			if id == bossId then
				bossCareerDict[enemyCareer] = (bossCareerDict[enemyCareer] or 0) + 1

				table.insert(enemyBossList, id)
			else
				enemyCareerDict[enemyCareer] = (enemyCareerDict[enemyCareer] or 0) + 1

				table.insert(enemyList, id)
			end
		end
	end

	local enemyCareerList = {}

	for k, v in pairs(bossCareerDict) do
		table.insert(enemyCareerList, {
			career = k,
			count = v
		})
	end

	local enemyBossEndIndex = #enemyCareerList

	for k, v in pairs(enemyCareerDict) do
		table.insert(enemyCareerList, {
			career = k,
			count = v
		})
	end

	return enemyCareerList, enemyBossEndIndex
end

function Season123EpisodeListModel:setSelectLayer(layer)
	self.curSelectLayer = layer
end

function Season123EpisodeListModel:cleanPlayLoadingAnimRecord(stage)
	if not self._loadingRecordMap then
		return
	end

	self._loadingRecordMap = self._loadingRecordMap or {}
	self._loadingRecordMap[stage] = nil
end

function Season123EpisodeListModel:savePlayLoadingAnimRecord(stage)
	self._loadingRecordMap = self._loadingRecordMap or {}
	self._loadingRecordMap[stage] = true
end

function Season123EpisodeListModel:isLoadingAnimNeedPlay(stage)
	return self._loadingRecordMap == nil or self._loadingRecordMap[stage] == nil
end

function Season123EpisodeListModel:stageIsPassed()
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return false
	end

	local stageMO = seasonMO.stageMap[self.stage]

	return stageMO and stageMO.isPass
end

Season123EpisodeListModel.instance = Season123EpisodeListModel.New()

return Season123EpisodeListModel
