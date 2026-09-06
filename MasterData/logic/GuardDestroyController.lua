-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/controller/GuardDestroyController.lua

module("logic.extensions.guarddestroy.controller.GuardDestroyController", package.seeall)

local GuardDestroyController = class("GuardDestroyController", BaseController)

function GuardDestroyController:ctor()
	return
end

function GuardDestroyController:onInit()
	self:onReset()
end

function GuardDestroyController:onReset()
	return
end

function GuardDestroyController:handlePM_GuardDestroyGetInfoRes(msg)
	GuardDestroyModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardDestroyGetInfoRes)
end

function GuardDestroyController:handlePM_GuardDestroyConfirmChallengeResultRes(msg)
	GuardDestroyModel.instance:saveConfirmInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardDestroyGetInfoRes)
end

function GuardDestroyController:handlePM_GuardDestroyGainBalancePrizeRes(msg)
	GuardDestroyModel.instance:saveGainBalancePrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardDestroyGetInfoRes)
end

function GuardDestroyController:handlePM_GuardDestroyGainProgressPrizeRes(msg)
	GuardDestroyModel.instance:saveGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardDestroyGetInfoRes)
end

function GuardDestroyController:handlePM_GuardDestroyGetRankViewRes(msg)
	GuardDestroyModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardDestroyGetRankViewRes)
end

function GuardDestroyController:handlePM_Notify_GuardDestroyChallengeRes(msg)
	if msg.win then
		if msg.needConfirm == false then
			GuardDestroyModel.instance:saveChallengeInfo(msg)
		else
			GuardDestroyModel.instance:saveTempChallengeInfo(msg)
			BattleFacade.instance:registerResultHandler(self._endBattle, self)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardDestroyGetInfoRes)
end

function GuardDestroyController:handlePM_GuardDestroyUpgradeSignInBuffRes(msg)
	GuardDestroyModel.instance:saveDayBuffInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardDestroyGetInfoRes)
end

function GuardDestroyController:openMissionView(activityId, stageId, type, creepsMasterId)
	local fmtMo = GuardDestroyModel.instance:getFmtMo()

	fmtMo:initParams(activityId, stageId, type, creepsMasterId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function GuardDestroyController:isStageOpen(activityId, stageId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.GuardDestroyClg, activityId)
	local stageCfg = GuardDestroyConfig.instance:getStageCfg(activityId, stageId)
	local activityFirstTime, stageOpenTime = GameUtil.getTimestampOnStartAndEnd(startTime, 1, stageCfg.openDays - 1)

	return stageOpenTime <= ServerTime.now(), stageOpenTime
end

function GuardDestroyController:_endBattle()
	local info = GuardDestroyModel.instance:getTempChallengeInfo()

	if info then
		local content
		local oldTotalScore = GuardDestroyModel.instance:getProgress(info.activityId, info.stageType)
		local oldStageScore = GuardDestroyModel.instance:getStageScore(info.activityId, info.stageId, info.stageType)
		local newScore = oldTotalScore - oldStageScore + info.score

		TipsFacade.instance:openPopupWindow(lang("提示"), info.stageType == 1 and langPara("恭喜您挑战成功！\n本次挑战中，您的己阵精灵存活数为：%d\n若保存本次挑战结果，己阵精灵累计存活数将由\n%d→%d\n是否保存？", info.score, oldTotalScore, newScore) or langPara("恭喜您挑战成功！\n本次挑战中，您击杀敌阵精灵数为：%d\n若保存本次挑战结果，累计击杀敌阵精灵数将由\n%d→%d\n是否保存？", info.score, oldTotalScore, newScore), function()
			GuardDestroyAgent.instance:sendPM_GuardDestroyConfirmChallengeResultReq(info.activityId, info.stageId, info.stageType, true)
			GuardDestroyModel.instance:resetTempChallengeInfo()
			BattleController.instance:endBattle()
		end, function()
			GuardDestroyAgent.instance:sendPM_GuardDestroyConfirmChallengeResultReq(info.activityId, info.stageId, info.stageType, false)
			GuardDestroyModel.instance:resetTempChallengeInfo()
			BattleController.instance:endBattle()
		end, lang("确认"), lang("取消"), UnityEngine.TextAnchor.MiddleCenter)
	end

	return true
end

function GuardDestroyController:checkBattleResultComfirm()
	local info = GuardDestroyModel.instance:getTempChallengeInfo()

	if info then
		local content

		if info.stageType == 1 then
			local oldTotalScore = GuardDestroyModel.instance:getProgress(info.activityId, info.stageType)
			local oldStageScore = GuardDestroyModel.instance:getStageScore(info.activityId, info.stageId, info.stageType)
			local newScore = oldTotalScore - oldStageScore + info.score

			content = langPara("恭喜您挑战成功！\n本次挑战中，您的己阵精灵存活数为：%d\n若保存本次挑战结果，己阵精灵累计存活数将由\n%d→%d\n是否保存？", info.score, oldTotalScore, newScore)
		else
			content = langPara("恭喜您挑战成功！\n本次挑战中，您击杀敌阵精灵数为：%d\n若保存本次挑战结果，累计击杀敌阵精灵数将由\n%d→%d\n是否保存？", info.score, oldTotalScore, newScore)
		end

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			GuardDestroyAgent.instance:sendPM_GuardDestroyConfirmChallengeResultReq(info.activityId, info.stageId, info.stageType, true)
			GuardDestroyModel.instance:resetTempChallengeInfo()
		end, function()
			GuardDestroyAgent.instance:sendPM_GuardDestroyConfirmChallengeResultReq(info.activityId, info.stageId, info.stageType, false)
			GuardDestroyModel.instance:resetTempChallengeInfo()
		end, lang("确认"), lang("取消"), UnityEngine.TextAnchor.MiddleCenter)
	end
end

GuardDestroyController.instance = GuardDestroyController.New()

return GuardDestroyController
