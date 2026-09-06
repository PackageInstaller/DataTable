-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/controller/DivineDualDragonClgController.lua

module("logic.extensions.divinedualdragonclg.controller.DivineDualDragonClgController", package.seeall)

local DivineDualDragonClgController = class("DivineDualDragonClgController", BaseController)

function DivineDualDragonClgController:ctor()
	return
end

function DivineDualDragonClgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivinedualdragonclg", self._enterDivineDualDragonClg, self)
end

function DivineDualDragonClgController:onReset()
	return
end

function DivineDualDragonClgController:getActivityType()
	return GameEnum.ActivityType.DivineDualDragonClg
end

function DivineDualDragonClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivineDualDragonClgController:isInActivityTime(activityId)
	return ActivityDefineController.instance:isInActivityTimeById(self:getActivityType(), activityId)
end

function DivineDualDragonClgController:_enterDivineDualDragonClg(params)
	params = params or {}

	self:enterDivineDualDragonClg(checknumber(params[1]))
end

function DivineDualDragonClgController:enterDivineDualDragonClg(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show(lang("不在活动开启时间内"))

		return
	end

	UIStateManager.instance:push(ViewName.DivineDualDragonClgMainView, activityId)
end

function DivineDualDragonClgController:handlePM_DivineDualDragonClgGetInfoRes(msg)
	DivineDualDragonClgModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineDualDragonClgGetInfoRes)
end

function DivineDualDragonClgController:handlePM_Notify_DivineDualDragonClgChallengeRes(msg)
	if msg.pass == true then
		DivineDualDragonClgModel.instance:saveChallengeInfo(msg)

		local activityId = checknumber(msg.activityId)

		if ActivityDefineController.instance:isAoqiGodProcessType(activityId) and self:isPassAllStage(activityId) then
			AoqiGodController.instance:doHandleChallengeFinishReady(self:getActivityType(), activityId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_DivineDualDragonClgChallengeRes)
end

function DivineDualDragonClgController:checkNormalStagePass(activityId, phaseId)
	local activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(activityId)
	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(activityCfg.phasePlanId, phaseId)
	local stagePlanCfg = DivineDualDragonClgConfig.instance:getStagesByStagePlanId(phaseCfg.stagePlanId)
	local isAllPass = true

	for i, v in ipairs(stagePlanCfg) do
		if not v.finalStage and not DivineDualDragonClgModel.instance:getStagePass(activityId, phaseId, v.stageId) then
			isAllPass = false

			break
		end
	end

	return isAllPass
end

function DivineDualDragonClgController:checkFinalStagePass(activityId, phaseId)
	local activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(activityId)
	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(activityCfg.phasePlanId, phaseId)
	local stagePlanCfg = DivineDualDragonClgConfig.instance:getStagesByStagePlanId(phaseCfg.stagePlanId)

	for i, v in ipairs(stagePlanCfg) do
		if v.finalStage == true and DivineDualDragonClgModel.instance:getStagePass(activityId, phaseId, v.stageId) == true then
			return true
		end
	end

	return false
end

function DivineDualDragonClgController:isPassAllStage(activityId)
	local activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(activityId)
	local phaseCfgs = DivineDualDragonClgConfig.instance:getPhaseCfgs(activityCfg.phasePlanId)

	for i, v in ipairs(phaseCfgs) do
		if self:checkFinalStagePass(activityId, v.phaseId) == false then
			return false
		end
	end

	return true
end

function DivineDualDragonClgController:openNormalMissionView(activityId, phaseId, stageId)
	local fmtMo = DivineDualDragonClgModel.instance:getNormalFmtMo()

	fmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineDualDragonClgController:openFinalMissionView(activityId, phaseId, stageId)
	local fmtMo = DivineDualDragonClgModel.instance:getFinalFmtMo()

	fmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineDualDragonClgController:openUltimateTrialFinalMissionView(activityId, phaseId, stageId)
	local fmtMo = DivineDualDragonClgModel.instance:getUltimateTrialFinalFmtMo()

	fmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineDualDragonClgController:openUltimateTrialNormalMissionView(activityId, phaseId, stageId)
	local fmtMo = DivineDualDragonClgModel.instance:getUltimateTrialNormalFmtMo()

	fmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineDualDragonClgController:getTotalScore(activityId)
	DivineDualDragonClgModel.instance:getTotalScore(activityId)
end

DivineDualDragonClgController.instance = DivineDualDragonClgController.New()

return DivineDualDragonClgController
