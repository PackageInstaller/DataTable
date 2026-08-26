-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgBattleModel.lua

module("modules.logic.versionactivity3_4.chg.model.ChgBattleModel", package.seeall)

local ChgBattleModel = class("ChgBattleModel", BaseModel)

function ChgBattleModel:onInit()
	ChgBattleMapMO.default_ctor(self, "_mapMO")

	self._trackMO = ChgBattleTrackMO.New()

	self:reInit()
end

function ChgBattleModel:reInit()
	self:clear()
end

function ChgBattleModel:clear()
	self._elementId = 0
	self._isServerCompleted = false

	if self._dragContext then
		self._dragContext:clear()
	else
		self._dragContext = ChgMapDragContext.New()
	end
end

function ChgBattleModel:getElementCo()
	return ChgConfig.instance:getElementCo(self._elementId)
end

function ChgBattleModel:restartByEpisodeId(episodeId)
	local activityId = ChgConfig.instance:actId()
	local elementCo = Activity176Config.instance:getElementCo(activityId, episodeId)
	local elementId = elementCo.id

	self:restart(elementId)
end

function ChgBattleModel:restart(elementId)
	elementId = elementId or self._elementId
	self._elementId = elementId

	self:setServerCompleted(false)
	self._dragContext:clear()

	local elementCo = self:getElementCo()

	self._mapMO:restart((elementCo or nil) and (elementCo.param or nil))
end

function ChgBattleModel:restartRound(...)
	self._mapMO:restartRound(...)
end

function ChgBattleModel:elementId()
	return self._elementId
end

function ChgBattleModel:mapMO()
	return self._mapMO
end

function ChgBattleModel:dragContext()
	return self._dragContext
end

function ChgBattleModel:trackMO()
	return self._trackMO
end

function ChgBattleModel:onReceiveMapElementReply(elementId)
	if elementId ~= self._elementId then
		return
	end

	self:setServerCompleted(true)
end

function ChgBattleModel:setServerCompleted(isCompleted, optelementId)
	self._isServerCompleted = isCompleted
	self._elementId = optelementId or self._elementId

	if isCompleted then
		ChgController.instance:dispatchEvent(ChgEvent.OnGameFinished, self._elementId)
	end
end

function ChgBattleModel:isServerCompleted()
	return self._isServerCompleted
end

function ChgBattleModel:track_act_chengheguang_operation(eOperationType, ...)
	self._trackMO:track_act_chengheguang_operation(self._elementId, self._mapMO, eOperationType, ...)
end

ChgBattleModel.instance = ChgBattleModel.New()

return ChgBattleModel
