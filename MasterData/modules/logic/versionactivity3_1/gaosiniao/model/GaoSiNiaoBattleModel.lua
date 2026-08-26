-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/GaoSiNiaoBattleModel.lua

module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleModel", package.seeall)

local GaoSiNiaoBattleModel = class("GaoSiNiaoBattleModel", BaseModel)

function GaoSiNiaoBattleModel:onInit()
	GaoSiNiaoBattleMapMO.default_ctor(self, "_mapMO")

	self._trackMO = GaoSiNiaoBattleTrackMO.New()

	self:reInit()
end

function GaoSiNiaoBattleModel:reInit()
	self._episodeId = 0
	self._isServerCompleted = false

	if self._dragContext then
		self._dragContext:clear()
	else
		self._dragContext = GaoSiNiaoMapDragContext.New()
	end
end

function GaoSiNiaoBattleModel:restart(episodeId)
	self:setServerCompleted(false)

	self._episodeId = episodeId

	self._dragContext:clear()
	self._mapMO:createMapByEpisodeId(episodeId)
end

function GaoSiNiaoBattleModel:episodeId()
	return self._episodeId
end

function GaoSiNiaoBattleModel:mapMO()
	return self._mapMO
end

function GaoSiNiaoBattleModel:dragContext()
	return self._dragContext
end

function GaoSiNiaoBattleModel:trackMO()
	return self._trackMO
end

function GaoSiNiaoBattleModel:_onReceiveAct210FinishEpisodeReply(msg)
	if msg.episodeId ~= self._episodeId then
		return
	end

	self:setServerCompleted(true)
end

function GaoSiNiaoBattleModel:isServerCompleted()
	return self._isServerCompleted
end

function GaoSiNiaoBattleModel:setServerCompleted(isCompleted, optEpisodeId)
	self._isServerCompleted = isCompleted
	self._episodeId = optEpisodeId or self._episodeId
end

function GaoSiNiaoBattleModel:saveProgressAsStr()
	return ""
end

function GaoSiNiaoBattleModel:loadProgressInfoInByStr(progressStr)
	return
end

function GaoSiNiaoBattleModel:_onReceiveAct210SaveEpisodeProgressReply(msg)
	return
end

function GaoSiNiaoBattleModel:track_act210_operation(operation_type)
	self._trackMO:track_act210_operation(self:mapMO(), operation_type)
end

GaoSiNiaoBattleModel.instance = GaoSiNiaoBattleModel.New()

return GaoSiNiaoBattleModel
