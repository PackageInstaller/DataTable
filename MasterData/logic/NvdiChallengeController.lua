-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/controller/NvdiChallengeController.lua

module("logic.extensions.nvdi.controller.NvdiChallengeController", package.seeall)

local NvdiChallengeController = class("NvdiChallengeController", BaseController)

function NvdiChallengeController:onInit()
	GlobalDispatcher:addListener("enternvdichallenge", self._enterNvdiChallenge, self)
	self:onReset()
end

function NvdiChallengeController:onReset()
	self.extFmtMo = NvdiExtFmtMo.New()
	self.norFmtMo = NvdiNormalFmtMo.New()
	self._activityId = 0
	self._isNormalWin = false
	self._dataBitId = 0
	self._immunityAttackCount = 0
	self._curFightScore = 0
	self._isExtWin = false
	self._extMsgInfo = nil
end

function NvdiChallengeController:sendGetInfo(activityId)
	EmpressChallengeAgent.instance:sendPM_EmpressClgGetInfoReq(activityId)
end

function NvdiChallengeController:onGetInfo(msg)
	NvdiChallengeModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NVDI_CHALLENGE_INFO_UPDATE)
end

function NvdiChallengeController:sendGetProgressPrize(activityId, id)
	EmpressChallengeAgent.instance:sendPM_EmpressGainNormalClgProgressPrizeReq(activityId, id)
end

function NvdiChallengeController:onGetProgressPrize(msg)
	NvdiChallengeModel.instance:onGetProgressPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NVDI_CHALLENGE_INFO_UPDATE)
end

function NvdiChallengeController:sendGetExtPrize(activityId)
	EmpressChallengeAgent.instance:sendPM_EmpressClgGainExtremePrizeReq(activityId)
end

function NvdiChallengeController:ondGetExtPrize(msg)
	NvdiChallengeModel.instance:ondGetExtPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NVDI_CHALLENGE_INFO_UPDATE)
end

function NvdiChallengeController:sendResetExtStage(activityId, stageId)
	EmpressChallengeAgent.instance:sendPM_EmpressResetExtremeClgStageReq(activityId, stageId)
end

function NvdiChallengeController:onResetExtStage(msg)
	NvdiChallengeModel.instance:onResetExtStage(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NVDI_CHALLENGE_INFO_UPDATE)
end

function NvdiChallengeController:showNormalMissionview(activityId, groupId, dataBitId)
	self.norFmtMo:initParams(activityId, groupId, dataBitId)
	CustomFmtController.instance:showMissionView(self.norFmtMo)
end

function NvdiChallengeController:sendStartFightNormal(activityId, dataBitId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))
	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
	EmpressChallengeAgent.instance:sendPM_EmpressNormalFightReq(activityId, dataBitId, form_pb)
end

function NvdiChallengeController:onNoramlFightMsg(msg)
	self._activityId = msg.activityId
	self._isNormalWin = msg.win
	self._dataBitId = msg.dataBitId
	self._immunityAttackCount = msg.immunityAttackCount
	self._curFightScore = msg.curFightScore

	NvdiChallengeModel.instance:onNoramlFightMsg(msg)
end

function NvdiChallengeController:onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if self._isNormalWin == false then
		return false
	end

	UIStateManager.instance:push(ViewName.NvdiNorDetailView, self._activityId, self._dataBitId, self._curFightScore, self._immunityAttackCount)

	return true
end

function NvdiChallengeController:showExtMissionview(activityId, stageId)
	self.extFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self.extFmtMo)
end

function NvdiChallengeController:sendStartFightExt(activityId, stageId, buffIdUsed, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEndExt, self, activityId))
	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
	EmpressChallengeAgent.instance:sendPM_EmpressExtremeFightReq(activityId, stageId, buffIdUsed, form_pb)
end

function NvdiChallengeController:onExtFightMsg(msg)
	self._isExtWin = msg.win
	self._extMsgInfo = GameUtil.pbToTable(msg)

	NvdiChallengeModel.instance:onExtFightMsg(msg)
end

function NvdiChallengeController:onBattleEndExt(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

	if isAoqiGodProcessType then
		local activityType = self:getActivityType()

		AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
	end

	if self._isExtWin then
		UIStateManager.instance:push(ViewName.NvdiextsuccessView, self._extMsgInfo)

		return true
	else
		return false
	end
end

function NvdiChallengeController:checkAndShowSuccView()
	local passExtremeClg = NvdiChallengeModel.instance.passExtremeClg

	if passExtremeClg then
		NvdiChallengeModel.instance.passExtremeClg = false

		UIStateManager.instance:push(ViewName.NvdimaxpassView)
	end
end

function NvdiChallengeController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function NvdiChallengeController:getActivityType()
	return GameEnum.ActivityType.NvdiChallenge
end

function NvdiChallengeController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function NvdiChallengeController:_enterNvdiChallenge(params)
	self:enterNvdiChallenge(checknumber(params[1]))
end

function NvdiChallengeController:enterNvdiChallenge(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.NvdimainView, activityId)
end

NvdiChallengeController.instance = NvdiChallengeController.New()

return NvdiChallengeController
