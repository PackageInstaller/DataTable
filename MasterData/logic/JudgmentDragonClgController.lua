-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/controller/JudgmentDragonClgController.lua

module("logic.extensions.judgmentdragonclg.controller.JudgmentDragonClgController", package.seeall)

local JudgmentDragonClgController = class("JudgmentDragonClgController", BaseController)

function JudgmentDragonClgController:onInit()
	return
end

function JudgmentDragonClgController:onReset()
	return
end

function JudgmentDragonClgController:sendPM_JudgmentDragonClgGetInfoReq(activityId)
	JudgmentDragonClgAgent.instance:sendPM_JudgmentDragonClgGetInfoReq(activityId)
end

function JudgmentDragonClgController:handlePM_JudgmentDragonClgGetInfoRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_JudgmentDragonClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_JudgmentDragonClgGetInfoRes)
end

function JudgmentDragonClgController:sendPM_JudgmentDragonClgFightReq(activityId, phaseId, stageId, form)
	JudgmentDragonClgAgent.instance:sendPM_JudgmentDragonClgFightReq(activityId, phaseId, stageId, form)
end

function JudgmentDragonClgController:handlePM_JudgmentDragonClgFightRes(msg)
	return
end

function JudgmentDragonClgController:sendPM_JudgmentDragonClgResetReq(activityId, phaseId, stageId)
	JudgmentDragonClgAgent.instance:sendPM_JudgmentDragonClgResetReq(activityId, phaseId, stageId)
end

function JudgmentDragonClgController:handlePM_JudgmentDragonClgResetRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_JudgmentDragonClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_JudgmentDragonClgResetRes)
end

function JudgmentDragonClgController:handlePM_JudgmentDragonNotifyFightRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_JudgmentDragonNotifyFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_JudgmentDragonNotifyFightRes)
end

function JudgmentDragonClgController:getActivityId()
	return 461001
end

function JudgmentDragonClgController:getActivityType()
	return GameEnum.ActivityType.JudgmentDragonClg
end

function JudgmentDragonClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function JudgmentDragonClgController:getClgMo(activityId)
	return JudgmentDragonClgModel.instance:getClgMo(activityId)
end

function JudgmentDragonClgController:enterBattle(activityId, phaseId, stageId)
	local fmtMo = JudgmentDragonClgModel.instance:getFmtMo()

	fmtMo:updateCfg(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function JudgmentDragonClgController:getTryResultAndTipsEnterPhase(isShowTips, activityId, phaseId)
	local result = GameEnum.ResultCode.Success
	local tips
	local clgMo = self:getClgMo(activityId)

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "不在活动时间范围内"
	elseif clgMo:isPassPhase(phaseId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "已通关"
	elseif not clgMo:isUnlockPhase(phaseId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未通关上一大关"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

JudgmentDragonClgController.instance = JudgmentDragonClgController.New()

return JudgmentDragonClgController
