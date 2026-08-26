-- chunkname: @modules/logic/versionactivity1_3/armpipe/model/Activity124Model.lua

module("modules.logic.versionactivity1_3.armpipe.model.Activity124Model", package.seeall)

local Activity124Model = class("Activity124Model", BaseModel)

function Activity124Model:onInit()
	self._episodeInfoDict = {}
end

function Activity124Model:reInit()
	self._episodeInfoDict = {}
end

function Activity124Model:getCurActivityID()
	return self._curActivityId
end

function Activity124Model:onReceiveGetAct120InfoReply(proto)
	self._curActivityId = proto.activityId
	self._episodeInfoDict[proto.activityId] = {}

	self:_updateEpisodeInfo(self._curActivityId, proto.act124Episodes)
end

function Activity124Model:onReceiveFinishAct124EpisodeReply(proto)
	self:_updateEpisodeInfo(proto.activityId, proto.updateAct124Episodes)
end

function Activity124Model:onReceiveReceiveAct124RewardReply(proto)
	local actId = proto.activityId
	local episodeId = proto.episodeId
	local data = self:getEpisodeData(actId, episodeId)

	if data then
		data.state = ArmPuzzlePipeEnum.EpisodeState.Received
	end
end

function Activity124Model:_updateEpisodeInfo(actId, episodeList)
	local episodeInfoData = self._episodeInfoDict[actId]

	if not episodeInfoData then
		episodeInfoData = {}
		self._episodeInfoDict[actId] = episodeInfoData
	end

	for i, v in ipairs(episodeList) do
		local id = v.id

		episodeInfoData[id] = episodeInfoData[id] or {}
		episodeInfoData[id].id = v.id
		episodeInfoData[id].state = v.state
	end
end

function Activity124Model:getEpisodeData(actId, id)
	return self._episodeInfoDict[actId] and self._episodeInfoDict[actId][id]
end

function Activity124Model:isEpisodeOpenById(actId, episodeId)
	return (ArmPuzzleHelper.isOpenDay(episodeId))
end

function Activity124Model:isEpisodeClear(actId, episodeId)
	local episodeData = self:getEpisodeData(actId, episodeId)

	if episodeData then
		return episodeData.state == ArmPuzzlePipeEnum.EpisodeState.Finish or episodeData.state == ArmPuzzlePipeEnum.EpisodeState.Received
	end

	return false
end

function Activity124Model:isHasReard(actId, episodeId)
	local episodeData = self:getEpisodeData(actId, episodeId)

	if episodeData then
		return episodeData.state == ArmPuzzlePipeEnum.EpisodeState.Finish
	end

	return false
end

function Activity124Model:isReceived(actId, episodeId)
	local episodeData = self:getEpisodeData(actId, episodeId)

	if episodeData then
		return episodeData.state == ArmPuzzlePipeEnum.EpisodeState.Received
	end

	return false
end

Activity124Model.instance = Activity124Model.New()

return Activity124Model
