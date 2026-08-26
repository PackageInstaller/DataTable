-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/GaoSiNiaoSysModel.lua

module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoSysModel", package.seeall)

local GaoSiNiaoSysModel = class("GaoSiNiaoSysModel", Activity210Model)

function GaoSiNiaoSysModel:reInit()
	GaoSiNiaoSysModel.super.reInit(self)
	self:_internal_set_config(GaoSiNiaoConfig.instance)
	self:_internal_set_taskType(TaskEnum.TaskType.Activity210)
end

function GaoSiNiaoSysModel:_onReceiveAct210SaveEpisodeProgressReply(msg)
	GaoSiNiaoBattleModel.instance:_onReceiveAct210SaveEpisodeProgressReply(msg)
	GaoSiNiaoController.instance:dispatchEvent(GaoSiNiaoEvent.onReceiveAct210SaveEpisodeProgressReply, msg)
end

function GaoSiNiaoSysModel:_onReceiveAct210FinishEpisodeReply(msg)
	GaoSiNiaoBattleModel.instance:_onReceiveAct210FinishEpisodeReply(msg)
	GaoSiNiaoController.instance:dispatchEvent(GaoSiNiaoEvent.onReceiveAct210FinishEpisodeReply, msg)
end

function GaoSiNiaoSysModel:_onReceiveAct210EpisodePush(msg)
	GaoSiNiaoController.instance:dispatchEvent(GaoSiNiaoEvent.onReceiveAct210EpisodePush, msg)
end

function GaoSiNiaoSysModel:currentEpisodeIdToPlay(isFromSvrSide)
	local episodeCOList, _SPCOList = self:config():getEpisodeCOList()
	local lastOneEpisodeId = 0

	for _, CO in ipairs(episodeCOList) do
		local episodeId = CO.episodeId

		lastOneEpisodeId = episodeId

		local isPassed = self:_internal_hasPassEpisode(episodeId, isFromSvrSide)

		if not isPassed then
			return episodeId
		end
	end

	for _, CO in ipairs(_SPCOList) do
		local episodeId = CO.episodeId

		lastOneEpisodeId = episodeId

		local isPassed = self:_internal_hasPassEpisode(episodeId, isFromSvrSide)

		if not isPassed then
			return episodeId
		end
	end

	return lastOneEpisodeId
end

function GaoSiNiaoSysModel:currentPassedEpisodeId()
	local currentEpisodeIdToPlay = self:currentEpisodeIdToPlay()

	if currentEpisodeIdToPlay <= 0 then
		return
	end

	if self:hasPassLevelAndStory(currentEpisodeIdToPlay) then
		return currentEpisodeIdToPlay
	end

	return self:config():getPreEpisodeId(currentEpisodeIdToPlay)
end

function GaoSiNiaoSysModel:isSpEpisodeOpen(optSpecificEpisodeId)
	local _, _SPCOList = self:config():getEpisodeCOList()

	if #_SPCOList <= 0 then
		return false
	end

	for _, CO in ipairs(_SPCOList) do
		local episodeId = CO.episodeId

		if optSpecificEpisodeId then
			if episodeId == optSpecificEpisodeId then
				return self:isEpisodeOpen(episodeId)
			end
		elseif self:isEpisodeOpen(episodeId) then
			return true
		end
	end

	return false
end

GaoSiNiaoSysModel.instance = GaoSiNiaoSysModel.New()

return GaoSiNiaoSysModel
