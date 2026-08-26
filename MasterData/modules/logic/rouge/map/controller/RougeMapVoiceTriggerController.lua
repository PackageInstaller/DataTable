-- chunkname: @modules/logic/rouge/map/controller/RougeMapVoiceTriggerController.lua

module("modules.logic.rouge.map.controller.RougeMapVoiceTriggerController", package.seeall)

local RougeMapVoiceTriggerController = class("RougeMapVoiceTriggerController")

function RougeMapVoiceTriggerController:init()
	if self.inited then
		return
	end

	self.inited = true
	self.lastTriggerTime = -RougeMapEnum.TalkCD

	RougeMapController.instance:registerCallback(RougeMapEvent.onCreateMapDoneFlowDone, self.tryTriggerRecordVoice, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onAcceptEntrust, self.onAcceptEntrust, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onNodeEventStatusChange, self.onNodeEventStatusChange, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onNormalActorBeforeMove, self.onNormalActorBeforeMove, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)

	if RougeMapModel.instance:getFirstEnterMapFlag() then
		self:tryRecordEnterNormalLayerVoice()
		RougeMapModel.instance:setFirstEnterMap(nil)
	end
end

function RougeMapVoiceTriggerController:clear()
	self.inited = nil
	self.lastTriggerTime = nil

	RougeMapController.instance:unregisterCallback(RougeMapEvent.onCreateMapDoneFlowDone, self.tryTriggerRecordVoice, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onAcceptEntrust, self.onAcceptEntrust, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onNodeEventStatusChange, self.onNodeEventStatusChange, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onNormalActorBeforeMove, self.onNormalActorBeforeMove, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	TaskDispatcher.cancelTask(self.endTriggerShortVoice, self)
end

function RougeMapVoiceTriggerController:onChangeMapInfo()
	local type = RougeMapModel.instance:getMapType()

	if type == RougeMapEnum.MapType.Normal then
		self:tryRecordEnterNormalLayerVoice()
	elseif type == RougeMapEnum.MapType.Middle then
		self:tryRecordEnterMiddleLayerVoice()
	elseif type == RougeMapEnum.MapType.PathSelect then
		self:tryRecordEnterPathSelectLayerVoice()
	end
end

function RougeMapVoiceTriggerController:onExitPieceChoiceEvent()
	local groupCo = self:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.ExitPieceTalk)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function RougeMapVoiceTriggerController:onAcceptEntrust()
	local entrustId = RougeMapModel.instance:getEntrustId()

	if not entrustId then
		return
	end

	local groupCo = self:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.AcceptEntrust)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function RougeMapVoiceTriggerController:onNodeEventStatusChange(eventId, curStatus)
	if curStatus ~= RougeMapEnum.EventState.Finish then
		return
	end

	self:tryTriggerFinishEvent(eventId)
end

function RougeMapVoiceTriggerController:onMiddleActorBeforeMove()
	local groupCo = self:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.MiddleLayerMove)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function RougeMapVoiceTriggerController:onNormalActorBeforeMove()
	local groupCo = self:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.NormalLayerMove)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function RougeMapVoiceTriggerController:tryTriggerFinishEvent(eventId)
	local eventCo = RougeMapConfig.instance:getRougeEvent(eventId)

	if not eventCo then
		return
	end

	local groupCo = self:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.FinishEvent, eventCo.type)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function RougeMapVoiceTriggerController:tryRecordEnterNormalLayerVoice()
	local layerId = RougeMapModel.instance:getLayerId()
	local groupCo = self:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.EnterNormalLayer, layerId)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
end

function RougeMapVoiceTriggerController:tryRecordEnterMiddleLayerVoice()
	local layerId = RougeMapModel.instance:getMiddleLayerId()
	local groupCo = self:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.EnterMiddleLayer, layerId)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
end

function RougeMapVoiceTriggerController:tryRecordEnterPathSelectLayerVoice()
	local layerCo = RougeMapModel.instance:getPathSelectCo()
	local layerId = layerCo and layerCo.id
	local groupCo = self:getCanTriggerGroup(RougeMapEnum.ShortVoiceTriggerType.EnterPathSelectLayer, layerId)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
end

function RougeMapVoiceTriggerController:onCloseViewFinish(viewName)
	self:tryTriggerRecordVoice()
end

function RougeMapVoiceTriggerController:tryTriggerRecordVoice()
	if not self.curTriggerGroupId then
		return
	end

	local curTime = Time.time

	if curTime - self.lastTriggerTime < RougeMapEnum.TalkCD then
		return
	end

	local curMapState = RougeMapModel.instance:getMapState()

	if curMapState ~= RougeMapEnum.MapState.Normal then
		self:log(string.format("try trigger groupId : %s, mapState : %s", self.curTriggerGroupId, curMapState))

		return
	end

	if not RougeMapHelper.checkMapViewOnTop(true) then
		return
	end

	local voice = RougeMapConfig.instance:getRandomVoice(self.curTriggerGroupId)

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onTriggerShortVoice, voice)
	self:log(string.format("trigger voice id : %s, voice desc : %s", voice.id, voice.desc))

	self.lastTriggerTime = curTime
	self.curTriggerGroupId = nil

	TaskDispatcher.runDelay(self.endTriggerShortVoice, self, RougeMapEnum.TalkDuration)
end

function RougeMapVoiceTriggerController:endTriggerShortVoice()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEndTriggerShortVoice)
end

function RougeMapVoiceTriggerController:recordCurTriggerVoice(groupId)
	local curTime = Time.time

	if curTime - self.lastTriggerTime < RougeMapEnum.TalkCD then
		return
	end

	if self.curTriggerGroupId then
		self:log(string.format("exist group id ： %s, cover new group id ： %s", self.curTriggerGroupId, groupId))
	end

	self.curTriggerGroupId = groupId
end

function RougeMapVoiceTriggerController:getCanTriggerGroup(type, param)
	local groupList = RougeMapConfig.instance:getVoiceGroupList()

	for _, groupCo in ipairs(groupList) do
		local triggerType = groupCo.triggerType

		if triggerType == type then
			local groupParam = groupCo.triggerParam

			if groupParam == 0 then
				self:logTriggerGroup(groupCo)

				return groupCo
			elseif groupParam == param then
				self:logTriggerGroup(groupCo)

				return groupCo
			end
		end
	end
end

function RougeMapVoiceTriggerController:logTriggerGroup(groupCo)
	self:log(string.format("trigger group id " .. tostring(groupCo.id)))
end

function RougeMapVoiceTriggerController:log(msg)
	logNormal("[地图语音]" .. tostring(msg))
end

function RougeMapVoiceTriggerController:checkCanTriggerGroup(groupCo)
	if not groupCo then
		return false
	end

	local rate = groupCo.rate

	if rate >= 1000 then
		return true
	end

	local randomRate = math.random(1000)

	return randomRate <= rate
end

RougeMapVoiceTriggerController.instance = RougeMapVoiceTriggerController.New()

return RougeMapVoiceTriggerController
