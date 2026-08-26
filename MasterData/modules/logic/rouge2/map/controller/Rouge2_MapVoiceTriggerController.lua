-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapVoiceTriggerController.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapVoiceTriggerController", package.seeall)

local Rouge2_MapVoiceTriggerController = class("Rouge2_MapVoiceTriggerController")

function Rouge2_MapVoiceTriggerController:init()
	if self.inited then
		return
	end

	self.inited = true
	self.lastTriggerTime = -Rouge2_MapEnum.TalkCD

	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onCreateMapDoneFlowDone, self.tryTriggerRecordVoice, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onAcceptEntrust, self.onAcceptEntrust, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onNodeEventStatusChange, self.onNodeEventStatusChange, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onNormalActorBeforeMove, self.onNormalActorBeforeMove, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)

	if Rouge2_MapModel.instance:getFirstEnterMapFlag() then
		self:tryRecordEnterNormalLayerVoice()
		Rouge2_MapModel.instance:setFirstEnterMap(nil)
	end
end

function Rouge2_MapVoiceTriggerController:clear()
	self.inited = nil
	self.lastTriggerTime = nil

	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onCreateMapDoneFlowDone, self.tryTriggerRecordVoice, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onAcceptEntrust, self.onAcceptEntrust, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onNodeEventStatusChange, self.onNodeEventStatusChange, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onNormalActorBeforeMove, self.onNormalActorBeforeMove, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	TaskDispatcher.cancelTask(self.endTriggerShortVoice, self)
end

function Rouge2_MapVoiceTriggerController:onChangeMapInfo()
	local type = Rouge2_MapModel.instance:getMapType()

	if type == Rouge2_MapEnum.MapType.Normal then
		self:tryRecordEnterNormalLayerVoice()
	elseif type == Rouge2_MapEnum.MapType.Middle then
		self:tryRecordEnterMiddleLayerVoice()
	elseif type == Rouge2_MapEnum.MapType.PathSelect then
		self:tryRecordEnterPathSelectLayerVoice()
	end
end

function Rouge2_MapVoiceTriggerController:onExitPieceChoiceEvent()
	local groupCo = self:getCanTriggerGroup(Rouge2_MapEnum.ShortVoiceTriggerType.ExitPieceTalk)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function Rouge2_MapVoiceTriggerController:onAcceptEntrust(newEntrustIdList)
	local entrustId = newEntrustIdList and newEntrustIdList[1]

	if not entrustId then
		return
	end

	local groupCo = self:getCanTriggerGroup(Rouge2_MapEnum.ShortVoiceTriggerType.AcceptEntrust)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function Rouge2_MapVoiceTriggerController:onNodeEventStatusChange(eventId, curStatus)
	if curStatus ~= Rouge2_MapEnum.EventState.Finish then
		return
	end

	self:tryTriggerFinishEvent(eventId)
end

function Rouge2_MapVoiceTriggerController:onMiddleActorBeforeMove()
	local groupCo = self:getCanTriggerGroup(Rouge2_MapEnum.ShortVoiceTriggerType.MiddleLayerMove)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function Rouge2_MapVoiceTriggerController:onNormalActorBeforeMove()
	local groupCo = self:getCanTriggerGroup(Rouge2_MapEnum.ShortVoiceTriggerType.NormalLayerMove)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function Rouge2_MapVoiceTriggerController:tryTriggerFinishEvent(eventId)
	local eventCo = Rouge2_MapConfig.instance:getRougeEvent(eventId)

	if not eventCo then
		return
	end

	local groupCo = self:getCanTriggerGroup(Rouge2_MapEnum.ShortVoiceTriggerType.FinishEvent, eventCo.type)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
	self:tryTriggerRecordVoice()
end

function Rouge2_MapVoiceTriggerController:tryRecordEnterNormalLayerVoice()
	local layerId = Rouge2_MapModel.instance:getLayerId()
	local groupCo = self:getCanTriggerGroup(Rouge2_MapEnum.ShortVoiceTriggerType.EnterNormalLayer, layerId)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
end

function Rouge2_MapVoiceTriggerController:tryRecordEnterMiddleLayerVoice()
	local layerId = Rouge2_MapModel.instance:getMiddleLayerId()
	local groupCo = self:getCanTriggerGroup(Rouge2_MapEnum.ShortVoiceTriggerType.EnterMiddleLayer, layerId)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
end

function Rouge2_MapVoiceTriggerController:tryRecordEnterPathSelectLayerVoice()
	local layerCo = Rouge2_MapModel.instance:getPathSelectCo()
	local layerId = layerCo and layerCo.id
	local groupCo = self:getCanTriggerGroup(Rouge2_MapEnum.ShortVoiceTriggerType.EnterPathSelectLayer, layerId)

	if not self:checkCanTriggerGroup(groupCo) then
		return
	end

	self:recordCurTriggerVoice(groupCo.id)
end

function Rouge2_MapVoiceTriggerController:onCloseViewFinish(viewName)
	self:tryTriggerRecordVoice()
end

function Rouge2_MapVoiceTriggerController:tryTriggerRecordVoice()
	if not self.curTriggerGroupId then
		return
	end

	local curTime = Time.time

	if curTime - self.lastTriggerTime < Rouge2_MapEnum.TalkCD then
		return
	end

	local curMapState = Rouge2_MapModel.instance:getMapState()

	if curMapState ~= Rouge2_MapEnum.MapState.Normal then
		self:log(string.format("try trigger groupId : %s, mapState : %s", self.curTriggerGroupId, curMapState))

		return
	end

	if not Rouge2_MapHelper.checkMapViewOnTop(true) then
		return
	end

	local voice = Rouge2_MapConfig.instance:getRandomVoice(self.curTriggerGroupId)

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onTriggerShortVoice, voice)
	self:log(string.format("trigger voice id : %s, voice desc : %s", voice.id, voice.desc))

	self.lastTriggerTime = curTime
	self.curTriggerGroupId = nil

	TaskDispatcher.runDelay(self.endTriggerShortVoice, self, Rouge2_MapEnum.TalkDuration)
end

function Rouge2_MapVoiceTriggerController:endTriggerShortVoice()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onEndTriggerShortVoice)
end

function Rouge2_MapVoiceTriggerController:recordCurTriggerVoice(groupId)
	local curTime = Time.time

	if curTime - self.lastTriggerTime < Rouge2_MapEnum.TalkCD then
		return
	end

	if self.curTriggerGroupId then
		self:log(string.format("exist group id ： %s, cover new group id ： %s", self.curTriggerGroupId, groupId))
	end

	self.curTriggerGroupId = groupId
end

function Rouge2_MapVoiceTriggerController:getCanTriggerGroup(type, param)
	local groupList = Rouge2_MapConfig.instance:getVoiceGroupList()

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

function Rouge2_MapVoiceTriggerController:logTriggerGroup(groupCo)
	self:log(string.format("trigger group id " .. tostring(groupCo.id)))
end

function Rouge2_MapVoiceTriggerController:log(msg)
	logNormal("[地图语音]" .. tostring(msg))
end

function Rouge2_MapVoiceTriggerController:checkCanTriggerGroup(groupCo)
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

Rouge2_MapVoiceTriggerController.instance = Rouge2_MapVoiceTriggerController.New()

return Rouge2_MapVoiceTriggerController
