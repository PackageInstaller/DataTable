-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/controller/FusionSoulController.lua

module("logic.extensions.fusionsoul.controller.FusionSoulController", package.seeall)

local FusionSoulController = class("FusionSoulController", BaseController)

FusionSoulController.TYPE_DISPATCH = "dispatch"
FusionSoulController.TYPE_BATTLE = "battle"
FusionSoulController.TYPE_MISSION = "mission"
FusionSoulController.TYPE_CHAT = "chat"
FusionSoulController.TYPE_FUSION = "fusion"

function FusionSoulController:ctor()
	return
end

function FusionSoulController:onInit()
	self:onReset()
end

function FusionSoulController:onReset()
	self._blockClue = {}
	self._newClueId = nil
end

function FusionSoulController:handlePM_FusionSoulGetInfoRes(msg)
	FusionSoulModel.instance:saveInfo(msg)

	local activityId = msg.activityId
	local data = FusionSoulConfig.instance:getFusionEventData(activityId)

	if data then
		if not data.zoneId then
			local zoneId = 0
			local info = FusionSoulModel.instance:getZoneInfo(activityId, zoneId)

			if info and info.eventId > data.eventId then
				FuYaoStoryController.instance:savePlotWatchRecord(FuYaoStoryEnum.Story_Plot_7)
			end

			GlobalDispatcher:dispatch(GlobalNotify.FusionSoulGetInfoRes)
		end
	end
end

function FusionSoulController:handlePM_FusionSoulGainProgressPrizeRes(msg)
	FusionSoulModel.instance:savePrizeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FusionSoulGetInfoRes)
end

function FusionSoulController:sendPM_FusionSoulStartDispatchReq(activityId, zoneId, eventId)
	local eventKey = self:packagePM_FusionSoulEventKey(activityId, zoneId, eventId)

	FusionSoulAgent.instance:sendPM_FusionSoulStartDispatchReq(eventKey)
end

function FusionSoulController:handlePM_FusionSoulStartDispatchRes(msg)
	FusionSoulModel.instance:saveStartDispatch(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FusionSoulGetInfoRes)
end

function FusionSoulController:sendPM_FusionSoulFinishDispatchReq(activityId, zoneId, eventId)
	local eventKey = self:packagePM_FusionSoulEventKey(activityId, zoneId, eventId)

	FusionSoulAgent.instance:sendPM_FusionSoulFinishDispatchReq(eventKey)
end

function FusionSoulController:handlePM_FusionSoulFinishDispatchRes(msg)
	FusionSoulModel.instance:saveFinishEvent(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FusionSoulGetInfoRes)
end

function FusionSoulController:sendPM_FusionSoulBattleReq(activityId, zoneId, eventId, form)
	local eventKey = self:packagePM_FusionSoulEventKey(activityId, zoneId, eventId)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(activityId, zoneId, eventId)

	if eventCfg.gainClues then
		self:setBlockClue(eventCfg.gainClues)
	end

	FusionSoulAgent.instance:sendPM_FusionSoulBattleReq(eventKey, form)
end

function FusionSoulController:handlePM_FusionSoulBattleRes(msg)
	return
end

function FusionSoulController:sendPM_FusionSoulFinishMissionReq(activityId, zoneId, eventId)
	local eventKey = self:packagePM_FusionSoulEventKey(activityId, zoneId, eventId)

	FusionSoulAgent.instance:sendPM_FusionSoulFinishMissionReq(eventKey)
end

function FusionSoulController:handlePM_FusionSoulFinishMissionRes(msg)
	FusionSoulModel.instance:saveFinishEvent(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FusionSoulGetInfoRes)
end

function FusionSoulController:sendPM_FusionSoulSelectAnswerReq(activityId, zoneId, eventId, answerId)
	local eventKey = self:packagePM_FusionSoulEventKey(activityId, zoneId, eventId)

	FusionSoulAgent.instance:sendPM_FusionSoulSelectAnswerReq(eventKey, answerId)
end

function FusionSoulController:handlePM_FusionSoulSelectAnswerRes(msg)
	FusionSoulModel.instance:saveAnswerInfo(msg)

	if msg.finish == true then
		FusionSoulModel.instance:saveFinishEvent(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.FusionSoulGetInfoRes)
end

function FusionSoulController:sendPM_FusionSoulFinishFinalEventReq(activityId, zoneId, eventId)
	local eventKey = self:packagePM_FusionSoulEventKey(activityId, zoneId, eventId)

	FusionSoulAgent.instance:sendPM_FusionSoulFinishFinalEventReq(eventKey)
end

function FusionSoulController:handlePM_FusionSoulFinishFinalEventRes(msg)
	FusionSoulModel.instance:saveFinishEvent(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FusionSoulGetInfoRes)
end

function FusionSoulController:sendPM_FusionSoulCombineClueReq(activityId, clueId)
	self._newClueId = nil

	FusionSoulAgent.instance:sendPM_FusionSoulCombineClueReq(activityId, clueId)
