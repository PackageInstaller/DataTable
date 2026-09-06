-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/controller/DivineChenClgController.lua

module("logic.extensions.divinechenclg.controller.DivineChenClgController", package.seeall)

local DivineChenClgController = class("DivineChenClgController", BaseController)

function DivineChenClgController:ctor()
	return
end

function DivineChenClgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivinechenclg", self._enterDivineChenClg, self)
end

function DivineChenClgController:onReset()
	self._clgExtremeFmtMo = DivineChenClgExtremeFmtMo.New()
	self._clgNormalFmtMo = DivineChenClgNormalFmtMo.New()
	self.ciList = nil
end

function DivineChenClgController:getActivityType()
	return 457
end

function DivineChenClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivineChenClgController:isInActivityTime(activityId)
	return ActivityDefineController.instance:isInActivityTimeById(self:getActivityType(), activityId)
end

function DivineChenClgController:_enterDivineChenClg(params)
	params = params or {}

	self:enterDivineChenClg(checknumber(params[1]))
end

function DivineChenClgController:enterDivineChenClg(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show(lang("不在活动开启时间内"))

		return
	end

	UIStateManager.instance:push(ViewName.DivineChenClgMainView, activityId)
end

function DivineChenClgController:checkPassAoqiGodProcessResult(activityId)
	if not ActivityDefineController.instance:isAoqiGodProcessType(activityId) then
		return true
	end

	local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self:getActivityType(), activityId)

	return result == GameEnum.ResultCode.Success
end

function DivineChenClgController:openExtremeMissionView(activityId, stageId, creepId)
	self._clgExtremeFmtMo:initParams(activityId, stageId, creepId)
	CustomFmtController.instance:showMissionView(self._clgExtremeFmtMo)
end

function DivineChenClgController:openNormalMissionView(activityId, stageId, creepId)
	self._clgNormalFmtMo:initParams(activityId, stageId, creepId)
	CustomFmtController.instance:showMissionView(self._clgNormalFmtMo)
end

function DivineChenClgController:getExtremeInfo(activityId)
	DivineChenClgAgent.instance:sendPM_DivineChenClgExtremeInfoReq(activityId)
end

function DivineChenClgController:handleGetExtremeInfo(msg)
	DivineChenClgModel.instance:onGetExtremeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineChenClgGetExtremeInfoRes)
end

function DivineChenClgController:startExtremeClg(activityId, stageId, form_pb)
	DivineChenClgAgent.instance:sendPM_DivineChenClgExtremeClgReq(activityId, stageId, form_pb)
end

function DivineChenClgController:extremerResetStage(activityId, stageId)
	DivineChenClgAgent.instance:sendPM_DivineChenClgExtremeResetStageReq(activityId, stageId)
end

function DivineChenClgController:handleExtremeResetStage(msg)
	DivineChenClgModel.instance:onResetExtremeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineChenClgExtremeResetStageRes)
end

function DivineChenClgController:getNormalInfo(activityId)
	DivineChenClgAgent.instance:sendPM_DivineChenClgNormalInfoReq(activityId)
end

function DivineChenClgController:handleGetNormalInfo(msg)
	DivineChenClgModel.instance:onGetNormalInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineChenClgGetNormalInfoRes)
end

function DivineChenClgController:startNormalClg(activityId, stageId, form_pb)
	DivineChenClgAgent.instance:sendPM_DivineChenClgNormalClgReq(activityId, stageId, form_pb)
end

function DivineChenClgController:normalResetStage(activityId, stageId)
	DivineChenClgAgent.instance:sendPM_DivineChenClgNormalResetStageReq(activityId, stageId)
end

function DivineChenClgController:handleNormalResetStage(msg)
	DivineChenClgModel.instance:onResetNormalInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineChenClgNormalResetStageRes)
end

function DivineChenClgController:normalGainPrize(activityId, prizeId)
	DivineChenClgAgent.instance:sendPM_DivineChenClgNormalGainPrizeReq(activityId, prizeId)
end

function DivineChenClgController:handleNormalGainPrize(msg)
	DivineChenClgModel.instance:onNormalGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineChenClgNormalGainPrize)
end

function DivineChenClgController:handleNotifyExtremeClgEnd(msg)
	local info = GameUtil.pbToTable(msg)

	self.ciList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleFacade.instance:registerResultHandler(function()
		ViewMgr.instance:open(ViewName.DivineChenClgResultView, info)

		return true
	end)
end

function DivineChenClgController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function DivineChenClgController:handleNotifyNormalClgEnd(msg)
	return
end

DivineChenClgController.instance = DivineChenClgController.New()

return DivineChenClgController
