-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/controller/GoddessTrialController.lua

module("logic.extensions.goddesstrial.controller.GoddessTrialController", package.seeall)

local GoddessTrialController = class("GoddessTrialController", BaseController)

function GoddessTrialController:onInit()
	self:onReset()
end

function GoddessTrialController:onReset()
	return
end

function GoddessTrialController:openNormalMissionView(activityId, stageId)
	local fmtMo = GoddessTrialModel.instance:getNormalFmtMo()
	local stepId = self:getCurStepId(activityId)

	fmtMo:initParams(activityId, stepId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function GoddessTrialController:openSuperMissionView(activityId, stageId)
	local fmtMo = GoddessTrialModel.instance:getSuperFmtMo()
	local stepId = self:getCurStepId(activityId)

	fmtMo:initParams(activityId, stepId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function GoddessTrialController:openBossMissionView(activityId, mode)
	local fmtMo = GoddessTrialModel.instance:getBossFmtMo()
	local stepId = self:getCurStepId(activityId)

	fmtMo:initParams(activityId, stepId, mode)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function GoddessTrialController:handlePM_GoddessTrialGetInfoRes(msg)
	GoddessTrialModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GoddessTrialGetInfoRes)
end

function GoddessTrialController:sendPM_GoddessTrialNormalFightReq(activityId, stepId, stageId, form)
	local option = GoddessTrialClgExtension_pb.PM_GoddessTrialFightOption()

	option.stageId = stageId
	option.stepId = stepId
	option.type = 1

	GoddessTrialClgAgent.instance:sendPM_GoddessTrialFightReq(activityId, form, option)
end

function GoddessTrialController:handlePM_GoddessTrialNormalFightRes(msg)
	if msg.isWin then
		GoddessTrialModel.instance:saveNormalBattleInfo(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_GoddessTrialGetInfoRes)
end

function GoddessTrialController:sendPM_GoddessTrialSuperFightReq(activityId, stepId, stageId, form)
	local option = GoddessTrialClgExtension_pb.PM_GoddessTrialFightOption()

	option.stageId = stageId
	option.stepId = stepId
	option.type = 2

	GoddessTrialClgAgent.instance:sendPM_GoddessTrialFightReq(activityId, form, option)
end

function GoddessTrialController:handlePM_GoddessTrialSuperFightRes(msg)
	if msg.isWin then
		GoddessTrialModel.instance:saveSuperBattleInfo(msg)
	end

	GoddessTrialModel.instance:saveTempSuperBattleResult(msg)
	BattleFacade.instance:registerResultHandler(self._openSuperResult, self)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GoddessTrialGetInfoRes)
end

function GoddessTrialController:_openSuperResult()
	if GoddessTrialModel.instance:getTempSuperBattleResult() ~= nil then
		ViewMgr.instance:open(ViewName.GoddessTrialSuperResultView)

		return true
	else
		return false
	end
end

function GoddessTrialController:sendPM_GoddessTrialBossFightReq(activityId, stepId, isPractice, form)
	local option = GoddessTrialClgExtension_pb.PM_GoddessTrialFightOption()

	option.isPractice = isPractice
	option.stepId = stepId
	option.type = 3

	GoddessTrialClgAgent.instance:sendPM_GoddessTrialFightReq(activityId, form, option)
end

function GoddessTrialController:handlePM_GoddessTrialBossFightRes(msg)
	if not msg.option.isPractice then
		GoddessTrialModel.instance:saveBossBattleInfo(msg)
	end

	GoddessTrialModel.instance:saveTempBossBattleResult(msg)
	BattleFacade.instance:registerResultHandler(self._openBossResult, self)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GoddessTrialGetInfoRes)
end

function GoddessTrialController:_openBossResult()
	if GoddessTrialModel.instance:getTempBossBattleResult() ~= nil then
		ViewMgr.instance:open(ViewName.GoddessTrialBossResultView)

		return true
	else
		return false
	end
end

function GoddessTrialController:handlePM_GoddessTrialGainPrizeRes(msg)
	GoddessTrialModel.instance:savePrizeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GoddessTrialGetInfoRes)
end

function GoddessTrialController:handlePM_GoddessTrialRankViewRes(msg)
	GoddessTrialModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GoddessTrialGetInfoRes)
end

function GoddessTrialController:getCurStepId(activityId)
	return GoddessTrialModel.instance:getCurStepId(activityId)
end

function GoddessTrialController:getNormalScore(activityId)
	local stepCfgs = GoddessTrialConfig.instance:getStepCfgs(activityId)
	local totalScore = 0

	for i, v in ipairs(stepCfgs) do
		local stepNormalScore = self:getNormalScoreWithStep(activityId, v.stepId)

		totalScore = totalScore + stepNormalScore
	end

	return totalScore
end

function GoddessTrialController:getNormalScoreWithStep(activityId, stepId)
	local stepCfg = GoddessTrialConfig.instance:getStepCfg(activityId, stepId)
	local stageCfgs = GoddessTrialConfig.instance:getNormalStageCfgs(stepCfg.normalTrialPlanId)
	local maxPassStageId = GoddessTrialModel.instance:getPassNormalStageId(activityId, stepId)
	local score = 0

	for i, v in ipairs(stageCfgs) do
		if maxPassStageId >= v.stageId then
			score = score + v.score
		end
	end

	return score
end

function GoddessTrialController:getSuperScore(activityId)
	local stepCfgs = GoddessTrialConfig.instance:getStepCfgs(activityId)
	local totalScore = 0

	for i, v in ipairs(stepCfgs) do
		local stepSuperScore = self:getSuperScoreWithStep(activityId, v.stepId)

		totalScore = totalScore + stepSuperScore
	end

	return totalScore
end

function GoddessTrialController:getSuperScoreWithStep(activityId, stepId)
	local stepCfg = GoddessTrialConfig.instance:getStepCfg(activityId, stepId)
	local stageCfgs = GoddessTrialConfig.instance:getSuperStageCfgs(stepCfg.superTrialPlanId)
	local score = 0

	for i, v in ipairs(stageCfgs) do
		score = score + GoddessTrialModel.instance:getSuperStageScore(activityId, stepId, v.stageId)
	end

	return score
end

function GoddessTrialController:getBossScore(activityId)
	local stepCfgs = GoddessTrialConfig.instance:getStepCfgs(activityId)
	local totalScore = 0

	for i, v in ipairs(stepCfgs) do
		local stepBossScore = GoddessTrialModel.instance:getTotalBossScore(activityId, v.stepId)

		totalScore = totalScore + stepBossScore
	end

	return totalScore
end

function GoddessTrialController:getTotalScoreWithStep(activityId, stepId)
	local normalScore = self:getNormalScoreWithStep(activityId, stepId)
	local superScore = self:getSuperScoreWithStep(activityId, stepId)
	local bossScore = GoddessTrialModel.instance:getTotalBossScore(activityId, stepId)

	return normalScore + superScore + bossScore
end

function GoddessTrialController:getTotalScore(activityId)
	return self:getNormalScore(activityId) + self:getSuperScore(activityId) + self:getBossScore(activityId)
end

GoddessTrialController.instance = GoddessTrialController.New()

return GoddessTrialController