end

function FusionSoulController:handlePM_FusionSoulCombineClueRes(msg)
	local isCombineCorrect = true

	if msg.combineClueId <= 0 then
		FloatWordMgr.instance:show(lang("无关联结果"))

		isCombineCorrect = false
	end

	if FusionSoulModel.instance:isGainClue(msg.activityId, msg.combineClueId) == true and self._newClueId ~= msg.combineClueId then
		FloatWordMgr.instance:show(lang("已获得该线索"))

		isCombineCorrect = false
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_FusionSoulCombineClueRes, isCombineCorrect)
end

function FusionSoulController:handlePM_Notify_FusionSoulChallengeResult(msg)
	if msg.win == true then
		FusionSoulModel.instance:saveFinishEvent(msg)
	else
		self:setBlockClue()
	end

	GlobalDispatcher:dispatch(GlobalNotify.FusionSoulGetInfoRes)
end

function FusionSoulController:handlePM_Notify_FusionSoulClueGain(msg)
	FusionSoulModel.instance:saveGainClue(msg)

	local canShow = false
	local content = "获得线索"
	local showClueId = 0

	for i, v in ipairs(msg.clueId) do
		if not self._blockClue[v] then
			local clueCfg = FusionSoulConfig.instance:getClueCfg(msg.activityId, v)

			content = langPara("%s【%s】", content, clueCfg.name)
			canShow = true
			showClueId = v
		end

		self._newClueId = v
	end

	if canShow == true then
		UIStateManager.instance:push(ViewName.FusionSoulClueTipView, msg.activityId, showClueId, true)
		FloatWordMgr.instance:show(content)
	end
end

function FusionSoulController:packagePM_FusionSoulEventKey(activityId, zoneId, eventId)
	local eventKey = FusionSoulExtension_pb.PM_FusionSoulEventKey()

	eventKey.activityId = activityId
	eventKey.zoneId = zoneId
	eventKey.eventId = eventId

	return eventKey
end

function FusionSoulController:getCurPhase(activityId)
	local clueCount = FusionSoulModel.instance:getTotalClueCount(activityId)
	local phaseCfgs = FusionSoulConfig.instance:getPhaseCfgs(activityId)
	local curPhaseId = 0

	for i, v in ipairs(phaseCfgs) do
		if clueCount >= v.clueCount then
			curPhaseId = v.sectionId
		end
	end

	return curPhaseId
end

function FusionSoulController:setNewEvent(activityId, zoneId, eventId)
	local newEvent = FusionSoulModel.instance:getNewEvent(activityId, zoneId)

	if not newEvent or newEvent ~= eventId then
		FusionSoulModel.instance:saveNewEvent(activityId, zoneId, eventId)
		GlobalDispatcher:dispatch(GlobalNotify.FusionSoulGetInfoRes)
	end
end

function FusionSoulController:isNewEvent(activityId, zoneId, eventId)
	local newEvent = FusionSoulModel.instance:getNewEvent(activityId, zoneId)

	return checknumber(newEvent) ~= eventId
end

function FusionSoulController:isCanCommit(activityId, zoneId, eventId)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(activityId, zoneId, eventId)

	if not eventCfg or eventCfg.eventType ~= FusionSoulController.TYPE_MISSION then
		return false
	end

	local arrayTarget = string.split(eventCfg.eventParam, ",")
	local isAllCollect = true

	for i, v in ipairs(arrayTarget) do
		if not FusionSoulModel.instance:isGainClue(activityId, checknumber(v)) then
			isAllCollect = false

			break
		end
	end

	return isAllCollect
end

function FusionSoulController:openMission(activityId, zoneId, eventId)
	local fmtMo = FusionSoulModel.instance:getFmtMo()

	fmtMo:initParams(activityId, zoneId, eventId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function FusionSoulController:isUnlockFinalEvent(activityId)
	local zoneCfgs = FusionSoulConfig.instance:getZoneCfgs(activityId)

	for i = 1, #zoneCfgs do
		local zoneInfo = FusionSoulModel.instance:getZoneInfo(activityId, i)
		local eventCfg = FusionSoulConfig.instance:getEventCfg(activityId, i, zoneInfo.eventId)

		if eventCfg and not eventCfg.finalEvent then
			return false
		end
	end

	return true
end

function FusionSoulController:setBlockClue(clueIds)
	table.clear(self._blockClue)

	for i, v in ipairs(clueIds or {}) do
		self._blockClue[v] = true
	end
end

function FusionSoulController:getBlockClue()
	return self._blockClue
end

function FusionSoulController:isCollectAllClue(activityId)
	local clueCfgs = FusionSoulConfig.instance:getClueCfgs(activityId)
	local isGetAll = true

	for i, v in ipairs(clueCfgs) do
		if not FusionSoulModel.instance:isGainClue(activityId, v.clueId) then
			isGetAll = false

			break
		end
	end

	return isGetAll
end

FusionSoulController.instance = FusionSoulController.New()

return FusionSoulController
